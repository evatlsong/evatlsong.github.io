---
title: practical-vim
date: 2015-06-29 10:39:27
tags: vim
---

:version

# basic operate
## viewing different parts of the work buffer

    CONTROL-E (default: 1 line)
    CONTROL-Y 

    CONTROL-D(down) (default: 1/2 window)
    CONTROL-U(up)

    CONTROL-F(forward) (default: 1 window)
    CONTROL-B(backward)

    zz: scroll cursor to top
    zb: bottom
    zz: center

    G: go to line

## search

    n     Jump to next match, preserving direction and offset
    N     Jump to previous match, preserving direction and offset
    /<CR> Jump forward to next match of same pattern
    ?<CR> Jump backward to previous match of same pattern

    %

    :noh<CR> to mute search highlighting

## replace

    r
    R

## interact with the System clipboard

    :set paste
    :set paste!

## folding and outlining

    zA Toggle the state of folds, recursively
    zC Close folds, recursively
    zD Delete folds, recursively
    zE Eliminate all folds
    zf Create a fold from the current line to the one where the following motion
       command takes the cursor
    countzF Create a fold covering count lines, starting with the current line
    zM Set option foldlevel to 0
    zN, zn Set (zN) or reset (zn) the foldenable option
    zO Open folds, recursively
    za Toggle the state of one fold
    zc Close one fold
    zd Delete one fold
    zi Toggle the value of the foldenable option
    zj, zk Move cursor to the start (zj) of the next fold or to the end (zk) of the
           previous fold
    zm, zr Decrement (zm) or increment (zr) the value of the foldlevel option by one
    zo Open one fold

    zA, zC, zD and zO are called recursive because they operate on all folds nested 
    within the one where you issue the commands

text object (文本对象 aw iw it)

. 重复上次修改
a change could be anything that modifies the text in the document. That includes
commands triggered from Normal, Visual, and Command-Line modes, but a change could
also encompass any text entered (or deleted) in Insert mode.

Moving Around in Insert Mode Resets the Change

    复合命令 等效的长命令
    C        c$
    s        cl
    S        ^c
    I        ^i
    A        $a
    o        A<CR>
    O        ko

    Intent                               Act                     Repeat   Reverse
    Make a change                        {edit}                  .        u
    Scan line for next character         f{char}/t{char}         ;        ,
    Scan line for previous character     F{char}/T{char}         ;        ,
    Scan document for next match         /pattern<CR>            n        N
    Scan document for previous match     ?pattern<CR>            n        N
    Perform substitution                 :s/target/replacement   &        u
    Execute a sequence of changes        qx{changes}q            @x       u

* 查找当前光标下的单词

normal mode

    Operator + Motion = Action

Vim's grammar has just one more rule: when an operator command is invoked in 
duplicate, it acts upon the current line. So dd deletes the current line, 
while >> indents it.  The gU command is a special case. We can make it act upon 
the current line by running either gUgU or the shorthand gUU.


Vim's Operator Commands

    Trigger Effect
    c       Change
    d       Delete
    y       Yank into register
    g~      Swap case
    gu      Make lowercase
    gU      Make uppercase
    >       Shift right
    <       Shift left
    =       Autoindent
    !       Filter {motion} lines through an external program


Insert Mode

    Keystrokes Effect
    <C-h>      Delete back one character (backspace)
    <C-w>      Delete back one word
    <C-u>      Delete back to start of line

    Keystrokes Effect
    <Esc>      Switch to Normal mode
    <C-[>      Switch to Normal mode
    <C-o>      Switch to Insert Normal mode

register
expression register 

    Keystrokes       Buffer Contents
    A                6 plus 35 equals
    <C-r>=6*35<CR>   6 plus 35 equals 210

Insert Unusual Characters by Character Code
Insert Unusual Characters

    Keystrokes             Effect
    <C-v>{123}             Insert character by decimal code
    <C-v>u{1234}           Insert character by hexadecimal code
    <C-v>{nondigit}        Insert nondigit literally
    <C-k>{char1}{char2}    Insert character represented by {char1}{char2} digraph

ga command outputs a message at the bottom of the screen, revealing the character
code in decimal and hexadecimal notations

Overwrite Tab Characters with Virtual Replace Mode
gR
gr{char}

Visual Mode
Enabling Visual Modes

    Command  Effect
    v        Enable character-wise Visual mode
    V        Enable line-wise Visual mode
    <C-v>    Enable block-wise Visual mode
    gv       Reselect the last visual selection

    o        Go to other end of highlighted text


In Visual and Operator-Pending modes the i and a keys follow a different convention:
they form the first half of a text object.
If you've made a selection with Visual-Block mode and you wonder why you're not 
in Insert mode after pressing i, try using I instead.


Command-Line Mode
a few of the symbols that can be used to create addresses and ranges for Ex commands

    Symbol Address
    1      First line of the file
    $      Last line of the file
    0      Virtual line above first line of the file
    .      Line where the cursor is placed
    'm     Line containing mark m
    '<     Start of visual selection
    '>     End of visual selection
    %      The entire file (shorthand for : 1,$)
