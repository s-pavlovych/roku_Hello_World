sub init()
    m.itemPoster = m.top.findNode("itemPoster")
    m.itemPosterCover = m.top.findNode("itemPosterCover")
    m.maskGroup = m.top.findNode("maskGroup")
    m.title = m.top.findNode("title")
    m.time = m.top.findNode("time")
    m.score = m.top.findNode("score")
    m.posterTeam1 = m.top.findNode("posterTeam1")
    m.posterTeam2 = m.top.findNode("posterTeam2")
end sub

sub showcontent()
    itemcontent = m.top.itemContent
    m.title.text = itemcontent.title
    ' m.time.text = itemcontent.time
    m.score.text = itemcontent.score
    m.top.sport = itemContent.sport
    m.top.idTeam1 = itemContent.idTeam1
    m.top.idTeam2 = itemContent.idTeam2
end sub

sub showFocus()
    m.itemPosterCover.opacity = m.top.focusPercent
end sub

sub showRowFocus()
    m.itemPosterCover.opacity = 0
end sub

sub setLabels()
    if m.top.rowIndex <> 0
        m.top.removeChild(m.time)
        m.top.removeChild(m.score)
        m.title.translation = [6, 0]
    end if
end sub

sub updateLayout()
    setSize(m.itemPoster, m.top)
    setSize(m.itemPosterCover, m.itemPoster)
    setSize(m.score, m.itemPoster)
    setSize(m.time, m.itemPoster)
    m.maskGroup.masksize = [m.itemPoster.width, m.itemPoster.height]
    m.posterTeam1.width = m.top.width / 2
    m.posterTeam2.width = m.top.width / 2
    m.posterTeam1.height = m.top.height / 2
    m.posterTeam2.height = m.top.height / 2
    m.posterTeam1.translation = [0, m.top.height / 8]
    m.posterTeam2.translation = [m.top.width / 2, m.top.height / 4]
    m.title.maxWidth = m.itemPoster.width - 20
    m.title.height = m.itemPoster.height
    m.title.translation = [6, -45]
    m.time.translation = [6, 0]
    m.score.translation = [-12, 6]
end sub

sub setSize(child as object, parent as object)
    child.width = parent.width
    child.height = parent.height
end sub

sub setUri(event)
    field = event.getField()
    if field = "idTeam1"
        m.posterTeam1.uri = getUri() + m.top.idTeam1.toStr() + ".png"
    else field = "idTeam2"
        m.posterTeam2.uri = getUri() + m.top.idTeam2.toStr() + ".png"
    end if
end sub

function getUri() as string
    if m.top.sport = 1
        uri = "https://instatscout.com/images/teams/180/"
    else if m.top.sport = 2
        uri = "https://hockey.instatscout.com/images/teams/180/"
    else if m.top.sport = 3
        uri = "https://basketball.instatscout.com/images/teams/180/"
    end if
    return uri
end function