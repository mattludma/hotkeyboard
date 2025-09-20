; A simple Autohotkey script that adds nifty multilingual support
; to your keyboard using right Alt key (a.k.a. AltGr)
;
; Note: Lines starting with ";" are comments (not part of the script)
; For more info visit https://github.com/mattludma/hotkeyboard



; Variables initialization (it has to be done before keys monitoring)
; ===================================================================

global lastCharacterTypedWithAltgr := ""

isLeftShiftPressed := 0
isRightShiftPressed := 0

isLeftCtrlPressed := 0
isRightCtrlPressed := 0

isLeftAltPressed := 0
isRightAltPressed := 0

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

*~LAlt::isLeftAltPressed := 1
*~LAlt Up::isLeftAltPressed := 0

; Monitoring without the "~" modifier means that all monitored key presses will be
; intercepted to prevent focus loss or some other unwanted alt functionality
*RAlt::isRightAltPressed := 1
*RAlt Up::
    isRightAltPressed := 0
    lastCharacterTypedWithAltgr := 0
    return



; Monitoring of all AltGr combinations (for lower case letters)
; =============================================================

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
*SC0c::SendInput {U+2212} ; --> Minus sign - U+2212
*SC0d::SendInput {U+2011} ; =-> Non-breaking hyphen
; *SC0e::SendInput {U+0000} ; Backspace->

*SC0f::SendInput {U+0009} ; Tab-> Puts TAB character in a field instead of jumping to next field
; *SC10::SendInput {U+0000} ; q->
; *SC11::SendInput {U+0000} ; w->
*SC12::TypeNextCharacter(["é","ě"]) ; e->é{U+00e9},ě{U+011b}
*SC13::TypeNextCharacter(["ř"]) ; r->ř{U+0159}
*SC14::TypeNextCharacter(["ť"]) ; t->ť{U+0165}
*SC15::TypeNextCharacter(["ý"]) ; y->ý{U+00fd}
*SC16::TypeNextCharacter(["ú","ů"]) ; u->ú{U+00fa},ů{U+016f}
*SC17::TypeNextCharacter(["í"]) ; i->í{U+00ed}
*SC18::TypeNextCharacter(["ó"]) ; o->ó{U+00f3}
; *SC19::SendInput {U+0000} ; p->
*SC1a::TypeNextCharacter(["«"]) ; [->«{U+00ab}
*SC1b::TypeNextCharacter(["»"]) ; ]->»{U+00bb}

; *SC3a::SendInput {U+0000} ; Capslock->
*SC1e::TypeNextCharacter(["á"]) ; a->á{U+00e1}
*SC1f::TypeNextCharacter(["š"]) ; s->š{U+0161}
*SC20::TypeNextCharacter(["ď"]) ; d->ď{U+010f}
; *SC21::SendInput {U+0000} ; f->
; *SC22::SendInput {U+0000} ; g->
; *SC23::SendInput {U+0000} ; h->
; *SC24::SendInput {U+0000} ; j->
; *SC25::SendInput {U+0000} ; k->
; *SC26::SendInput {U+0000} ; l->
*SC27::TypeNextCharacter(["„"]) ; ;->„{U+201e}
*SC28::TypeNextCharacter(["“"]) ; '->“{U+201c}
*SC2b::TypeNextCharacter(["”"]) ; \->”{U+201d}
; *SC1c::SendInput {U+0000} ; Enter->

*SC2c::TypeNextCharacter(["ž"]) ; z->ž{U+017e}
; *SC2d::SendInput {U+0000} ; x->
*SC2e::TypeNextCharacter(["č"]) ; c->č{U+010d}
; *SC2f::SendInput {U+0000} ; v->
; *SC30::SendInput {U+0000} ; b->
*SC31::TypeNextCharacter(["ň"]) ; n->ň{U+0148}
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



; Monitoring of all AltGr + Shift combinations (for upper case letters)
; =====================================================================

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
*SC12::TypeNextCharacter(["É","Ě"]) ; E->É{U+00c9},Ě{U+011a}
*SC13::TypeNextCharacter(["Ř"]) ; R->Ř{U+0158}
*SC14::TypeNextCharacter(["Ť"]) ; T->Ť{U+0164}
*SC15::TypeNextCharacter(["Ý"]) ; Y->Ý {U+00dd}
*SC16::TypeNextCharacter(["Ú","Ů"]) ; U->Ú{U+00da},Ů{U+016e}
*SC17::TypeNextCharacter(["Í"]) ; I->Í{U+00cd}
*SC18::TypeNextCharacter(["Ó"]) ; O->Ó{U+00d3}
; *SC19::SendInput {U+0000} ; P->
*SC1a::TypeNextCharacter(["‹"]) ; {->‹{U+2039}
*SC1b::TypeNextCharacter(["›"]) ; }->›{U+203a}

; *SC3a::SendInput {U+0000} ; Capslock->
*SC1e::TypeNextCharacter(["Á"]) ; A->Á{U+00c1}
*SC1f::TypeNextCharacter(["Š"]) ; S->Š{U+0160}
*SC20::TypeNextCharacter(["Ď"]) ; D->Ď{U+010e}
; *SC21::SendInput {U+0000} ; F->
; *SC22::SendInput {U+0000} ; G->
; *SC23::SendInput {U+0000} ; H->
; *SC24::SendInput {U+0000} ; J->
; *SC25::SendInput {U+0000} ; K->
; *SC26::SendInput {U+0000} ; L->
*SC27::TypeNextCharacter(["‚"]) ; :->‚{U+201a}
*SC28::TypeNextCharacter(["‘"]) ; "->‘{U+2018}
*SC2b::TypeNextCharacter(["’"]) ; |->’{U+2019}
; *SC1c::SendInput {U+0000} ; Enter->

*SC2c::TypeNextCharacter(["Ž"]) ; Z->Ž{U+017d}
; *SC2d::SendInput {U+0000} ; X->
*SC2e::TypeNextCharacter(["Č"]) ; C->Č{U+010c}
; *SC2f::SendInput {U+0000} ; V->
; *SC30::SendInput {U+0000} ; B->
*SC31::TypeNextCharacter(["Ň"]) ; N->Ň{U+0147}
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
