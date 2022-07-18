sub init()
    initVars()
    checkToken()
    ' showLoginScreen()
end sub

sub initVars()
    m.screenManager = m.top.findNode("screenManager")
    m.loader = m.top.findNode("LoadingFacade")
    m.screenManager.observeField("isEmpty", "close")
end sub

sub close(event)
    state = event.getData()
    if state = true
        m.top.exitValue = "exit"
    end if
end sub

sub checkToken()
    sec = CreateObject("roRegistrySection", "Authentication")
    if sec.Exists("accessToken")
        showHomeScreen()
        ? "Token is OK"
    else ? "NO token"
        showLoginScreen()
    end if
end sub

function showScreen(screen, animated as boolean)
    m.screenManager.callFunc("showScreen", screen, animated)
end function

sub delScreen(event)
    state = event.getData()
    if state = false
    screen = event.getRoSGNode()
    ? "sceene delete screen" screen.id
    m.screenManager.callFunc("delScreen", screen)
    end if
end sub

sub showLoginScreen()
    loginScreen = CreateObject("roSGNode", "LoginScreen")
    loginScreen.observeField("isShown", "delScreen")
    loginScreen.id = "loginScreen"
    loginScreen.opacity = 0
    loginScreen.screenIndex = 1
    showScreen(loginScreen, true)
end sub

sub showHomeScreen()
    homeScreen = CreateObject("roSGNode", "TestScreen")
    homeScreen.observeField("isShown", "hideLoader")
    homeScreen.id = "homeScreen"
    homeScreen.opacity = 0
    homeScreen.screenIndex = 1
    homeScreen.text = "I am home screen"
    showScreen(homeScreen, true)
end sub

sub showLoader()
    m.loader.control = "start"
    m.loader.visible = "true"
end sub

sub hideLoader()
    m.loader.visible = "false"
    m.loader.control = "stop"
end sub