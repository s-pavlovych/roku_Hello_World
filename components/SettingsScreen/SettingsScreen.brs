sub init()
    initVars()
    setGroupTranslation()
    setAreaTranslation()
    setCheckBoxesTranslation()
    getRepeatFromReg()
end sub

sub initVars()
    m.group = m.top.findNode("group")
    m.contentArea = m.top.findNode("contentArea")
    m.posterLogo = m.top.findNode("posterLogo")
    m.qualityList = m.top.findNode("qualityList")
    m.logout = m.top.findNode("logout")
    m.replay = m.top.findNode("replay")
    m.quality = m.top.findNode("quality")
    m.replayList = m.top.findNode("replayList")
    m.top.observeField("focusedChild", "setFocus")
    m.quality.observeField("isSelected", "setQuality")
    m.logout.observeField("isSelected", "logout")
    m.replay.observeField("isSelected", "setReplay")
    m.qualityList.observeField("itemSelected", "saveSetting")
    m.replayList.observeField("itemSelected", "saveSetting")
    m.loop = ""
end sub

sub getRepeatFromReg()
    m.loop = readRegSec("Repeat", "Repeat")
    if m.loop = "true"
        m.replayList.checkedItem = 0
    else
        m.replayList.checkedItem = 1
    end if
end sub

sub saveSetting(event)
    node = event.getRoSGNode()
    m.group.setFocus(true)
    node.visible = false
    m.posterLogo.visible = true
    item = event.getData()
    if node.id = "replayList"
        if item = 0
            m.loop = true
        else m.loop = false
        end if
        saveInRegSec(m.loop.toStr(), "Repeat", "Repeat")
    end if
end sub

sub setQuality()
    m.posterLogo.visible = false
    m.qualityList.visible = true
    m.qualityList.setFocus(true)
end sub

sub setReplay()
    getRepeatFromReg()
    m.posterLogo.visible = false
    m.replayList.visible = true
    m.replayList.setFocus(true)
end sub

sub setCheckBoxesTranslation()
    centerX = (m.contentArea.width - m.qualityList.itemSize[0]) / 2
    centerY = m.contentArea.height / 3
    m.qualityList.translation = [centerX, centerY]
    m.replayList.translation = [centerX, centerY]
end sub

sub setAreaTranslation()
    centerX = 1920 / 6
    centerY = 1080 / 5
    m.contentArea.translation = [centerX, centerY]
end sub

sub setGroupTranslation()
    centerX = 1920 * 0.7
    centerY = 1080 / 2
    m.group.translation = [centerX, centerY]
end sub

sub setFocus()
    state = m.top.hasFocus()
    if state = true
        m.replay.setFocus(true)
    end if
end sub

sub logout()
    sec = CreateObject("roRegistrySection", "Authentication")
    sec.delete("accessToken")
    m.top.isShown = false
end sub