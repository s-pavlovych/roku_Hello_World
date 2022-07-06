function init()
    _initVars()
    setGroupTranslation()
end function

sub _initVars() 
m.group = m.top.findNode("group")
end sub

sub setGroupTranslation()
    centerX = 1280 /2
    centerY = 720 /2
    m.group.translation = [centerX, centerY]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    ? "function onKeyEvent("key" as string, "press" as boolean) as boolean"
    handled = false
    if press
        if key = "OK"
        end if
    end if
    return handled
end function