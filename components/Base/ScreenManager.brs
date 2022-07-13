sub init()
    m.top.focusable = true
end sub

function showScreen(screen as object)
        m.top.appendChild(screen)
        screen.setFocus(true)
        screen.observeField("backTapped", "popScreen")
        ? "created" screen.screenIndex
end function

function popScreen()
        lastIndex = m.top.getChildCount() - 1
        m.top.removeChildIndex(lastIndex)
        ? "deleted " lastIndex
        if lastIndex <> 0
            lastScreen = m.top.getChild(lastIndex - 1)
            lastScreen.setFocus(true)
        end if
    end function