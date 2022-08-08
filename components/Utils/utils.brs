function checkRegSec(key as string, section as string)
    sec = CreateObject("roRegistrySection", section)
    if sec.Exists(key)
        ' ? "Token is OK"
        return sec.Exists(key)
    else
        ' ? "token is NOT ok"
        return invalid
    end if
end function

sub saveInRegSec(data as object, key as string, section as string)
    sec = CreateObject("roRegistrySection", section)
    sec.write(key, data)
    sec.flush()
end sub

function readRegSec(key as string, section as string)
    sec = CreateObject("roRegistrySection", section)
    if sec.Exists(key)
        return sec.Read(key)
    else
        return invalid
    end if
end function

sub deleteFromRegSec(key as string, section as string)
    sec = CreateObject("roRegistrySection", section)
    sec.delete(key)
    sec.flush()
    ' ? "deleted"
end sub

function getTodayAsSeconds()
    today = CreateObject("roDateTime")
    today = today.AsSeconds().toStr()
    return today
    ? today
end function