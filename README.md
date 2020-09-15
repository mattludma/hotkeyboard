# HotKeyboard
A simple 
[Autohotkey script](https://github.com/mattludma/hotkeyboard/raw/master/release/hotkeyboard.zip)
that adds nifty multilingual support to your keyboard using AltGr (right Alt) key

## What is it for

- Are you constantly switching between different keyboard layouts?
- Are you fed up with all the typos made when you forget to check which one is active?

HotKeyboard is a script that will add all the missing characters to your
main keyboard layout, so you won't have to bother with switching layouts
ever again. You can access these extra characters by holding `AltGr`
(right Alt) key and then pressing the base key of the character.

**Some examples:**

| Keys combination     | Outcome  | Languages character occurs in |
|----------------------|----------|-------------------------------|
| `AlrGr + a`          | á        | Czech, Slovak                 |
| `AlrGr + Shift + a`  | Á        | Czech, Slovak                 |
| `AlrGr + e`          | é        | Czech, Slovak, French         |
| `AlrGr + e + e`      | ě        | Czech                         |
| `AlrGr + s + s`      | ß        | German                        |
| `AltGr + ?`          | ¿        | Spanish                       |
        
Your base keyboard layout is unaffected by the script. The only ecxeption is
the right Alt key, which will stop acting as an "Alt" key, as it will become
a new modifier key.

This concept is similar to the "International US keyboard" that is present on
Windows operating system but has several advantages over it:

1) **It fully covers multiple latin alphabets**.
   - You can get to different special characters by pressing the base key repeatedly.
   - e.g. `AltGr + n` will give you "ň" (Slovak) but `AltGr + n + n` will give you "ñ" (Spanish)
2) **It's adjustable to your specific needs**.
   - You can easily modify the keyboard based on your language preferences. Just change the
   `hotkeyboard.ahk` file and create your very own version. It's easier then you might think.
3) **It's compatibile with any base keyboard layout**.
   - Your base layout will stay the same, so your colleagues and friends won't have a hard time
   when typing on your computer (and vice versa).

## Usage

1) Download and unzip the
[current version](https://github.com/mattludma/hotkeyboard/raw/master/release/hotkeyboard.zip)
of HotKeyboard
2) Run the stand-alone `hotkeyboard.exe` file.
   - A green icon indicating that the script is running should appear in your system tray.
   - ![tray](./resources/tray.png)
3) If you want to run the HotKeyboard on each startup, run the `enable_exe_on_startup.bat` file.

Alternatively you can install [AutoHotkey](https://www.autohotkey.com/) scripting
lnaguage and then run the `hotkeyboard.ahk` source file. Use this option if you want
to customize the keyboard (`hotkeyboard.ahk` is esentially just a text file that you
can edit according to
[AutoHothey syntax](https://www.autohotkey.com/docs/FAQ.htm#language-syntax)).

I recommend using a standard US keyboard as the base layout, especially if you are
a programmer.

## Supported languages

- Croatian
- Czech
- Danish
- Dutch
- Estonian
- English
- Icelandic
- Italian
- Finnish
- French
- German
- Hungarian
- Norwegian
- Slovak
- Slovene
- Spanish
- Swedish
- Polish
- Portuguese


Hotkeyboard is currently optimized for **Czech and Slovak** language
(apart from English of course), but **feel free to create new versions**
optimised for different language combinations!

- You can check for more info on [github](https://github.com/mattludma/hotkeyboard).
- Scancodes for keyboard keys can be found [here](http://www.seasip.info/Misc/1227T.html).
