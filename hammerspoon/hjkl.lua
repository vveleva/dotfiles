-- Map alt + hjkl to arrow keys
hs.hotkey.bind({"alt"}, "h", function() hs.eventtap.keyStroke({}, 'left') end)
hs.hotkey.bind({"alt"}, "j", function() hs.eventtap.keyStroke({}, 'down') end)
hs.hotkey.bind({"alt"}, "k", function() hs.eventtap.keyStroke({}, 'up') end)
hs.hotkey.bind({"alt"}, "l", function() hs.eventtap.keyStroke({}, 'right') end)


-- -- Disable arrow keys
-- hs.hotkey.bind({}, 'left', function() end)
-- hs.hotkey.bind({}, 'down', unction() end)
-- hs.hotkey.bind({}, 'up', function() end)
-- hs.hotkey.bind({}, 'right', function() end)

