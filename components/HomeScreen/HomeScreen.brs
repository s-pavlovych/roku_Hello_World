sub init()
    m.top.observeField("access", "getData")
    m.top.observeField("focusedChild", "setFocus")
    m.global.observeField("content", "updateFavorites", true)
    ' m.top.setFocus(true)
    m.rowlist = m.top.findNode("rowList")
    m.rowlist.observeField("rowItemSelected", "showDetailPage")
    m.content = createObject("RoSGNode", "ContentNode")
    m.rowlist.content = m.content
    m.contentArray = []
    m.today = CreateObject("roDateTime")
    m.daysToShow = 10
    m.emptyDays = 0
    m.favoriteContent = {}
    setGlobalFromRegistry()
    doRequest()
end sub

sub setFocus()
    state = m.top.hasFocus()
    if state = true
        m.rowlist.setFocus(true)
    end if
end sub

sub setContent(event)
    array = event.getData()
        contentRows = []
        array.sortBy("date")
        if array.count() = m.daysToShow - m.emptyDays
        for i = array.count() - 1 to 1 step -1
            row = array.GetEntry(i)
            row = row.Lookup("contentNode")
            contentRows.Push(row)
            m.content.appendChildren(contentRows)
            m.top.isShown = true
        end for
    end if
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
    ' ? "doRequest end"
end function

function getToken(event)
    response = event.getData()
    if response.code = 200
        body = response.body
        if body <> invalid
            accessToken = body.lookup("access_token")
            if accessToken <> invalid
                saveInRegSec(accessToken, "accessToken", "Authentication")
                ' ? "Token = " accessToken
                m.top.access = true
            end if
        end if
    else if response.code = 400
    end if
end function

sub getData()
    for i = m.daysToShow to 1 step -1
        dataRequest(m.today.GetDayOfMonth().toStr() + "/" + m.today.GetMonth().toStr() + "/" + m.today.GetYear().toStr())
        m.today.FromSeconds(m.today.AsSeconds() - 84600)
    end for
end sub

sub dataRequest(date as string)
    m.urlTask = CreateObject("roSGNode", "UrlTask")
    m.urlTask.observeField("responseData", "getResponse")
    m.urlTask.url = "https://api.instat.tv/data"
    token = readRegSec("accessToken", "Authentication")
    m.urlTask.headers = { "Authorization": "Bearer " + token }
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
    ' ? "GET RESPONSE RUN"
    index = event.getNode()
    response = event.getData()
    if response.code = 200
        body = response.body
        videoContent = body.Lookup("video_content")
        broadcast = videoContent.Lookup("broadcast")
        if broadcast <> invalid
            date = broadcast[0]
            date = date.Lookup("date")
            date = date.left(10)
            ' ? "DATE IS " date
            ' ? "INDEX IS " index
            broadcast = convertToContentNode(broadcast)
            m.contentArray.push({ "date": date, "contentNode": broadcast })
        else m.emptyDays+=1
        end if
        m.top.contentArray = m.contentArray
    end if
end sub

function convertToContentNode(content as object) as object
    rowContent = createObject("RoSGNode", "ContentNode")
    date = content[0]
    date = date.Lookup("date")
    date = date.left(10)
    rowContent.title = date
    for each key in content
        m.gameId = key.Lookup("id")
        sport = key.Lookup("sport")
        team1 = key.Lookup("team1")
        team2 = key.Lookup("team2")
        poster = key.Lookup("previewURL")
        nameTeam1 = team1.Lookup("name_eng")
        nameTeam2 = team2.Lookup("name_eng")
        idTeam1 = team1.Lookup("id")
        idTeam2 = team2.Lookup("id")
        score1 = team1.Lookup("score")
        score2 = team2.Lookup("score")
        poster = key.Lookup("previewURL")
        title = nameTeam1 + " vs " + nameTeam2
        score = ""
        if score1 <> invalid or score2 <> invalid
            score = score1.toStr() + " - " + score2.toStr()
        end if
        itemContent = rowContent.createChild("ContentNode")
        fieldsToAdd = {
            "gameId" : m.gameId
            "favorite": false,
            "idTeam1": idTeam1,
            "idTeam2": idTeam2,
            "sport": sport,
            "score": score,
            "title": title,
            "posterTeam1Uri": "",
            "posterTeam2Uri": "",
        }
        itemContent.addFields(fieldsToAdd)
        if m.global.content.doesExist(m.gameId.toStr()) = true
            itemContent.favorite = true
        end if
    end for
    return rowContent
end function

sub updateFavorites()
    ' ?"update run "
    rows = m.content.getChildren(-1, 0)
    for each row in rows
        items = row.getChildren(-1, 0)
        for each item in items
            if m.global.content.doesExist(item.gameId.toStr()) = false
                item.favorite = false
            else item.favorite = true
            end if
        end for
    end for
    m.favoriteContent = m.global.content
end sub

sub setGlobalFromRegistry()
    sec = CreateObject("roRegistrySection", "Favorites")
    for each item in sec.GetKeyList()
        favoriteItem = ParseJson(readRegSec(item, "Favorites"))
        m.favoriteContent.AddReplace(item, favoriteItem)
    end for
    m.global.content = m.favoriteContent
end sub

sub addToFavorite()
    row = m.rowlist.content.getChild(m.rowlist.rowItemFocused[0])
    item = row.getChild(m.rowlist.rowItemFocused[1])
    id = item.gameId.toStr()
    item.favorite = not item.favorite
    if item.favorite = true
        item = {
            "favorite": item.favorite,
            "idTeam1": item.idTeam1,
            "idTeam2": item.idTeam2,
            "gameId": item.gameId.toStr(),
            "sport": item.sport,
            "score": item.score,
            "title": item.title,
            "posterTeam1Uri": item.posterTeam1Uri,
            "posterTeam2Uri": item.posterTeam2Uri
        }
        saveInRegSec(FormatJson(item), id, "Favorites")
        m.favoriteContent.AddReplace(id, item)
    else
        deleteFromRegSec(id, "Favorites")
        m.favoriteContent.Delete(id)
    end if
    m.global.content = m.favoriteContent
    ' ?"GLOBAL IS " m.global.content
end sub

sub showDetailPage()
    row = m.rowlist.content.getChild(m.rowlist.rowItemSelected[0])
    item = row.getChild(m.rowlist.rowItemSelected[1])
    DetailPage = CreateObject("roSGNode", "DetailPage")
    DetailPage.id = getTodayAsSeconds()
    DetailPage.screenIndex = 1
    DetailPage.parentItem = item
    showScreen(DetailPage, true)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press and key = "options"
        addToFavorite()
        handled = true
    end if
    return handled
end function