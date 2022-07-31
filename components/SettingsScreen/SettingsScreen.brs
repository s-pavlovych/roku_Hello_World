sub init()
    initVars()
    setGroupTranslation()
    setAreaTranslation()
    setCheckBoxesTranslation()
end sub

sub initVars()
    m.group = m.top.findNode("group")
    m.contentArea = m.top.findNode("contentArea")
    m.qualityList = m.top.findNode("qualityList")
    m.logout = m.top.findNode("logout")
    m.replay = m.top.findNode("replay")
    m.quality = m.top.findNode("quality")
    m.replayChecklist = m.top.findNode("replayChecklist")
    m.qualityList.observeField("checkedItem", "saveQuality")
    m.top.observeField("focusedChild", "setFocus")
    m.quality.observeField("isSelected", "setQuality")
    m.logout.observeField("isSelected", "logout")
    m.replay.observeField("isSelected", "setReplay")
    m.qualityList.observeField("checkedItem", "saveQuality")
end sub

sub setQuality()
    m.qualityList.visible = true
    m.qualityList.setFocus(true)
end sub

sub setReplay()
    m.replayChecklist.visible = true
    m.replayChecklist.setFocus(true)
end sub

sub saveQuality()
    m.group.setFocus(true)
    m.qualityList.visible = false
end sub

sub setCheckBoxesTranslation()
    centerX = (m.contentArea.width - m.qualityList.itemSize[0]) /2
    centerY = m.contentArea.height /3
    m.qualityList.translation = [centerX, centerY]
    m.replayChecklist.translation = [centerX, centerY]
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
        m.group.setFocus(true)
    end if
end sub

sub logout()
    sec = CreateObject("roRegistrySection", "Authentication")
    sec.delete("accessToken")
    m.top.isShown = false
    ' ? "logout " m.top.isShown
end sub