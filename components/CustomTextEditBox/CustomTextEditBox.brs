sub init()
    _initVars()
end sub

sub _initVars()
    m.bounds = m.top.findNode("bounds")
    m.background = m.top.findNode("background")
    m.textEditBox = m.top.findNode("textEditBox")
    m.top.observeField("focusedChild", "focused")
end sub

sub focused()
    state = m.top.isInFocusChain()
    if state = true
        m.background.scale = [1.1, 1.1]
        m.background.opacity = 1
    else
        m.background.scale = [1, 1]
        m.background.opacity = 0.6
    end if
end sub

sub setBackgroundWidth()
    ? "sub setBackgroundWidth()"
    m.background.width = m.bounds.width * m.top.scaleIndex
    m.textEditBox.width =  m.background.width - 20
    setBackgroundTranslation()
    setTextTranslation()
end sub

sub setBackgroundHeight()
    ?" sub setBackgroundHeight()"
    m.background.height = m.bounds.height * m.top.scaleIndex
    m.textEditBox.height =  m.background.height
    setBackgroundTranslation()
    setTextTranslation()
end sub

sub setBackgroundTranslation()
    ? "sub setBackgroundTranslation()"
    centerX = (m.bounds.width - m.background.width) /2
    centerY = (m.bounds.height - m.background.height) /2
    m.background.translation = [centerX, centerY]
    setScaleRotateCenter()
end sub

sub setTextTranslation()
    centerX = (m.bounds.width - m.textEditBox.width) /2
    centerY = (m.bounds.height - m.textEditBox.height) /2
    m.textEditBox.translation = [centerX, centerY]
    setScaleRotateCenter()
end sub

sub setScaleRotateCenter()
    m.background.scaleRotateCenter = [(m.background.width/2), (m.background.height/2)]
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press and key = "OK"
        m.top.isSelected = not m.top.isSelected
        handled = true
    end if
    return handled
end function