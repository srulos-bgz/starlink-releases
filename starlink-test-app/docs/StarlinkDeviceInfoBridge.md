# Starlink Device Info Bridge Documentation

## Overview
The Starlink WebView automatically injects device and app information functionality into JavaScript through the native bridge. No additional JavaScript files are needed.

## Available Methods

## Combined Info Methods

### window.Starlink.DeviceInfo.getAllInfo()
Get all device and app information in one call.

**Returns:** Promise that resolves with complete device and app info object

### window.Starlink.DeviceInfo.getAllDeviceInfo()
Get all device-specific information.

**Returns:** Promise that resolves with device info object

### window.Starlink.DeviceInfo.getAllAppInfo()
Get all app-specific information.

**Returns:** Promise that resolves with app info object

## Device Info Methods

### window.Starlink.DeviceInfo.getDeviceModel()
Get the device model identifier.

**Returns:** Promise that resolves with device model string (e.g., "iPhone14,2")

### window.Starlink.DeviceInfo.getDeviceName()
Get the user-assigned device name.

**Returns:** Promise that resolves with device name string (e.g., "John's iPhone")

### window.Starlink.DeviceInfo.getSystemName()
Get the operating system name.

**Returns:** Promise that resolves with system name string (e.g., "iOS")

### window.Starlink.DeviceInfo.getSystemVersion()
Get the operating system version.

**Returns:** Promise that resolves with system version string (e.g., "17.0.1")

### window.Starlink.DeviceInfo.getIdentifierForVendor()
Get the vendor identifier (IDFV).

**Returns:** Promise that resolves with UUID string or `null`

### window.Starlink.DeviceInfo.getScreenScale()
Get the screen scale factor.

**Returns:** Promise that resolves with scale number (e.g., 2.0, 3.0)

### window.Starlink.DeviceInfo.getScreenSize()
Get the screen size in points.

**Returns:** Promise that resolves with size object `{width: number, height: number}`

### window.Starlink.DeviceInfo.isJailbroken()
Check if the device is jailbroken.

**Returns:** Promise that resolves with boolean value

## App Info Methods

### window.Starlink.DeviceInfo.getBundleIdentifier()
Get the app's bundle identifier.

**Returns:** Promise that resolves with bundle ID string (e.g., "com.company.app")

### window.Starlink.DeviceInfo.getAppVersion()
Get the app version.

**Returns:** Promise that resolves with version string (e.g., "1.2.3")

### window.Starlink.DeviceInfo.getBuildNumber()
Get the app build number.

**Returns:** Promise that resolves with build number string (e.g., "456")

### window.Starlink.DeviceInfo.getAppDisplayName()
Get the app display name.

**Returns:** Promise that resolves with display name string

### window.Starlink.DeviceInfo.getAppExecutableName()
Get the app executable name.

**Returns:** Promise that resolves with executable name string

### window.Starlink.DeviceInfo.getFirstInstallTime()
Get the app's first installation time.

**Returns:** Promise that resolves with timestamp string

### window.Starlink.DeviceInfo.getAppInstallTime()
Get the app's installation time.

**Returns:** Promise that resolves with timestamp string

## Usage Examples

```javascript
// Get all information at once
try {
    const allInfo = await window.Starlink.DeviceInfo.getAllInfo();
    console.log('Complete device and app info:', allInfo);
    /*
    Example response:
    {
        device: {
            model: "iPhone14,2",
            name: "John's iPhone",
            systemName: "iOS",
            systemVersion: "17.0.1",
            identifierForVendor: "12345678-1234-1234-1234-123456789012",
            screenScale: 3.0,
            screenSize: {width: 390, height: 844},
            isJailbroken: false
        },
        app: {
            bundleIdentifier: "com.company.myapp",
            version: "1.2.3",
            buildNumber: "456",
            displayName: "My App",
            executableName: "MyApp",
            firstInstallTime: "2023-01-15T10:30:00Z",
            installTime: "2023-01-15T10:30:00Z"
        }
    }
    */
} catch (error) {
    console.error('Failed to get device info:', error);
}

// Get device information only
try {
    const deviceInfo = await window.Starlink.DeviceInfo.getAllDeviceInfo();
    console.log('Device info:', deviceInfo);
} catch (error) {
    console.error('Failed to get device info:', error);
}

// Get app information only
try {
    const appInfo = await window.Starlink.DeviceInfo.getAllAppInfo();
    console.log('App info:', appInfo);
} catch (error) {
    console.error('Failed to get app info:', error);
}

// Get specific device properties
try {
    const model = await window.Starlink.DeviceInfo.getDeviceModel();
    const systemVersion = await window.Starlink.DeviceInfo.getSystemVersion();
    const screenSize = await window.Starlink.DeviceInfo.getScreenSize();
    const isJailbroken = await window.Starlink.DeviceInfo.isJailbroken();
    
    console.log('Device details:', {
        model,
        systemVersion,
        screenSize,
        isJailbroken
    });
} catch (error) {
    console.error('Failed to get device details:', error);
}

// Get specific app properties
try {
    const bundleId = await window.Starlink.DeviceInfo.getBundleIdentifier();
    const version = await window.Starlink.DeviceInfo.getAppVersion();
    const buildNumber = await window.Starlink.DeviceInfo.getBuildNumber();
    const displayName = await window.Starlink.DeviceInfo.getAppDisplayName();
    
    console.log('App details:', {
        bundleId,
        version,
        buildNumber,
        displayName
    });
} catch (error) {
    console.error('Failed to get app details:', error);
}

// Practical example - Device compatibility check
async function checkDeviceCompatibility() {
    try {
        const systemVersion = await window.Starlink.DeviceInfo.getSystemVersion();
        const screenSize = await window.Starlink.DeviceInfo.getScreenSize();
        const screenScale = await window.Starlink.DeviceInfo.getScreenScale();
        
        // Parse iOS version
        const versionParts = systemVersion.split('.');
        const majorVersion = parseInt(versionParts[0]);
        
        // Check compatibility
        const isCompatible = majorVersion >= 14; // Requires iOS 14+
        const isHighRes = screenScale >= 2.0;
        const isLargeScreen = screenSize.width >= 375;
        
        console.log('Compatibility check:', {
            systemVersion,
            isCompatible,
            isHighRes,
            isLargeScreen,
            screenInfo: {
                size: screenSize,
                scale: screenScale
            }
        });
        
        return {
            compatible: isCompatible && isHighRes,
            details: {
                systemVersion,
                screenSize,
                screenScale
            }
        };
    } catch (error) {
        console.error('Compatibility check failed:', error);
        return { compatible: false, error: error.message };
    }
}

// Practical example - App analytics info
async function getAnalyticsInfo() {
    try {
        const deviceInfo = await window.Starlink.DeviceInfo.getAllDeviceInfo();
        const appInfo = await window.Starlink.DeviceInfo.getAllAppInfo();
        
        return {
            device_model: deviceInfo.model,
            os_version: deviceInfo.systemVersion,
            app_version: appInfo.version,
            app_build: appInfo.buildNumber,
            screen_size: `${deviceInfo.screenSize.width}x${deviceInfo.screenSize.height}`,
            screen_scale: deviceInfo.screenScale,
            is_jailbroken: deviceInfo.isJailbroken,
            install_date: appInfo.firstInstallTime
        };
    } catch (error) {
        console.error('Failed to get analytics info:', error);
        return null;
    }
}

// Practical example - Security check
async function performSecurityCheck() {
    try {
        const isJailbroken = await window.Starlink.DeviceInfo.isJailbroken();
        const systemVersion = await window.Starlink.DeviceInfo.getSystemVersion();
        
        // Parse version for security check
        const versionParts = systemVersion.split('.');
        const majorVersion = parseInt(versionParts[0]);
        const minorVersion = parseInt(versionParts[1] || 0);
        
        // Check for minimum secure version (example: iOS 15.0+)
        const isSecureVersion = majorVersion > 15 || (majorVersion === 15 && minorVersion >= 0);
        
        const securityStatus = {
            isJailbroken,
            systemVersion,
            isSecureVersion,
            securityLevel: isJailbroken ? 'high_risk' : isSecureVersion ? 'secure' : 'medium_risk'
        };
        
        console.log('Security check:', securityStatus);
        return securityStatus;
    } catch (error) {
        console.error('Security check failed:', error);
        return { securityLevel: 'unknown', error: error.message };
    }
}
```

## Error Handling

All methods will reject their promises if:
- Native bridge is not available
- Device information cannot be accessed
- System permissions are denied

```javascript
try {
    const deviceModel = await window.Starlink.DeviceInfo.getDeviceModel();
    console.log('Device model:', deviceModel);
} catch (error) {
    console.error('Device info error:', error.message);
    // Handle error appropriately
}
```

## Notes
- This API is automatically available in Starlink WebView - no imports needed
- All device information is read-only
- IDFV (Identifier for Vendor) may be `null` in certain circumstances
- Jailbreak detection uses multiple heuristics but may not be 100% accurate
- Screen size is reported in points, not pixels (use scale factor for pixel calculations)
- Install times are provided as ISO 8601 formatted strings
- Only works within Starlink WebView environment (native bridge required)
