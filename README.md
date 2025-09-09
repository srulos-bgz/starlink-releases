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
    .package(url: "https://github.com/srulos-bgz/starlink-releases.git", from: "1.1.0")
]
```

## 🚀 快速开始

```swift
import Starlink

// 在 AppDelegate 或 SceneDelegate 中设置根视图控制器
let rootViewController = StarlinkCore.shared.createWebViewRootViewController()
window?.rootViewController = rootViewController
```

## 📱 iOS 示例项目 (StarlinkDemo)

本仓库包含完整的 iOS 示例项目，展示框架的正确使用方法：

- ✅ 完整的 iOS 应用示例
- ✅ 正确的权限配置
- ✅ WebView 控制器集成
- ✅ 生产环境配置参考

**运行示例：**
```bash
# 1. 克隆仓库
git clone https://github.com/srulos-bgz/starlink-releases.git

# 2. 打开项目
open StarlinkDemo/StarlinkDemo.xcodeproj

# 3. 运行项目 (⌘+R)
```

## 🌐 JavaScript SDK 测试应用 (starlink-test-app)

包含完整的 JavaScript SDK 测试环境，用于开发和调试：

### 功能特性：
- 📚 **完整文档** - 所有桥接 API 的详细说明
- 🧪 **测试页面** - 交互式功能测试
- 🔧 **开发服务器** - 本地测试环境
- 📋 **API 参考** - StarlinkAlertBridge, StarlinkDataBridge, StarlinkDeviceInfoBridge, StarlinkIAPBridge, StarlinkNetworkBridge, StarlinkUmengBridge

### 快速启动：
```bash
# 1. 进入测试应用目录
cd starlink-test-app

# 2. 安装依赖
npm install

# 3. 启动开发服务器
npm start

# 4. 打开浏览器访问
open http://localhost:3000
```

### 测试页面：
- 🚨 **Alert 测试** - `/alert-test.html`
- 💾 **Data 测试** - `/data-test.html`
- 📱 **设备信息测试** - `/deviceinfo-test.html`
- 💰 **IAP 测试** - `/iap-test.html`
- 🌐 **网络测试** - `/network-test.html`
- 📊 **友盟统计测试** - `/umeng-test.html`

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
- **Node.js**: 16.0+ (仅测试应用需要)

## 📚 文档

- [StarlinkAlertBridge API](starlink-test-app/docs/StarlinkAlertBridge.md)
- [StarlinkDataBridge API](starlink-test-app/docs/StarlinkDataBridge.md)
- [StarlinkDeviceInfoBridge API](starlink-test-app/docs/StarlinkDeviceInfoBridge.md)
- [StarlinkIAPBridge API](starlink-test-app/docs/StarlinkIAPBridge.md)
- [StarlinkNetworkBridge API](starlink-test-app/docs/StarlinkNetworkBridge.md)
- [StarlinkUmengBridge API](starlink-test-app/docs/StarlinkUmengBridge.md)

## 🔒 许可证

私有框架，仅供授权团队使用。

---

## 🛠️ 开发者指南

### 项目结构
```
starlink-releases/
├── Package.swift              # Swift Package 配置
├── README.md                  # 本文档
├── StarlinkDemo/             # iOS 示例项目
│   ├── StarlinkDemo.xcodeproj
│   └── StarlinkDemo/
└── starlink-test-app/        # JavaScript SDK 测试
    ├── docs/                 # API 文档
    ├── public/              # 测试页面
    ├── server.js            # Express 服务器
    └── package.json         # Node.js 配置
```

### 版本更新
框架会定期发布新版本，请关注 [Releases](https://github.com/srulos-bgz/starlink-releases/releases) 页面获取最新版本。
