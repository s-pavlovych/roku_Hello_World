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
    headers = { "Content-Type": "application/json" }
<<<<<<< HEAD
    if m.top.headers <> invalid and m.top.headers.keys() <> invalid 
        headers.append(m.top.headers)
    end if
    ' ? "headers are " headers
=======
    if m.top.headers <> invalid and m.top.headers <> ""
        headers.append(m.top.headers)
    end if
>>>>>>> 08b7ca82b27970be227bf700bfe724b19e0fd15f
    sendRequest.setHeaders(headers)
    body = FormatJson(m.top.body)
    if m.top.method = "POST"
        sendRequest.asyncPostFromString(body)
    else if m.top.method = "GET"
        sendRequest.asyncGetToString()
    end if
    while true
        response = wait(0, port)
        responseType = type(response)
        if responseType = "roUrlEvent"
            m.top.responseData = {
<<<<<<< HEAD
                "code": response.GetResponseCode()
                "body": parseJson(response.GetString())
            }
        end if
        ' ? "URLTask ended"
        ' ? "ResponseData is" m.top.responseData
        exit while
=======
                "code" : response.GetResponseCode()
                "body" : parseJson(response.GetString())
            }
            end if
            ? "URLTask ended"
            exit while
>>>>>>> 08b7ca82b27970be227bf700bfe724b19e0fd15f
    end while
end function

