# mflova-vim-config

Repository used to install and set up vim and my main configuration used. The idea is not to modify anything from this repository. All changes can be made in .vim folder (including README.md and todo.txt). When local files from the .vim folder are changed, the script /update_vim_repo from .vim will automatically update this repository so that you can push it to github.

## Installation

Just run `./install` from the repository's root directory. Do not forget to set its permissions with chmod +x install. This will
automatically do the following:
- Install vim-nox and its dependencies
- Initialize the vimrc file
- Copy all the plugins into the .vim folder
- Change the configuration of some specific plugins

If vim is already installed, you only need to copy the content of the vimrc and change the mapping of the av.vim plugin to better use the editor.

## How to update this repository
After modifying the local files in your .vim folder, you can execute the `./update_vim_repo` to update the files from this repo. Then, you can git commit the changes. Only following files will be updated:
- .vimrc
- README.md
- todo.txt 

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
|  F3 | Toggles and untoggles the taglist (summary of a file, defined by its classes or variables). To remove entries just press u  |
|   Enter (normal mode) | Selects everything between two brackets. Multiple enters will select more  |
|   ctrl + u/d| Moves the cursor half the screen  |
|o/O | Inserts a new line below and above and enters into insert mode |
|*/# | When the cursor is on a word, it will jump to next (or previous) matching word|
| f/F/t/T -> char -> (, or ;) | Jumps to the next (or previous) one char that matches. This will be recorded. You can press , or ; at any time to continue with previous and next matches. T comes from "till" and f from "find"|
| (number)dd | Removes the following (number) lines. 1 if not specified |
| c/d -> t/T/f/F -> char | Deletes everything till the cursor reaches the specified char. If d is used it will also enter into insert mode|
|H/M/L| Moves the cursosr to the highest, middle or lower part of the screen|
| Shift + D/C | Removes from cursor to right. D will also enter into insert mode|
|:number| Jump to that line|
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
| dgg/D | Remove from the cursor to the beginning/end of the line|
| gqap | In normal mode, it break long lines|

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
| Enter (normal mode)  | Selects everything between two brackets. Multiple enters will select more  |


### Window/Tab handling

| Command/Shortcut  | Description |
| ------------- | ------------- |
| Shift + Arrows  | Moves between split panes  |
| Ctrl + Up/Down  | Moves between tabs  |
| Ctrl + W | Close current tab  |
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
| :ntsave name | Save NERDTree directory  |
| :ntload name  | Load NERDTree directory  |
| :ntrm name  | Remove NERDTree directory  |


### Searching

Search for strings in a file
| Command/Shortcut  | Description |
| ------------- | ------------- |
| /word + enter  | Searches for a word of string. If the saerch is in lowercase, it will be non-sensitive case search. If there is any uppercase, it will be case sensitive  |
| /word + enter + n/N  | Previous and next matches  |

Search for strings in files
| Command/Shortcut  | Description |
| ------------- | ------------- |
| :vgrep or :Ag name  | Enters visual mode  |
| Enter  | Opens file where the cursor is*  |
| t  | Opens file in new tab  |
| x  | Opens file in horizontal split  |
| v  | Opens file in vertical split  |

*By default, the window search will be closed. If you want to change this, comment the line `autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>` in the vimrc.

Search for files
| Command/Shortcut  | Description |
| ------------- | ------------- |
| Ctrl + p | Search for file in the NERDTree directory   |
| v | Open the file in vertical split   |
| x |  Open the file in horizontal split  |
| t |  Open the file in new tab  |

### Misc
Misc 
| Command/Shortcut  | Description |
| ------------- | ------------- |
| F4 | Runs flake8 |
| :SO write here the issue | Search the issue in stack overflow |
| ctrl+x | Comment line/block in Python|

## Notes           

Inspired by [igemnace][1] repository.

[1]: https://github.com/igemnace/vim-config
