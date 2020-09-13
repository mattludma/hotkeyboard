# HotKeyboard
A simple 
[Autohotkey script](https://github.com/mattludma/hotkeyboard/blob/master/bin/hotkeyboard.exe)
that adds nifty multilingual support to your keyboard using AltGr (right Alt) key

## What is HotKeyboard

- Do you constantly have to switch between different keyboard layouts?
- Are you fed up with always correcting typos you've made by using the wrong one?

HotKeyboard is a script that will let you add all the missing characters
to your preffered keyboard layout, so you don't have to bother with switching
layouts ever again. You can access these characters by holding right Alt
(**a.k.a. AltGr**) key and then pressing the base key of the character.

For example:

- AlrGr+r = "ř" (Czech)
- AltGr+Shift+l = "Ľ" (Slovak)
- AltGr+s = "ß" (German)
- AltGr+? = "¿" (Spanish)

Your base keyboard layout will is unaffected by the script. The only ecxeption
in the right Alt key, which will stop acting as an "Alt" key, as it will become
a completely new modifier key.

This concept is similar to the "International US keyboard" that is present on
Windows operating system, but has two big improvements over it:

1) You can get to more then one special characters by pressing the base key repeatedly
   - (e.g. AltGr+e will give you "é" but **AltGr+e+e** will give you "ě")
2) You can easily adjust the keyboard to your specific preferences. Just change the
hotkeyboard.ahk file and you can run your very own version of this multilingual keyboard.
It's easier then you might think.

## Usage

You can run the script by either running a
[standalone executable](https://github.com/mattludma/hotkeyboard/blob/master/bin/hotkeyboard.exe)
or by installing [AutoHotkey](https://www.autohotkey.com/) scripting lnaguage
and then running the
[source file](https://github.com/mattludma/hotkeyboard/blob/master/src/hotkeyboard.ahk),
which is esentially a .txt file that you can edit according to
[AutoHothey syntax](https://www.autohotkey.com/docs/FAQ.htm#language-syntax)
.

I reccomend using a standard US keyboard as the base layout, because you are most likely
to encounter with it when typing on someone else's computer.

## Supported languages

Current Hotkeyboard is optimized for **Czech and Slovak** language
(apart from English of course).

Characters of these all languages are also included:
- French
- German
- Spanish
- Polish

**Feel free to participe** by adding more characters and creating versions optimised for
different language combinations!

More info at https://github.com/mattludma/hotkeyboard
