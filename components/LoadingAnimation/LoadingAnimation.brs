function init()
   m.animation1 = m.top.FindNode("c1Animation")
   m.animation2 = m.top.FindNode("c2Animation")
   m.animation3 = m.top.FindNode("c3Animation")
   m.animationColor1 = m.top.FindNode("c1AnimationColor")
   m.animationColor2 = m.top.FindNode("c2AnimationColor")
   m.animationColor3 = m.top.FindNode("c3AnimationColor")
   setAnimationControl()
   setColorDuration()
   setDuration()
end function

function setDuration() as void
   m.animation1.duration = m.top.duration
   m.animation2.duration = m.top.duration
   m.animation3.duration = m.top.duration
end function

function setColorDuration() as void
   m.animationColor1.duration = (m.top.duration) * 4
   m.animationColor2.duration = (m.top.duration) * 4
   m.animationColor3.duration = (m.top.duration) * 4
end function

function setAnimationControl() as void
   m.animation1.control = m.top.control
   m.animation2.control = m.top.control
   m.animation3.control = m.top.control
   m.animationColor1.control = m.top.control
   m.animationColor2.control = m.top.control
   m.animationColor3.control = m.top.control
   if m.top.control = "stop"
      m.top.visible = "false"
   end if
end function

function onKeyEvent(key as string, press as boolean) as boolean
   handled = false
   if press and key = "Options"
      if m.top.control = "stop"
         m.top.control = "start"
      else m.top.control = "stop"
         handled = true
      end if
   end if
   return handled
end function