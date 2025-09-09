# Starlink Umeng Bridge Documentation

## Overview
The Starlink WebView automatically injects Umeng SDK functionality into JavaScript through the native bridge. No additional JavaScript files are needed.

## Available Methods

### window.Starlink.Umeng.init(appKey, channel)
Initialize Umeng SDK with app key and channel.

**Parameters:**
- `appKey` (String, required) - Your Umeng application key from Umeng console
- `channel` (String, optional) - Distribution channel, defaults to "App Store"

**Returns:** Promise that resolves with `true` on success

## Usage Examples

```javascript
// Basic initialization
try {
    const result = await window.Starlink.Umeng.init('your_umeng_app_key');
    console.log('Umeng SDK initialized successfully:', result);
} catch (error) {
    console.error('Failed to initialize Umeng SDK:', error);
}

// Initialize with custom channel
try {
    await window.Starlink.Umeng.init('your_umeng_app_key', 'TestFlight');
    console.log('Umeng SDK initialized with TestFlight channel');
} catch (error) {
    console.error('Initialization failed:', error);
}

// Initialize with different channels
await window.Starlink.Umeng.init('your_key', 'App Store');     // App Store distribution
await window.Starlink.Umeng.init('your_key', 'Enterprise');   // Enterprise distribution
await window.Starlink.Umeng.init('your_key', 'Debug');        // Debug builds
```

## Error Handling

The method will reject the promise if:
- `appKey` is missing or empty
- Native bridge is not available
- Umeng SDK initialization fails

```javascript
try {
    await window.Starlink.Umeng.init('', 'App Store');
} catch (error) {
    // Error: "Missing or invalid appKey parameter"
}
```

## Notes
- This API is automatically available in Starlink WebView - no imports needed
- The app key must be obtained from your Umeng console
- Channel parameter helps track different distribution sources for analytics
- Should be called early in your app lifecycle, typically on page load
- Only works within Starlink WebView environment (native bridge required)
