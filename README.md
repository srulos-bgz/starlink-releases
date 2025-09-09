# Starlink iOS Framework

Starlink 是一个功能强大的 iOS 框架，提供 WebView 集成、网络管理、本地服务器等功能。

## 安装

### Swift Package Manager

在 Xcode 中添加包依赖：

1. File → Add Package Dependencies
2. 输入仓库 URL: `https://github.com/srulos-bgz/starlink-releases`
3. 选择版本

或在 `Package.swift` 中添加：

```swift
dependencies: [
    .package(url: "https://github.com/srulos-bgz/starlink-releases.git", from: "1.1.0")
]
```

## 使用

```swift
import Starlink

// Set StarlinkWebViewController as root view controller
let rootViewController = StarlinkCore.shared.createWebViewRootViewController()
window?.rootViewController = rootViewController
```

## 权限配置

在项目的 `Info.plist` 中添加：

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

## 系统要求

- iOS 16.0+
- Xcode 14.0+
- Swift 5.7+

## 许可证

私有框架，仅供授权团队使用。
