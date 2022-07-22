sub init()
    m.itemposter = m.top.findNode("itemPoster")
    m.maskGroup = m.top.findNode("maskGroup")
    m.title = m.top.findNode("title")
    m.time = m.top.findNode("time")
    m.score = m.top.findNode("score")
    m.posterTeam1 = m.top.findNode("posterTeam1")
    m.posterTeam2 = m.top.findNode("posterTeam2")
end sub

sub showcontent()
    itemcontent = m.top.itemContent
    ' m.itemposter.uri = itemcontent.hdposterurl
    m.title.text = itemcontent.title
    ' m.time.text = itemcontent.time
    m.score.text = itemcontent.score
    m.posterTeam1.uri = itemcontent.posterTeam1
    m.posterTeam2.uri = itemcontent.posterTeam2
end sub

sub setLabels()
    if m.top.rowIndex <> 0
        m.top.removeChild(m.time)
        m.top.removeChild(m.score)
        m.title.translation = [6, 0]
    end if
end sub

sub updateLayout()
    setSize(m.itemposter, m.top)
    setSize(m.score, m.itemposter)
    setSize(m.time, m.itemposter)
    m.maskGroup.masksize = [m.itemposter.width, m.itemposter.height]
    m.posterTeam1.width = m.top.width / 2
    m.posterTeam2.width = m.top.width / 2
    m.posterTeam1.height = m.top.height / 2
    m.posterTeam2.height = m.top.height / 2
    m.posterTeam1.translation = [0, m.top.height /8]
    m.posterTeam2.translation = [m.top.width /2, m.top.height /4]
    m.title.maxWidth = m.itemposter.width
    m.title.height = m.itemposter.height
    m.title.translation = [6, -45]
    m.time.translation = [6, 0]
    m.score.translation = [-12, 6]
end sub

sub setSize(child as object, parent as object)
    child.width = parent.width
    child.height = parent.height
end sub