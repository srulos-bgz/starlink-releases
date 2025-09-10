# Starlink iOS Framework v1.7.0

## 🚀 新特性

### 🔧 运行时调试模式支持 (v1.7.0)
- **重要更新**: 解决了 framework 打包后无法进入调试模式的问题
- 新增 `isDebugModeEnabled` 属性，支持运行时控制调试模式
- 更新 `createWebViewRootViewController` 方法，添加 `debugMode` 参数
- 即使 framework 以 Release 模式构建，宿主应用仍可启用调试模式
- 完善的文档说明和使用示例

### 📦 完整的友盟SDK集成 (v1.6.0)
- **重要更新**: 修复了 "No such module 'UMCommon'" 错误
- 所有友盟SDK依赖现已自动包含在framework中：
  - UMCommon.xcframework: 核心友盟功能
  - UMDevice.xcframework: 设备信息收集
  - UYuMao.xcframework: 高级分析功能
  - UMCommonLog.framework: 日志功能
  - UMRemoteConfig.framework: 远程配置
  - UTDID.framework: 设备标识
- 更新了打包脚本，确保所有依赖都包含在分发包中
- 无需额外集成友盟SDK，开箱即用

### 🧹 代码清理和优化 (v1.5.0)
- 移除多余的UmengSDK文档文件
- 清理项目结构，减少不必要的资源文件
- 优化构建流程和包大小

### 🔧 Release Notes 自动化 (v1.4.0)
- 新增独立的 release-notes.md 模板系统
- 自动替换 checksum 和版本信息
- 改进发布流程的文档生成

### ✨ 可扩展 JavaScript Bridge 系统 (v1.3.0+)
- 引入全新的扩展架构，支持业务项目注入自定义 native API
- 新增 `StarlinkBridgeRegistry` 统一管理所有桥接模块
- 提供 `StarlinkBridgeExtensionProvider` 协议，简化扩展开发

### 🔧 自定义 API 支持 (v1.3.0+)
- 支持 Promise 和回调两种 JavaScript 调用方式
- 动态模块注册和移除
- 模块冲突检测和管理
- 完整的错误处理机制

### 📦 模块化架构 (v1.3.0+)
- 保持向后兼容，现有代码无需修改
- 清晰的扩展接口设计
- 统一的模块生命周期管理

## 📋 使用示例

### 创建自定义扩展

```swift
import Starlink

class DemoAPIExtension: NSObject, StarlinkJSBridgeModule {
    static let moduleName = "DemoAPI"
    
    func function1(params: [String: Any], callback: @escaping StarlinkJSCallback) {
        let result = ["message": "Hello from native!", "timestamp": Date().timeIntervalSince1970]
        callback(.success(result))
    }
}

class DemoExtensionProvider: StarlinkBridgeExtensionProvider {
    func getCustomBridgeModules() -> [StarlinkJSBridgeModule] {
        return [DemoAPIExtension()]
    }
}
```

### 集成到项目

```swift
let extensionProvider = DemoExtensionProvider()
let webViewController = StarlinkCore.createWebViewController(
    extensionProvider: extensionProvider
)
```

### JavaScript 调用

```javascript
// Promise 方式
const result = await window.StarlinkBridge.DemoAPI.function1({});

// 回调方式
window.StarlinkBridge.DemoAPI.function1({}, (result) => {
    console.log('Native API result:', result);
});
```

## 🔄 兼容性

- **iOS**: 16.0+
- **Xcode**: 14.0+
- **Swift**: 5.7+
- 完全向后兼容，现有项目无需修改

## 📦 安装方式

在你的 `Package.swift` 中添加：

```swift
dependencies: [
    .package(url: "https://github.com/srulos-bgz/starlink-releases", from: "1.7.0")
]
```

## 📚 文档

完整的扩展开发指南和 API 文档请访问：
- [GitHub Repository](https://github.com/srulos-bgz/starlink-releases)
- StarlinkDemo 示例项目

---

**Checksum**: `c2b6c5282d3635cc1e5cb0cce6f775f8bffdd83edf769ddaaec728fde2c9f340`
