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
    .package(url: "https://github.com/srulos-bgz/starlink-releases.git", from: "1.3.0")
]
```

## 🚀 快速开始

```swift
import Starlink

// 基础使用 - 在 AppDelegate 或 SceneDelegate 中设置根视图控制器
let rootViewController = StarlinkCore.shared.createWebViewRootViewController()
window?.rootViewController = rootViewController

// 使用自定义扩展
let extensionProvider = MyExtensionProvider()
let rootViewController = StarlinkCore.shared.createWebViewRootViewController(
    extensionProvider: extensionProvider
)
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

## 🔧 自定义扩展 (v1.3.0+)

Starlink 框架支持可扩展的 JavaScript Bridge 系统，允许业务项目添加自定义的 native API。

### 创建自定义扩展

```swift
import Starlink

// 1. 创建自定义 Bridge 模块
class DemoAPIExtension: NSObject, StarlinkJSBridgeModule {
    private weak var bridge: StarlinkJSBridge?
    
    func setBridge(_ bridge: StarlinkJSBridge) {
        self.bridge = bridge
    }
    
    func handleCall(method: String, params: [String: Any], callId: String) {
        switch method {
        case "function1":
            function1(params: params, callId: callId)
        case "function2":
            function2(params: params, callId: callId)
        default:
            bridge?.sendResult(callId: callId, result: nil, error: "Method not found")
        }
    }
    
    func getJavaScriptInterface(moduleName: String) -> String {
        return """
        window.Starlink.\(moduleName) = {
            function1: function(callback) {
                return window.StarlinkBridge.call('\(moduleName)', 'function1', {}, callback);
            },
            function2: function(callback) {
                return window.StarlinkBridge.call('\(moduleName)', 'function2', {}, callback);
            }
        };
        console.log('Demo API Extension loaded successfully!');
        """
    }
    
    private func function1(params: [String: Any], callId: String) {
        let result = ["result": "function1 success", "value": 100]
        bridge?.sendResult(callId: callId, result: result)
    }
    
    private func function2(params: [String: Any], callId: String) {
        let result = ["result": "function2 success", "value": 200]
        bridge?.sendResult(callId: callId, result: result)
    }
}

// 2. 创建扩展提供者
class DemoExtensionProvider: StarlinkBridgeExtensionProvider {
    func configureBridgeExtensions(registry: StarlinkBridgeRegistry) {
        let demoAPI = DemoAPIExtension()
        registry.registerCustomModule(demoAPI, withName: "DemoAPI")
    }
}

// 3. 在 SceneDelegate 中使用
let extensionProvider = DemoExtensionProvider()
let rootViewController = StarlinkCore.shared.createWebViewRootViewController(
    extensionProvider: extensionProvider
)
window?.rootViewController = rootViewController
```

### JavaScript 中调用自定义 API

```javascript
// Promise 方式
const result1 = await window.Starlink.DemoAPI.function1();
console.log(result1); // {result: "function1 success", value: 100}

const result2 = await window.Starlink.DemoAPI.function2();
console.log(result2); // {result: "function2 success", value: 200}

// 回调方式
window.Starlink.DemoAPI.function1(function(result, error) {
    if (error) {
        console.error("Error:", error);
    } else {
        console.log("Success:", result);
    }
});
```

### 扩展管理

```swift
// 注册多个模块
registry.registerCustomModules([
    (UserAPI(), "User"),
    (PaymentAPI(), "Payment"),
    (AnalyticsAPI(), "Analytics")
])

// 检查模块是否存在
let hasModule = StarlinkBridgeRegistry.shared.hasModuleWithName("DemoAPI")

// 获取所有模块名称
let moduleNames = StarlinkBridgeRegistry.shared.getRegisteredModuleNames()

// 移除自定义模块
StarlinkBridgeRegistry.shared.removeCustomModule(withName: "DemoAPI")
```

## 📋 系统要求

- **iOS**: 16.0+
- **Xcode**: 14.0+
- **Swift**: 5.7+

## 🔒 许可证

私有框架，仅供授权团队使用。

---

## 🌟 核心功能

- **WebView 集成**: 完整的 WebView 控制器，支持调试和发布模式
- **JavaScript Bridge**: 原生 iOS API 的 JavaScript 桥接
- **本地服务器**: 内置 HTTP 服务器，支持 Vue.js 等前端项目
- **网络管理**: 自动网络权限监控和请求处理
- **IAP 支持**: 完整的应用内购买和订阅管理
- **可扩展架构**: 支持自定义 native API 扩展

## 📚 更多资源

- 📱 **示例项目**: 请访问源码仓库获取完整的 StarlinkDemo 示例项目
- 🌐 **JavaScript SDK 测试**: 请访问源码仓库获取 starlink-test-app 测试应用
- 📖 **API 文档**: 完整的桥接 API 文档包含在源码仓库中

### 版本更新
框架会定期发布新版本，请关注 [Releases](https://github.com/srulos-bgz/starlink-releases/releases) 页面获取最新版本。

#### v1.3.0 新特性
- ✨ **可扩展 JavaScript Bridge 系统**
- 🔧 **自定义 native API 支持**
- 📦 **模块化架构设计**
- 🔄 **向后兼容保证**
