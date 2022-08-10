sub init()
    m.buttonPoster = m.top.findNode("buttonPoster")
    m.buttonInFocusPoster = m.top.findNode("buttonInFocusPoster")
end sub

sub showcontent()
    itemContent = m.top.itemContent
    m.buttonPoster.uri = itemContent.HDPOSTERURL
    m.buttonInFocusPoster.uri = itemContent.buttonInFocusPoster
end sub

sub showFocus()
    if m.top.gridHasFocus = true
        scale = 1 + (m.top.focusPercent * 0.1)
        m.buttonInFocusPoster.scale = [scale, scale]
        m.buttonPoster.scale = [scale, scale]
        m.buttonInFocusPoster.opacity = m.top.focusPercent
    else if m.top.gridHasFocus = false
        m.buttonInFocusPoster.scale = [1, 1]
        m.buttonPoster.scale = [1, 1]
        m.buttonInFocusPoster.opacity = 0
    end if
end sub