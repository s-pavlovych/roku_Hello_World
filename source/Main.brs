sub Main()
    print "in showChannelSGScreen"
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    scene = screen.CreateScene("MainScene")
    m.global = screen.getGlobalNode()
    m.global.id = "FavoriteContent"
    m.global.addField("content", "assocarray", true)
    screen.show()'vscode_rale_tracker_entry
    scene.observeField("exitValue", m.port)
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if msgType = "roSGNodeEvent"
            if (msg.GetData() = "exit")
                screen.Close()
                screen = invalid
            end if
        end if
    end while
end sub