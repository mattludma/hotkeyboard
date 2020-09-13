; A simple Autohotkey script that adds nifty multilingual support to your keyboard using right Alt key (aka AltGr)
; https://github.com/mattludma/hotkeyboard




; Variables initialization (it has to be done somewhere before keys monitoring)
; =============================================================================

global lastCharacterTypedWithAltgr := ""

isLeftShiftPressed := 0
isRightShiftPressed := 0

isLeftCtrlPressed := 0
isRightCtrlPressed := 0

isLeftAltPressed := 0
isRightAltPressed := 0




; User define functions
; =====================

; Function returns the 1-based index of a character in an array of chars.
; It will return 0 if the character is not in the array.
GetCharPosition(ByRef char, ByRef arrayOfChars) {
    indexOfTheCharacter := 0
    for index, value in arrayOfChars
        if (char == value) {
            indexOfTheCharacter := index
        }
    ;
    return indexOfTheCharacter
}

; Function lastCharacterTypedWithAltgr is used on keys, that has more than one defined ascended value.
; It detects, whether it's a repeated stroke of the same key and if so, it replaces the last printed
; character with a next one in the listOfSpecialChars array.
PrintNextCharacter(ByRef listOfSpecialChars) {
    indexOfLastPrintedChar := GetCharPosition(lastCharacterTypedWithAltgr, listOfSpecialChars)
    lastCharWasPrintedWithAltgr := indexOfLastPrintedChar > 0   
    
    ; update the lastCharacterTypedWithAltgr global variable
    if (lastCharWasPrintedWithAltgr) {
        indexOfNextChar := Mod(indexOfLastPrintedChar, listOfSpecialChars.Length()) + 1
        lastCharacterTypedWithAltgr := listOfSpecialChars[indexOfNextChar]
        ; delete last printed character before printing the new one
        Send {Left}{Delete} ; works better than backspace
    } else {
        lastCharacterTypedWithAltgr := listOfSpecialChars[1]
    }
    
    ; print the character
    Send %lastCharacterTypedWithAltgr% 
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

*~LAlt::isLeftAltPressed := 1
*~LAlt Up::isLeftAltPressed := 0

; Monitoring withoout the "~" modifier means that all monitored key presses will be
; intercepted to prevent focus loss or some other unwanted alt functionality
*RAlt::
    lastCharacterTypedWithAltgr := 0
    isRightAltPressed := 1
    return
*RAlt Up::
    lastCharacterTypedWithAltgr := 0
    isRightAltPressed := 0
    return




; Monitoring of all AltGr combinations (Shift not pressed)
#If (isLeftShiftPressed = 0 and isRightShiftPressed = 0
    and isLeftCtrlPressed = 0 and isRightCtrlPressed = 0
    and isLeftAltPressed = 0 and isRightAltPressed = 1)

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
; *SC0c::SendInput {U+0000} ; -->
; *SC0d::SendInput {U+0000} ; =->
; *SC0e::SendInput {U+0000} ; Backspace->

*SC0f::SendInput {U+0009} ; Tab-> Puts TAB character in a field instead of jumping to next field
; *SC10::SendInput {U+0000} ; q->
; *SC11::SendInput {U+0000} ; w->
*SC12::PrintNextCharacter(["é","ě","ę","è","ê","ë"]) ; e->é{U+00e9},ě{U+011b},ę,è,ê,ë
*SC13::PrintNextCharacter(["ř","ŕ"]) ; r->ř{U+0159},ŕ{U+0155}
*SC14::PrintNextCharacter(["ť"]) ; t->ť {U+0165}
*SC15::PrintNextCharacter(["ý"]) ; y->ý {U+00fd}
*SC16::PrintNextCharacter(["ú","ů","ù","û","ü"]) ; u->ú{U+00fa},ů{U+016f},ù,û,ü
*SC17::PrintNextCharacter(["í","î","ï"]) ; i->í{U+00ed},î,ï
*SC18::PrintNextCharacter(["ó","ô","ö"]) ; o->ó{U+00f3},ô{U+00f4}
; *SC19::SendInput {U+0000} ; p->
*SC1a::PrintNextCharacter(["«"]) ; [->« {U+00ab}
*SC1b::PrintNextCharacter(["»"]) ; ]->» {U+00bb}

; *SC3a::SendInput {U+0000} ; Capslock->
*SC1e::PrintNextCharacter(["á","ä","ą","à","â"]) ; a->á{U+00e1},ä{U+00e4},ą,à,â
*SC1f::PrintNextCharacter(["š","ś","ß"]) ; s->š{U+0161},ś,ß{U+00df}
*SC20::PrintNextCharacter(["ď"]) ; d->ď {U+010f}
; *SC21::SendInput {U+0000} ; f->
; *SC22::SendInput {U+0000} ; g->
; *SC23::SendInput {U+0000} ; h->
; *SC24::SendInput {U+0000} ; j->
; *SC25::SendInput {U+0000} ; k->
*SC26::PrintNextCharacter(["ľ","ĺ","ł"]) ; l->ĺ{U+013a},ľ{U+013e},ł
*SC27::PrintNextCharacter(["„"]) ; ;->„ {U+201e}
*SC28::PrintNextCharacter(["“"]) ; '->“ {U+201c}
*SC2b::PrintNextCharacter(["”"]) ; \->” {U+201d}
; *SC1c::SendInput {U+0000} ; Enter->

*SC2c::PrintNextCharacter(["ž","ż","ź"]) ; z->ž{U+017e},ż,ź
; *SC2d::SendInput {U+0000} ; x->
*SC2e::PrintNextCharacter(["č","ć","ç"]) ; c->č{U+010d},ć,ç
; *SC2f::SendInput {U+0000} ; v->
; *SC30::SendInput {U+0000} ; b->
*SC31::PrintNextCharacter(["ň","ń","ñ"]) ň ; n->ň {U+0148},ń,ñ{U+00F1}
; *SC32::SendInput {U+0000} ; m->
; *SC33::SendInput {U+0000} ; ,->
; *SC34::SendInput {U+0000} ; .->
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



; Monitoring of all AltGr+Shift combinations
#If ((isLeftShiftPressed = 1 or isRightShiftPressed = 1)
    and isLeftCtrlPressed = 0 and isRightCtrlPressed = 0
    and isLeftAltPressed = 0 and isRightAltPressed = 1)

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

*SC29::SendInput {U+00b0} ; ~->° {U+00b0}
; *SC02::SendInput {U+0000} ; !->
; *SC04::SendInput {U+0000} ; #->
*SC05::PrintNextCharacter(["€","£"]) ; $->€,£
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
*SC12::PrintNextCharacter(["É","Ě","Ę","È","Ê","Ë"]) ; E->É{U+00c9},Ě{U+011a},Ę,È,Ê,Ë
*SC13::PrintNextCharacter(["Ř","Ŕ"]) ; R->Ř{U+0158},Ŕ{U+0154}
*SC14::PrintNextCharacter(["Ť"]) ; T->Ť {U+0164}
*SC15::PrintNextCharacter(["Ý"]) ; Y->Ý {U+00dd}
*SC16::PrintNextCharacter(["Ú","Ů","Ù","Û","Ü"]) ; U->Ú{U+00da},Ů{U+016e},Ù,Û,Ü
*SC17::PrintNextCharacter(["Í","Î","Ï"]) ; I->Í{U+00cd},Î,Ï
*SC18::PrintNextCharacter(["Ó","Ô","Ö"]) ; O->Ó{U+00d3},Ô{U+00d4},Ö
; *SC19::SendInput {U+0000} ; P->
*SC1a::PrintNextCharacter(["‹"]) ; {->‹ {U+2039}
*SC1b::PrintNextCharacter(["›"]) ; }->› {U+203a}

; *SC3a::SendInput {U+0000} ; Capslock->
*SC1e::PrintNextCharacter(["Á","Ä","Ą","À","Â"]) ; A->Á{U+00c1},Ä{U+00c4},Ą,À,Â
*SC1f::PrintNextCharacter(["Š","Ś","ẞ"]) ; S->Š{U+0160},Ś,ẞ
*SC20::PrintNextCharacter(["Ď"]) ; D->Ď {U+010e}
; *SC21::SendInput {U+0000} ; F->
; *SC22::SendInput {U+0000} ; G->
; *SC23::SendInput {U+0000} ; H->
; *SC24::SendInput {U+0000} ; J->
; *SC25::SendInput {U+0000} ; K->
*SC26::PrintNextCharacter(["Ľ","Ĺ","Ł"]) ; L->Ĺ{U+0139},Ľ{U+013d},Ł
*SC27::PrintNextCharacter(["‚"]) ; :->‚ {U+201a}
*SC28::PrintNextCharacter(["‘"]) ; "->‘ {U+2018}
*SC2b::PrintNextCharacter(["’"]) ; |->’ {U+2019}
; *SC1c::SendInput {U+0000} ; Enter->

*SC2c::PrintNextCharacter(["Ž","Ż","Ź"]) Ž ; Z->Ž{U+017d},Ż,Ź
; *SC2d::SendInput {U+0000} ; X->
*SC2e::PrintNextCharacter(["Č","Ć","Ç"])  ; C->Č{U+010c},Ć,Ç
; *SC2f::SendInput {U+0000} ; V->
; *SC30::SendInput {U+0000} ; B->
*SC31::PrintNextCharacter(["Ň","Ń","Ñ"]) Ň ; N->Ň{U+0147},Ń,Ñ{U+00D1}
; *SC32::SendInput {U+0000} ; M->
; *SC33::SendInput {U+0000} ; <->
; *SC34::SendInput {U+0000} ; >->
*SC35::PrintNextCharacter(["¿"]) ; ?->¿{U+00BF} 

; *SC39::SendInput {U+0000} ; Space->
; *SC37::SendInput {U+0000} ; PrtSc->
; *SC49::SendInput {U+0000} ; PgUp->
; *SC51::SendInput {U+0000} ; PgDn->
; *SC48::SendInput {U+0000} ; Up->
; *SC4b::SendInput {U+0000} ; Left->
; *SC50::SendInput {U+0000} ; Down->
; *SC4d::SendInput {U+0000} ; Right->
#If