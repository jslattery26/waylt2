"use strict";
// All of the Node.js APIs are available in the preload process.
// It has the same sandbox as a Chrome extension.
window.require = require;
window.addEventListener('DOMContentLoaded', () => {
    var _a;
    const replaceText = (selector, text) => {
        const element = document.getElementById(selector);
        if (element) {
            element.innerText = text;
        }
    };
    for (const type of ['chrome', 'node', 'electron']) {
        replaceText(`${type}-version`, (_a = process.versions[type]) !== null && _a !== void 0 ? _a : 'yes');
    }
});
//# sourceMappingURL=preload.js.map