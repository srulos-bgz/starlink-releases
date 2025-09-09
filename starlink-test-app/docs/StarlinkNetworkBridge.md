# Starlink Network Bridge Documentation

## Overview

The Starlink Network Bridge provides a unified HTTP request interface for web applications within the Starlink WebView. This module supports both regular requests and signed requests with anti-replay protection, along with CORS support for cross-origin requests.

## Features

- Unified HTTP request interface (GET, POST, PUT, DELETE, PATCH)
- Anti-replay protection with signed requests
- Automatic JSON response parsing
- CORS support for cross-origin requests
- Custom headers and parameters
- Comprehensive error handling

## Available Methods

### window.Starlink.Network.request(options)

Make a regular HTTP request.

**Parameters:**
- `options` (Object, required) - Request configuration object
  - `url` (String, required) - Request URL
  - `method` (String, optional) - HTTP method, defaults to 'GET'
  - `parameters` (Object, optional) - Request parameters
  - `headers` (Object, optional) - Custom request headers

**Returns:** Promise that resolves with parsed JSON response data

### window.Starlink.Network.signedRequest(options)

Make a signed HTTP request with anti-replay protection. Parameters are the same as `request()`.

**Signature Mechanism:**
- Automatically adds timestamp (X-Timestamp header)
- Automatically adds nonce (X-Nonce header)
- Automatically generates SHA256 signature (X-Signature header)

**Returns:** Promise that resolves with parsed JSON response data

## Usage Examples

```javascript
// Basic GET request
try {
    const data = await window.Starlink.Network.request({
        url: 'https://api.example.com/users/123'
    });
    console.log('User data:', data);
} catch (error) {
    console.error('Request failed:', error);
}

// POST request with parameters
const result = await window.Starlink.Network.request({
    url: 'https://api.example.com/users',
    method: 'POST',
    parameters: {
        name: 'John Doe',
        email: 'john@example.com'
    },
    headers: {
        'Authorization': 'Bearer token123'
    }
});

// Signed request for sensitive operations
const secureResult = await window.Starlink.Network.signedRequest({
    url: 'https://api.example.com/secure/update',
    method: 'PUT',
    parameters: {
        userId: 123,
        sensitiveData: 'confidential information'
    }
});

// Complex request with full configuration
const response = await window.Starlink.Network.request({
    url: 'https://api.example.com/data',
    method: 'POST',
    parameters: {
        page: 1,
        limit: 10,
        filters: {
            status: 'active',
            category: 'premium'
        }
    },
    headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + authToken,
        'X-Client-Version': '1.0.0'
    }
});
```

## Error Handling

All methods return promises that can be handled with try-catch or .catch():

```javascript
// Using try-catch
try {
    const data = await window.Starlink.Network.request({
        url: 'https://api.example.com/data'
    });
    console.log('Success:', data);
} catch (error) {
    console.error('Request failed:', error.message);
}

// Using .catch()
window.Starlink.Network.request({
    url: 'https://api.example.com/data'
})
.then(data => {
    console.log('Success:', data);
})
.catch(error => {
    console.error('Request failed:', error.message);
});

// Comprehensive error handling
async function makeRequest(config) {
    try {
        const response = await window.Starlink.Network.request(config);
        return { success: true, data: response };
    } catch (error) {
        console.error('Request failed:', error);
        return { 
            success: false, 
            error: error.message || 'Unknown error' 
        };
    }
}
```

## Common Error Types

- `Missing or invalid url parameter` - URL parameter is missing or invalid
- `Invalid HTTP method` - HTTP method is not supported
- `Failed to parse response` - Response parsing failed
- `Request failed` - Network request failed

## CORS Support

StarlinkNetworkBridge provides CORS support for cross-origin requests. The primary focus is on HTTP requests through the bridge interface.

## Best Practices

### 1. Request Configuration

```javascript
// Recommended request configuration
const config = {
    url: 'https://api.example.com/data',
    method: 'POST',
    parameters: {
        // Use clear parameter names
        userId: 123,
        action: 'create',
        timestamp: Date.now()
    },
    headers: {
        // Set appropriate Content-Type
        'Content-Type': 'application/json',
        // Add authentication headers
        'Authorization': 'Bearer ' + authToken,
        // Add client identification
        'X-Client-Platform': 'iOS'
    }
};
```

### 2. When to Use Signed Requests

Use `signedRequest` for:
- Sensitive data operations
- User authentication requests
- Payment-related APIs
- Operations requiring anti-replay protection

```javascript
// Use signed requests for sensitive operations
const paymentResult = await window.Starlink.Network.signedRequest({
    url: 'https://api.example.com/payment/process',
    method: 'POST',
    parameters: {
        amount: 100.00,
        currency: 'USD',
        orderId: 'order_' + Date.now(),
        paymentMethod: 'card'
    }
});
```

### 3. Response Handling

```javascript
// Proper response handling
async function handleApiCall(config) {
    try {
        const response = await window.Starlink.Network.request(config);
        
        // Check if response has expected structure
        if (response && response.status === 'success') {
            return response.data;
        } else {
            throw new Error(response.message || 'API returned error');
        }
    } catch (error) {
        // Log error for debugging
        console.error('API call failed:', error);
        
        // Return user-friendly error
        throw new Error('Operation failed. Please try again.');
    }
}
```

## Implementation Details

### Architecture

The StarlinkNetworkBridge uses a unified request handling architecture with flexible JSON response processing:

```swift
public class StarlinkNetworkBridge: StarlinkJSBridgeModule {
    // Unified HTTP request handler
    private func handleHttpRequest(params: [String: Any], callId: String) {
        let isSigned = params["signed"] as? Bool ?? false
        
        let completionHandler: (Result<Data, StarlinkNetworkManager.NetworkError>) -> Void = { result in
            switch result {
            case .success(let data):
                // Parse JSON manually to get [String: Any]
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        self.bridge?.sendResult(callId: callId, result: json)
                    } else {
                        // If not a dictionary, wrap the response
                        let wrappedResponse: [String: Any] = ["data": try JSONSerialization.jsonObject(with: data)]
                        self.bridge?.sendResult(callId: callId, result: wrappedResponse)
                    }
                } catch {
                    self.bridge?.sendResult(callId: callId, result: nil, error: "Failed to parse response: \(error.localizedDescription)")
                }
            case .failure(let error):
                self.bridge?.sendResult(callId: callId, result: nil, error: error.localizedDescription)
            }
        }
        
        if isSigned {
            StarlinkNetworkManager.shared.signedRequest(responseType: Data.self, completion: completionHandler)
        } else {
            StarlinkNetworkManager.shared.request(responseType: Data.self, completion: completionHandler)
        }
    }
}
```

### Key Features

1. **Unified Processing**: Single `handleHttpRequest` method handles both signed and unsigned requests
2. **Flexible JSON Parsing**: Uses `JSONSerialization` for maximum compatibility with different API response formats
3. **Raw Data Processing**: Requests `Data.self` type to avoid JSONDecoder constraints
4. **Plain JSON Support**: Removed ISO8601 date decoding strategy to handle all responses as plain JSON
5. **Error Handling**: Comprehensive error handling with detailed error messages

### JSON Response Processing

The bridge now uses a two-stage JSON processing approach:

1. **StarlinkNetworkManager**: Returns raw `Data` without JSON decoding
2. **StarlinkNetworkBridge**: Uses `JSONSerialization` to parse JSON flexibly

This approach ensures compatibility with various API response formats, including:
- Standard JSON objects: `{"status": "success", "data": {...}}`
- Timestamp responses: `{"data": 1757414798674, "message": "成功", "status": 0}`
- Array responses: `[{"id": 1}, {"id": 2}]`
- Simple values: `"success"` or `123`

## Version History

### v1.2.0 (Current)
- Removed ISO8601 date decoding strategy for plain JSON support
- Added special handling for Data type in StarlinkNetworkManager
- Improved JSON response parsing flexibility
- Enhanced compatibility with various API response formats
- Updated test interface to be more generic and flexible

### v1.1.0
- Merged `handleRequest` and `handleSignedRequest` methods
- Removed `uploadFile` and `downloadFile` interfaces
- Simplified method routing logic
- Improved error handling mechanism

### v1.0.0
- Initial release
- Basic HTTP request support
- Signed request support

## Notes

- This API is automatically available in Starlink WebView - no imports needed
- All requests are processed through the native iOS network stack
- CORS support enables cross-origin requests
- Only works within Starlink WebView environment (native bridge required)
- Signed requests provide additional security for sensitive operations
