sub init()
    initVars()
    showHomePage()
    ' checkUser()
    ' showLoginScreen()
end sub

sub showHomePage()
    showLoaderOnTimer()
    homeScreen = CreateObject("roSGNode", "HomePage")
    homeScreen.observeField("isShown", "delScreen")
    homeScreen.observeField("contentIsShown", "hideLoader")
    homeScreen.id = "HomePage"
    homeScreen.screenIndex = 1
    showScreen(homeScreen, true)
end sub

sub showLoaderOnTimer()
    m.timer = CreateObject("roSGNode", "Timer")
    m.timer.observeField("fire", "showLoader")
    m.timer.repeat = false
    m.timer.duration = "0.5"
    m.timer.control = "start"
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

sub checkUser()
    if checkRegSec("accessToken", "Authentication") = true
        showHomePage()
    else showLoginScreen()
    end if
end sub

function showScreen(screen, animated as boolean)
    m.screenManager.callFunc("showScreen", screen, animated)
end function

sub delScreen(event)
    state = event.getData()
    if state = false
        screen = event.getRoSGNode()
        ' ? "RoSceene delete screen" screen.id
        m.screenManager.callFunc("delScreen", screen)
        if screen <> invalid and screen.id = "HomePage"
            showLoginScreen()
        end if
    end if
end sub

sub showLoginScreen()
    loginScreen = CreateObject("roSGNode", "LoginScreen")
    loginScreen.observeField("isShown", "delScreen")
    loginScreen.id = "loginScreen"
    loginScreen.screenIndex = 1
    showScreen(loginScreen, true)
end sub

sub showLoader()
    m.loadingFacade.isShown = "true"
end sub

sub hideLoader()
    m.loadingFacade.isShown = "false"
end sub