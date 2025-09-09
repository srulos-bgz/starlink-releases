# Starlink IAP Bridge Documentation

## Overview
The Starlink WebView automatically injects In-App Purchase functionality into JavaScript through the native bridge. No additional JavaScript files are needed.

## Available Methods

## Basic IAP Operations

### window.Starlink.IAP.configure(productIDs)
Configure IAP with product identifiers.

**Parameters:**
- `productIDs` (Array, required) - Array of product identifier strings

**Returns:** Promise that resolves with `true` on success

### window.Starlink.IAP.loadProducts(forceRefresh)
Load products from App Store.

**Parameters:**
- `forceRefresh` (Boolean, optional) - Force refresh from App Store, defaults to `false`

**Returns:** Promise that resolves with array of product objects

### window.Starlink.IAP.getProducts()
Get all loaded products.

**Returns:** Promise that resolves with array of product objects

### window.Starlink.IAP.getProduct(productID)
Get specific product by ID.

**Parameters:**
- `productID` (String, required) - Product identifier

**Returns:** Promise that resolves with product object or `null`

### window.Starlink.IAP.purchase(productID)
Purchase a product.

**Parameters:**
- `productID` (String, required) - Product identifier to purchase

**Returns:** Promise that resolves with purchase result object

### window.Starlink.IAP.isPurchased(productID)
Check if product is purchased.

**Parameters:**
- `productID` (String, required) - Product identifier

**Returns:** Promise that resolves with boolean value

### window.Starlink.IAP.getPurchasedProducts()
Get all purchased product IDs.

**Returns:** Promise that resolves with array of purchased product ID strings

### window.Starlink.IAP.restorePurchases()
Restore previous purchases.

**Returns:** Promise that resolves with restore result object

### window.Starlink.IAP.canMakePayments()
Check if payments are allowed on this device.

**Returns:** Promise that resolves with boolean value

## Subscription Management

### window.Starlink.IAP.subscription.updateStatuses(forceRefresh)
Update subscription statuses.

**Parameters:**
- `forceRefresh` (Boolean, optional) - Force refresh from App Store, defaults to `false`

**Returns:** Promise that resolves with update result

### window.Starlink.IAP.subscription.getInfo(productID)
Get subscription information for a product.

**Parameters:**
- `productID` (String, required) - Subscription product identifier

**Returns:** Promise that resolves with subscription info object

### window.Starlink.IAP.subscription.hasActive(productID)
Check if user has active subscription.

**Parameters:**
- `productID` (String, required) - Subscription product identifier

**Returns:** Promise that resolves with boolean value

### window.Starlink.IAP.subscription.getGroup(groupID)
Get subscriptions in a group.

**Parameters:**
- `groupID` (String, required) - Subscription group identifier

**Returns:** Promise that resolves with array of subscription objects

### window.Starlink.IAP.subscription.cancel(productID)
Cancel subscription (opens App Store management).

**Parameters:**
- `productID` (String, required) - Subscription product identifier

**Returns:** Promise that resolves when App Store opens

### window.Starlink.IAP.subscription.getRenewalDate(productID)
Get subscription renewal date.

**Parameters:**
- `productID` (String, required) - Subscription product identifier

**Returns:** Promise that resolves with renewal date string or `null`

## Usage Examples

```javascript
// Basic IAP setup and product loading
try {
    // Configure with your product IDs
    const productIDs = ['com.myapp.premium', 'com.myapp.coins_100', 'com.myapp.monthly_sub'];
    await window.Starlink.IAP.configure(productIDs);
    
    // Check if payments are allowed
    const canPay = await window.Starlink.IAP.canMakePayments();
    if (!canPay) {
        console.log('Payments not allowed on this device');
        return;
    }
    
    // Load products from App Store
    const products = await window.Starlink.IAP.loadProducts();
    console.log('Available products:', products);
    /*
    Example products array:
    [
        {
            productIdentifier: "com.myapp.premium",
            localizedTitle: "Premium Features",
            localizedDescription: "Unlock all premium features",
            price: 9.99,
            priceLocale: "USD",
            localizedPrice: "$9.99"
        },
        ...
    ]
    */
} catch (error) {
    console.error('IAP setup failed:', error);
}

// Purchase a product
async function purchaseProduct(productID) {
    try {
        // Check if already purchased
        const isPurchased = await window.Starlink.IAP.isPurchased(productID);
        if (isPurchased) {
            console.log('Product already purchased');
            return;
        }
        
        // Make purchase
        const result = await window.Starlink.IAP.purchase(productID);
        console.log('Purchase successful:', result);
        /*
        Example result:
        {
            productIdentifier: "com.myapp.premium",
            transactionIdentifier: "1000000123456789",
            transactionDate: "2023-01-15T10:30:00Z",
            success: true
        }
        */
        
        // Handle successful purchase
        handlePurchaseSuccess(productID);
        
    } catch (error) {
        console.error('Purchase failed:', error);
        handlePurchaseError(error);
    }
}

// Restore purchases
async function restorePurchases() {
    try {
        const result = await window.Starlink.IAP.restorePurchases();
        console.log('Restore result:', result);
        
        // Get all purchased products after restore
        const purchasedProducts = await window.Starlink.IAP.getPurchasedProducts();
        console.log('Restored products:', purchasedProducts);
        
        // Update UI based on restored purchases
        updateUIForPurchases(purchasedProducts);
        
    } catch (error) {
        console.error('Restore failed:', error);
    }
}

// Subscription management
async function manageSubscriptions() {
    try {
        // Update subscription statuses
        await window.Starlink.IAP.subscription.updateStatuses(true);
        
        // Check specific subscription
        const subscriptionID = 'com.myapp.monthly_sub';
        const hasActive = await window.Starlink.IAP.subscription.hasActive(subscriptionID);
        
        if (hasActive) {
            // Get subscription details
            const subInfo = await window.Starlink.IAP.subscription.getInfo(subscriptionID);
            console.log('Active subscription:', subInfo);
            /*
            Example subscription info:
            {
                productIdentifier: "com.myapp.monthly_sub",
                isActive: true,
                expirationDate: "2023-02-15T10:30:00Z",
                renewalDate: "2023-02-15T10:30:00Z",
                isInGracePeriod: false,
                willAutoRenew: true
            }
            */
            
            // Get renewal date
            const renewalDate = await window.Starlink.IAP.subscription.getRenewalDate(subscriptionID);
            console.log('Next renewal:', renewalDate);
            
        } else {
            console.log('No active subscription');
        }
        
    } catch (error) {
        console.error('Subscription management failed:', error);
    }
}

// Get subscription group information
async function getSubscriptionGroup(groupID) {
    try {
        const subscriptions = await window.Starlink.IAP.subscription.getGroup(groupID);
        console.log('Subscriptions in group:', subscriptions);
        
        // Find active subscription in group
        const activeSubscription = subscriptions.find(sub => sub.isActive);
        if (activeSubscription) {
            console.log('Active subscription in group:', activeSubscription);
        }
        
        return subscriptions;
    } catch (error) {
        console.error('Failed to get subscription group:', error);
        return [];
    }
}

// Cancel subscription (opens App Store)
async function cancelSubscription(productID) {
    try {
        await window.Starlink.IAP.subscription.cancel(productID);
        console.log('Opened App Store for subscription management');
    } catch (error) {
        console.error('Failed to open subscription management:', error);
    }
}

// Practical example - Premium feature check
async function checkPremiumAccess() {
    try {
        const premiumProductID = 'com.myapp.premium';
        const subscriptionID = 'com.myapp.monthly_sub';
        
        // Check one-time purchase
        const hasPremium = await window.Starlink.IAP.isPurchased(premiumProductID);
        
        // Check subscription
        const hasActiveSubscription = await window.Starlink.IAP.subscription.hasActive(subscriptionID);
        
        const isPremiumUser = hasPremium || hasActiveSubscription;
        
        console.log('Premium access:', {
            hasPremium,
            hasActiveSubscription,
            isPremiumUser
        });
        
        return isPremiumUser;
    } catch (error) {
        console.error('Premium check failed:', error);
        return false;
    }
}

// Practical example - Product display
async function displayProducts() {
    try {
        const products = await window.Starlink.IAP.getProducts();
        const purchasedProducts = await window.Starlink.IAP.getPurchasedProducts();
        
        const productList = products.map(product => ({
            id: product.productIdentifier,
            title: product.localizedTitle,
            description: product.localizedDescription,
            price: product.localizedPrice,
            isPurchased: purchasedProducts.includes(product.productIdentifier)
        }));
        
        console.log('Product list for display:', productList);
        return productList;
    } catch (error) {
        console.error('Failed to display products:', error);
        return [];
    }
}

// Helper functions
function handlePurchaseSuccess(productID) {
    console.log(`Purchase successful for ${productID}`);
    // Update UI, unlock features, etc.
}

function handlePurchaseError(error) {
    console.error('Purchase error:', error);
    // Show user-friendly error message
    if (error.message.includes('cancelled')) {
        console.log('User cancelled purchase');
    } else if (error.message.includes('network')) {
        console.log('Network error during purchase');
    }
}

function updateUIForPurchases(purchasedProducts) {
    console.log('Updating UI for purchases:', purchasedProducts);
    // Update app UI based on purchased products
}
```

## Error Handling

All methods will reject their promises if:
- Native bridge is not available
- App Store connection fails
- User cancels purchase
- Product IDs are invalid
- Payments are restricted

```javascript
try {
    await window.Starlink.IAP.purchase('invalid_product_id');
} catch (error) {
    console.error('Purchase error:', error.message);
    // Handle specific error types
    if (error.message.includes('Product not found')) {
        // Handle invalid product ID
    } else if (error.message.includes('User cancelled')) {
        // Handle user cancellation
    }
}
```

## Notes
- This API is automatically available in Starlink WebView - no imports needed
- Configure product IDs before attempting to load or purchase products
- Always check `canMakePayments()` before showing purchase options
- Subscription status should be checked regularly and updated when app becomes active
- Use restore purchases for users who reinstall the app
- Subscription cancellation opens the App Store management page
- All prices are formatted according to the user's locale
- Only works within Starlink WebView environment (native bridge required)
