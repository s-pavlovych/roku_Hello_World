sub init()
    m.top.observeField("access", "getData")
    m.rowlist = m.top.findNode("rowList")
    m.top.setFocus(true)
    m.content = createObject("RoSGNode", "ContentNode")
    m.rowlist.content = m.content
    m.count = 0
    doRequest()
end sub

function doRequest()
    m.urlTask = CreateObject("roSGNode", "UrlTask")
    m.urlTask.observeField("responseData", "getToken")
    m.urlTask.url = "https://auth.instat.tv/token"
    m.urlTask.method = "POST"
    m.urlTask.body = {
        "email": "a@a.net",
        "client_id": "ott-android",
        "password": "a",
        "grant_type": "password"
    }
    m.urlTask.control = "run"
    ? "doRequest end"
end function

function getToken(event)
    response = event.getData()
    ? "REsponse code" response.code

    if response.code = 200
        ? "REsponse code" response.code
        body = response.body
        if body <> invalid
            accessToken = body.lookup("access_token")
            if accessToken <> invalid
                saveInRegSec(accessToken, "accessToken", "Authentication")
                ? "Token = " accessToken
                m.top.access = true
            end if
        end if
    else if response.code = 400
    end if
end function

sub getData()
dataRequest("17/07/2022")
dataRequest("15/07/2022")
dataRequest("17/07/2022")
dataRequest("15/07/2022")
dataRequest("17/07/2022")
end sub

sub dataRequest(date as string)
    m.urlTask = CreateObject("roSGNode", "UrlTask")
    m.urlTask.observeField("responseData", "getResponse")
    m.urlTask.url = "https://api.instat.tv/data"
    token = readRegSec("accessToken", "Authentication")
    m.urlTask.headers = { "Authorization": "Bearer " + token }
    ' ? m.urlTask.headers
    m.urlTask.method = "POST"
    m.urlTask.body = {
        "params": {
            "_p_date": date + " 00:00:00",
            "_p_limit": 60,
            "_p_offset": 0
        },
        "proc": "get_matches"
    }
    m.urlTask.control = "run"
end sub

sub getResponse(event)
    response = event.getData()
    if response.code = 200
        ? response.code
        body = response.body
        videoContent = body.Lookup("video_content")
        broadcast = videoContent.Lookup("broadcast")
        ? "Broadcast" broadcast
        broadcast = convertToContentNode(broadcast)
        ? broadcast
        addContentRow(broadcast, m.count+1)
    end if

end sub

function convertToContentNode(content as object) as object
    rowContent = createObject("RoSGNode", "ContentNode")
    for each key in content
        sport = key.Lookup("sport")
        team1 = key.Lookup("team1")
        team2 = key.Lookup("team2")
        nameTeam1 = team1.Lookup("name_eng")
        nameTeam2 = team2.Lookup("name_eng")
        idTeam1 = team1.Lookup("id")
        idTeam2 = team2.Lookup("id")
        score1 = team1.Lookup("score")
        score2 = team2.Lookup("score")
        uriTeam1 = getUri(idTeam1.toStr(), sport)
        uriTeam2 = getUri(idTeam2.toStr(), sport)
        title = nameTeam1 + " vs " + nameTeam2
        score = ""
        if score1 <> invalid or score2 <> invalid
            score = score1.toStr() + " - " + score2.toStr()
        end if
        poster = key.Lookup("previewURL")
        itemContent = rowContent.createChild("ContentNode")
        itemContent.addField("score", "string", false)
        itemContent.addField("posterTeam1", "string", false)
        itemContent.addField("posterTeam2", "string", false)
        itemContent.posterTeam1 = uriTeam1
        itemContent.posterTeam2 = uriTeam2
        itemContent.score = score
        itemContent.title = title
        itemContent.hdposterurl = poster
    end for
    return rowContent
end function

function getUri(id as string, sport as integer) as string
    if sport = 1
        uri = "https://instatscout.com/images/teams/180/" + id + ".png"
       else if sport = 2
        uri =  "https://hockey.instatscout.com/images/teams/180/" + id + ".png"
       else if sport = 3
        uri = "https://basketball.instatscout.com/images/teams/180/" + id + ".png"
    end if
    return uri
end function

sub addContentRow(row as object, index as integer)
    row.title = index.toStr()
    m.content.insertChild(row, index)
end sub
