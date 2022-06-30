function init()
   _initVars()
   setColorDuration()
end function

function _initVars()
   m.animation1 = m.top.FindNode("c1Animation")
   m.animation2 = m.top.FindNode("c2Animation")
   m.animation3 = m.top.FindNode("c3Animation")
   m.animationColor1 = m.top.FindNode("c1AnimationColor")
   m.animationColor2 = m.top.FindNode("c2AnimationColor")
   m.animationColor3 = m.top.FindNode("c3AnimationColor")
   m.animationColor3.ObserveField("state", "repeatColors")
   m.animation3.ObserveField("state", "repeat")
end function

sub setColorDuration()
   m.animationColor1.duration = (m.top.duration) * 4
   m.animationColor2.duration = (m.top.duration) * 4
   m.animationColor3.duration = (m.top.duration) * 4
end sub

sub repeat()
   if m.animation3.state = "stopped"
      if m.top.reverse = false
         m.top.reverse = true
         m.top.control = "start"
      else if m.top.reverse = true
         m.top.reverse = false
         m.top.control = "start"
      end if
   end if
end sub

sub repeatColors()
   if m.animationColor3.state = "stopped"
      if m.top.colorReverse = false
         m.top.colorReverse = true
         m.top.colorsControl = "start"
      else if m.top.colorReverse = true
         m.top.colorReverse = false
         m.top.colorsControl = "start"
      end if
   end if
end sub

sub hide()
   if m.top.control = "stop"
      m.top.visible = "false"
   else m.top.visible = "true"
   end if
end sub
