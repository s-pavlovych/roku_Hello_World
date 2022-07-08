sub init()
    _initVars()
end sub

sub _initVars()
    m.footprint = m.top.findNode("footprint")
    m.text = m.top.findNode("text")
    m.footAnimation = m.top.FindNode("footAnimation")
    m.fade = m.top.FindNode("fade")
    m.footAnimation.ObserveField("state", "repeat")
    m.top.observeField("focusedChild", "focused")
    m.text.color = m.top.color
end sub

sub setFootprint()
    m.footprint.uri = m.top.footprintUri
end sub

sub repeat(event)
    state = event.getData()
    if state = "stopped"
        m.fade.reverse = not m.fade.reverse
        m.footAnimation.control = "start"
    end if
 end sub

 sub focused()
    state = m.top.isInFocusChain()
    if state = true
        m.footprint.uri = m.top.footprintUriInFocus
        m.text.color = m.top.colorInFocus
    else
        m.footprint.uri = m.top.footprintUri
        m.text.color = m.top.color
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press and key = "OK"
        m.top.isSelected = not m.top.isSelected
        handled = true
    end if
    return handled
end function