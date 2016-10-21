local should_send_escape = true
local was_ctrl_down = false

local escape_key_timeout = hs.timer.delayed.new(
  .25,
  function() should_send_escape = false end
)

function handle_flags_changed(event)
  local is_ctrl_down = event:getFlags()["ctrl"]

  if was_ctrl_down == is_ctrl_down then return end

  was_ctrl_down = is_ctrl_down

  if is_ctrl_down then
    should_send_escape = true
    escape_key_timeout:start()
  else
    if should_send_escape then
      hs.eventtap.keyStroke({}, "ESCAPE")
    end
    escape_key_timeout:stop()
  end
end

function handle_key_down(event)
  -- print(hs.inspect(event:getRawEventData()))
    should_send_escape = false
  end
end

local flags_changed_listener = hs.eventtap.new(
  {hs.eventtap.event.types.flagsChanged},
  handle_flags_changed
)

local key_down_listener = hs.eventtap.new(
  {hs.eventtap.event.types.keyDown},
  handle_key_down
)

flags_changed_listener:start()
key_down_listener:start()

-- Map alt + hjkl to arrow keys
hs.hotkey.bind({"alt"}, "h", function() hs.eventtap.keyStroke({}, 'left') end)
hs.hotkey.bind({"alt"}, "j", function() hs.eventtap.keyStroke({}, 'down') end)
hs.hotkey.bind({"alt"}, "k", function() hs.eventtap.keyStroke({}, 'up') end)
hs.hotkey.bind({"alt"}, "l", function() hs.eventtap.keyStroke({}, 'right') end)

local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end
hs.hotkey.bind({"cmd","alt","shift"}, "D", mouseHighlight)



hs.urlevent.bind("someAlert", function(eventName, params)
hs.alert.show("Received someAlert")
end)


-- Defeat paste blocking
-- allows you to paste in fields that try to block you from copy/pasting your email or password
-- It emits a fake keyboard events to type the contents
hs.hotkey.bind({"cmd", "alt"}, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)
