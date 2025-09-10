# Starlink iOS SDK

A comprehensive iOS framework providing In-App Purchase management, JavaScript bridge functionality, WebView integration, network monitoring, and local HTTP server capabilities for hybrid iOS applications.

## Project Structure

```
SLSDK/
├── Starlink.xcworkspace/          # Main workspace
├── Starlink/                      # Framework project
│   ├── Starlink/
│   │   ├── Core/                 # Core framework components
│   │   │   ├── Bridge/           # JavaScript bridge modules
│   │   │   ├── IAP/              # In-App Purchase management
│   │   │   ├── WebView/          # WebView controllers
│   │   │   ├── Update/           # App update checking
│   │   │   └── Data/             # Data management
│   │   ├── Networking/           # Network utilities and monitoring
│   │   ├── Utilities/            # Helper utilities
│   │   ├── Logging/              # Logging system
│   │   ├── Frameworks/           # Third-party frameworks
│   │   ├── Starlink.h            # Public header
│   │   └── Info.plist            # Framework info
│   └── Starlink.xcodeproj/       # Framework Xcode project
└── StarlinkDemo/                  # Demo application
    ├── StarlinkDemo/
    │   ├── AppDelegate.swift
    │   ├── SceneDelegate.swift
    │   ├── ViewController.swift   # Demo UI implementation
    │   ├── Main.storyboard        # UI layout
    │   ├── LaunchScreen.storyboard
    │   ├── Assets.xcassets
    │   └── Info.plist
    └── StarlinkDemo.xcodeproj/    # Demo app Xcode project
```

## Features

### Core Framework
- **StarlinkCore**: Main framework class with singleton pattern
- **JavaScript Bridge System**: Complete JS bridge for native iOS API access
- **WebView Integration**: Full-featured WebView controllers for hybrid apps
- **Local HTTP Server**: Built-in web server for serving Vue.js projects and static files
- **Logging System**: Comprehensive logging with multiple levels

### In-App Purchase & Subscriptions
- **StarlinkIAPManager**: Complete IAP management with StoreKit 2
- **StarlinkSubscriptionManager**: Advanced subscription handling and status tracking
- **StarlinkIAPBridge**: JavaScript bridge for IAP functionality
- **Product Management**: Load, purchase, restore, and query products
- **Subscription Status**: Real-time subscription state monitoring
- **Transaction Handling**: Automatic transaction processing and validation

### JavaScript Bridge Modules
- **StarlinkIAPBridge**: In-App Purchase and subscription management
- **StarlinkAlertBridge**: Native alert and action sheet display
- **StarlinkDataBridge**: Data storage and retrieval
- **StarlinkDeviceInfoBridge**: Device information and capabilities
- **StarlinkUmengBridge**: Analytics integration
- **StarlinkNetworkBridge**: Network request handling
- **Custom Extension Support**: Extensible bridge system for business-specific APIs

### Network & Connectivity
- **StarlinkNetworkManager**: HTTP request handling and management
- **StarlinkNetworkPermissionMonitor**: Automatic network permission monitoring
- **Auto Permission Requests**: Proactive network access permission handling

### WebView & Hybrid App Support
- **StarlinkWebViewController**: Full-featured WebView controller
- **Debug/Release Modes**: Different behavior for development and production
- **Runtime Debug Mode**: Enable debug mode even when framework is built in Release mode
- **Update Checking**: Automatic app update verification
- **Local Server Integration**: Seamless local content serving

### Demo Application
- Interactive UI demonstrating all framework capabilities
- IAP and subscription testing interface
- WebView integration examples
- Network monitoring demonstration
- JavaScript bridge testing tools

## Getting Started

### Requirements
- iOS 16.0+
- Xcode 15.0+
- Swift 5.0+

### Opening the Project
1. Open `Starlink.xcworkspace` in Xcode
2. The workspace contains both the framework and demo projects
3. Build the framework first, then the demo app

### Building the Framework
1. Select the `Starlink` scheme
2. Choose your target device or simulator
3. Build the project (⌘+B)

### Running the Demo
1. Select the `StarlinkDemo` scheme
2. Choose your target device or simulator
3. Run the project (⌘+R)

## Framework Usage

### Basic Initialization
```swift
import Starlink

// Initialize the framework
StarlinkCore.shared.initialize()
```

### WebView Integration
```swift
// Present WebView controller from existing view controller
StarlinkCore.shared.presentWebViewController(from: self)

// Create root WebView controller for webview-based apps
let rootViewController = StarlinkCore.shared.createWebViewRootViewController()
window?.rootViewController = rootViewController

// Create WebView controller with custom extensions
let extensionProvider = MyExtensionProvider()
let rootViewController = StarlinkCore.shared.createWebViewRootViewController(
    extensionProvider: extensionProvider
)
window?.rootViewController = rootViewController

// Create WebView controller with debug mode enabled (useful when framework is built in Release mode)
let rootViewController = StarlinkCore.shared.createWebViewRootViewController(
    extensionProvider: nil,
    debugMode: true
)
window?.rootViewController = rootViewController

// Create standalone WebView controller
let webViewController = StarlinkCore.shared.createStandaloneWebViewController()
present(webViewController, animated: true)

// Enable debug mode on existing WebView controller
if let webVC = rootViewController.viewControllers.first as? StarlinkWebViewController {
    webVC.isDebugModeEnabled = true
}
```

### In-App Purchase Management
```swift
// Configure product IDs
let productIDs = ["com.yourapp.premium", "com.yourapp.subscription"]
StarlinkIAPManager.shared.configure(productIDs: productIDs)

// Load products
await StarlinkIAPManager.shared.loadProducts()

// Purchase a product
let result = await StarlinkIAPManager.shared.purchase(productID: "com.yourapp.premium")
switch result {
case .success(let transaction):
    print("Purchase successful: \(transaction)")
case .cancelled:
    print("Purchase cancelled")
case .failed(let error):
    print("Purchase failed: \(error)")
case .pending:
    print("Purchase pending")
}

// Restore purchases
await StarlinkIAPManager.shared.restorePurchases()

// Check if product is purchased
let isPurchased = StarlinkIAPManager.shared.isPurchased("com.yourapp.premium")
```

### Subscription Management
```swift
// Update subscription statuses
await StarlinkSubscriptionManager.shared.updateSubscriptionStatuses()

// Get active subscriptions
let activeSubscriptions = StarlinkSubscriptionManager.shared.activeSubscriptions

// Check subscription status
if let status = StarlinkSubscriptionManager.shared.subscriptionStatuses["com.yourapp.subscription"] {
    print("Subscription status: \(status)")
}

// Get subscription info
if let info = await StarlinkSubscriptionManager.shared.getSubscriptionInfo(for: "com.yourapp.subscription") {
    print("Subscription expires: \(info.expirationDate)")
    print("Auto-renew enabled: \(info.willAutoRenew)")
}
```

### Network Permission Monitoring
```swift
// Network monitoring starts automatically, but you can control it manually
StarlinkNetworkPermissionMonitor.shared.startMonitoring()

// Check network permission status
let hasPermission = await StarlinkNetworkPermissionMonitor.shared.checkNetworkPermission()

// Request network permission
await StarlinkNetworkPermissionMonitor.shared.requestNetworkPermission()

// Wait for network permission with completion handler
StarlinkNetworkPermissionMonitor.shared.waitForNetworkPermission { granted in
    if granted {
        print("Network permission granted")
    } else {
        print("Network permission denied")
    }
}
```

### Local HTTP Server
```swift
// Start local server for serving web content
let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
let webRootPath = (documentsPath as NSString).appendingPathComponent("WebRoot")

StarlinkCore.shared.startLocalServer(rootDirectory: webRootPath, port: 18888) { success, error in
    if success {
        print("Server started successfully!")
        if let url = StarlinkCore.shared.localServerURL {
            print("Server URL: \(url)")
        }
    } else {
        print("Failed to start server: \(error?.localizedDescription ?? "Unknown error")")
    }
}

// Stop the server
StarlinkCore.shared.stopLocalServer()

// Check server status
let isRunning = StarlinkCore.shared.isLocalServerRunning
let serverURL = StarlinkCore.shared.localServerURL
```

### JavaScript Bridge Usage
The framework provides JavaScript bridges that can be accessed from web content loaded in the WebView:

```javascript
// In-App Purchase from JavaScript
window.Starlink.IAP.configureProducts(['com.yourapp.premium', 'com.yourapp.subscription']);
window.Starlink.IAP.loadProducts();
window.Starlink.IAP.purchase('com.yourapp.premium');
window.Starlink.IAP.restorePurchases();

// Device information
window.Starlink.DeviceInfo.getDeviceInfo();
window.Starlink.DeviceInfo.getSystemVersion();

// Native alerts
window.Starlink.Alert.showAlert('Title', 'Message');
window.Starlink.Alert.showActionSheet('Title', ['Option 1', 'Option 2']);

// Data storage
window.Starlink.Data.setData('key', 'value');
window.Starlink.Data.getData('key');

// Network requests
window.Starlink.Network.request('GET', 'https://api.example.com/data');

// Custom extensions (if registered)
window.Starlink.MyCustomAPI.myMethod();
```

## API Reference

### StarlinkCore
- `shared`: Singleton instance
- `initialize()`: Initialize framework
- `presentWebViewController(from:)`: Present WebView controller
- `createWebViewRootViewController(extensionProvider:debugMode:)`: Create root WebView controller with optional extensions and debug mode
- `createStandaloneWebViewController()`: Create standalone WebView controller
- `startLocalServer(rootDirectory:port:completion:)`: Start HTTP server
- `stopLocalServer()`: Stop HTTP server
- `isLocalServerRunning`: Check if server is running
- `localServerURL`: Get server URL

### StarlinkIAPManager
- `shared`: Singleton instance
- `configure(productIDs:)`: Configure product IDs for IAP
- `loadProducts()`: Load products from App Store
- `purchase(productID:)`: Purchase a product
- `purchase(product:)`: Purchase a product object
- `restorePurchases()`: Restore previous purchases
- `isPurchased(_:)`: Check if product is purchased
- `products`: Array of available products
- `purchasedProductIDs`: Set of purchased product IDs

### StarlinkSubscriptionManager
- `shared`: Singleton instance
- `updateSubscriptionStatuses(forceRefresh:)`: Update subscription statuses
- `getSubscriptionInfo(for:)`: Get subscription information
- `activeSubscriptions`: Array of active subscriptions
- `subscriptionStatuses`: Dictionary of subscription statuses

### StarlinkNetworkPermissionMonitor
- `shared`: Singleton instance
- `startMonitoring()`: Start network monitoring
- `stopMonitoring()`: Stop network monitoring
- `checkNetworkPermission()`: Check current network permission
- `requestNetworkPermission()`: Request network permission
- `waitForNetworkPermission(completion:)`: Wait for permission with callback

### JavaScript Bridge Modules
- **StarlinkIAPBridge**: IAP and subscription management from JavaScript
- **StarlinkAlertBridge**: Native alerts and action sheets
- **StarlinkDataBridge**: Data storage and retrieval
- **StarlinkDeviceInfoBridge**: Device information access
- **StarlinkUmengBridge**: Analytics integration
- **StarlinkNetworkBridge**: Network request handling
- **StarlinkBridgeRegistry**: Extensible bridge system for custom APIs

### StarlinkWebViewController
- Full-featured WebView controller with debug/release modes
- Runtime debug mode support for framework usage (`isDebugModeEnabled` property)
- Automatic update checking and local server integration
- Navigation controls and error handling

## Debug Mode for Framework Usage

When the Starlink framework is built and distributed as a framework (`.xcframework`), the compile-time `#if DEBUG` flag is determined by the framework's build configuration, not the host application's configuration. This means that even if your host app is running in Debug mode, the framework will always use Release mode behavior.

### Problem
- Framework built in Release mode → `#if DEBUG` is always false
- Host app cannot access debug URL input dialog
- Difficult to test with local development servers

### Solution
The framework now provides runtime debug mode control:

```swift
// Method 1: Enable debug mode when creating WebView controller
let rootViewController = StarlinkCore.shared.createWebViewRootViewController(
    debugMode: true  // This enables debug mode regardless of build configuration
)

// Method 2: Enable debug mode on existing controller
if let webVC = navigationController.viewControllers.first as? StarlinkWebViewController {
    webVC.isDebugModeEnabled = true
}
```

### When to Use Debug Mode
- **Development**: Testing with local development servers (localhost:3000, etc.)
- **QA Testing**: Manual testing with different server configurations
- **Framework Integration**: When integrating the framework into other projects during development

### Behavior
- **Debug Mode Enabled**: Shows URL input dialog for custom server configuration
- **Debug Mode Disabled**: Uses automatic update check and local server startup (production behavior)

## Custom Bridge Extensions

The framework now supports extensible JavaScript bridge system, allowing business projects to add custom native APIs without modifying the SDK core.

### Creating Custom Bridge Extensions

```swift
import Starlink

// 1. Create custom bridge module
class MyCustomBridge: NSObject, StarlinkJSBridgeModule {
    private weak var bridge: StarlinkJSBridge?
    
    func setBridge(_ bridge: StarlinkJSBridge) {
        self.bridge = bridge
    }
    
    func handleCall(method: String, params: [String: Any], callId: String) {
        switch method {
        case "myMethod":
            myMethod(params: params, callId: callId)
        default:
            bridge?.sendResult(callId: callId, result: nil, error: "Method not found")
        }
    }
    
    func getJavaScriptInterface(moduleName: String) -> String {
        return """
        window.Starlink.\(moduleName) = {
            myMethod: function(data, callback) {
                return window.StarlinkBridge.call('\(moduleName)', 'myMethod', {
                    data: data
                }, callback);
            }
        };
        """
    }
    
    private func myMethod(params: [String: Any], callId: String) {
        let result = ["success": true, "message": "Custom method executed"]
        bridge?.sendResult(callId: callId, result: result)
    }
}

// 2. Create extension provider
class MyExtensionProvider: StarlinkBridgeExtensionProvider {
    func configureBridgeExtensions(registry: StarlinkBridgeRegistry) {
        let customBridge = MyCustomBridge()
        registry.registerCustomModule(customBridge, withName: "MyAPI")
    }
}

// 3. Use with WebView controller
let extensionProvider = MyExtensionProvider()
let rootViewController = StarlinkCore.shared.createWebViewRootViewController(
    extensionProvider: extensionProvider
)
```

### JavaScript Usage of Custom Extensions

```javascript
// Use custom API from JavaScript
const result = await window.Starlink.MyAPI.myMethod({key: "value"});
console.log(result); // {success: true, message: "Custom method executed"}

// Or with callback
window.Starlink.MyAPI.myMethod({key: "value"}, function(result, error) {
    if (error) {
        console.error("Error:", error);
    } else {
        console.log("Success:", result);
    }
});
```

### Extension Registry Management

```swift
// Register multiple modules
registry.registerCustomModules([
    (UserBridge(), "User"),
    (PaymentBridge(), "Payment"),
    (AnalyticsBridge(), "Analytics")
])

// Check if module exists
let hasModule = StarlinkBridgeRegistry.shared.hasModuleWithName("MyAPI")

// Get all registered module names
let moduleNames = StarlinkBridgeRegistry.shared.getRegisteredModuleNames()

// Remove custom module
StarlinkBridgeRegistry.shared.removeCustomModule(withName: "MyAPI")

// Clear all custom modules
StarlinkBridgeRegistry.shared.clearCustomModules()
```

## Integration into Other Projects

### Using the Framework
1. Build the Starlink framework
2. Add `Starlink.framework` to your target project
3. Import the framework: `import Starlink`
4. Initialize and use as shown in the usage examples

### Serving Vue.js Projects
1. Build your Vue.js project (`npm run build`)
2. Copy the `dist` folder contents to your iOS app's Documents/WebRoot directory
3. Start the local server pointing to the WebRoot directory
4. Access your Vue app at `http://localhost:18888`
5. Use JavaScript bridges to access native iOS functionality

### Hybrid App Development
The framework is perfect for creating hybrid iOS apps where:
- The entire UI is built with web technologies (Vue.js, React, etc.)
- Native iOS APIs are accessed through JavaScript bridges
- Local HTTP server serves the web content
- WebView controller handles the app lifecycle

## Dependencies

The framework includes the following dependencies:
- **ZipArchive**: For handling ZIP file operations
- **Umeng SDK**: For analytics and statistics (included frameworks)
  - UMCommon.xcframework: Core Umeng functionality
  - UMDevice.xcframework: Device information collection
  - UYuMao.xcframework: Advanced analytics features
  - UMCommonLog.framework: Logging functionality
  - UMRemoteConfig.framework: Remote configuration
  - UTDID.framework: Device identification

**Note**: Starting from version 1.6.0, all Umeng SDK dependencies are automatically included in the Starlink.xcframework distribution, eliminating the need for separate integration.

## Project Configuration

### Swift Package Dependencies
- ZipArchive: Used for archive operations

### Linker Flags
The project includes linker flags to suppress warnings from third-party frameworks:
```
OTHER_LDFLAGS = "-Wl,-no_warn_duplicate_libraries -Wl,-w"
```

## Architecture

The framework follows these design principles:
- **Modular Design**: Separate modules for different functionality (IAP, Network, WebView, etc.)
- **Singleton Pattern**: Shared instances for managers and core components
- **JavaScript Bridge System**: Seamless communication between web and native code
- **Async/Await**: Modern Swift concurrency for IAP and network operations
- **StoreKit 2**: Latest Apple APIs for In-App Purchases
- **iOS Best Practices**: Follows Apple's recommended patterns and guidelines

## Development Notes

### Network Permission Handling
- Network monitoring starts automatically on framework initialization
- Network permission requests are triggered proactively (0.1s delay)
- Automatic lightweight network requests to prompt system permission dialogs

### IAP and Subscription Management
- Full StoreKit 2 integration with comprehensive product data
- Automatic transaction listening and processing
- Subscription status caching and real-time updates
- JavaScript bridge exposes complete IAP functionality to web content

### WebView Integration
- Debug mode: URL input for development testing
- Release mode: Automatic update check → local server → web content loading
- Full-screen and embedded WebView controller options
- Automatic server lifecycle management

## License

Copyright © 2025 Starlink. All rights reserved.

## Repository

GitHub: https://github.com/srulos-bgz/Starlink.git

## Support

For questions or issues, please refer to the demo application for usage examples or contact the development team.
