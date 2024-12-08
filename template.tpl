{
  "template_name": "Google Consent Mode Manager",
  "template_description": "Manages Google Consent Mode using GTM. Dynamically updates consent states based on user preferences.",
  "author": "Cookiex",
  "icon_url": "https://cookiex.io/wp-content/uploads/2024/11/cookiex-logo-e1730715245710.png",
  "permissions": {
    "access_globals": [
      "window",
      "document"
    ],
    "inject_scripts": [
      "https://www.googletagmanager.com/gtm.js"
    ]
  },
  "fields": [
    {
      "type": "text",
      "name": "gtm_id",
      "label": "GTM ID",
      "description": "Enter your Google Tag Manager ID (e.g., GTM-XXXXXX).",
      "required": true
    },
    {
      "type": "checkbox",
      "name": "consent_categories",
      "label": "Consent Categories",
      "description": "Select the consent categories to grant.",
      "options": [
        { "value": "Necessary", "label": "Necessary" },
        { "value": "Preferences", "label": "Preferences" },
        { "value": "Marketing", "label": "Marketing" },
        { "value": "Statistics", "label": "Statistics" }
      ]
    }
  ],
  "code": {
    "html": "",
    "css": "",
    "javascript": [
      "// Fetch GTM ID and user-selected consent categories",
      "const gtmId = data.gtm_id;",
      "const categories = data.consent_categories || [];",

      "if (!gtmId) {",
      "  console.error('GTM ID is missing. Please configure it in the template settings.');",
      "  return;",
      "}",

      "// Load Google Tag Manager",
      "(function(w, d, s, l, i) {",
      "  w[l] = w[l] || [];",
      "  w[l].push({ 'gtm.start': new Date().getTime(), event: 'gtm.js' });",
      "  const f = d.getElementsByTagName(s)[0],",
      "        j = d.createElement(s),",
      "        dl = l !== 'dataLayer' ? '&l=' + l : '';",
      "  j.async = true;",
      "  j.src = 'https://www.googletagmanager.com/gtm.js?id=' + i + dl;",
      "  f.parentNode.insertBefore(j, f);",
      "})(window, document, 'script', 'dataLayer', gtmId);",

      "console.log(`GTM with ID ${gtmId} loaded.`);",

      "// Define default denied consent states",
      "const consentStates = {",
      "  ad_storage: 'denied',",
      "  analytics_storage: 'denied',",
      "  functionality_storage: 'denied',",
      "  personalization_storage: 'denied',",
      "  security_storage: 'denied'",
      "};",

      "// Map user-selected categories to consent states",
      "const categoryToState = {",
      "  Necessary: ['functionality_storage', 'security_storage'],",
      "  Preferences: ['personalization_storage'],",
      "  Marketing: ['ad_storage'],",
      "  Statistics: ['analytics_storage']",
      "};",

      "categories.forEach(category => {",
      "  categoryToState[category]?.forEach(state => {",
      "    consentStates[state] = 'granted';",
      "  });",
      "});",

      "// Update GCM consent states",
      "if (typeof window.gtag === 'function') {",
      "  window.gtag('consent', 'default', consentStates);",
      "  console.log('Consent states updated:', consentStates);",
      "} else {",
      "  console.warn('Google Tag (gtag) is not available.');",
      "}"
    ]
  }
}
