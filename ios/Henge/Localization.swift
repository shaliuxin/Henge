import Foundation

/// Localization helpers.
///
/// SwiftUI views that receive a string *literal* (e.g. `Text("Start")`) are localized automatically
/// through `Localizable.strings`. Places that hold text in a `String` variable or return it from a
/// computed property are not, so they funnel through these helpers instead.
///
/// The app ships English as its development language and a `zh-Hans` localization. iOS picks the
/// bundle that matches the system language, so the interface follows the device language with no
/// in-app switch: Simplified Chinese systems see Chinese, every other language falls back to the
/// English development strings.
extension String {
    /// Look this string up in `Localizable.strings` for the current system language.
    var loc: String {
        NSLocalizedString(self, comment: "")
    }

    /// Localize a format string and substitute the given arguments.
    func locFormat(_ args: CVarArg...) -> String {
        String(format: NSLocalizedString(self, comment: ""), arguments: args)
    }
}
