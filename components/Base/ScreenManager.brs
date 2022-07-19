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
    screen.isShown = true
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
        m.top.removeChildIndex(lastIndex)
        ? "deleted " lastIndex
        if lastIndex <> 1
            lastScreen = m.top.getChild(lastIndex - 1)
            lastScreen.setFocus(true)
        else
            m.top.isEmpty = "true"
        end if
    end if

end function

sub delScreen(screen as object)
    m.top.removeChild(screen)
    ? "manager delete screen"
end sub