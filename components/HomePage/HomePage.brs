sub init()
    _initVars()
    setGroupTranslation()
    ' m.group.setFocus(true)
end sub

sub _initVars()
    m.top.observeField("focusedChild", "setFocus")
    m.group = m.top.findNode("group")
    m.home = m.top.findNode("home")
    m.myList = m.top.findNode("myList")
    m.options = m.top.findNode("options")
    m.homeScreen = m.top.findNode("homeScreen")
    m.settingsScreen = m.top.findNode("settingsScreen")
    m.favoritesScreen = m.top.findNode("favoritesScreen")
    m.favoritesScreen.observeField("focusable", "backFocusOnButtons", true)
    m.home.observeField("focusedChild", "switchScreen")
    m.myList.observeField("focusedChild", "switchScreen")
    m.options.observeField("focusedChild", "switchScreen")
    m.settingsScreen.observeField("isShown", "userLogout")
    m.settingsScreen.focusable = true
    m.homeScreen.focusable = true
end sub

sub backFocusOnButtons(event)
    state = event.getData()
    ? "state is " state
    if state = false and m.favoritesScreen.visible = true
        ?"FFFFFFFFFFFFFFFFFFFFFFF"
    m.group.setFocus(true)
    end if
end sub

sub userLogout(event)
    state = event.getData()
    if state = false
        m.top.isShown = false
    end if
    ' ? "userLogout " m.top.isShown
end sub

sub switchScreen(event)
    m.homeScreen.visible = false
    m.favoritesScreen.visible = false
    m.settingsScreen.visible = false
    node = event.getNode()
    if node <> invalid
        if node = "home"
            m.top.visibleScreen = m.homeScreen
            m.homeScreen.visible = true
        else if node = "myList"
            m.top.visibleScreen = m.favoritesScreen
            m.favoritesScreen.visible = true
        else if node = "options"
            m.top.visibleScreen = m.settingsScreen
            m.settingsScreen.visible = true
        end if
    end if
end sub

sub setGroupTranslation()
    centerX = 1920 / 2
    centerY = 30
    m.group.translation = [centerX, centerY]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    ' ? "Home Page function onKeyEvent("key" as string, "press" as boolean) as boolean "
    handled = false
    if press = true
        if key = "down" and m.top.visibleScreen.focusable = true
            m.top.visibleScreen.setFocus(true)
            handled = true
        else if key = "up" and m.group.hasFocus() = false
        m.group.setFocus(true)
        handled = true
        end if
    end if
    return handled
end function

sub setFocus()
    state = m.top.hasFocus()
    if state = true
        m.top.visibleScreen.setFocus(true)
    end if
end sub