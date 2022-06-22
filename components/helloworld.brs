    '** 
    '** Example: Edit a Label size and color with BrightScript
    '**

    function init()
      m.myLabel = m.top.findNode("myLabel")
      m.Counter = m.top.findNode("Counter")
      m.testPoster = m.top.findNode("testPoster")
      m.Rectangle = m.top.findNode("testRectangle")
      m.myLabel.font.size=70
      m.myLabel.color="0x72D7EEFF"
      m.Counter.font.size=30
      m.posterTranslation = CreateObject("roArray", 2, false)
      m.posterTranslation = m.testPoster.translation
      m.rectTranslation = CreateObject("roArray", 2, false)
      m.rect = m.Rectangle.translation
      m.count = 0
    end function


    function count() as object
      
      m.count +=1
      if m.count =1 then
      m.myLabel.text = "You pressed OK" + stri(m.count) +" time"
      else
      m.myLabel.text = "You pressed OK" + stri(m.count) +" times"
          if  m.count >= 10 then
          m.testPoster.visible = true
          m.Rectangle.visible = true
          m.Counter.text = "Keep pressing OK or move the Poster to square using arrows"
          end if
      end if
    end function   

    function finish() as object
      if m.posterTranslation[0]=m.rect[0]+20 and m.posterTranslation[1]=m.rect[1]+20 then
         m.myLabel.text = "You win"
      end if
    end function

  function onKeyEvent(key as String, press as Boolean) as Boolean
      handled = false
      if (key = "OK") and (press = true) then
        count()
        handled = true
      else if (key = "up") and (press = true) then
        m.posterTranslation[1]-=5
      m.testPoster.translation = m.posterTranslation
      finish()
        handled = true
      else if (key = "down") and (press = true) then
        m.posterTranslation[1]+=5
        m.testPoster.translation = m.posterTranslation
        finish()
        handled = true
      else if (key = "left") and (press = true) then
        m.posterTranslation[0]-=5
        m.testPoster.translation = m.posterTranslation
        finish()
        handled = true
      else if (key = "right") and (press = true) then
        m.posterTranslation[0]+=5
        m.testPoster.translation = m.posterTranslation
        finish()
        handled = true
      end if
      return handled
  end function