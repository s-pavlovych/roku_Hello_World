sub init()
    initVars()
end sub

sub initVars()
    m.screenManager = m.top.findNode("screenManager")
    m.firstScreen = m.top.findNode("firstScreen")
    m.firstScreen.setFocus(true)
end sub

function showScreen(screen)
    m.screenManager.callFunc("showScreen", screen)
  end function