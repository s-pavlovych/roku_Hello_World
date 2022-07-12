function init()
    _initVars()
    centerAnimation()
end function

sub _initVars()
    m.loading = m.top.findNode("loading")
    m.background = m.top.findNode("background")
end sub

sub centerAnimation()
    centerX = (1920 - m.loading.width) / 2
    centerY = 1080 / 2
    m.loading.translation = [centerX, centerY]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    ? "LoadingFacade function onKeyEvent("key" as string, "press" as boolean) as boolean"
    handled = true
    if press and key = "back"
        m.top.isShown = not m.top.isShown
    end if
    return handled
end function