<p align="center">
  <img src="docs/icon.png" width="120" height="120" alt="Henge">
</p>

<h1 align="center">Henge</h1>

<p align="center">在 iPhone 和 iPad 上运行 macOS。</p>

<p align="center">
  <a href="#安装">安装</a>
  ·
  <a href="#与-Mac-共享">与 Mac 共享</a>
  ·
  <a href="docs/architecture.md">工作原理</a>
  ·
  <a href="https://itslevii.dev">官方网站</a>
  ·
  <a href="https://github.com/shaliuxin/Henge/releases">发布版本</a>
</p>

<p align="center">
  <a href="#关于本分支">关于本分支</a>
  ·
  <a href="README.md">English</a>
</p>

> **关于本分支**：这是 [Leviidev/Henge](https://github.com/Leviidev/Henge) 的简体中文分支。界面已全面中文化，并会根据系统语言自动切换：系统为简体中文时显示中文，其他语言回退为英文。功能与原项目保持一致。本分支的 IPA 与 TrollStore 版 `.tipa` 在[发布页面](https://github.com/shaliuxin/Henge/releases)提供。

下载 macOS，安装到设备上，即可使用。

- **自研模拟器** — iOS 不向 App 提供虚拟机管理框架，因此 Henge 通过自研 JIT 运行 Mac 的 arm64 代码，并配备自己的 MMU 和设备模型。它不使用 QEMU，也不使用 Virtualization.framework。
- **在设备上安装** — Henge 下载 Apple 的恢复镜像，并像 Mac 一样进行恢复。无需 Mac，也不涉及任何解密或打补丁。
- **图形** — macOS 通过虚拟 GPU 绘制，Henge 用 Metal 重放其命令。Safari 以及 Discord 等 Electron 应用都可以在上面绘制。
- **触控** — 屏幕相当于妙控板 2：双指滚动，Mac 自带的手势同样可用——三指轻扫切换调度台和 Mission Control 等。音量键作为妙控板的按键：音量加为单击，音量减为右键，按住为拖动。Esc、Tab、Control、Option 和 Command 键位于键盘上方。
- **键盘和鼠标** — 在 iPad 上，妙控键盘或蓝牙键盘和鼠标可直接操控 Mac。
- **外接显示器** — Mac 会话期间，可用支持视频输出的 USB-C 线或 USB-C/HDMI 扩展坞连接显示器。该模式会自动激活：外接显示器显示 Mac，而 iPhone 或 iPad 仍保留触控板和键盘控制。断开连接后画面回到设备。已有的客户机分辨率保持不变。在 iOS 17–26 上，同样的功能通过较旧的 iOS 路径实现，尚未在真机上验证；非 Mac 会话时显示器会镜像设备画面。USB-C 视频输出已在运行 iOS 27 的 iPhone 17 Pro 上由用户确认可用（开发版 0.1/2）。
- **共享** — 在 macOS 和设备之间复制粘贴，并在“文件”应用和 Mac 上显示一个共享文件夹。
- **适配屏幕** — 在 iPad 上，新建的 Mac 会采用与 iPad 相同比例的屏幕，因此没有黑边。

在 iPhone 17 Pro 上，macOS 约 15 秒即可到达锁屏界面。Discord 可安装，约 15 秒打开，并能登录和发送消息。

## 安装

用 SideStore 或 AltStore 侧载[发布页面](https://github.com/shaliuxin/Henge/releases)中的 `Henge.ipa`，或用 TrollStore / TrollStore Lite 安装 `Henge.tipa`。要在 SideStore 或 AltStore 中获取更新，请添加 Henge 的软件源：`https://raw.githubusercontent.com/shaliuxin/Henge/main/repo.json`，或使用 `https://itslevii.dev/repo.json` 获取 Leviidev 的全部应用。系统要求为 iOS 或 iPadOS 17 及以上，芯片为 A14 或 M1 及更新型号。目前仅在 iPhone 17 Pro 上测试过：iPad 支持是新增功能，尚未在真机 iPad 上运行验证。

- **JIT 为必需项**：可通过 StikDebug、TrollStore（仅支持到 iOS 17.0）、TrollStore Lite（需要越狱）、单独的越狱环境，或 Henge 内置的 StikJIT 辅助程序（iOS 26 及以上）。
- **存储空间：** 安装 macOS Sequoia 大约需要 43 GB 可用空间。其中下载包 17 GB（安装完成后可删除），Mac 本体 26 GB。
- **内存：** Mac 可分配 4、6 或 8 GB。如果你的证书支持提升内存限额权限，请用该权限为 Henge 签名。

然后打开“安装”标签页，选择 macOS Sequoia 15.6.1，并保持 Henge 打开、设备连接状态。也提供 Tahoe 26.6.2 和 macOS 27.2：两者都能在 iPhone 17 Pro 上安装运行，不过 Tahoe 首次设置较慢，macOS 27 最慢（Safari 页面可能一直空白）。Sonoma 14.6.1 和 Ventura 13.6 的下载体积更小（分别为 14.1 和 12.3 GB），适合存储空间紧张的设备：它们可以安装、完成设置并运行 Safari（均已在 iPhone 17 Pro 上测试）。暂不提供 Monterey：它可以安装，但桌面始终无法显示。

## 与 Mac 共享

每台 Mac 只需设置一次：在 Mac 上打开终端，然后在 Henge 中打开“详情”并点按**输入设置命令**。在 Mac 上按回车，当 macOS 询问 `henge-agent` 和本地网络权限时选择“允许”。该命令要求 Mac 的键盘布局为美式。

之后，Mac 主文件夹中的 Henge 文件夹与“文件 › Henge › Shared”是同一个文件夹。你在 Mac 上复制的内容也会复制到设备上，粘贴按钮会将设备上的内容粘贴到 Mac 中。

## 已知限制

- 在 macOS 内登录 Apple 账户会失败，并报验证错误。
- 图形功能已在 macOS 自带应用、Chrome、Firefox、VS Code 和 Discord 上测试。其他应用可能显示异常。
- 在 macOS Sonoma 上，切换到动态壁纸（如 Sonoma 壁纸）可能导致屏幕停止更新；打开任意应用即可恢复。在 Ventura 上，程序坞中的日历图标缺少日期。
- 登录后的最初几分钟，macOS 在后台忙于启动，因此应用打开较慢。
- 每次启动只能开启一台 Mac。要启动另一台，或在重启/关闭 macOS 后再次启动，请退出 Henge 后重新打开。
- iPadOS 会保留部分键盘快捷键供自己使用，例如 Command-Tab。
- 由于是模拟运行，速度比真实 Mac 慢。

## 截图

<table>
  <tr>
    <td align="center" colspan="3"><img src="Screenshots/ipad.jpg" alt="iPad 上的 Discord"><br><sub>iPad</sub></td>
  </tr>
  <tr>
    <td align="center" width="33%"><img src="Screenshots/macs.png" alt="Mac 列表"><br><sub>Mac 列表</sub></td>
    <td align="center" width="33%"><img src="Screenshots/trackpad.png" alt="触控板"><br><sub>触控板</sub></td>
    <td align="center" width="33%"><img src="Screenshots/install.png" alt="安装 macOS"><br><sub>安装 macOS</sub></td>
  </tr>
</table>

<sub>在 Mac 上截取：应用自身界面配合示例数据，按 iPad 和 iPhone 尺寸展示，画面来自 Henge 的渲染器。</sub>

## 编译

要使用 Henge，请安装[最新发布版](https://github.com/shaliuxin/Henge/releases)。所有改动一完成就合并到 `main`，因此两次发布之间的 `main` 分支可能处于未完成状态。

编译环境为 Mac，需要 Xcode 27 及以上和 `xcodegen`。Henge 从位于 `~/Documents/Coding/Husk` 的已构建 [Husk](https://github.com/Leviidev/Husk) 代码库获取 StikJIT、设备端配对、libslirp 和 glib（可设置 `HUSK` 指定其他路径）：

```bash
ios/scripts/fetch_deps.sh
tools/build_ios_restore.sh
make ios-lib
ios/scripts/package_ipa.sh
```

这会生成 `~/Desktop/Henge.ipa`，而 `package_ipa.sh --trollstore` 会生成 `Henge.tipa`。

`make` 会为 Mac 构建引擎 `build/hengevm`，`make test` 运行其测试。

> **提示：** 若你所在环境的 Xcode 宏插件服务无法在沙箱内运行（表现为 `@State` 相关的 `self is immutable` 报错），可在 `xcodebuild` 命令中加入 `OTHER_SWIFT_FLAGS="-Xfrontend -disable-sandbox"`。

## 许可

GPL-2.0-or-later。Henge 编译进了 usbmuxd（GPLv2 或 GPLv3）以及来自 Husk 的代码（GPL-2.0-or-later），因此发布的二进制文件是遵循 GPL 的组合作品。它无法上架 App Store。详见 [docs/licensing.md](docs/licensing.md)。

macOS 和 Mac 的启动 ROM 属于 Apple，不属于 Henge。Henge 会在安装时从 Apple 下载这两者。
