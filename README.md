# Starlink iOS Framework

一个功能强大的 iOS WebView 框架，支持可扩展的 JavaScript Bridge 系统和原生 API 集成。

## 📦 安装方式

### Swift Package Manager

在你的 `Package.swift` 中添加：

```swift
dependencies: [
    .package(url: "https://github.com/srulos-bgz/starlink-releases", from: "1.8.2")
]
```

或在 Xcode 中：
1. File → Add Package Dependencies
2. 输入仓库 URL: `https://github.com/srulos-bgz/starlink-releases`
3. 选择版本 `1.8.2` 或更高版本

## 📋 使用示例

### 基础使用

```swift
import Starlink

// 在 SceneDelegate.swift 中
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // 基础使用 - 不带扩展
        let rootViewController = StarlinkCore.shared.createWebViewRootViewController()
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
```

### 调试模式

框架支持调试模式，方便开发时连接到本地开发服务器。推荐使用条件编译来自动切换：

```swift
#if DEBUG
let rootViewController = StarlinkCore.shared.createWebViewRootViewController(debugMode: true)
#else
let rootViewController = StarlinkCore.shared.createWebViewRootViewController(debugMode: false)
#endif
window?.rootViewController = rootViewController
```

**调试模式功能：**
- **debugMode: true** - 启动时显示 Action Sheet，提供两种输入方式：
  - 输入完整 HTTP 链接（如：http://192.168.1.100:3000）
  - 分别输入本地 IP 地址和端口号
- **debugMode: false** - 正常启动，加载内置的 Web 项目

**使用场景：**
- Debug 构建：自动启用调试模式，连接本地开发服务器
- Release 构建：自动使用内置 Web 资源

### 扩展使用和示例

#### 1. 扩展使用

```swift
import Starlink

// 在 SceneDelegate.swift 中
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // 带扩展使用
        let extensionProvider = DemoExtensionProvider()
        let rootViewController = StarlinkCore.shared.createWebViewRootViewController(
            extensionProvider: extensionProvider,
            debugMode: false
        )
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
```

#### 2. 创建自定义 API 模块

```swift
import Starlink

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
            bridge?.sendResult(callId: callId, result: nil, error: "Method '\(method)' not found in DemoAPI")
        }
    }
    
    func getJavaScriptInterface(moduleName: String) -> String {
        return \"\"\"
        window.Starlink.\(moduleName) = {
            function1: function(callback) {
                return window.StarlinkBridge.call('\(moduleName)', 'function1', {}, callback);
            },
            function2: function(callback) {
                return window.StarlinkBridge.call('\(moduleName)', 'function2', {}, callback);
            }
        };
        \"\"\"
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
```

#### 3. 创建扩展提供者

```swift
class DemoExtensionProvider: StarlinkBridgeExtensionProvider {
    func configureBridgeExtensions(registry: StarlinkBridgeRegistry) {
        let demoAPI = DemoAPIExtension()
        registry.registerCustomModule(demoAPI, withName: "DemoAPI")
    }
}
```

#### 4. JavaScript 调用

```javascript
// 调用自定义 API
window.Starlink.DemoAPI.function1((result) => {
    console.log('Function1 结果:', result);
});

window.Starlink.DemoAPI.function2((result) => {
    console.log('Function2 结果:', result);
});
```

### 内置 API 模块

框架提供以下内置模块：

- **StarlinkAlert**: 原生弹窗和提示
- **StarlinkData**: 数据存储和管理  
- **StarlinkDeviceInfo**: 设备信息获取
- **StarlinkLocation**: 位置服务
- **StarlinkNetwork**: 网络状态监控
- **StarlinkIAP**: 内购功能支持

## 🔄 兼容性

- **iOS**: 13.0+
- **Xcode**: 14.0+
- **Swift**: 5.7+

## 📚 更多资源

- [完整示例项目](https://github.com/srulos-bgz/starlink-test-app) - Native API 在 Web 项目中的完整使用示例
- [Demo 下载](https://gamepet.oss-cn-shenzhen.aliyuncs.com/Demo.zip) - 可运行的演示项目
- [更新日志](https://github.com/srulos-bgz/starlink-releases/releases)

## 🆕 最新更新 (v1.8.2)

### 🔧 运行时调试模式支持 (v1.7.0)
- **重要更新**: 解决了 framework 打包后无法进入调试模式的问题
- 新增 `isDebugModeEnabled` 属性，支持运行时控制调试模式
- 更新 `createWebViewRootViewController` 方法，添加 `debugMode` 参数
- 即使 framework 以 Release 模式构建，宿主应用仍可启用调试模式
- 完善的文档说明和使用示例
### 📦 完整的友盟SDK集成 (v1.6.0)
- **重要更新**: 修复了 "No such module 'UMCommon'" 错误
- 所有友盟SDK依赖现已自动包含在framework中：

查看完整更新日志: [Releases](https://github.com/srulos-bgz/starlink-releases/releases/tag/1.8.2)

---

**当前版本**: 1.8.2  
**Checksum**: 581f9a78b80b5dcb06b27094429ee65664e9fd4a2257ead46ff97f1f83630ffe
