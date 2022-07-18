function init()
    _initVars()
    setGroupTranslation()
    setPosterTranslation()
end function

sub _initVars()
    m.group = m.top.findNode("group")
    m.login = m.top.findNode("login")
    m.password = m.top.findNode("password")
    m.enter = m.top.findNode("enter")
    m.logo = m.top.findNode("logo")
    m.scene = m.top.getScene()
    m.login.observeField("isSelected", "keyboardOpen")
    m.password.observeField("isSelected", "keyboardOpen")
    m.enter.observeField("isSelected", "doRequest")
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
    field = event.getRoSGNode()
    m.keyboard = m.top.createChild("StandardKeyboardDialog")
    m.keyboard.title = field.hintText
    m.keyboard.textEditBox.leadingEllipsis = "true"
    m.keyboard.text = field.text
    m.keyboard.message = ["Please, enter your " + field.id + " here"]
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
    m.urlTask.observeField("response", "getResponse")
    m.urlTask.url = "https://auth.instat.tv/token"
    m.urlTask.method = "POST"
    m.urlTask.body = {
        "email": m.login.text,
        "client_id": "ott-android",
        "password": m.password.text,
        "grant_type": "password"
    }
    m.urlTask.control = "run"
end function

function getResponse()
    ? "getResp"
    response = m.urlTask.response
    accessToken = response.lookup("access_token")
    if accessToken <> invalid
        showHomeScreen()
    end if
    ? "resp is " accessToken
    registry = CreateObject("roRegistry")
    sec = CreateObject("roRegistrySection", "Authentication")
    sec.write("accessToken", accessToken)
    sec.flush()
end function

sub success(event)
    m.top.removeChild(m.loadingScreen)
    m.group.setFocus(true)
end sub

sub showHomeScreen()
    m.scene.callFunc("showHomeScreen")
    m.top.isShown = false
end sub