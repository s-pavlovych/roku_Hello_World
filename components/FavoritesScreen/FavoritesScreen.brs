sub init()
    m.top.observeField("focusedChild", "setFocus")
    m.markupGrid = m.top.findNode("MarkupGrid")
    m.content = createObject("RoSGNode", "ContentNode")
    m.global.observeField("content", "setContent", true)
    ' m.markupGrid.content = CreateObject("roSGNode", "MarkupGridContent")
    m.markupGrid.content = m.content
    m.favoriteContent = {}
    setContent()
end sub


sub setContent()
    ? "SET CONTENT RUN "
    for each key in m.global.content
        contentArray = m.content.getChildren(-1, 0)
        contentArrayOfId = {}
        for each item in contentArray
            contentArrayOfId.addReplace(item.id, item)
        end for
        if contentArrayOfId.doesExist(key) = false
            value = m.global.content.Lookup(key)
            m.favoriteContent.AddReplace(key, value)
            gridItem = convertToContentNode(value)
            m.content.appendChild(gridItem)
        end if
    end for
    for each item in m.favoriteContent
        contentArray = m.content.getChildren(-1, 0)
        contentArrayOfId = {}
        for each item in contentArray
            contentArrayOfId.addReplace(item.id, item)
        end for
        if m.global.content.doesExist(item.id) = false
        ? m.content.removeChild(item)
        ? m.favoriteContent.Delete(item.id)
        end if
    end for
end sub

function convertToContentNode(content as object) as object
    gridItem = createObject("RoSGNode", "ContentNode")
    for each key in content
        id = content.Lookup("id")
        sport = content.Lookup("sport")
        idTeam1 = content.Lookup("idTeam1")
        idTeam2 = content.Lookup("idTeam2")
        title = content.Lookup("title")
        favorite = content.Lookup("favorite")
        score = content.Lookup("score")
        posterTeam1Uri = content.Lookup("posterTeam1Uri")
        posterTeam2Uri = content.Lookup("posterTeam2Uri")
        fieldsToAdd = {
            "favorite": favorite,
            "idTeam1": idTeam1,
            "idTeam2": idTeam2,
            "sport": sport,
            "score": score,
            "title": title,
            "posterTeam1Uri": posterTeam1Uri,
            "posterTeam2Uri": posterTeam2Uri,
        }
        gridItem.id = id
        gridItem.addFields(fieldsToAdd)
    end for
    return gridItem
end function

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
    item = m.markupGrid.content.getChild(m.markupGrid.itemFocused)
    m.content.removeChild(item)
    m.favoriteContent.Delete(item.id)
    ? "DELETED "item.id
    m.global.content = m.favoriteContent
    deleteFromRegSec(item.id, "Favorites")
    ? "Deleted global is " m.global.content
end sub

