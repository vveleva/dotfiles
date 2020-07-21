local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("💚") -- "☕" awake ❤️ 💔
    else
        caffeine:setTitle("💔") -- "😴" sleepy
    end
    -- 🌕 🌖 🌗 🌘 🌑 🌒 🌓 🌔 🌕
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
