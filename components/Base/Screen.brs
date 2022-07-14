sub init()

end sub

sub showScreen(screen, animated as boolean)
    scene = m.top.getScene()
    scene.callFunc("showScreen", screen, animated)
  end sub
  