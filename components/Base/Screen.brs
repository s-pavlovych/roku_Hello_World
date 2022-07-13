sub init()

end sub

sub showScreen(screen)
    scene = m.top.getScene()
    scene.callFunc("showScreen", screen)
  end sub