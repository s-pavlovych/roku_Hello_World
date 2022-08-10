function init()
    _initVars()
    setGroupTranslation()
    setPosterTranslation()
    _setTestData()
end function

sub _setTestData()
    m.login.text = "a@a.net"
    m.password.text = "a"
end sub

sub _initVars()
    m.group = m.top.findNode("group")
    m.login = m.top.findNode("login")
    m.password = m.top.findNode("password")
    m.enter = m.top.findNode("enter")
    m.logo = m.top.findNode("logo")
    m.scene = m.top.getScene()
    m.top.observeField("focusedChild", "setFocus")
    m.login.observeField("isSelected", "keyboardOpen")
    m.password.observeField("isSelected", "keyboardOpen")
    m.enter.observeField("isSelected", "doRequest")
end sub

sub setFocus()
    state = m.top.hasFocus()
    if state = true
        m.login.setFocus(true)
    end if
end sub

sub setPosterTranslation()
    centerX = (1920 / 2) - (m.logo.width / 2)
    m.logo.translation = [centerX, 150]
end sub

sub setGroupTranslation()
    centerX = 1920 / 2
    centerY = 1080 / 2
    m.group.translation = [centerX, centerY]
end sub

sub keyboardOpen(event)
    node = event.getRoSGNode()
    m.keyboard = m.top.createChild("StandardKeyboardDialog")
    m.keyboard.title = node.hintText
    m.keyboard.textEditBox.leadingEllipsis = "true"
    m.keyboard.text = node.text
    m.keyboard.message = ["Please, enter your " + node.id + " here"]
    m.keyboard.buttons = ["OK", "Cancel"]
    m.keyboard.setFocus(true)
    m.keyboard.ObserveField("buttonSelected", "keyboardClose")
    m.keyboard.ObserveField("wasClosed", "keyboardClose")
end sub

sub keyboardClose(event)
    key = event.getData()
    if key = 0
        if m.keyboard.title = m.login.hintText
            m.login.text = m.keyboard.text
            m.login.textColor = "#000000"
        else
            m.password.text = m.keyboard.text
            m.password.textColor = "#000000"
        end if
        if m.keyboard.text = ""
            m.login.textColor = "#616161"
            m.password.textColor = "#616161"
        end if
    end if
    m.top.removeChild(m.keyboard)
    m.group.setFocus(true)
end sub

sub loading()
    m.loadingScreen = m.top.createChild("LoadingFacade")
    m.loadingScreen.ObserveField("isShown", "success")
    m.loadingScreen.setFocus(true)
end sub

function doRequest()
    m.scene.callFunc("showLoader")
    m.urlTask = CreateObject("roSGNode", "UrlTask")
    m.urlTask.observeField("responseData", "getResponse")
    m.urlTask.url = "https://auth.instat.tv/token"
    m.urlTask.method = "POST"
    m.urlTask.body = {
        "email": m.login.text,
        "client_id": "ott-android",
        "password": m.password.text,
        "grant_type": "password"
    }
    m.urlTask.control = "run"
    ' ? "doRequest end"
end function

function getResponse(event)
    response = event.getData()
    if response.code = 200
        body = response.body
        if body <> invalid
            accessToken = body.lookup("access_token")
            if accessToken <> invalid
                saveInRegSec(accessToken, "accessToken", "Authentication")
                showHomeScreen()
            end if
        end if
    else if response.code = 400
        showAlert()
    end if
end function

sub showAlert()
    m.scene.callFunc("hideLoader")
    m.alert = m.top.createChild("StandardMessageDialog")
    m.alert.title = "Error"
    m.alert.message = ["Login or password is invalid", "Please, check your information and try again"]
    m.alert.buttons = ["OK"]
    m.alert.ObserveField("buttonSelected", "hideAlert")
    m.alert.setFocus(true)
end sub

sub hideAlert()
    m.top.removeChild(m.alert)
    m.group.setFocus(true)
end sub

sub showHomeScreen()
    m.scene.callFunc("showHomePage")
    m.top.isShown = false
end sub