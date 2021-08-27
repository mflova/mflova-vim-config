# mflova-vim-config

Repository used to install and set up vim and my main configuration used. The idea is to have this repository wherever you want. When local files from the .vim folder are changed, a script will automatically update this repository so that you can push it in github.

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
|  ctrl + r |  Update opened file (should be automatic) |
|  ctrl + t | Opens a new tab  |
|   ctrl + k| Switch between source and header files  |
|  F3 | Toggles and untoggles the taglist (summary of a file, defined by its classes or variables). To remove entries just press u  |
|   Enter (normal mode) | Selects everything between two brackets. Multiple enters will select more  |
|   ctrl + u/d| Moves the cursor half the screen  |

Highlighting and copy/pasting
| Command/Shortcut  | Description |
| ------------- | ------------- |
| v  | Enters visual mode  |
| w  | Highlights up to next word  |
| Ctrl + Arrows | Highlights up to next space  |
| vv  | Resets highlighted text  |
| y  | Copy  |
| d  | Cut  |
|  u | Undo changes  |
| p/P  | Paste  |
| Enter (normal mode)  | Selects everything between two brackets. Multiple enters will select more  |


### Window/Tab handling

| Command/Shortcut  | Description |
| ------------- | ------------- |
| Shift + Arrows  | Moves between split panes  |
| Ctrl + Up/Down  | Moves between tabs  |
| Ctrl + w  | Close current tab  |
| Shift + x  | Temporary fulscreens a split pane  |
| :vsplit  | Creates a new vertical split with the same file  |
| :split  | Creates a new horizontal split with the same file  |

Resizing and moving split planes

| Command/Shortcut  | Description |
| ------------- | ------------- |
| Ctrl + e  | Content Cell  |
| Enter  | Content Cell  |
| e  | Content Cell  |
| q  | Content Cell  |
| Moving split panes  | Select a split pane, press Ctrl + e (resize mode), then e (move mode) and move it with the arrows  |


### NERDTree

| Command/Shortcut  | Description |
| ------------- | ------------- |
| F2  | Content Cell  |
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
| /word + enter  | Enters visual mode  |
| /word + enter + n/N  | Previous and next matches  |

Search for strings in files
| Command/Shortcut  | Description |
| ------------- | ------------- |
| :vgrep or :ag name  | Enters visual mode  |
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




## Notes           

Inspired by [igemnace][1] repository.

[1]: https://github.com/igemnace/vim-config
