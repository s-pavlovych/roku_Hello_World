sub init()
    initVars()
end sub

sub initVars()
    m.screenManager = m.top.findNode("screenManager")
    m.firstScreen = m.top.findNode("firstScreen")
    m.firstScreen.setFocus(true)
end sub

function showScreen(screen, animated as boolean)
    m.screenManager.callFunc("showScreen", screen, animated)
  end function