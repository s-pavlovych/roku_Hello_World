function init()
    _initVars()
    centerAnimation()
end function

sub _initVars()
    m.top.visible = false
    m.loading = m.top.findNode("loading")
    m.background = m.top.findNode("background")
    m.top.observeField("isShown", "control")
    m.backAnimation = m.top.findNode("backAnimation")
end sub

sub centerAnimation()
    centerX = (1920 - m.loading.width) / 2
    centerY = 1080 / 2
    m.loading.translation = [centerX, centerY]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    ' ? "LoadingFacade function onKeyEvent("key" as string, "press" as boolean) as boolean"
    handled = true
    if press and key = "back"
        m.top.isShown = false
    end if
    return handled
end function

sub control(event)
    state = event.getData()
    if state = true
        m.loading.switch = true
        m.top.control = "start"
        m.top.visible = true
    else
        m.top.visible = false
        m.top.control = "stop"
        m.loading.switch = false
    end if
end sub