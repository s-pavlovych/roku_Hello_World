sub init()
    initVars()
    doRequest()
end sub

sub initVars()
    m.screenManager = m.top.findNode("screenManager")
    m.firstScreen = m.top.findNode("firstScreen")
    m.firstScreen.setFocus(true)
    m.urlTask = m.top.findNode("urlTask")
end sub

function doRequest()
    m.urlTask.url = "https://auth.instat.tv/token"
    m.urlTask.method = "POST"
    m.urlTask.body = {
        "email": "a@a.net",
        "client_id": "ott-android",
        "password": "a",
        "grant_type": "password"
    }
    m.urlTask.control = "run"
end function

function showScreen(screen, animated as boolean)
    m.screenManager.callFunc("showScreen", screen, animated)
end function

