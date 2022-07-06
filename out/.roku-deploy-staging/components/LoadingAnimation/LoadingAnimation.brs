function init()
   _initVars()
   ' valuesToDefault()
   setColorDuration()
end function

function _initVars()
   m.animateCircles = m.top.FindNode("animateCircles")
   m.c1Animation = m.top.FindNode("c1Animation")
   m.c2Animation = m.top.FindNode("c2Animation")
   m.c3Animation = m.top.FindNode("c3Animation")
   m.c1translation = m.top.FindNode("c1translation")
   m.c2translation = m.top.FindNode("c2translation")
   m.c3translation = m.top.FindNode("c3translation")
   m.c1AnimationColor = m.top.FindNode("c1AnimationColor")
   m.c2AnimationColor = m.top.FindNode("c2AnimationColor")
   m.c3AnimationColor = m.top.FindNode("c3AnimationColor")
   m.top.ObserveField("switch", "switcher")
   m.c3AnimationColor.ObserveField("state", "repeatColors")
   m.c1Animation.ObserveField("state", "repeat1")
   m.c2Animation.ObserveField("state", "repeat2")
   m.c3Animation.ObserveField("state", "repeat3")
end function

sub setColorDuration()
   m.c1AnimationColor.duration = (m.top.duration) * 2
   m.c2AnimationColor.duration = (m.top.duration) * 2
   m.c3AnimationColor.duration = (m.top.duration) * 2
end sub

sub repeat1(event)
   state = event.getData()
   isAnimated(state)
   if state = "stopped"
      repeater(m.c1Animation, m.c1translation)
   end if
end sub

sub repeat2(event)
   state = event.getData()
   isAnimated(state)
   if state = "stopped"
      repeater(m.c2Animation, m.c2translation)
   end if
end sub

sub repeat3(event)
   state = event.getData()
   isAnimated(state)
   if state = "stopped"
      repeater(m.c3Animation, m.c3translation)
   end if
end sub

sub repeatColors(event)
   state = event.getData()
   if state = "stopped"
      m.top.colorReverse = not m.top.colorReverse
      m.top.colorsControl = "start"
   end if
end sub

sub switcher()
   if m.top.switch = true
      valuesToDefault()
      m.top.colorsControl = "start"
      m.animateCircles.control = "start"
      ' m.top.visible = true
   else
      m.animateCircles.control = "stop"
      m.top.colorsControl = "stop"
      ' m.top.visible = false
   end if
end sub

sub isAnimated(x as string)
   if x = "running"
      m.top.isAnimated = "true"
   else
      m.top.isAnimated = "false"
   end if
end sub

sub repeater(animation as object, interpolator as object)
   if m.animateCircles.control = "start"
      animation.delay = 0
      interpolator.reverse = not interpolator.reverse
      animation.control = "start"
   end if
end sub

sub printer()
   ' ?m.top.isAnimated
end sub

sub valuesToDefault()
   m.c1Animation.delay = 0
   m.c2Animation.delay = 0.1
   m.c3Animation.delay = 0.2
   m.c1translation.reverse = false
   m.c2translation.reverse = false
   m.c3translation.reverse = false
end sub