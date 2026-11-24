import Foundation
import SwiftUI

/// The interface language chosen in Settings.
///
/// `.system` follows the device language through the normal `zh-Hans` / English
/// localization bundles. The other two force a language at runtime by loading the
/// matching `.lproj` — no app restart and no change to the system-wide `AppleLanguages`.
enum AppLanguage: String, CaseIterable, Identifiable {
    case system = "system"
    case simplifiedChinese = "zh-Hans"
    case english = "en"

    var id: String { rawValue }

    /// Resolved as a `LocalizedStringKey` in the picker, so the option names follow the current language.
    var titleKey: LocalizedStringKey {
        switch self {
        case .system: return "System"
        case .simplifiedChinese: return "Chinese (Simplified)"
        case .english: return "English"
        }
    }
}

// MARK: - Runtime language override

/// One associated object on `Bundle.main` holds the forced language. Swizzling its
/// class once lets every `NSLocalizedString` / SwiftUI `LocalizedStringKey` lookup —
/// including the `String.loc` helper — resolve against the chosen `.lproj`.
private var forcedLanguageKey: UInt8 = 0

private final class HengeLocalizedBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let code = objc_getAssociatedObject(self, &forcedLanguageKey) as? String,
              code != AppLanguage.system.rawValue else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        // English is the development language: no en.lproj ships, so the source
        // literal (the key itself) is the correct English string.
        if code == AppLanguage.english.rawValue {
            return value ?? key
        }
        let lproj = (Bundle.main.bundlePath as NSString).appendingPathComponent("\(code).lproj")
        if let bundle = Bundle(path: lproj) {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}

private extension Bundle {
    static func applyLanguage(_ language: AppLanguage) {
        if object_getClass(Bundle.main) != HengeLocalizedBundle.self {
            objc_setAssociatedObject(Bundle.main, &forcedLanguageKey, AppLanguage.system.rawValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            object_setClass(Bundle.main, HengeLocalizedBundle.self)
        }
        objc_setAssociatedObject(Bundle.main, &forcedLanguageKey, language.rawValue,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

/// Observable store for the language choice, shared by the app root and Settings.
final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    static let storageKey = "henge.appLanguage"

    @Published var language: AppLanguage {
        // Swift skips observers during initialization, so init() calls apply() explicitly.
        didSet { apply() }
    }

    private init() {
        let raw = UserDefaults.standard.string(forKey: Self.storageKey) ?? ""
        language = AppLanguage(rawValue: raw) ?? .system
        // Apply before the first view render so the chosen language shows immediately on launch.
        apply()
    }

    func apply() {
        UserDefaults.standard.set(language.rawValue, forKey: Self.storageKey)
        Bundle.applyLanguage(language)
    }
}
