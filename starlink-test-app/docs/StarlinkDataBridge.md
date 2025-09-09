# Starlink Data Bridge Documentation

## Overview
The Starlink WebView automatically injects data storage functionality (UserDefaults and Keychain) into JavaScript through the native bridge. No additional JavaScript files are needed.

## Available Methods

## UserDefaults Operations

### window.Starlink.Data.userDefaults.set(key, value)
Store a value in UserDefaults.

**Parameters:**
- `key` (String, required) - Storage key
- `value` (Any, required) - Value to store (string, number, boolean, array, object)

**Returns:** Promise that resolves with `true` on success

### window.Starlink.Data.userDefaults.get(key)
Get a value from UserDefaults.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with the stored value or `null` if not found

### window.Starlink.Data.userDefaults.getString(key)
Get a string value from UserDefaults.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with string value or `null`

### window.Starlink.Data.userDefaults.getInt(key)
Get an integer value from UserDefaults.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with integer value or `0` if not found

### window.Starlink.Data.userDefaults.getBool(key)
Get a boolean value from UserDefaults.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with boolean value or `false` if not found

### window.Starlink.Data.userDefaults.getDouble(key)
Get a double value from UserDefaults.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with double value or `0.0` if not found

### window.Starlink.Data.userDefaults.getArray(key)
Get an array value from UserDefaults.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with array or `null` if not found

### window.Starlink.Data.userDefaults.getDictionary(key)
Get a dictionary/object value from UserDefaults.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with object or `null` if not found

### window.Starlink.Data.userDefaults.remove(key)
Remove a value from UserDefaults.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with `true` on success

### window.Starlink.Data.userDefaults.exists(key)
Check if a key exists in UserDefaults.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with `true` if key exists, `false` otherwise

### window.Starlink.Data.userDefaults.getAllKeys()
Get all UserDefaults keys.

**Returns:** Promise that resolves with array of all keys

## Keychain Operations

### window.Starlink.Data.keychain.set(key, value)
Store a secure string value in Keychain.

**Parameters:**
- `key` (String, required) - Storage key
- `value` (String, required) - String value to store securely

**Returns:** Promise that resolves with `true` on success

### window.Starlink.Data.keychain.get(key)
Get a secure string value from Keychain.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with string value or `null` if not found

### window.Starlink.Data.keychain.delete(key)
Delete a value from Keychain.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with `true` on success

### window.Starlink.Data.keychain.exists(key)
Check if a key exists in Keychain.

**Parameters:**
- `key` (String, required) - Storage key

**Returns:** Promise that resolves with `true` if key exists, `false` otherwise

### window.Starlink.Data.keychain.getAllKeys()
Get all Keychain keys.

**Returns:** Promise that resolves with array of all keys

## Usage Examples

```javascript
// UserDefaults - Basic operations
try {
    // Store different types of data
    await window.Starlink.Data.userDefaults.set('username', 'john_doe');
    await window.Starlink.Data.userDefaults.set('user_id', 12345);
    await window.Starlink.Data.userDefaults.set('is_premium', true);
    await window.Starlink.Data.userDefaults.set('settings', {theme: 'dark', notifications: true});
    await window.Starlink.Data.userDefaults.set('favorites', ['item1', 'item2', 'item3']);
    
    // Retrieve data
    const username = await window.Starlink.Data.userDefaults.getString('username');
    const userId = await window.Starlink.Data.userDefaults.getInt('user_id');
    const isPremium = await window.Starlink.Data.userDefaults.getBool('is_premium');
    const settings = await window.Starlink.Data.userDefaults.getDictionary('settings');
    const favorites = await window.Starlink.Data.userDefaults.getArray('favorites');
    
    console.log('User data:', {username, userId, isPremium, settings, favorites});
} catch (error) {
    console.error('UserDefaults error:', error);
}

// UserDefaults - Check existence and manage keys
try {
    const exists = await window.Starlink.Data.userDefaults.exists('username');
    if (exists) {
        console.log('Username is stored');
    }
    
    // Get all stored keys
    const allKeys = await window.Starlink.Data.userDefaults.getAllKeys();
    console.log('All UserDefaults keys:', allKeys);
    
    // Remove a key
    await window.Starlink.Data.userDefaults.remove('old_setting');
} catch (error) {
    console.error('UserDefaults management error:', error);
}

// Keychain - Secure storage
try {
    // Store sensitive data securely
    await window.Starlink.Data.keychain.set('api_token', 'secret_token_12345');
    await window.Starlink.Data.keychain.set('user_password', 'encrypted_password');
    
    // Retrieve secure data
    const apiToken = await window.Starlink.Data.keychain.get('api_token');
    const password = await window.Starlink.Data.keychain.get('user_password');
    
    if (apiToken) {
        console.log('API token retrieved from keychain');
        // Use token for API calls
    }
} catch (error) {
    console.error('Keychain error:', error);
}

// Keychain - Management operations
try {
    // Check if secure data exists
    const hasToken = await window.Starlink.Data.keychain.exists('api_token');
    if (hasToken) {
        console.log('API token is stored securely');
    }
    
    // Get all keychain keys
    const keychainKeys = await window.Starlink.Data.keychain.getAllKeys();
    console.log('Keychain keys:', keychainKeys);
    
    // Delete sensitive data when no longer needed
    await window.Starlink.Data.keychain.delete('old_token');
} catch (error) {
    console.error('Keychain management error:', error);
}

// Practical example - User session management
async function saveUserSession(user) {
    try {
        // Store non-sensitive data in UserDefaults
        await window.Starlink.Data.userDefaults.set('user_id', user.id);
        await window.Starlink.Data.userDefaults.set('username', user.username);
        await window.Starlink.Data.userDefaults.set('last_login', new Date().toISOString());
        
        // Store sensitive data in Keychain
        await window.Starlink.Data.keychain.set('access_token', user.accessToken);
        await window.Starlink.Data.keychain.set('refresh_token', user.refreshToken);
        
        console.log('User session saved successfully');
    } catch (error) {
        console.error('Failed to save user session:', error);
    }
}

async function loadUserSession() {
    try {
        // Load user data
        const userId = await window.Starlink.Data.userDefaults.getInt('user_id');
        const username = await window.Starlink.Data.userDefaults.getString('username');
        const lastLogin = await window.Starlink.Data.userDefaults.getString('last_login');
        
        // Load tokens
        const accessToken = await window.Starlink.Data.keychain.get('access_token');
        const refreshToken = await window.Starlink.Data.keychain.get('refresh_token');
        
        if (userId && accessToken) {
            return {
                id: userId,
                username,
                lastLogin,
                accessToken,
                refreshToken
            };
        }
        return null;
    } catch (error) {
        console.error('Failed to load user session:', error);
        return null;
    }
}

async function clearUserSession() {
    try {
        // Clear UserDefaults
        await window.Starlink.Data.userDefaults.remove('user_id');
        await window.Starlink.Data.userDefaults.remove('username');
        await window.Starlink.Data.userDefaults.remove('last_login');
        
        // Clear Keychain
        await window.Starlink.Data.keychain.delete('access_token');
        await window.Starlink.Data.keychain.delete('refresh_token');
        
        console.log('User session cleared');
    } catch (error) {
        console.error('Failed to clear user session:', error);
    }
}
```

## Error Handling

All methods will reject their promises if:
- Native bridge is not available
- Invalid parameters are provided
- Storage operation fails
- Key parameter is missing or invalid

```javascript
try {
    await window.Starlink.Data.userDefaults.set('', 'value'); // Invalid empty key
} catch (error) {
    console.error('Storage error:', error.message);
    // Error: "Missing or invalid key parameter"
}
```

## Notes
- This API is automatically available in Starlink WebView - no imports needed
- UserDefaults is suitable for app preferences, settings, and non-sensitive data
- Keychain provides secure storage for sensitive data like tokens and passwords
- All data persists between app launches
- UserDefaults can store various data types (strings, numbers, booleans, arrays, objects)
- Keychain only stores string values but provides encryption and security
- Only works within Starlink WebView environment (native bridge required)
