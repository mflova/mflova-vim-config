# mflova-vim-config

Repository used to install and set up vim and my main configuration used. This wills etup vim with the vimrc found at cfg/vimrc.

## Features
Main features of this VIM:
- Tree window: to display files of a project
- Taglist window: to summarize and easy access to classes, functions and variables of a file.
- Fuzzy finder: Search any file given its name or any string inside it. Open the file in any split you want.
- Git integration: check files changed, diff of the file wrt 1) the last commit or 2) any branch. Also integrated change history for files and even functions. Displays in the editor which lines have been changed.
- Temporary maximize one window to better code
- Easy resizing and moving window splits with the keyboard
- Auto-generate templates for documenting functions
- Easy toggle between source (.cpp) and header (.h) files
- Easy selection of sentences enclosed by brackets or any delimiter
- Autocomplete functionality
- Plenty of linters based on format, code analysis, syntaxis and style for Python (pydocstyle, flake8, pylint, mypy and pycodestyle)
- Fast and easy replace mode
- Extremely quick script to print variables and its type.
- Improved motion all over the document with just a few keys


## Installation

Just run `./install` from the repository's root directory. Do not forget to set its permissions with chmod +x install. This will
automatically do the following:
- Install last vim-nox and its dependencies
- Initialize the vimrc file
- Copy all the plugins into the .vim folder

If vim is already installed, you only need to copy the content of the vimrc and change the mapping of the av.vim plugin to better use the editor.

## How to update this repository
The two main files (todo.txt and cfg/.vimrc) are expected to be changed directly from there. During vim installation, the .vimrc that will be read from now on is the one at cfg/.vimrc! Not the one by default at .vim/.vimrc

## How to use this setup
Following tables gather all the commands and shortcuts I like using:

### Main VIM use
Main use
| Command/Shortcut  | Description |
| ------------- | ------------- |
|  :vsave name | Save a session with all splits and NERDTree  |
|  :vload name | Load sessions  |
|  u | Undo changes  |
| . | Repeat last action performed in vim|
|  ctrl + r |  Update opened file (should be automatic) |
|  ctrl + t | Opens a new tab  |
|   ctrl + k| Switch between source and header files  |
|  <Leader>t | Toggles and untoggles the taglist (summary of a file, defined by its classes or variables). To remove entries just press u  |
|   Enter (normal mode) | Selects everything between two brackets. Multiple enters will select more  |
|   ctrl + u/d| Moves the cursor half the screen  |
|o/O | Inserts a new line below and above and enters into insert mode |
|*/# | When the cursor is on a word, it will jump to next (or previous) matching word|
| f/F/t/T -> char -> (, or ;) | Jumps to the next (or previous) one char that matches. This will be recorded. You can press , or ; at any time to continue with previous and next matches. T comes from "till" and f from "find"|
| (number)dd | Removes the following (number) lines. 1 if not specified |
| :(number)d | Removes the specified line|
| c/d -> t/T/f/F -> char | Deletes everything till the cursor reaches the specified char. If d is used it will also enter into insert mode|
|H/M/L| Moves the cursosr to the highest, midle or lower part of the screen|
| Shift + D/C | Removes from cursor to right. D will also enter into insert mode|
|:number| Jump to that line|
|:numberd| Remove that line |
| % over parenthesis | Will jump to the other corresponding parenthesis. It can be combined with commands such as c% to remove everything contained between brackets/parenthesis|
| I/A | Enters insert mode at the beggining/end of the line|
| Space | Insert space and go to insert mode|
| x/s | Delete char. s will also go into insert mode after writing a character|
| dw/dW/cw/cW | Removes word from the cursor and goes into insert mode if c is used. A number before it specifies how many words to delete|
| daw/caw | Removes the entire word, including prev character|
| de/ce | Removes the entire word (Better use this ones)|
|>> or <<| Shifts the line while being in normal mode|  
| 0 | Move to the start of the line|
| b or w| Moves backwards/forwards between the start of different words. You can specific how many words with xb or can be used to remove x words with xcb/xdb|
| e | Jump between the end of next words|
| dgg/D/d$ | Remove from the cursor to the beginning/end of the line|
| gqap | In normal mode, it break long lines|
| ctrl + d | Autocomplete command line|
| ctrl + d (Insert mode) | Delete word under cursor in inser mode|
| ctrl + v (Insert mode) | Paste a yanked work in insert mode|
| v/x (Quickfix/location window)| Opens the file in vertical/horizontal split |
| :term or :vert term | Opens a new terminal (horizontal or vertical)|

Find and replace
| Command/Shortcut  | Description |
| ------------- | ------------- |
| :s/foo/bar/  | Changes foo by bar (first occurence) |
| :s/foo/bar/g  | Changes foo by bar (entire line) |
| :%s/foo/bar/g  | Changes foo by bar (all file) |
| :%s/foo/bar/gc  | Changes foo by bar (all file. Confirmation prompt) |
| Se | (Plugin) Removes the word with se and write new one. Press . to replace following matches |

Highlighting and copy/pasting
| Command/Shortcut  | Description |
| ------------- | ------------- |
| v  | Enters visual mode  |
| w  | Highlights up to next word  |
| Ctrl + Arrows | Highlights up to next space  |
| vv  | Resets highlighted text  |
| y  | Copy  |
| yy | Copy line. p will paste it below|
| d  | Cut  |
|  u | Undo changes  |
| p/P  | Paste  |
| :pu  | Paste in new line  |
| Enter (normal mode)  | Selects everything between two brackets. Multiple enters will select more  |


### Window/Tab handling

| Command/Shortcut  | Description |
| ------------- | ------------- |
| Shift + Arrows  | Moves between split panes  |
| Ctrl + Up/Down  | Moves between tabs  |
| :tclose | Close current tab|
| Shift + W | Close current split pane|
| Shift + x  | Temporary fulscreens a split pane  |
| :vsplit  | Creates a new vertical split with the same file  |
| :split  | Creates a new horizontal split with the same file  |

Resizing and moving split planes

| Command/Shortcut  | Description |
| ------------- | ------------- |
| Ctrl + e  | Enters the mode to resize or move split panes  |
| Enter  | Confirm changes and quite mode  |
| e  | Swap between different moves such as resize or move mode  |
| q  | Quit mode  |
| Moving split panes  | Select a split pane, press Ctrl + e (resize mode), then e (move mode) and move it with the arrows  |


### NERDTree

| Command/Shortcut  | Description |
| ------------- | ------------- |
| F2  | Toggle and untoggle the NERDTree  |
| v in file  | Opens a file in vertical split  |
| x in file  | Opens a file in horizontal split  |
| t in file  | Opens a file in new tab  |
| T in file  | Opens a file in new tab (silent)  |
| r/R  | Refresh node and root node  |
| t in a folder  | Changes current dir to that one  |


### Searching

Search for strings in a file
| Command/Shortcut  | Description |
| ------------- | ------------- |
| /word + enter  | Searches for a word of string. If the saerch is in lowercase, it will be non-sensitive case search. If there is any uppercase, it will be case sensitive  |
| /word + enter + n/N  | Previous and next matches  |

Search for files
| Command/Shortcut  | Description |
| ------------- | ------------- |
| Ctrl + b | Find a specific line within a file (fuzzy finder) |
| Ctrl + f | Find a specific line within all the opened files (fuzzy finder) |
| Ctrl + g | Search for a file in the current directory given a string|
| Ctrl + p | Search for file name in the current directory. Use <Tab> to select more than one file|
| Ctrl + v | Open the file in vertical split   |
| Ctrl + x |  Open the file in horizontal split  |
| Ctrl + t |  Open the file in new tab  |

### Misc
Misc 
| Command/Shortcut  | Description |
| ------------- | ------------- |
| :SO write here the issue | Search the issue in stack overflow |
| :Google write here the issue | Search the issue in google|
| :Googlef write here the issue | Search the issue in google and adds the programming language beaing used as the first word in the saerch|
| Leader c | Comment line/block in Python|
| ctrl+p (Inser mode) | Autocomplete the word based on the document |
| :dcs or :Dosctring | Generates docstring for a given Python function or class|
| Leader -> p/P| Inserts a print statement above or below with the variable chosen by the cursor|
| Leader g | Performs git diff on that file. By quitting it will return to the same file|

Vim-fugitive or git integration
Note: g stands for git
| Command/Shortcut  | Description |
| ------------- | ------------- |
| <Leader>gdf | Git diff of the current file wrt the previous commit|
| <Leader>gdd | Git diff of the current file wrt the develop branch |
| <Leader>gdm | Git diff of the current file wrt the master branch|
| <Leader>gt | Function to toggle/untoggle the folds found in the code|
| <Leader>gh | Check history of changes for the current file (previous commits)|
| <Leader>gH | Check history of changes for the current function (previous commits)|

CTags: Jumping from file to file to look for function definitions
| Command/Shortcut  | Description |
| ------------- | ------------- |
| <Leader>td | use Tags to jump to Definition of a function. Opened in vertical split|

Vim-easy-motion
| Command/Shortcut  | Description |
| ------------- | ------------- |
| <Leader>f | Displays how to jump to the start of a word|
| <Leader>e | Displays how to jump to the end of a word|
| <Leader>w | Displays how to jump to the start of every single word, including all splits|
| <Leader>. | Repeat last vim-easy-motion command|
| <Leader>j or k| Jump to specified line|

Linters/Syntaxis check
| Command/Shortcut  | Description |
| ------------- | ------------- |
| <Leader>at | Toggle the ALE tool (combination of multiple tools that refresh automatically in the buffer. These are as mypy, flake8, pylint...). Note: max-line-length fixed to 90. If you removed that constraing in the vimrc file, the .flake8 will be read with the proper config instead|
| <Leader>af | Fixes some of the changes. The fixers are in the vim config|
| :GrammarousCheck | Display grammar errors |
| :GrammarousReset | Remove the errors |
| F4 | Flake8 quickfix window. Not recommendedm automatically done with ALE now |
| :Isort/:isort | Sorts the imports of Python script according to Pep8 |

To do list manager
| Command/Shortcut  | Description |
| ------------- | ------------- |
| <Leader><Leader> | Swap between the todo list and the file that is being edit|
| All status | DONE, WIP, TODO, HELP, WAIT, BLOCKED|

## Notes           

Inspired by [igemnace][1] repository.

[1]: https://github.com/igemnace/vim-config
