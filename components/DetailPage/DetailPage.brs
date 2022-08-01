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

sub switchFavorite()
    m.starIcon.visible = not m.starIcon.visible
    content = {}
    content = m.global.content
    ? "content " content
    if m.starIcon.visible = true
        item = {
            "favorite": true,
            "idTeam1": m.top.parentItem.idTeam1,
            "idTeam2": m.top.parentItem.idTeam2,
            "id": m.top.parentItem.id,
            "sport": m.top.parentItem.sport,
            "score": m.top.parentItem.score,
            "title": m.top.parentItem.title,
            "posterTeam1Uri": m.top.parentItem.posterTeam1Uri,
            "posterTeam2Uri": m.top.parentItem.posterTeam2Uri
        }
        content.AddReplace(m.top.id, item)
        saveInRegSec(FormatJson(item), m.top.id, "Favorites")
    else if m.starIcon.visible = false
        content.delete(m.top.id)
        deleteFromRegSec(m.top.id, "Favorites")
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

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press
        if key = "back"
            m.top.backTapped = true
            handled = true
        end if
    end if
    return handled
end function