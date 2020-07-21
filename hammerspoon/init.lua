-- maps caps lock to control and escape
local HybridControl = require("hybrid_control")
HybridControl.start()

-- loads caffeine menubar icon
require("caffeine")

-- maps alt (opt) + hjkl to arrow keys
require("hjkl")

-- Defeat paste blocking
-- allows you to paste in fields that try to block you from copy/pasting your email or password
-- It emits a fake keyboard events to type the contents
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)


