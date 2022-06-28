function init()
    m.myLabel = m.top.findNode("myLabel")
    m.counter = m.top.findNode("counter")
    m.testPoster = m.top.findNode("testPoster")
    m.rectangle = m.top.findNode("testRectangle")
    m.myScene = m.top.findNode("HelloWorld")
    m.myLabel.font.size = 70
    m.counter.font.size = 30
    m.top.addField("count", "integer", true)
    m.top.setField("count", "0")
    m.posterTranslation = m.testPoster.translation
    m.rectTranslation = m.Rectangle.translation
    m.top.observeField("count", "counting")
end function

function counting() as object
    m.myLabel.text = "You pressed OK" + stri(m.top.count) + " time"
    if m.top.count > 1
        m.myLabel.text += "s"
    end if
    if m.top.count >= 10
        m.testPoster.visible = true
        m.Rectangle.visible = true
        m.counter.text = "Keep pressing OK or move the Poster to square using arrows"
    end if
end function

function finish() as object
    m.testPoster.translation = m.posterTranslation
    if m.posterTranslation [0] = m.rectTranslation [0] + 20 and m.posterTranslation [1] = m.rectTranslation [1] + 20
        m.myLabel.text = "You win"
    end if
end function

function onKeyEvent(key as string, press as boolean) as boolean
    ? "function onKeyEvent("key" as string, "press" as boolean) as boolean"
    handled = false
    if press
        if key = "OK"
            m.top.count++
            ? (m.count)
            handled = true
        else if (key = "up")
            m.posterTranslation [1] -= 5
            handled = true
        else if (key = "down")
            m.posterTranslation [1] += 5
            handled = true
        else if (key = "left")
            m.posterTranslation [0] -= 5
            handled = true
        else if (key = "right")
            m.posterTranslation [0] += 5
            handled = true
        end if
        finish()
    end if
    return handled
end function