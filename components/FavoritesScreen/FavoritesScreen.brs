sub init()
    m.top.observeField("focusedChild", "setFocus")
    m.markupGrid = m.top.findNode("MarkupGrid")
    m.markupGrid.observeField("itemSelected", "showDetailPage")
    m.label = m.top.findNode("Label")
    m.global.observeField("content", "setContent", true)
    m.favoriteContent = {}
    setLabelTranslation()
    setGridTranslation()
    setContent()
end sub

sub showDetailPage()
    item = m.markupGrid.content.getChild(m.markupGrid.itemSelected)
    DetailPage = CreateObject("roSGNode", "DetailPage")
    DetailPage.id = getTodayAsSeconds()
    DetailPage.screenIndex = 1
    DetailPage.parentItem = item
    showScreen(DetailPage, true)
end sub

sub setGridTranslation()
    centerX = (1920 - ((m.markupGrid.itemSpacing[0] * (m.markupGrid.numColumns - 1)) + (m.markupGrid.itemSize[0] * m.markupGrid.numColumns))) / 2
    m.markupGrid.translation = [centerX, 160]
end sub

sub setContent()
    content = CreateObject("roSGNode", "ContentNode")
    ' contentArray = m.content.getChildren(-1, 0)
    ' contentArrayOfId = {}
    ' for each item in contentArray
    '     contentArrayOfId.addReplace(item.id, item)
    ' end for
    for each key in m.global.content
        ' if contentArrayOfId.doesExist(key) = false
        value = m.global.content.Lookup(key)
        m.favoriteContent.AddReplace(key, value)
        gridItem = convertToContentNode(value)
        content.appendChild(gridItem)
        ' m.content.appendChild(gridItem)
        ' end if
    end for
    m.markupGrid.content = content
    ' for each item in m.favoriteContent
    '     contentArray = m.content.getChildren(-1, 0)
    '     contentArrayOfId = {}
    '     for each item in contentArray
    '         contentArrayOfId.addReplace(item.id, item)
    '     end for
    '     if m.global.content.doesExist(item.id) = false
    '         m.content.removeChild(item)
    '         m.favoriteContent.Delete(item.id)
    '     end if
    ' end for
    if (content.getChildren(-1, 0)).Count() = 0
        ? "Content is empty "
        m.top.focusable = false
        m.label.visible = true
        m.markupGrid.visible = false
    else
        m.top.focusable = true
        m.label.visible = false
        m.markupGrid.visible = true
    end if
end sub

function convertToContentNode(content as object) as object
    gridItem = createObject("RoSGNode", "ContentNode")
    for each key in content
        gameId = content.Lookup("gameId")
        sport = content.Lookup("sport")
        idTeam1 = content.Lookup("idTeam1")
        idTeam2 = content.Lookup("idTeam2")
        title = content.Lookup("title")
        favorite = content.Lookup("favorite")
        score = content.Lookup("score")
        posterTeam1Uri = content.Lookup("posterTeam1Uri")
        posterTeam2Uri = content.Lookup("posterTeam2Uri")
        fieldsToAdd = {
            "gameId": gameId
            "favorite": favorite,
            "idTeam1": idTeam1,
            "idTeam2": idTeam2,
            "sport": sport,
            "score": score,
            "title": title,
            "posterTeam1Uri": posterTeam1Uri,
            "posterTeam2Uri": posterTeam2Uri,
        }
        gridItem.addFields(fieldsToAdd)
    end for
    return gridItem
end function

sub setLabelTranslation()
    m.label.font.size = 75
    centerX = (1920 - m.label.width) / 2
    centerY = (1080 - m.label.height) / 2
    m.label.translation = [centerX, centerY]
end sub

sub setFocus()
    state = m.top.hasFocus()
    if state = true
        m.markupGrid.setFocus(true)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press and key = "options"
        delFromFavorite()
        handled = true
    end if
    return handled
end function

sub delFromFavorite()
    focusIndex = m.markupGrid.itemFocused
    item = m.markupGrid.content.getChild(focusIndex)
    if item <> invalid
        m.favoriteContent.Delete(item.gameId.toStr())
        m.global.content = m.favoriteContent
        deleteFromRegSec(item.gameId.toStr(), "Favorites")
        m.markupGrid.content.removeChild(item)
        if focusIndex <> 0 and focusIndex < m.markupGrid.content.getChildren(-1, 0).Count()
            ? "DFFFFFFFFFFFFFFFFFFFFFFFFFFf"
            m.markupGrid.jumpToItem = focusIndex
        else
            m.markupGrid.jumpToItem = focusIndex - 1
        end if
    end if
    ' ? (m.markupGrid.content.getChildren(-1, 0)).Count()
end sub

