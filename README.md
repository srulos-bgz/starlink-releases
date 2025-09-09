# Starlink iOS Framework

Starlink 是一个功能强大的 iOS 框架，提供 WebView 集成、网络管理、本地服务器等功能。

## 📦 安装

### Swift Package Manager

在 Xcode 中添加包依赖：

1. File → Add Package Dependencies
2. 输入仓库 URL: `https://github.com/srulos-bgz/starlink-releases`
3. 选择版本

或在 `Package.swift` 中添加：

```swift
dependencies: [
    .package(url: "https://github.com/srulos-bgz/starlink-releases.git", from: "1.2.0")
]
```

## 🚀 快速开始

```swift
import Starlink

// 在 AppDelegate 或 SceneDelegate 中设置根视图控制器
let rootViewController = StarlinkCore.shared.createWebViewRootViewController()
window?.rootViewController = rootViewController
```

## ⚙️ 权限配置

在项目的 `Info.plist` 中添加以下配置：

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
    <key>NSExceptionDomains</key>
    <dict>
        <key>localhost</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>
```

## 📋 系统要求

- **iOS**: 16.0+
- **Xcode**: 14.0+
- **Swift**: 5.7+

## 🔒 许可证

私有框架，仅供授权团队使用。

---

## 📚 更多资源

- 📱 **示例项目**: 请访问源码仓库获取完整的 StarlinkDemo 示例项目
- 🌐 **JavaScript SDK 测试**: 请访问源码仓库获取 starlink-test-app 测试应用
- 📖 **API 文档**: 完整的桥接 API 文档包含在源码仓库中

### 版本更新
框架会定期发布新版本，请关注 [Releases](https://github.com/srulos-bgz/starlink-releases/releases) 页面获取最新版本。
