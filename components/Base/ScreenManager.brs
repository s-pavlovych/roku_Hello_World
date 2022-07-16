sub init()
    initVars()
end sub

sub initVars()
    m.backAnimation = m.top.findNode("backAnimation")
    m.fade = m.top.findNode("fade")
end sub

function showScreen(screen as object, animated as boolean)
    m.top.animation = "finish"
    m.top.appendChild(screen)
    screen.observeField("backTapped", "fadeScreen")
    screen.setFocus(true)
    if animated = true
        m.fade.reverse = false
        m.fade.fieldToInterp = screen.id + ".opacity"
        m.top.animation = "start"
        ? "animated" m.fade.fieldToInterp
    else
        screen.opacity = 1
    end if
end function

sub fadeScreen(event)
    m.top.animation = "finish"
    screen = event.getRoSGNode()
    screen.observeField("opacity", "popScreen")
    m.fade.fieldToInterp = screen.id + ".opacity"
    m.fade.reverse = true
    m.top.animation = "start"
end sub

function popScreen(event)
    x = event.getData()
    if x = 0
        lastIndex = m.top.getChildCount() - 1
        if lastIndex <> 1
        m.top.removeChildIndex(lastIndex)
        ? "deleted " lastIndex
        end  if
        if lastIndex <> 0
            lastScreen = m.top.getChild(lastIndex - 1)
            lastScreen.setFocus(true)
        end if
    end if
end function