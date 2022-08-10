sub init()
    initVars()
    setObservers()
    setGridTranslation()
    setLabelsTranslation()
    hideTimerStart()
    getRepeatFromReg()
    setFocusOnButtonsGrid()
end sub

sub initVars()
    m.video = m.top.findNode("video")
    m.video.notificationInterval = 1
    m.buttonsGrid = m.top.findNode("buttonsGrid")
    m.buttonsGrid.content = CreateObject("roSGNode", "ButtonsGridContent")
    m.progressBarBack = m.top.findNode("progressBarBack")
    m.progressBar = m.top.findNode("progressBar")
    m.point = m.top.findNode("point")
    m.playerPanel = m.top.findNode("playerPanel")
    m.currentPosition = m.top.findNode("currentPosition")
    m.duration = m.top.findNode("duration")
    m.currentPosition.text = secondsToMinutes(m.video.position)
    m.duration.text = m.video.duration
    m.time = 0
    m.key = ""
    m.hideTimer = m.top.findNode("hideTimer")
    m.longPressObserveTimer = m.top.findNode("longPressObserveTimer")
    m.forwardTimer = m.top.findNode("forwardTimer")
    m.rewindTimer = m.top.findNode("rewindTimer")
end sub

sub setObservers()
    m.top.observeField("content", "startPlaying")
    m.video.observeField("position", "updatePosition", true)
    m.video.observeField("duration", "updateDuration")
    m.video.observeField("state", "stateObservingFunction")
    m.top.observeField("loop", "changeLoopIcon", true)
    m.buttonsGrid.observeField("itemSelected", "controlPlayback", true)
    m.buttonsGrid.observeField("pressed", "hideTimerStart", true)
    m.point.observeField("focusedChild", "scalePoint")
    m.hideTimer.observeField("fire", "hideButtons")
    m.longPressObserveTimer.observeField("fire", "longPressObserve")
    m.forwardTimer.observeField("fire", "forward")
    m.rewindTimer.observeField("fire", "rewind")
end sub

sub startPlaying(event)
    content = event.getData()
    if content <> invalid
        m.video.control = "play"
    end if
end sub

sub getRepeatFromReg()
    ? "Regsection " readRegSec("Repeat", "Repeat")
    m.top.loop = readRegSec("Repeat", "Repeat")
end sub

sub changeLoopIcon(event)
    state = event.GetData()
    repeatButton = m.buttonsGrid.content.getChild(0)
    if state = true
        repeatButton.HDPosterUrl = "pkg:/images/repeatOnUnfocused.png"
        repeatButton.buttonInFocusPoster = "pkg:/images/repeatOnFocused.png"
    else
        repeatButton.HDPosterUrl = "pkg:/images/repeatUnfocused.png"
        repeatButton.buttonInFocusPoster = "pkg:/images/repeatFocused.png"
    end if
end sub

sub hideTimerStart()
    m.playerPanel.visible = true
    m.hideTimer.control = "start"
end sub

sub startVideo()
    m.video.control = "play"
end sub

sub stopTimers()
    m.longPressObserveTimer.control = "stop"
    m.rewindTimer.control = "stop"
    m.forwardTimer.control = "stop"
end sub

sub longPressObserve()
    if m.buttonsGrid.hasFocus() = true and m.key = "OK"
        if m.buttonsGrid.itemSelected = 3
            m.forwardTimer.control = "start"
        else if m.buttonsGrid.itemSelected = 1
            m.rewindTimer.control = "start"
        end if
    else if m.point.hasFocus() = true
        if m.key = "right"
            m.forwardTimer.control = "start"
        else if m.key = "left"
            m.rewindTimer.control = "start"
        end if
    end if
end sub

sub stateObservingFunction(event)
    state = event.getData()
    playButton = m.buttonsGrid.content.getChild(2)
    if state = "finished"
        if m.top.loop = true
            m.video.control = "play"
        else
            m.video.control = "stop"
        end if
    else if state = "playing"
        playButton.HDPosterUrl = "pkg:/images/pause.png"
        playButton.buttonInFocusPoster = "pkg:/images/pauseFocused.png"
    else
        playButton.HDPosterUrl = "pkg:/images/play.png"
        playButton.buttonInFocusPoster = "pkg:/images/playFocused.png"
    end if
end sub

sub forward()
    hideTimerStart()
    setPosition("forward", 10)
end sub

sub rewind()
    hideTimerStart()
    setPosition("rewind", 10)
end sub

sub setFocusOnButtonsGrid()
    m.buttonsGrid.setFocus(true)
    m.buttonsGrid.jumpToItem = "2"
end sub

sub hideButtons()
    ' ? "BUTTONS HIDED"
    m.video.setFocus(true)
    m.playerPanel.visible = false
end sub

sub switchLoop()
    m.top.loop = not m.top.loop
    saveInRegSec(m.top.loop.toStr(), "Repeat", "Repeat")
end sub

sub scalePoint()
    m.point.scaleRotateCenter = [10, 10]
    if m.point.hasFocus() = true
        m.point.scale = [2, 2]
    else m.point.scale = [1, 1]
    end if
end sub

sub controlPlayback(event)
    m.hideTimer.control = "start"
    button = event.getData()
    if button = 0
        switchLoop()
    else if button = 1
        setPosition("rewind", 10)
    else if button = 2
        if m.video.state = "playing"
            m.video.control = "pause"
        else if m.video.state = "paused"
            m.video.control = "resume"
        end if
    else if button = 3
        setPosition("forward", 10)
    else if button = 4
        m.video.control = "play"
    end if
end sub

sub setPosition(direction as string, seconds as integer)
    m.split = m.progressBarBack.width / m.video.duration
    if direction = "rewind"
        m.progressBar.width -= m.split * seconds
        m.time -= seconds
    else if direction = "forward"
        m.progressBar.width += m.split * seconds
        m.time += seconds
    end if
    if m.time < 0
        m.time = 0
        m.progressBar.width = 0
    else if m.time > m.video.duration
        m.time = m.video.duration
        m.progressBar.width = m.progressBarBack.width
    end if
    m.point.translation = [m.progressBar.width - 10, -5]
    m.currentPosition.text = secondsToMinutes(m.time)
    m.video.seek = m.time
end sub

sub setLabelsTranslation()
    xPosition = m.progressBarBack.translation[0]
    xDuration = (m.progressBarBack.translation[0] + m.progressBarBack.width) - m.duration.width
    m.currentPosition.translation = [xPosition, 90]
    m.duration.translation = [xDuration, 90]
end sub

sub setGridTranslation()
    centerX = (1920 - ((m.buttonsGrid.itemSpacing[0] * (m.buttonsGrid.numColumns - 1)) + (m.buttonsGrid.itemSize[0] * m.buttonsGrid.numColumns))) / 2
    m.buttonsGrid.translation = [centerX, 90]
end sub

sub updatePosition()
    m.time = m.video.position
    m.split = m.progressBarBack.width / m.video.duration
    m.progressBar.width = m.split * m.video.position
    m.point.translation = [m.progressBar.width - 10, -5]
    m.currentPosition.text = secondsToMinutes(m.video.position)
end sub

sub updateDuration()
    m.duration.text = secondsToMinutes(m.video.duration)
end sub

function secondsToMinutes(seconds as integer) as string
    x = seconds \ 60
    y = seconds MOD 60
    if y < 10
        y = y.toStr()
        y = "0" + y
    else
        y = y.toStr()
    end if
    result = x.toStr()
    result = result + ":" + y
    return result
end function

function onKeyEvent(key as string, press as boolean) as boolean
    ' ? "VideoScreen function onKeyEvent("key" as string, "press" as boolean) as boolean "
    m.key = key
    handled = false
    if press = true
        if m.video.hasFocus() = true
            if key = "rewind"
                setPosition("rewind", 10)
            else if key = "fastforward"
                setPosition("forward", 10)
            else if key = "play"
                if m.video.state = "playing"
                    m.video.control = "pause"
                else if m.video.state = "paused"
                    m.video.control = "resume"
                end if
            else if key = "replay"
                m.video.control = "play"
            else
                setFocusOnButtonsGrid()
            end if
            handled = true
            return handled
        end if
        if m.buttonsGrid.hasFocus() = true and key = "up"
            m.point.setFocus(true)
            handled = true
            hideTimerStart()
        end if
        if m.point.hasFocus() = true
            if key = "down"
                setFocusOnButtonsGrid()
            else if key = "left"
                setPosition("rewind", 10)
            else if key = "right"
                setPosition("forward", 10)
            end if
            hideTimerStart()
        end if
        m.longPressObserveTimer.control = "start"
    else
        stopTimers()
    end if
    return handled
end function