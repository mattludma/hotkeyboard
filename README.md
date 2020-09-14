# HotKeyboard
A simple 
[Autohotkey script](https://github.com/mattludma/hotkeyboard/raw/master/release/hotkeyboard.zip)
that adds nifty multilingual support to your keyboard using AltGr (right Alt) key

## What is it for

- Are you constantly switching between different keyboard layouts?
- Are you fed up with all the typos when you forget to check the current one?

HotKeyboard is a script that will let you add all the missing characters to
your one preffered keyboard layout, so you don't have to bother with switching
layouts ever again. You can access these characters by holding AltGr
(right Alt) key and then pressing the base key of the character.

Examples:

| Keys combination   | Outcome  | Languages character occurs in |
|--------------------|----------|-------------------------------|
| AlrGr + a          | á        | Czech, Slovak                 |
| AlrGr + Shift + a  | Á        | Czech, Slovak                 |
| AlrGr + e          | é        | Czech, Slovak, French         |
| AlrGr + e + e      | ě        | Czech                         |
| AlrGr + s + s      | ß        | German                        |
| AltGr + ?          | ¿        | Spanish                       |
        
Your base keyboard layout is unaffected by the script. The only ecxeption is
the right Alt key, which will stop acting as an "Alt" key, as it will become
a new modifier key.

This concept is similar to the "International US keyboard" that is present on
Windows operating system, but has several advantages over it:

1) **Full support of multiple latin alphabets**. You can get to different special characters by pressing the
base key repeatedly.
   - e.g. *AltGr + n* will give you "ň" (Slovak) but *AltGr + n + n* will give you "ñ" (Spanish)
2) **It's adjustable to your specific needs**.
   - You can easily modify the keyboard to your specific preferences. Just change the
*hotkeyboard.ahk* file and run your very own version of this multilingual keyboard.
It's easier then you might think.
3) **It's compatibile with any base keyboard layout**.
   - Your base layout will stay the same, so your colleagues and friends won't have a hard time
   when typing on your computer (and vice versa).

## Usage

After downloading and unzipping the
[current version](https://github.com/mattludma/hotkeyboard/raw/master/release/hotkeyboard.zip)
of HotKeyboard you can either run the standalone *hotkeyboard.exe* file or you can install
[AutoHotkey](https://www.autohotkey.com/) scripting lnaguage and then run the *hotkeyboard.ahk*
source file (which is esentially a .txt file that you can edit according to
[AutoHothey syntax](https://www.autohotkey.com/docs/FAQ.htm#language-syntax)).

I reccomend using a standard US keyboard as the base layout (especially if you are
a programmer) and removing layouts of languages covered by HotKeyboard, so the switching
wont bother you ever again.

## Supported languages

- Czech
- Slovak
- Polish
- French
- German
- Spanish

Hotkeyboard is currently optimized for **Czech and Slovak** language
(apart from English of course), but **feel free to participe** by creating
versions optimised for different language combinations!

- You can check for more info on [github](https://github.com/mattludma/hotkeyboard).
- Scancodes for keyboard keys can be found [here](http://www.seasip.info/Misc/1227T.html).
