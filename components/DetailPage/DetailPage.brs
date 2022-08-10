sub init()
    _initVars()
    setGroupTranslation()
    setLayout()
end sub

sub _initVars()
    m.top.observeField("focusedChild", "setFocus")
    m.top.observeField("parentItem", "setContent")
    m.group = m.top.findNode("group")
    m.play = m.top.findNode("play")
    m.buy = m.top.findNode("buy")
    m.favorite = m.top.findNode("favorite")
    m.itemPoster = m.top.findNode("itemPoster")
    m.title = m.top.findNode("title")
    m.starIcon = m.top.findNode("starIcon")
    m.posterTeam1 = m.top.findNode("posterTeam1")
    m.posterTeam2 = m.top.findNode("posterTeam2")
    m.favorite.observeField("isSelected", "switchFavorite", true)
    m.play.observeField("isSelected", "playVideo", true)
end sub

sub setContent()
    m.title.text = m.top.parentItem.title
    m.posterTeam1.uri = m.top.parentItem.posterTeam1Uri
    m.posterTeam2.uri = m.top.parentItem.posterTeam2Uri
    m.starIcon.visible = m.top.parentItem.favorite
end sub

sub setLayout()
    centerX = (1920 / 2) - (m.itemPoster.width / 2)
    m.itemPoster.translation = [centerX, 90]
    m.title.font.size = 75
    m.starIcon.translation = [m.itemPoster.width * 0.9, 20]
    m.posterTeam1.width = m.itemPoster.width / 2
    m.posterTeam2.width = m.itemPoster.width / 2
    m.posterTeam1.height = m.itemPoster.height / 2
    m.posterTeam2.height = m.itemPoster.height / 2
    m.posterTeam1.translation = [0, m.itemPoster.height / 8]
    m.posterTeam2.translation = [m.itemPoster.width / 2, m.itemPoster.height / 4]
end sub

sub playVideo()
        playerScreen = CreateObject("roSGNode", "PlayerScreen")
        playerScreen.observeField("isShown", "delScreen")
        videocontent = createObject("RoSGNode", "ContentNode")
        videocontent.title = "Example Video"
        videocontent.StreamFormat = "hls"
        videocontent.url = "https://cdn.flowplayer.com/a30bd6bc-f98b-47bc-abf5-97633d4faea0/hls/de3f6ca7-2db3-4689-8160-0f574a5996ad/playlist.m3u8"
        playerScreen.content = videocontent
        playerScreen.title = m.title.text
        playerScreen.id = "PlayerScreen"
        playerScreen.screenIndex = 1
        showScreen(playerScreen, true)
end sub

sub switchFavorite()
    m.starIcon.visible = not m.starIcon.visible
    content = {}
    content = m.global.content
    ' ? "content " content
    if m.starIcon.visible = true
        item = {
            "favorite": true,
            "idTeam1": m.top.parentItem.idTeam1,
            "idTeam2": m.top.parentItem.idTeam2,
            "gameId": m.top.parentItem.gameId,
            "sport": m.top.parentItem.sport,
            "score": m.top.parentItem.score,
            "title": m.top.parentItem.title,
            "posterTeam1Uri": m.top.parentItem.posterTeam1Uri,
            "posterTeam2Uri": m.top.parentItem.posterTeam2Uri
        }
        content.AddReplace(m.top.parentItem.gameId.toStr(), item)
        saveInRegSec(FormatJson(item), m.top.parentItem.gameId.toStr(), "Favorites")
    else if m.starIcon.visible = false
        content.delete(m.top.parentItem.gameId.toStr())
        deleteFromRegSec(m.top.parentItem.gameId.toStr(), "Favorites")
    end if
    m.global.content = content
end sub

sub setGroupTranslation()
    centerX = 1920 / 2
    centerY = 1080 * 0.8
    m.group.translation = [centerX, centerY]
end sub

sub setFocus()
    state = m.top.hasFocus()
    if state = true
        m.play.setFocus(true)
    end if
end sub