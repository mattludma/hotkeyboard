; A simple Autohotkey script that adds nifty multilingual support
; to your keyboard using right Alt key (a.k.a. AltGr)
;
; Note: Lines starting with ";" are comments (not part of the script)
; For more info visit https://github.com/mattludma/hotkeyboard


; Variables initialization (it has to be done before keys monitoring)
; ===================================================================

global lastCharacterTypedWithAltgr := ""

global iTimeDiff := 0
global iLastLAltDownTime := A_Now . A_MSec
global iCurrnetAltDownTime := A_Now . A_MSec

isLeftShiftPressed := 0
isRightShiftPressed := 0
isFakeShiftPressed := 0

isLeftCtrlPressed := 0
isRightCtrlPressed := 0

isLeftAltPressed := 0
isRightAltPressed := 0

isCapslockPressed := 0
SetCapsLockState, Off
SetCapsLockState, AlwaysOff

; remap context menu key to ctrl
*AppsKey::Ctrl 

; workaround to prevent repeated typing when held down un US International keyboard
#MaxHotkeysPerInterval 500


; User-defined functions
; ======================

; Function TypeNextCharacter is used on keys, that has more than one extra value.
; It detects, whether it's a repeated stroke of the same key and if so, it replaces
; the last typed character with a next one in the listOfSpecialChars sequence.
;
; Note: If you release AltGr between the repeated strokes, the lastCharacterTypedWithAltgr
; will be reseted and the current character will be considered to be from a new sequence. 

TypeNextCharacter(ByRef listOfSpecialChars) {
    isLastCharFromDifferentSequence := 1
    indexOfLastChar := 0
    for index, value in listOfSpecialChars {
        if (lastCharacterTypedWithAltgr = value) {
            isLastCharFromDifferentSequence := 0
            indexOfLastChar := index
        }
    }
    if (listOfSpecialChars.Length() < 1) {
        ; incorrrect input data
    }
    if (isLastCharFromDifferentSequence or listOfSpecialChars.Length() = 1) {
        ; first character of the sequence will be typed
        lastCharacterTypedWithAltgr := listOfSpecialChars[1]
        Send %lastCharacterTypedWithAltgr% 
    } else {
        ; character from the same sequence gets replaced by a next character
        indexOfNextChar := Mod(indexOfLastChar, listOfSpecialChars.Length()) + 1
        lastCharacterTypedWithAltgr := listOfSpecialChars[indexOfNextChar]
        Send {Backspace}
        Send %lastCharacterTypedWithAltgr% 
    }
}



; Monitoring of modifier keys (shift, ctrl & alt)
; ===============================================

*~LShift::isLeftShiftPressed := 1
*~LShift Up::isLeftShiftPressed := 0

*~RShift::isRightShiftPressed := 1
*~RShift Up::isRightShiftPressed := 0

*~LCtrl::isLeftCtrlPressed := 1
*~LCtrl Up::isLeftCtrlPressed := 0

*~RCtrl::isRightCtrlPressed := 1
*~RCtrl Up::isRightCtrlPressed := 0

; Monitoring without the "~" modifier means that all monitored key presses will be
; intercepted to prevent focus loss or some other unwanted alt functionality
*RAlt::isRightAltPressed := 1
*RAlt Up::
    isRightAltPressed := 0
    lastCharacterTypedWithAltgr := 0
    return

*Capslock::isCapslockPressed := 1
*Capslock Up::isCapslockPressed := 0

*XButton1::SendInput {Left}
*XButton2::SendInput {Space}

; *~LAlt::isLeftAltPressed := 1
; *~LAlt Up::isLeftAltPressed := 0

; LAlt is remaped to RShift, doble click will still invote LAlt though
*LAlt::
	iCurrnetAltDownTime := A_Now . A_MSec
	iTimeDiff := (iCurrnetAltDownTime - iLastLAltDownTime) + 0
	iLastLAltDownTime := A_Now . A_MSec
	if (iTimeDiff < 300 )
	{
		isLeftAltPressed := 1
		SendInput {LAlt Down}
	}
	else
	{
		isFakeShiftPressed := 1
		SendInput {RShift Down}
	}
    return
*LAlt Up::
    if (isLeftAltPressed = 1)
    {
        isLeftAltPressed := 0
        SendInput {LAlt Up}
    }
    else
    {
        isFakeShiftPressed := 0
        SendInput {RShift Up}
    }
    return

; Monitoring of all AltGr combinations (for lower case letters)
; =============================================================

#If (isLeftShiftPressed = 0 and isRightShiftPressed = 0 and isFakeShiftPressed = 0
    and isLeftCtrlPressed = 0 and isRightCtrlPressed = 0
    and isLeftAltPressed = 0 and isRightAltPressed = 1
    and isCapslockPressed = 0)

; *SC01::SendInput {U+0000} ; Esc->
; *SC3b::SendInput {U+0000} ; F1->
; *SC3c::SendInput {U+0000} ; F2->
; *SC3d::SendInput {U+0000} ; F3->
; *SC3e::SendInput {U+0000} ; F4->
; *SC3f::SendInput {U+0000} ; F5->
; *SC40::SendInput {U+0000} ; F6->
; *SC41::SendInput {U+0000} ; F7->
; *SC42::SendInput {U+0000} ; F8->
; *SC43::SendInput {U+0000} ; F9->
; *SC44::SendInput {U+0000} ; F10->
; *SC57::SendInput {U+0000} ; F11->
; *SC58::SendInput {U+0000} ; F12->
; *SC47::SendInput {U+0000} ; Home->
; *SC4f::SendInput {U+0000} ; End->
; *SC53::SendInput {U+0000} ; Delete->

; *SC29::SendInput {U+0000} ; `->
; *SC02::SendInput {U+0000} ; 1->
; *SC03::SendInput {U+0000} ; 2->
; *SC04::SendInput {U+0000} ; 3->
; *SC05::SendInput {U+0000} ; 4->
; *SC06::SendInput {U+0000} ; 5->
; *SC07::SendInput {U+0000} ; 6->
; *SC08::SendInput {U+0000} ; 7->
; *SC09::SendInput {U+0000} ; 8->
; *SC0a::SendInput {U+0000} ; 9->
; *SC0b::SendInput {U+0000} ; 0->
*SC0c::SendInput {U+2212} ; --> Minus sign - U+2212
*SC0d::SendInput {U+2011} ; =-> Non-breaking hyphen
; *SC0e::SendInput {U+0000} ; Backspace->

*SC0f::SendInput {U+0009} ; Tab-> Puts TAB character in a field instead of jumping to next field
; *SC10::SendInput {U+0000} ; q->
; *SC11::SendInput {U+0000} ; w->
*SC12::TypeNextCharacter(["é","ě","ę","è","ê","ë"]) ; e->é{U+00e9},ě{U+011b},ę,è,ê,ë
*SC13::TypeNextCharacter(["ř","ŕ"]) ; r->ř{U+0159},ŕ{U+0155}
*SC14::TypeNextCharacter(["ť","þ"]) ; t->ť{U+0165},þ
*SC15::TypeNextCharacter(["ý"]) ; y->ý {U+00fd}
*SC16::TypeNextCharacter(["ú","ů","ù","û","ü","ű"]) ; u->ú{U+00fa},ů{U+016f},ù,û,ü
*SC17::TypeNextCharacter(["í","ì","î","ï"]) ; i->í{U+00ed},ì,î,ï
*SC18::TypeNextCharacter(["ó","ô","ò","ö","ő","õ","ø","œ"]) ; o->ó{U+00f3},ô{U+00f4},ò,ö,õ,ø,œ
; *SC19::SendInput {U+0000} ; p->
*SC1a::TypeNextCharacter(["«"]) ; [->« {U+00ab}
*SC1b::TypeNextCharacter(["»"]) ; ]->» {U+00bb}

; *SC3a::SendInput {U+0000} ; Capslock->
*SC1e::TypeNextCharacter(["á","ä","ą","à","â","ã","å","æ"]) ; a->á{U+00e1},ä{U+00e4},ą,à,â,ã,å,æ
*SC1f::TypeNextCharacter(["š","ś","ß"]) ; s->š{U+0161},ś,ß{U+00df}
*SC20::TypeNextCharacter(["ď","đ","ð"]) ; d->ď{U+010f},đ,ð
; *SC21::SendInput {U+0000} ; f->
; *SC22::SendInput {U+0000} ; g->
; *SC23::SendInput {U+0000} ; h->
; *SC24::SendInput {U+0000} ; j->
; *SC25::SendInput {U+0000} ; k->
*SC26::TypeNextCharacter(["ľ","ĺ","ł"]) ; l->ĺ{U+013a},ľ{U+013e},ł
*SC27::TypeNextCharacter(["„"]) ; ;->„ {U+201e}
*SC28::TypeNextCharacter(["“"]) ; '->“ {U+201c}
*SC2b::TypeNextCharacter(["”"]) ; \->” {U+201d}
; *SC1c::SendInput {U+0000} ; Enter->

*SC2c::TypeNextCharacter(["ž","ż","ź"]) ; z->ž{U+017e},ż,ź
; *SC2d::SendInput {U+0000} ; x->
*SC2e::TypeNextCharacter(["č","ć","ç"]) ; c->č{U+010d},ć,ç
; *SC2f::SendInput {U+0000} ; v->
; *SC30::SendInput {U+0000} ; b->
*SC31::TypeNextCharacter(["ň","ń","ñ"]) ; n->ň {U+0148},ń,ñ{U+00F1}
; *SC32::SendInput {U+0000} ; m->
; *SC33::SendInput {U+0000} ; ,->
*SC34::TypeNextCharacter(["…"]) ; .->…
; *SC35::SendInput {U+0000} ; /->

*SC39::SendInput {U+00a0} ; Space->Non-breaking space
; *SC37::SendInput {U+0000} ; PrtSc->
; *SC49::SendInput {U+0000} ; PgUp->
; *SC51::SendInput {U+0000} ; PgDn->
; *SC48::SendInput {U+0000} ; Up->
; *SC4b::SendInput {U+0000} ; Left->
; *SC50::SendInput {U+0000} ; Down->
; *SC4d::SendInput {U+0000} ; Right->
#If



; Monitoring of all AltGr + Shift combinations (for upper case letters)
; =====================================================================

#If ((isLeftShiftPressed = 1 or isRightShiftPressed = 1 or isFakeShiftPressed = 1)
    and isLeftCtrlPressed = 0 and isRightCtrlPressed = 0
    and isLeftAltPressed = 0 and isRightAltPressed = 1
    and isCapslockPressed = 0)

; *SC01::SendInput {U+0000} ; Esc->
; *SC3b::SendInput {U+0000} ; F1->
; *SC3c::SendInput {U+0000} ; F2->
; *SC3d::SendInput {U+0000} ; F3->
; *SC3e::SendInput {U+0000} ; F4->
; *SC3f::SendInput {U+0000} ; F5->
; *SC40::SendInput {U+0000} ; F6->
; *SC41::SendInput {U+0000} ; F7->
; *SC42::SendInput {U+0000} ; F8->
; *SC43::SendInput {U+0000} ; F9->
; *SC44::SendInput {U+0000} ; F10->
; *SC57::SendInput {U+0000} ; F11->
; *SC58::SendInput {U+0000} ; F12->
; *SC47::SendInput {U+0000} ; Home->
; *SC4f::SendInput {U+0000} ; End->
; *SC53::SendInput {U+0000} ; Delete->

*SC29::SendInput {U+00b0} ; ~->°{U+00b0}
*SC02::TypeNextCharacter(["¡"]) ; !->¡
; *SC04::SendInput {U+0000} ; #->
*SC05::TypeNextCharacter(["€","£"]) ; $->€,£
; *SC06::SendInput {U+0000} ; %->
; *SC07::SendInput {U+0000} ; ^->
; *SC08::SendInput {U+0000} ; &->
; *SC09::SendInput {U+0000} ; *->
; *SC0a::SendInput {U+0000} ; (->
; *SC0b::SendInput {U+0000} ; )->
; *SC0c::SendInput {U+0000} ; _->
; *SC0d::SendInput {U+0000} ; +->
; *SC0e::SendInput {U+0000} ; Backspace->

; *SC0f::SendInput {U+0000} ; Tab->
; *SC10::SendInput {U+0000} ; Q->
; *SC11::SendInput {U+0000} ; W->
*SC12::TypeNextCharacter(["É","Ě","Ę","È","Ê","Ë"]) ; E->É{U+00c9},Ě{U+011a},Ę,È,Ê,Ë
*SC13::TypeNextCharacter(["Ř","Ŕ"]) ; R->Ř{U+0158},Ŕ{U+0154}
*SC14::TypeNextCharacter(["Ť","Þ"]) ; T->Ť{U+0164},Þ
*SC15::TypeNextCharacter(["Ý"]) ; Y->Ý{U+00dd}
*SC16::TypeNextCharacter(["Ú","Ů","Ù","Û","Ü","Ű"]) ; U->Ú{U+00da},Ů{U+016e},Ù,Û,Ü,Ű
*SC17::TypeNextCharacter(["Í","Ì","Î","Ï"]) ; I->Í{U+00cd},Î,Ï
*SC18::TypeNextCharacter(["Ó","Ô","Ò","Ö","Ő","Õ","Ø","Œ"]) ; O->Ó{U+00d3},Ò,Ô{U+00d4},Ö,Ő,Õ,Ø,Œ
; *SC19::SendInput {U+0000} ; P->
*SC1a::TypeNextCharacter(["‹"]) ; {->‹{U+2039}
*SC1b::TypeNextCharacter(["›"]) ; }->›{U+203a}

; *SC3a::SendInput {U+0000} ; Capslock->
*SC1e::TypeNextCharacter(["Á","Ä","Ą","À","Â","Ã","Å","Æ"]) ; A->Á{U+00c1},Ä{U+00c4},Ą,À,Â,Ã,Å,Æ
*SC1f::TypeNextCharacter(["Š","Ś","ẞ"]) ; S->Š{U+0160},Ś,ẞ
*SC20::TypeNextCharacter(["Ď","Đ","Ð"]) ; D->Ď{U+010e},Đ,Ð
; *SC21::SendInput {U+0000} ; F->
; *SC22::SendInput {U+0000} ; G->
; *SC23::SendInput {U+0000} ; H->
; *SC24::SendInput {U+0000} ; J->
; *SC25::SendInput {U+0000} ; K->
*SC26::TypeNextCharacter(["Ľ","Ĺ","Ł"]) ; L->Ĺ{U+0139},Ľ{U+013d},Ł
*SC27::TypeNextCharacter(["‚"]) ; :->‚{U+201a}
*SC28::TypeNextCharacter(["‘"]) ; "->‘{U+2018}
*SC2b::TypeNextCharacter(["’"]) ; |->’{U+2019}
; *SC1c::SendInput {U+0000} ; Enter->

*SC2c::TypeNextCharacter(["Ž","Ż","Ź"]) ; Z->Ž{U+017d},Ż,Ź
; *SC2d::SendInput {U+0000} ; X->
*SC2e::TypeNextCharacter(["Č","Ć","Ç"]) ; C->Č{U+010c},Ć,Ç
; *SC2f::SendInput {U+0000} ; V->
; *SC30::SendInput {U+0000} ; B->
*SC31::TypeNextCharacter(["Ň","Ń","Ñ"]) ; N->Ň{U+0147},Ń,Ñ{U+00D1}
; *SC32::SendInput {U+0000} ; M->
; *SC33::SendInput {U+0000} ; <->
; *SC34::SendInput {U+0000} ; >->
*SC35::TypeNextCharacter(["¿"]) ; ?->¿{U+00BF} 

; *SC39::SendInput {U+0000} ; Space->
; *SC37::SendInput {U+0000} ; PrtSc->
; *SC49::SendInput {U+0000} ; PgUp->
; *SC51::SendInput {U+0000} ; PgDn->
; *SC48::SendInput {U+0000} ; Up->
; *SC4b::SendInput {U+0000} ; Left->
; *SC50::SendInput {U+0000} ; Down->
; *SC4d::SendInput {U+0000} ; Right->
#If



; Monitoring of Capslock custom scripts
; =====================================

#If (isLeftShiftPressed = 0 and isRightShiftPressed = 0 and isFakeShiftPressed = 0
    and isLeftCtrlPressed = 0 and isRightCtrlPressed = 0
    and isLeftAltPressed = 0 and isRightAltPressed = 0
    and isCapslockPressed = 1)

; *SC01::Reload ; Esc->Reload script
; *SC3b::SendInput {U+0000} ; F1->
; *SC3c::SendInput {U+0000} ; F2->
; *SC3d::SendInput {U+0000} ; F3->
; *SC3e::SendInput {U+0000} ; F4->
; *SC3f::SendInput {U+0000} ; F5->
; *SC40::SendInput {U+0000} ; F6->
; *SC41::SendInput {U+0000} ; F7->
; *SC42::SendInput {U+0000} ; F8->
; *SC43::SendInput {U+0000} ; F9->
; *SC44::SendInput {U+0000} ; F10->
; *SC57::SendInput {U+0000} ; F11->
; *SC58::SendInput {U+0000} ; F12->
; *SC47::SendInput {U+0000} ; Home->
; *SC4f::SendInput {U+0000} ; End->
; *SC53::SendInput !{F4} ; Delete->


; *SC29::SendInput {U+0000} ; `->
; *SC02::SendInput {U+0000} ; 1->
; *SC03::SendInput {U+0000} ; 2->
; *SC04::SendInput {U+0000} ; 3->
; *SC05::SendInput {U+0000} ; 4->
*SC06:: ; 5->
    formatedDateWithDay := ""
    dateFromClipboard := clipboard
    if (StrLen(dateFromClipboard) > 5)
    {
        StringReplace,dateFromClipboard,dateFromClipboard,-,,1
        FormatTime, formatedDateWithDay, %dateFromClipboard%, d.M.yyyy, ddd
    }
    if (StrLen(formatedDateWithDay) < 1)
    {
        FormatTime, formatedDateWithDay, A_Now, d.M.yyyy, ddd
    }
    formatedDateWithDay := StrReplace(formatedDateWithDay, "Mon", "Pondelok")
    formatedDateWithDay := StrReplace(formatedDateWithDay, "Tue", "Utorok")
    formatedDateWithDay := StrReplace(formatedDateWithDay, "Wed", "Streda")
    formatedDateWithDay := StrReplace(formatedDateWithDay, "Thu", "Štvrtok")
    formatedDateWithDay := StrReplace(formatedDateWithDay, "Fri", "Piatok")
    formatedDateWithDay := StrReplace(formatedDateWithDay, "Sat", "Sobota")
    formatedDateWithDay := StrReplace(formatedDateWithDay, "Sun", "Nedeľa")
    SendInput %formatedDateWithDay%
    return
; *SC07::SendInput {U+0000} ; 6->
; *SC08::SendInput {U+0000} ; 7->
; *SC09::SendInput {U+0000} ; 8->
; *SC0a::SendInput {U+0000} ; 9->
; *SC0b::SendInput {U+0000} ; 0->
; *SC0b::SendInput {U+0000} ; -->
; *SC0b::SendInput {U+0000} ; =->
; *SC0e::SendInput {U+0000} ; Backspace->


; *SC0f:: ; Tab->
	; SendInput {TAB}{TAB}{TAB}{TAB}{TAB}{TAB}
	; SendInput {TAB}{TAB}{TAB}{TAB}{TAB}{TAB}
	; SendInput {TAB}{TAB}{TAB}{TAB}{TAB}{TAB}
	; return
*SC10::SendInput ^+i ; q->ctrl+shift+i (open dev tools)
; *SC11:: ; w->RButton
    ; if (bRightMouseIsDown = 0)
    ; {
        ; bRightMouseIsDown := 1
        ; SendInput {RButton Down}
    ; }
    ; return
; *SC11 Up::
    ; if (bRightMouseIsDown = 1)
    ; {
        ; bRightMouseIsDown := 0
        ; SendInput {RButton Up}
    ; }
    ; return
; *SC12:: ; e->MButton
    ; if (bMiddleMouseIsDown = 0)
    ; {
        ; bMiddleMouseIsDown := 1
        ; SendInput {MButton Down}
    ; }
    ; return
; *SC12 Up::
    ; if (bMiddleMouseIsDown = 1)
    ; {
        ; bMiddleMouseIsDown := 0
        ; SendInput {MButton Up}
    ; }
    ; return
; *SC13:: ; r->LButton
    ; if (bLeftMouseIsDown = 0)
    ; {
        ; bLeftMouseIsDown := 1
        ; SendInput {LButton Down}
    ; }
    ; return
; *SC13 Up:: ; r->LButton
    ; if (bLeftMouseIsDown = 1)
    ; {
        ; bLeftMouseIsDown := 0
        ; SendInput {LButton Up}
    ; }
    ; return
*SC14:: ; t->Insert date with weekday (uses date in clipboard, otherwise uses current day)
    isoDateWithDay := ""
    dateFromClipboard := clipboard
    if (StrLen(dateFromClipboard) > 5)
    {
        StringReplace,dateFromClipboard,dateFromClipboard,-,,1
        FormatTime, isoDateWithDay, %dateFromClipboard%, (yyyy-MM-dd, ddd)
    }
    if (StrLen(isoDateWithDay) < 1)
    {
        FormatTime, isoDateWithDay, A_Now, (yyyy-MM-dd, ddd)
    }
    SendInput %isoDateWithDay%
    return
*SC15:: ; y->Insert date
    FormatTime, isoDate, A_Now, yyyy-MM-dd
    SendInput %isoDate%
    return
    
*SC16::SendInput {Home} ; u->Home
*SC17::SendInput {Backspace} ; i->Backspace
*SC18::SendInput {Delete} ; o->Delete
*SC19::SendInput {End} ; p->End
; *SC1a::SendInput !{F4}  ; [-> Alt+F4  ;RAlt doesn't work
*SC1b::SendInput {U+000d} ; ]->CR


; *SC3a::SendInput {U+0000} ; Capslock->
; *SC1e::SendInput {Enter} ; a->Enter
*SC1f::SendInput ^z ; s->CTRL+Z
*SC20::SendInput ^y ; d->CTRL+Y
*SC21::SendInput {Enter} ; f->Enter
*SC22::SendInput {ESC} ; g->ESC
; *SC23::SendInput ^!{TAB} ; h->CTRL-ALT-TAB
;*SC23:: ; h->Select word
;    SendInput {RCtrl Down}{Left}{RShift Down}{Right}{RCtrl Up}{RShift Up}
;    if (bFakeRShiftDown > 0)
;    {
;        SendInput {RShift Down}
;    }
;    if (bRCtrlDown = 1 or bFakeRCtrlDown > 0)
;    {
;        SendInput {RCtrl Down}
;    }
;    return
*SC24::SendInput {Left} ; j->Left
*SC25::SendInput {Down} ; k->Down
*SC26::SendInput {Up} ; l->Up
*SC27::SendInput {Right} ;->Right
; *SC28::Run C:\Programs\hotkeyboard\img\new_keyboard.jpg ; '->
*SC2b::SendInput {U+000a} ; \->LF
*SC1c::SendInput {U+000d}{U+000a} ; Enter->CR+LF
    

; *SC56::SendInput {U+0000} ; \->\
; *SC2c::SendInput {U+0000} ; z->
*SC2d::SendInput ^x ; x->CTRL+X
*SC2e::SendInput ^c ; c->CTRL+C
*SC2f::SendInput ^v ; v->CTRL+V
*SC30::SendInput ^+v ; b->CTRL+SHIFT+V
*SC31:: ; n->Alt+Esc (window select + cursor focus)
	SendInput !{Esc}
	Sleep, 50
    MouseMove,(A_CaretX),(A_CaretY+5)
    if (A_CaretX = "")
    {
        WinGetPos, posX, posY, posWidth, posHeight, A
        MouseMove,(0+posWidth/2),(0+posHeight/2)
    }
    return
*SC32:: ; m->Alt+Shift+Esc (window select + cursor focus)
	SendInput !+{Esc}
	Sleep, 50
    MouseMove,(A_CaretX),(A_CaretY+5)
    if (A_CaretX = "")
    {
        WinGetPos, posX, posY, posWidth, posHeight, A
        MouseMove,(0+posWidth/2),(0+posHeight/2)
    }
    return
*SC33::SendInput ^{PgUp} ; ,->Ctrl+PgUp
*SC34::SendInput ^{PgDn} ; .->Ctrl+PgDn
; *SC35::SendInput {U+0000} ; /


;Fn doesn't have any scancode
; *SC39:: ; Space->Place mouse on cursor
	SendInput {U+0020} ; Space->Space (ASCII code)
    ; MouseMove,(A_CaretX),(A_CaretY+5)
    ; if (A_CaretX = "")
    ; {
        ; WinGetPos, posX, posY, posWidth, posHeight, A
        ; MouseMove,(0+posWidth/2),(0+posHeight/2)
    ; }
    ; return
; *SC37::SendInput {U+0000} ; PrtSc->
; *SC49::SendInput {U+0000} ; PgUp->
; *SC51::SendInput {U+0000} ; PgDn->
; *SC48::SendInput {U+0000} ; Up->
; *SC4b::SendInput {U+0000} ; Left->
; *SC50::SendInput {U+0000} ; Down->
; *SC4d::SendInput {U+0000} ; Right->
#If
