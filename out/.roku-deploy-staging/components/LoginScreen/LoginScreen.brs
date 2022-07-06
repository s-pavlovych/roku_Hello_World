function init()
    _initVars()
    setGroupTranslation()
    setPosterTranslation()
end function

sub _initVars()
    m.group = m.top.findNode("group")
    m.login = m.top.findNode("login")
    m.password = m.top.findNode("password")
    m.enter = m.top.findNode("enter")
    m.logo = m.top.findNode("logo")
    m.enter.ObserveField("buttonSelected", "loading")
end sub

sub setPosterTranslation()
    centerX = (1280 /2) - (m.logo.width /2)
    m.logo.translation = [centerX, 100]
end sub

sub setGroupTranslation()
    centerX = 1280 / 2
    centerY = 720 / 2
    m.group.translation = [centerX, centerY]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    ? "LoginScreen function onKeyEvent("key" as string, "press" as boolean) as boolean"
    handled = false
    if press and key = "OK"
        if m.login.hasFocus() = true
            keyboardOpen("login")
            handled = true
        else if m.password.hasFocus() = true
            keyboardOpen("password")
            handled = true
        end if
    end if
    return handled
end function

sub keyboardOpen(field as string)
    m.keyboard = m.top.createChild("StandardKeyboardDialog")
    m.keyboard.title = field
    m.keyboard.message = ["Please, enter your " + field + " here"]
    m.keyboard.buttons = ["OK", "Cancel"]
    m.keyboard.setFocus(true)
    m.keyboard.ObserveField("buttonSelected", "keyboardClose")
end sub

sub keyboardClose(event)
    key = event.getData()
    if key = 0
        if m.keyboard.title = "login"
            m.login.text = m.keyboard.text
        else
            m.password.text = m.keyboard.text
        end if
    m.top.removeChild(m.keyboard)
    m.group.setFocus(true)
    else
    m.top.removeChild(m.keyboard)
    m.group.setFocus(true)
    end if
end sub

sub loading()
    m.loadingScreen = m.top.createChild("LoadingFacade")
    m.loadingScreen.setFocus(true)
    m.loadingScreen.ObserveField("isShown", "success")
end sub

sub success(event)
    x = event.getData()
    m.top.removeChild(m.loadingScreen)
    m.group.setFocus(true)
end sub