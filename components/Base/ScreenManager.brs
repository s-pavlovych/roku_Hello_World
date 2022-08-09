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
    ' screen.observeField("backTapped", "fadeScreen")
    screen.isShown = true
    screen.setFocus(true)
    if animated = true
        ' m.fade.reverse = false
        m.fade.keyValue = "[ 0, 1 ]"
        m.fade.fieldToInterp = screen.id + ".opacity"
        m.top.animation = "start"
        ' ? "animated" m.fade.fieldToInterp
    else
        screen.opacity = 1
    end if
    m.fade.fieldToInterp = ""
end function

sub fadeScreen()
    ' ? "FADE SCREEEN"
    m.top.animation = "finish"
    index = m.top.getChildCount() - 1
    screen = m.top.getChild(index)
    ' screen = event.getRoSGNode()
    screen.observeField("opacity", "popScreen")
    m.fade.fieldToInterp = screen.id + ".opacity"
    m.fade.keyValue = "[ 1, 0 ]"
    ' m.fade.reverse = true
    m.top.animation = "start"
    m.fade.fieldToInterp = ""
end sub

function popScreen(event)
    x = event.getData()
    if x = 0
        lastIndex = m.top.getChildCount() - 1
        m.top.removeChildIndex(lastIndex)
        ' ? "deleted " lastIndex
        if lastIndex > 1
            lastScreen = m.top.getChild(lastIndex - 1)
            lastScreen.setFocus(true)
            ? "last screen " lastScreen.id
        else
            m.top.isEmpty = "true"
        end if
    end if

end function

sub delScreen(screen as object)
    m.top.removeChild(screen)
    ' ? "manager delete screen"
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press and key = "back"
        fadeScreen()
        handled = true
    end if
    return handled
end function