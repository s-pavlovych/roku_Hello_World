sub init()
    initVars()
    ' checkToken()
    ' doRequest()
    showLoginScreen()
end sub

sub initVars()
    m.screenManager = m.top.findNode("screenManager")
    m.urlTask = m.top.findNode("urlTask")
end sub

function doRequest()
    m.urlTask.observeField("response", "getResponse")
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

function getResponse()
    response = m.urlTask.response
    accessToken = response.lookup("access_token")
    registry = CreateObject("roRegistry")
    sec = CreateObject("roRegistrySection", "Authentication")
    sec.write("accessToken", accessToken)
    sec.flush()
end function

sub checkToken()
    sec = CreateObject("roRegistrySection", "Authentication")
    if sec.Exists("accessToken")
        ? sec.Read("accessToken")
        showHomeScreen()
    else ? "NO token"
        showLoginScreen()
    end if
end sub

function showScreen(screen, animated as boolean)
    m.screenManager.callFunc("showScreen", screen, animated)
end function

sub showLoginScreen()
    loginScreen = CreateObject("roSGNode", "LoginScreen")
    loginScreen.id = "loginScreen"
    loginScreen.opacity = 0
    loginScreen.screenIndex = 1
    showScreen(loginScreen, true)
end sub

sub showHomeScreen()
    homeScreen = CreateObject("roSGNode", "TestScreen")
    homeScreen.id = "homeScreen"
    homeScreen.opacity = 0
    homeScreen.screenIndex = 1
    homeScreen.text = "I am home screen"
    showScreen(homeScreen, true)
end sub