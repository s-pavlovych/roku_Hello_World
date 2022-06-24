function init() 
   m.animation1 = m.top.FindNode("c1Animation")
   m.animation2 = m.top.FindNode("c2Animation")
   m.animation3 = m.top.FindNode("c3Animation")
   print(m.top.duration)
   startAnimations()
   m.animation1.duration = 1
   m.animation2.duration = 1
   m.animation3.duration = 1
   startAnimations()


end function
 
function setDuration() as void
   m.animation1.duration = m.top.duration
   m.animation2.duration = m.top.duration
   m.animation3.duration = m.top.duration
end function

function startAnimations() as void
   m.animation1.control = "start"
   m.animation2.control = "start"
   m.animation3.control = "start"
end function

function stopAnimations() as void
   m.animation1.control = "stop"
   m.animation2.control = "stop"
   m.animation3.control = "stop"
end function
