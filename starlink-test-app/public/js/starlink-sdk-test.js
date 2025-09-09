/* Starlink SDK Test - Common JavaScript Functions */

// SDK Status Management
class StarlinkSDKStatus {
    constructor(moduleName, statusIndicatorId = 'statusIndicator', statusDetailsId = 'statusDetails') {
        this.moduleName = moduleName;
        this.statusIndicator = document.getElementById(statusIndicatorId);
        this.statusDetails = document.getElementById(statusDetailsId);
    }

    check() {
        if (!this.statusIndicator || !this.statusDetails) {
            console.error('Status elements not found');
            return false;
        }

        if (window.Starlink && window.Starlink[this.moduleName]) {
            this.setReady();
            return true;
        } else if (window.Starlink) {
            this.setModuleMissing();
            return false;
        } else {
            this.setBridgeNotFound();
            return false;
        }
    }

    setReady() {
        this.statusIndicator.className = 'status-indicator status-ready';
        this.statusDetails.innerHTML = `
            <div class="success">
                ✅ ${this.moduleName} SDK is available and ready!<br>
                🔗 Bridge: Connected (Native iOS Bridge)<br>
                📱 Platform: Starlink WebView<br>
                ⚡ Module: window.Starlink.${this.moduleName} loaded
            </div>
        `;
    }

    setModuleMissing() {
        this.statusIndicator.className = 'status-indicator status-warning';
        this.statusDetails.innerHTML = `
            <div class="error">
                ⚠️ ${this.moduleName} SDK module not found<br>
                🔗 Bridge: Connected but ${this.moduleName} module missing<br>
                📱 Platform: Starlink WebView<br>
                🚨 Issue: window.Starlink.${this.moduleName} not available
            </div>
        `;
    }

    setBridgeNotFound() {
        this.statusIndicator.className = 'status-indicator status-error';
        this.statusDetails.innerHTML = `
            <div class="error">
                ❌ Starlink Bridge not available<br>
                <strong>Expected:</strong> window.Starlink.${this.moduleName}<br>
                <strong>Current:</strong> Bridge not found<br>
                This page must be loaded within the Starlink WebView environment.
            </div>
        `;
    }

    setCustomStatus(type, message) {
        this.statusIndicator.className = `status-indicator status-${type}`;
        this.statusDetails.innerHTML = message;
    }
}

// Code Display Management
class CodeDisplay {
    constructor() {
        this.codeElements = new Map();
    }

    register(buttonId, codeId, code) {
        const button = document.getElementById(buttonId);
        const codeElement = document.getElementById(codeId);
        
        if (button && codeElement) {
            this.codeElements.set(buttonId, {
                button,
                codeElement,
                code,
                visible: false
            });

            button.addEventListener('click', () => this.toggle(buttonId));
        }
    }

    toggle(buttonId) {
        const item = this.codeElements.get(buttonId);
        if (!item) return;

        if (item.visible) {
            item.codeElement.style.display = 'none';
            item.button.textContent = 'Show Code';
            item.button.classList.remove('active');
            item.visible = false;
        } else {
            item.codeElement.innerHTML = `
                <div class="code-display">
                    <pre><code>${item.code}</code></pre>
                </div>
            `;
            item.codeElement.style.display = 'block';
            item.button.textContent = 'Hide Code';
            item.button.classList.add('active');
            item.visible = true;
        }
    }

    show(buttonId) {
        const item = this.codeElements.get(buttonId);
        if (!item || item.visible) return;
        this.toggle(buttonId);
    }

    hide(buttonId) {
        const item = this.codeElements.get(buttonId);
        if (!item || !item.visible) return;
        this.toggle(buttonId);
    }
}

// Result Display Management
class ResultDisplay {
    constructor(resultAreaId = 'result-area') {
        this.resultArea = document.getElementById(resultAreaId);
    }

    show(message, type = 'info') {
        if (!this.resultArea) return;
        
        this.resultArea.className = `result-area result-${type}`;
        this.resultArea.textContent = message;
    }

    showSuccess(message) {
        this.show(message, 'success');
    }

    showError(message) {
        this.show(message, 'error');
    }

    showInfo(message) {
        this.show(message, 'info');
    }

    clear() {
        if (!this.resultArea) return;
        
        this.resultArea.className = 'result-area';
        this.resultArea.textContent = 'Results will appear here...';
    }

    formatApiResult(method, params, result, success = true) {
        const timestamp = new Date().toLocaleString();
        const status = success ? '✅' : '❌';
        const title = success ? 'Success' : 'Failed';
        
        return `
${status} ${method} ${title}

📊 Parameters:
${Object.entries(params).map(([key, value]) => `   ${key}: ${value}`).join('\n')}

📱 Result:
${typeof result === 'object' ? JSON.stringify(result, null, 2) : result}

⏰ Timestamp: ${timestamp}
        `.trim();
    }
}

// Data Display for Info Cards
class InfoCardDisplay {
    constructor() {
        this.cards = new Map();
    }

    register(cardId, contentId) {
        const card = document.getElementById(cardId);
        const content = document.getElementById(contentId);
        
        if (card && content) {
            this.cards.set(cardId, { card, content });
        }
    }

    showLoading(cardId) {
        const item = this.cards.get(cardId);
        if (!item) return;

        item.content.innerHTML = `
            <div class="info-item">
                <span class="info-label">Status:</span>
                <span class="info-value"><span class="loading"></span> Loading...</span>
            </div>
        `;
    }

    showError(cardId, error) {
        const item = this.cards.get(cardId);
        if (!item) return;

        item.content.innerHTML = `
            <div class="error">
                <strong>Error:</strong> ${error}
            </div>
        `;
    }

    showData(cardId, data) {
        const item = this.cards.get(cardId);
        if (!item) return;

        let html = '';
        
        if (typeof data === 'object' && data !== null) {
            for (const [key, value] of Object.entries(data)) {
                let displayValue = value;
                
                // Format timestamps
                if ((key.includes('Time') || key.includes('time')) && typeof value === 'number' && value > 1000000000) {
                    displayValue = new Date(value * 1000).toLocaleString();
                }
                // Format nested objects
                else if (typeof value === 'object' && value !== null) {
                    displayValue = JSON.stringify(value, null, 2);
                }
                
                html += `
                    <div class="info-item">
                        <span class="info-label">${key}:</span>
                        <span class="info-value">${displayValue !== null ? displayValue : 'null'}</span>
                    </div>
                `;
            }
        } else {
            html = `
                <div class="info-item">
                    <span class="info-label">Value:</span>
                    <span class="info-value">${data}</span>
                </div>
            `;
        }
        
        html += `
            <div class="timestamp">
                Updated: ${new Date().toLocaleString()}
            </div>
        `;
        
        item.content.innerHTML = html;
    }
}

// Method Documentation Display
class MethodsDisplay {
    constructor(containerId = 'methods-container') {
        this.container = document.getElementById(containerId);
        this.methods = [];
    }

    addMethod(signature, description, autoCall = false) {
        this.methods.push({ signature, description, autoCall });
    }

    render() {
        if (!this.container) return;

        const html = `
            <div class="methods-section">
                <h3>📋 Available Methods</h3>
                ${this.methods.map(method => `
                    <div class="method-item">
                        <div class="method-signature">${method.signature}</div>
                        <div class="method-description">${method.description}</div>
                        ${method.autoCall ? '<span class="badge">Auto-called</span>' : ''}
                    </div>
                `).join('')}
            </div>
        `;

        this.container.innerHTML = html;
    }
}

// Utility Functions
const StarlinkUtils = {
    // Format API call for display
    formatApiCall(moduleName, methodName, params = {}) {
        const paramStr = Object.keys(params).length > 0 
            ? Object.entries(params).map(([key, value]) => 
                typeof value === 'string' ? `'${value}'` : value
              ).join(', ')
            : '';
        
        return `const result = await window.Starlink.${moduleName}.${methodName}(${paramStr});`;
    },

    // Create code comment block
    createCodeBlock(code) {
        return `// ===== NATIVE API CALL =====\n${code}\n// ===========================`;
    },

    // Escape HTML
    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    },

    // Deep clone object
    deepClone(obj) {
        return JSON.parse(JSON.stringify(obj));
    },

    // Check if value is timestamp
    isTimestamp(key, value) {
        return (key.includes('Time') || key.includes('time')) && 
               typeof value === 'number' && 
               value > 1000000000;
    },

    // Format timestamp
    formatTimestamp(timestamp) {
        return new Date(timestamp * 1000).toLocaleString();
    }
};

// Global initialization
document.addEventListener('DOMContentLoaded', function() {
    // Add theme class to body if specified
    const themeClass = document.body.getAttribute('data-theme');
    if (themeClass) {
        document.body.classList.add(`theme-${themeClass}`);
    }
});

// Export for use in other scripts
window.StarlinkSDK = {
    StarlinkSDKStatus,
    CodeDisplay,
    ResultDisplay,
    InfoCardDisplay,
    MethodsDisplay,
    StarlinkUtils
};
