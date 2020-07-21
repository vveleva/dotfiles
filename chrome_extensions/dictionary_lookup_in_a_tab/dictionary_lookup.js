function getSelectionText() {
    let text = "";
    if (window.getSelection) {
        text = window.getSelection().toString();
    } else if (document.selection && document.selection.type != "Control") {
        text = document.selection.createRange().text;
    }
    return text;
}

function openInNewTab(url) {
  let win = window.open(url, '_blank');
  win.focus();
}

window.addEventListener('keypress', function(e) {
  let keys = {
    199: 'alt+shift+c',
    231: 'alt+c',
    212: 'alt+shift+j',
    216: 'alt+shift+o',
    248: 'alt+o',
    194: 'alt+shift+m',
  }
  let selectedText = getSelectionText();
  let cambridge = 'https://dictionary.cambridge.org/spellcheck/english-chinese-traditional/?q=%1F'
  let ldoceonline = 'https://www.ldoceonline.com/spellcheck/english-japanese/?q='
  let oxford = 'https://www.oxfordlearnersdictionaries.com/definition/english/word_1?q='
  let merriam = 'https://www.merriam-webster.com/dictionary/'

  console.log(e.keyCode);
  if (e.altKey && !!keys[e.keyCode]) {
    let urlDomain = ''
    if (e.keyCode == 199 || e.keyCode == 231) {
      urlDomain = cambridge
    } else if (e.keyCode == 212) {
      urlDomain = ldoceonline
    } else if (e.keyCode == 216 || e.keyCode == 248) {
      urlDomain = oxford
    } else if (e.keyCode == 194) {
      urlDomain = merriam
    }

    let url = urlDomain + selectedText;
    window.open(url, '_blank');
  }

}, false);

// chrome.commands.onCommand.addListener(function(command) {
//   console.log('onCommand event received for message: ', command);
// });

// Manifest
// {
//   "name": "Sample Extension Commands extension",
//     "description": "Press Ctrl+Shift+F (Command+Shift+F on a Mac) to open the browser action popup, press Ctrl+Shift+Y to send an event (Command+Shift+Y on a Mac).",
//     "version": "1.0",
//     "manifest_version": 2,
//     "background": {
//       "scripts": ["dictionary_lookup.js"],
//       "persistent": false
//     },
//     "browser_action": {
//       "default_popup": "browser_action.html"
//     },
//     "commands": {
//       "toggle-feature": {
//         "suggested_key": { "default": "Ctrl+Shift+Y" },
//         "description": "Send a 'toggle-feature' event to the extension"
//       },
//       "_execute_browser_action": {
//         "suggested_key": {
//           "default": "Ctrl+Shift+F",
//           "mac": "MacCtrl+Shift+F"
//         }
//       }
//     }
// }
