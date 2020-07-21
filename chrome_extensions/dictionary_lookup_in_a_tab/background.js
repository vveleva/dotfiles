var toggleOn = false;

chrome.browserAction.onClicked.addListener(function(tab) {
  toggleOn = !toggleOn;

  if (toggleOn) {
    chrome.browserAction.setBadgeText({ text: 'on' })
    chrome.tabs.executeScript(tab.id, {file:"editable_content.js"});
  } else {
    chrome.browserAction.setBadgeText({ text: '' })
    chrome.tabs.executeScript(tab.id, {file:"uneditable_content.js"});
  };
});
