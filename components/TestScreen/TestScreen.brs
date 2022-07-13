sub init()
    setVars()
    setButtonTranslation()
    setLabelTranslation()
    m.enter.setFocus(true)
end sub

sub setVars()
    m.enter = m.top.findNode("enter")
    m.testLabel = m.top.findNode("testLabel")
    ' m.enter.observeField("isSelected", "nextScreen")
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
        if key = "OK"
            testScreen = CreateObject("roSGNode", "TestScreen")
            testScreen.screenIndex = m.top.screenIndex + 1
            testScreen.text = "I am" + stri(testScreen.screenIndex)
            showScreen(testScreen)
            handled = true
        else if key = "back"
            m.top.backTapped = true
            handled = true
        end if
    end if
    return handled
end function
