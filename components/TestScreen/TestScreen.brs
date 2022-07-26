sub init()
    setVars()
    setButtonTranslation()
    setLabelTranslation()
    setColor()
end sub

sub setVars()
    m.enter = m.top.findNode("enter")
    m.testLabel = m.top.findNode("testLabel")
    m.enter.observeField("isSelected", "newScreen")
    m.top.observeField("focusedChild", "setFocus")
end sub

sub setFocus()
    state = m.top.hasFocus()
    if state = true
        m.enter.setFocus(true)
    end if
end sub

sub setColor()
    m.top.blendColor = rnd(7777777)

end sub

sub setButtonTranslation()
    centerX = 1920 / 2
    centerY = 1080 / 2
    m.enter.translation = [centerX, centerY]
end sub

sub setLabelTranslation()
    centerX = 1920 / 2
    m.testLabel.translation = [centerX, 200]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "back"
            m.top.backTapped = true
            handled = true
        else if key = "options"
            deleteToken()
        end if
    end if
    return handled
end function

sub newScreen()
    testScreen = CreateObject("roSGNode", "TestScreen")
    testScreen.opacity = 0
    testScreen.screenIndex = m.top.screenIndex + 1
    testScreen.id = "screen" + stri(testScreen.screenIndex)
    testScreen.text = "I am" + stri(testScreen.screenIndex)
    showScreen(testScreen, true)
end sub

sub deleteToken()
    sec = CreateObject("roRegistrySection", "Authentication")
    sec.delete("accessToken")
    ' ? "deleted"
end sub