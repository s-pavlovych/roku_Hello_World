sub init()
    m.top.functionName = "doRequest"
end sub

function doRequest()
    sendRequest = createObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    sendRequest.SetPort(port)
    sendRequest.setUrl(m.top.url)
    sendRequest.setRequest(m.top.method)
    sendRequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
    sendRequest.InitClientCertificates()
    headers = {"Content-Type": "application/json"}
    if m.top.headers <> invalid and m.top.headers <> ""
        headers.append(m.top.headers)
    end if
    sendRequest.setHeaders(headers)
    body = FormatJson(m.top.body)
    sendRequest.asyncPostFromString(body)
    while true
        response = wait(0, port)
        responseType = type(response)
        if responseType = "roUrlEvent"
            response = parseJson(response.GetString())
            ? response.Lookup("access_token")
            ' ? "Response headers: " response.GetResponseHeaders()
            ' ? "Status code: "response.GetResponseCode()
        end if
        exit while
    end while
end function

function _doRequest()
    sendRequest = createObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    sendRequest.SetPort(port)
    sendRequest.setUrl(m.top.url)
    sendRequest.setRequest("POST")
    headers = { "Content-Type": "application/json" }
    sendRequest.setHeaders(headers)
    sendRequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
    sendRequest.InitClientCertificates()
    body = {
        "email": "a@a.net",
        "client_id": "ott-android",
        "password": "a",
        "grant_type": "password"
    }
    body = FormatJson(body)
    sendRequest.asyncPostFromString(body)
    while true
        msg = wait(0, port)
        msgType = type(msg)
        if msgType = "roUrlEvent"
            ? "Response string: " msg.GetString()
            ? "Response headers: " msg.GetResponseHeaders()
            ? msg.GetResponseCode()
        end if
        exit while
    end while
    ' response = Wait(0, sendRequest.GetPort())
    ' ? type(response)
    ' ? "Response string: " response.GetString()
    ' ? "Response headers: " response.GetResponseHeaders()
    ' ? response.GetResponseCode()
end function