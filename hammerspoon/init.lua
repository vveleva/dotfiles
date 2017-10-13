local HybridControl = require("hybrid_control")

-- Map alt + hjkl to arrow keys
hs.hotkey.bind({"alt"}, "h", function() hs.eventtap.keyStroke({}, 'left') end)
hs.hotkey.bind({"alt"}, "j", function() hs.eventtap.keyStroke({}, 'down') end)
hs.hotkey.bind({"alt"}, "k", function() hs.eventtap.keyStroke({}, 'up') end)
hs.hotkey.bind({"alt"}, "l", function() hs.eventtap.keyStroke({}, 'right') end)

-- Disable arrow keys
hs.hotkey.bind({}, 'left', function() end)
hs.hotkey.bind({}, 'down', function() end)
hs.hotkey.bind({}, 'up', function() end)
hs.hotkey.bind({}, 'right', function() end)

-- Defeat paste blocking
-- allows you to paste in fields that try to block you from copy/pasting your email or password
-- It emits a fake keyboard events to type the contents
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)


HybridControl.start()
