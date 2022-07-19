sub checkToken()
    sec = CreateObject("roRegistrySection", "Authentication")
    if sec.Exists("accessToken")
        showHomeScreen()
        ? "Token is OK"
    else ? "NO token"
        showLoginScreen()
    end if
end sub

sub saveToken(data as object)
    sec = CreateObject("roRegistrySection", "Authentication")
    sec.write("accessToken", data)
    sec.flush()
end sub

