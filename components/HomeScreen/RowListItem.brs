sub init()
  m.itemposter = m.top.findNode("itemPoster")
  m.itemmask = m.top.findNode("itemMask")
  m.itemlabel = m.top.findNode("itemLabel")
end sub

sub showcontent()
  itemcontent = m.top.itemContent
  m.itemposter.uri = itemcontent.HDPosterUrl
  m.itemlabel.text = itemcontent.title
end sub

sub updateLayout()
    m.itemposter.width = m.top.width -6
    m.itemposter.height = m.top.height -6
end sub