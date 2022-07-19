sub init()
    initVars()
    checkToken()
    ' showLoginScreen()
end sub

sub initVars()
    m.screenManager = m.top.findNode("screenManager")
    m.loadingFacade = m.top.findNode("LoadingFacade")
    m.screenManager.observeField("isEmpty", "close")
end sub

sub close(event)
    state = event.getData()
    if state = true
        m.top.exitValue = "exit"
    end if
end sub

function showScreen(screen, animated as boolean)
    m.screenManager.callFunc("showScreen", screen, animated)
end function

sub delScreen(event)
    state = event.getData()
    if state = false
    screen = event.getRoSGNode()
    ? "RoSceene delete screen" screen.id
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
    m.loadingFacade.isShown = "true"
end sub

sub hideLoader()
    m.loadingFacade.isShown = "false"
end sub