    '** 
    '** Example: Edit a Label size and color with BrightScript
    '**

    function init()
      m.myLabel = m.top.findNode("myLabel")
      m.counter = m.top.findNode("Counter")
      m.testPoster = m.top.findNode("testPoster")
      m.rectangle = m.top.findNode("testRectangle")
      m.myLabel.font.size = 70
      m.counter.font.size = 30
      m.posterTranslation = m.testPoster.translation
      m.rectTranslation = m.Rectangle.translation
      m.count = 0
    end function


    function count() as object
      m.count +=1
      m.myLabel.text = "You pressed OK" + stri(m.count) +" time"
      if m.count >1
      m.myLabel.text += "s"
      end if
      
      if m.count >= 10
          m.testPoster.visible = true
          m.Rectangle.visible = true
          m.counter.text = "Keep pressing OK or move the Poster to square using arrows"
      end if
    end function   

    function finish() as object
      m.testPoster.translation = m.posterTranslation
      if m.posterTranslation [0] = m.rectTranslation [0] +20 and m.posterTranslation [1] = m.rectTranslation [1] +20
         m.myLabel.text = "You win"
      end if
    end function

  function onKeyEvent(key as String, press as Boolean) as Boolean
      handled = false
      finish()
      print(m.count)
      if (key = "OK") and (press = true)
        count()
        handled = true
      else if (key = "up") and (press = true)
        m.posterTranslation [1] -=5
        handled = true
      else if (key = "down") and (press = true)
        m.posterTranslation [1] +=5
        handled = true
      else if (key = "left") and (press = true)
        m.posterTranslation [0] -=5
        handled = true
      else if (key = "right") and (press = true)
        m.posterTranslation [0] +=5
        handled = true
      end if
      return handled
  end function