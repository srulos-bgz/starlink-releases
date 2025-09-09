# Starlink Alert Bridge Documentation

## Overview
The Starlink WebView automatically injects native iOS alert functionality into JavaScript through the native bridge. No additional JavaScript files are needed.

## Available Methods

### window.Starlink.Alert.alert(message, title, buttonText)
Show native iOS alert dialog.

**Parameters:**
- `message` (String, required) - Alert message text
- `title` (String, optional) - Alert title, defaults to "Alert"
- `buttonText` (String, optional) - Button text, defaults to "OK"

**Returns:** Promise that resolves with `true` when alert is dismissed

### window.Starlink.Alert.confirm(message, title, confirmText, cancelText)
Show native iOS confirm dialog.

**Parameters:**
- `message` (String, required) - Confirm message text
- `title` (String, optional) - Dialog title, defaults to "Confirm"
- `confirmText` (String, optional) - Confirm button text, defaults to "OK"
- `cancelText` (String, optional) - Cancel button text, defaults to "Cancel"

**Returns:** Promise with boolean result (`true` for confirm, `false` for cancel)

### window.Starlink.Alert.prompt(message, title, placeholder, defaultValue, confirmText, cancelText)
Show native iOS prompt dialog for text input.

**Parameters:**
- `message` (String, required) - Prompt message text
- `title` (String, optional) - Dialog title, defaults to "Input"
- `placeholder` (String, optional) - Input placeholder text
- `defaultValue` (String, optional) - Default input value
- `confirmText` (String, optional) - Confirm button text, defaults to "OK"
- `cancelText` (String, optional) - Cancel button text, defaults to "Cancel"

**Returns:** Promise with input text string or `null` if cancelled

### window.Starlink.Alert.actionSheet(title, message, actions, cancelText)
Show native iOS action sheet (iPad compatible).

**Parameters:**
- `title` (String, optional) - Action sheet title
- `message` (String, optional) - Action sheet message
- `actions` (Array, required) - Array of action button titles
- `cancelText` (String, optional) - Cancel button text, defaults to "Cancel"

**Returns:** Promise with selected action index (0-based) or `-1` for cancel

## Native Function Override
The bridge automatically overrides the standard web `alert()`, `confirm()`, and `prompt()` functions to use native iOS dialogs for seamless integration.

## Usage Examples

```javascript
// Basic alert
try {
    await window.Starlink.Alert.alert('Hello World!');
    console.log('Alert dismissed');
} catch (error) {
    console.error('Alert failed:', error);
}

// Custom alert with title and button
await window.Starlink.Alert.alert('Operation completed successfully!', 'Success', 'Got it');

// Confirm dialog
try {
    const confirmed = await window.Starlink.Alert.confirm('Are you sure you want to delete this item?', 'Confirmation');
    if (confirmed) {
        console.log('User confirmed deletion');
        // Proceed with deletion
    } else {
        console.log('User cancelled');
    }
} catch (error) {
    console.error('Confirm failed:', error);
}

// Custom confirm with button texts
const result = await window.Starlink.Alert.confirm(
    'Save changes before closing?', 
    'Unsaved Changes', 
    'Save', 
    'Discard'
);

// Prompt for input
try {
    const name = await window.Starlink.Alert.prompt('Enter your name:', 'User Input', 'Name here...');
    if (name !== null) {
        console.log('User entered:', name);
    } else {
        console.log('User cancelled input');
    }
} catch (error) {
    console.error('Prompt failed:', error);
}

// Full prompt with all parameters
const email = await window.Starlink.Alert.prompt(
    'Please enter your email address:',
    'Email Registration',
    'user@example.com',
    '',
    'Submit',
    'Skip'
);

// Action sheet
try {
    const selectedIndex = await window.Starlink.Alert.actionSheet(
        'Choose an action',
        'What would you like to do?',
        ['Edit', 'Share', 'Delete'],
        'Cancel'
    );
    
    switch (selectedIndex) {
        case 0:
            console.log('User chose Edit');
            break;
        case 1:
            console.log('User chose Share');
            break;
        case 2:
            console.log('User chose Delete');
            break;
        case -1:
            console.log('User cancelled');
            break;
    }
} catch (error) {
    console.error('Action sheet failed:', error);
}

// Using overridden native functions (works seamlessly)
alert('This uses native iOS alert!');
const confirmed = confirm('This uses native iOS confirm!');
const input = prompt('This uses native iOS prompt!');
```

## Error Handling

All methods will reject their promises if:
- Native bridge is not available
- Invalid parameters are provided
- Native dialog presentation fails

```javascript
try {
    await window.Starlink.Alert.alert('', 'Empty Message Test');
} catch (error) {
    // Handle error appropriately
    console.error('Alert error:', error.message);
}
```

## Notes
- This API is automatically available in Starlink WebView - no imports needed
- All dialogs use native iOS styling and behavior
- Action sheets automatically adapt for iPad (popover presentation)
- The native function overrides provide seamless integration with existing web code
- Only works within Starlink WebView environment (native bridge required)
