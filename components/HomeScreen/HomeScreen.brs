sub init()
    rowlist = m.top.findNode("rowList")
    rowlist.content = CreateObject("roSGNode", "RowListContent")
    m.top.setFocus(true)
  end sub