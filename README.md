# mflova-vim-config

Repository used to install and set up vim and my main configuration used. This will
set up vim with the vimrc found at cfg/vimrc. Intended for personal use, so it might
still be buggy.

## Install

You can run first the `bashrc_setup.yaml` and then the `nvim_installation.yaml`
with `ansible-playbook --ask-become`. Be aware that for the second script the variables
defined by the first one must be available, so it is necessary to either source
`.bashrc` or to launch a new terminal. You can do all of this with a single file:

```shell
. full_installation.yaml
```

## Set up as merge tool

Use the following lines:

```
git config --global mergetool.fugitive.cmd 'nvim -f -c "Gvdiffsplit!" "$MERGED"'
git config --global merge.tool fugitive
```

And then you can use "git mergetool" after finding conflicts to use Vim fugitive
tool. The centered window corresponds to the final changes that will be applied.

On vim, you can open a file in three way split by pressing `dv` over the conflicted
file in git status window from fugitive.

## Features

Main features of this VIM:

- Tree window: to display files of a project
- Taglist window: to summarize and easy access to classes, functions and variables
  of a file.
- Fuzzy finder: Search any file given its name or any string inside it.
  Open the file in any split you want.
- Git full integration: Full integration (log, stash, branch management, push,
  commit...) and also with the online repository.
- LSP functionalities: go to reference, definition, hover, context-aware
  statusline...
- Temporary maximize one window to better code
- Documentation template for docstrings easily auto-generated in multiple standards
- Easy resizing and moving window splits with the keyboard
- Auto-generate templates for documenting functions
- Easy toggle between source (.cpp) and header (.h) files
- Easy selection of sentences enclosed by brackets or any delimiter
- Autocomplete functionality
- Quick snippets for Python and C++. With endless items some of them.
- Plenty of linters based on format, code analysis, syntaxis and type checking.
  All of them integrated in the built-in neovim LSP:
  - Python: Pylint, mypy, vulture, pytestcov and flake8. This last one
    integtegrates: darglint, pytest-style, flake8-simplify, flake8-bugbear,
    dlint, comprehensions, flake8-rst-docstrings, flake8-markdown, flake8-builtins,
    flake8-borken-line, flake8-class-attributes-order and more.
  - Markdown: mdl.
  - C++: Clangtidy, cppcheck and cpplint.
  - CMake: CMakelint.
  - Yaml: yamllint.
  - Rst: rstlint and rstcheck.
  - Grammar-based: codespell and proselint.
- Fast and easy replace mode.
- Extremely quick script to print variables and its type.
- Improved motion all over the document with just a few keys.
- Integrated unit test frameworks within VIM (such as PyTest).
- Previewers for RST and Markdown that are live updated.
- Debugger for Python.
- Refactor capabilites.
- Ranger

## Installation

Just run `./install` from the repository's root directory. Do not forget to set
its permissions with chmod +x install. This will automatically do the following:

- Install last vim-nox and its dependencies
- Initialize the vimrc file
- Copy all the plugins into the .vim folder

If vim is already installed, you only need to copy the content of the vimrc and
change the mapping of the av.vim plugin to better use the editor.

## How to update this repository

The two main files (todo.txt and cfg/.vimrc) are expected to be changed directly
from there. During vim installation, the .vimrc that will be read from now on is
the one at cfg/.vimrc! Not the one by default at .vim/.vimrc

## How to use this setup

Following tables gather all the commands and shortcuts I like using:

### Main VIM use

Main use
| Command/Shortcut   | Description                                                                |
| ------------------ | -------------------------------------------------------------------------- |
| :vsave name        | Save a session with all splits and NERDTree                                |
| :vload name        | Load sessions                                                              |
| u                  | Undo changes                                                               |
| r                  | Redo changes                                                               |
| .                  | Repeat last action performed in vim                                        |
| ctrl + r           | Update opened file (should be automatic)                                   |
| ctrl + x           | Switch between source and header files                                     |
| ctrl + up          | Go two lines up                                                            |
| ctrl + down        | Go two lines down                                                          |
| F4                 | Toggles and untoggles the taglist (summary of a file, defined by itsclasses or variables). To remove entries just press u |
| Enter              | Selects everything between two brackets. Multiple enters will select more  |
| ctrl + u/d         | Moves the cursor half the screen                                           |
| o/O                | Inserts a new line below and above and enters into insert mode             |
| */#                | When on a word, it will jump to next (or previous) matching word           |
| f/F/t/T            | Jumps to the next (or previous) one char that matches. This will be recorded. You can press , or ; at any time to continue with previous and next matches. T comes from "till" and f from "find" |
| (number)dd         | Removes the following (number) lines. 1 if not specified                   |
| :(number)d         | Removes the specified line                                                 |
| c/d -> t/T/f/F     | Deletes everything till the cursor reaches the specified char. If d is used it will also enter into insert mode|
| H/M/L              | Moves the cursosr to the highest, midle or lower part of the screen        |
| Shift + D/C        | Removes from cursor to right. D will also enter into insert mode           |
| :number            | Jump to that line                                                          |
| :numberd           | Remove that line                                                           |
| %                  | Jump to paired bracket                                                     |
| I/A                | Enters insert mode at the beginning/end of the line                        |
| Space              | Insert space and go to insert mode                                         |
| x/s                | Delete char. s will also go into insert mode after writing a character     |
| dw/dW/cw/cW        | Removes word from the cursor and goes into insert mode if c is used. A number before it specifies how many words to delete|
| daw/caw            | Removes the entire word, including prev character                          |
| de/ce              | Removes the entire word (Better use this ones)                             |
| >> or <<           | Shifts the line while being in normal mode                                 |  
| 0                  | Move to the start of the line                                              |
| b or w             | Moves backwards/forwards between the start of different words. You can specific how many words with xb or can be used to remove x words with xcb/xdb|
| e                  | Jump between the end of next words                                         |
| dgg/D/d$           | Remove from the cursor to the beginning/end of the line                    |
| gqap               | In normal mode, it break long lines                                        |
| ctrl + d           | Autocomplete command line                                                  |
| ctrl + d (Insert m)| Delete word under cursor in inser mode                                     |
| ctrl + v (Insert m)| Paste a yanked work in insert mode                                         |
| TBD/x (Quickfix/location window)| Opens the file in vertical/horizontal split                   |
| :term/:vert term   | Opens a new terminal (horizontal or vertical)                              |

Find and replace
| Command/Shortcut  | Description                                                                   |
| -------------- | -------------------------------------------------------------------------------- |
| :s/foo/bar/    | Changes foo by bar (first occurrence)                                            |
| :s/foo/bar/g   | Changes foo by bar (entire line)                                                 |
| :%s/foo/bar/g  | Changes foo by bar (all file)                                                    |
| :%s/foo/bar/gc | Changes foo by bar (all file. Confirmation prompt)                               |
| Se             | Removes the word with se and write new one. Press . to replace following matches |

Highlighting and copy/pasting
| Command/Shortcut  | Description                                                           |
| ------------- | ------------------------------------------------------------------------- |
| v             | Enters visual mode                                                        |
| w             | Highlights up to next word                                                |
| Ctrl + Arrows | Highlights up to next space                                               |
| vv            | Resets highlighted text                                                   |
| y             | Copy                                                                      |
| yy            | Copy line. p will paste it below                                          |
| d             | Cut                                                                       |
| u             | Undo changes                                                              |
| p/P           | Paste                                                                     |
| :pu           | Paste in new line                                                         |
| Enter         | Selects everything between two brackets. Multiple enters will select more |


### Window/Tab handling

| Command/Shortcut  | Description                                        |
| ----------------- | -------------------------------------------------- |
| Shift + Arrows    | Moves between split panes                          |
| Shift + x         | Temporary fulscreens a split pane                  |
| :vsplit or :vs    | Creates a new vertical split with the same file    |
| :split            | Creates a new horizontal split with the same file  |
| Ctrl+Up/Down      | Move between items in the quickfix list            |

Resizing and moving split planes

| Command/Shortcut   | Description                                              |
| ------------------ | -------------------------------------------------------- |
| Ctrl + e           | Enters the mode to resize or move split panes            |
| Enter              | Confirm changes and quite mode                           |
| e                  | Swap between different moves such as resize or move mode |
| q                  | Quit mode                                                |
| Arrows (move mode) | Select a split pane, press Ctrl + e (resize mode), then e (move mode) and move it with the arrows  |


### File explorer

| Command/Shortcut | Description                       |
| ---------------- | --------------------------------- |
| F2               | Toggle and untoggle the nvim tree |
| Ctrl + v         | Opens a file in vertical split    |
| Ctrl + x         | Opens a file in horizontal split  |
| Ctrl + t         | Opens a file in new tab           |
| r                | Rename a file                     |
| R                | Refresh tree                      |
| p                | Paste a file                      |
| d                | Remove a file                     |
| a                | Create file/folder                |
| x                | Cut a file                        |


### Searching

Search for strings in a file
| Command/Shortcut     | Description                                                                                                                                              |
| -------------------- | -------------------------                                                                                                                                |
| /word + enter        | Searches for a word of string. If the saerch is in lowercase, it will be non-sensitive case search. If there is any uppercase, it will be case sensitive |
| /word + enter + n/N  | Previous and next matches                                                                                                                                |

Search for files and navigation
| Command/Shortcut   | Description                                                     |
| ------------------ | --------------------------------------------------------------- |
| Ctrl + b           | Find a specific line within a file (fuzzy finder)               |
| Ctrl + f           | Fuzzy finder for strings in multiple files                      |
| Ctrl + t           | Search files among open buffers                                 |
| Ctrl + f           | Search for a file in the current directory given a string       |
| Ctrl + g           | FZF Marks (change directory inside nvim)                        |
| Ctrl + p           | Search for file name in the current directory. Use \<Tab\> to select more than one file and then opened them with ctrl+v or ctrl+x |
| Ctrl + h           | FZF marks menu to quickly cd inside vim                         |
| \<leader\>Ctrl + p | Search within my own vim files                                  |
| \<leader\>f        | Open ranger                                                     |
| Ctrl + v           | Open the file in vertical split                                 |
| Ctrl + x           | Open the file in horizontal split                               |
| Ctrl + t           | Open the file in new tab                                        |
| Ctrl + q           | Open multiple selected files in a quickfix window               |
| Ctrl + Arrows      | Move the content of the previow window up or down               |
| Ctrl + a           | Alternate with the last file opened. Valid in insert mode       |

### LSP
Mainly LSP-related functionalities
| Command/Shortcut   | Description                                                    |
| ------------------ | -------------------------------------------------------------- |
| \<leader\>l        | LSP-related commands                                           |
| \<leader\>lt       | Toggle basic linting coming from LSP (as well as heavy linting)|
| \<leader\>lv       | Toggle heavy linting                                           |
| \<leader\>lc       | Toggle CMP. CMP keys below                                     |
| Tab/Shift-Tab      | Move between autocomplete options                              |
| Ctrl + Up/Down     | Scroll the documentation of a function in case it is displayed |
| Ctrl + q           | Quit the autocomplete menu                                     |
| \<leader\>ls       | Generate stubs for python module/package when cursor over "import/from" statement |
| \<leader\>ll       | Toggle a list of all diagnotics for the current file           |
| \<leader\>lL       | Toggle a list of all diagnotics for the entier working dir     |
| \<leader\>lr       | Open a list with references                                    |
| \<leader\>ld       | Go to definition                                               |
| Ctrl + i/o         | Goes to previews/next jump (useful after go to definition)     |
| \<leader\>lh       | Hover                                                          |

### Refactor
| Command/Shortcut       | Description                                                    |
| ---------------------- | -------------------------------------------------------------- |
| \<leader\>rm (or rm)   | Extract function                                               |
| \<leader\>rr           | Rename                                                         |
| \<leader\>ru           | Undo changes performed by the API                              |

### Coding
| Command/Shortcut       | Description                                                    |
| ---------------------- | -------------------------------------------------------------- |
| \<leader\>cr           | Run the code selected (Python)                                 |
| \<leader\>cR           | Clean the output of the pevious command                        |
| \<Leader\>cc           | Comment line/block in Python                                   |
| \<leader\>cr           | Toggle preview for markdown and rst                            |

### Testing
| Command/Shortcut    | Description                                                                      |
| ------------------- | -------------------------------------------------------------------------------- |
| \<Leader\>tT        | Toggle/Untoggle testing mode (pytest and pyunit) for the given file. Runs nearest test after saving |
| \<Leader\>tt        | Same as previous on but with summary                                             |
| R in summary window | Rerun a test                                                                     |
| \<Leader\>tr        | After entering in the test mode, this one runs all the tests regardless the current buffer |
| Alt+Up/down         | Move between prev and next failed tests                                          |
| Alt+Left/Right      | Enter the preview wndow that dsplays the results of the test                     |

### Debugging
| Command/Shortcut     | Description                                                                      |
| -------------------- | -------------------------------------------------------------------------------- |
| \<Leader\>dd         | Toggle debugger mode (UI) (only python)                                          |
| \<Leader\>dc or d\<Leader\>       | Run the debugger till breakpoint. Ctrl + Left if debug mode enabled |
| \<Leader\>db         | Toggle breakpoint                                                                |
| \<Leader\>d\<Up\>    | Step out (Ctrl+Up if debugger mode enabled)                                      |
| \<Leader\>d\<Down\>  | Step into (Ctrl+Down if debugger mode enabled)                                   |
| \<Leader\>d\<Right\> | Step over (Ctrl+Right if debugger mode enabled)                                  |
| \<Leader\>dt         | Debug a `test_` function from pytest. It launches the debug mode automatically   |
| \<Leader\>dT         | Debug a `Class` containing multiple pytest test. Launches debug mode as well     |



### Misc
Misc 
| Command/Shortcut              |                                                                                                                                                            Description |
| ----------------------------- |                                                                                                              --------------------------------------------------------- |
| :SO write here the issue      |                                                                                                                                     Search the issue in stack overflow |
| :Google write here the issue  |                                                                                                                                             Search the issue in google |
| :Googlef write here the issue |                                                               Search the issue in google and adds the programming language beaing used as the first word in the saerch |
| ctrl+p (Insert mode)          |                                                                                                                            Autocomplete the word based on the document |
| ctrl+d                        | Generates docstring for a given function or class. The cursor must be in the same line as the declaration. You can use tab/shift tab to move between the TODO comments |
| \<Leader\> + p/P              |                                                                                        Inserts a print statement above or below with the variable chosen by the cursor |
| gS/gJ                         |                                                                                 Splits/Join the arguments from a function into multiple lines (or the code in general) |
| \<Leader\><Right>             |                                                                                                            Go to column 90 (useful when you want to split a long line) |
| :Isort/:isort                 |                                                                                                                   Sorts the imports of Python script according to Pep8 |
| :Glow                         |                                                                                                                                            Previsualized markdown file |

Vimwiki (notes)
| Command/Shortcut       | Description                                                     |
| ---------------------- | --------------------------------------------------------------  |
| \<leader\>\<leader\>   | Toggle between vimwiki (notes) and your normal file             |
| Enter (in this mode)   | Generate a link to  anew file or enter if it is already defined |
| Delete (in this mode)  | Go back to previous file (you can also use ctrl-o)              |

Spotify
| Command/Shortcut       | Description                                                    |
| ---------------------- | -------------------------------------------------------------- |
| \<leader\>ss           | Open spotify main menu to search                               |
| \<leader\>sd           | Spotify devices                                                |
| \<leader\>s\<Right\>   | Skip track                                                     |
| \<leader\>s\<Down\>    | Pause track                                                    |
| \<leader\>s\<Left\>    | Previous track                                                 |


Snippets
| Command/Shortcut              | Description                                               |
| ----------------------------- | --------------------------------------------------------- |
| Tab/Shift tab                 | Jump between nodes                                        |
| Ctrl + e                      | Expand choice node. These are nodes with ·? symbol        |

Vim-fugitive or git integration
Note: g stands for git
| Command/Shortcut  | Description |
| ------------- | --------------------------------------------------------------------------------------- |
| \<leader\>gs  | Run the tool git status useful to stage, usntage...                                     |
| s/u/U on a file or folder | Stage/Unstage(all)                                                          |
| dv on a file  | 3 way split to solve merge conflicts                                                    |
| Enter on file | Open the file                                                                           |
| = on a file   | Visualize the changes to the file in quick format                                       |
| dd on file    | Performs diff in two windows                                                            |
| gi            | Opens the file .git/info/exclude under repo to add personal ignored files               |
| gI            | Ignore THAT file by adding it to the personal .git/info/ecxclude                        |
| cc            | Commit                                                                                  |
| ca            | Amend and commit (add something I forgot to the last commit)                            |
| X             | Discard changes of that file                                                            |
| \<Leader\>gt  | Run the stash tool                                                                      |
| Ctrl + p      | Pop                                                                                     |
| Ctrl + d      | Drop/Delete                                                                             |
| Ctrl + s      | Save/Stash/Push with no name or the name written in the FZF (staged and tracked)        |
| Ctrl + k      | Save/Stash/Push and and continue with the same working dir (only staged)                |
| Enter         | Apply                                                                                   |
| \<Leader\>gb  | Open the menu for operating with local branches. Options below                          |
| \<Leader\>gB  | Open the menu for operating with all branches. Options below                            |
| \<Leader\>gS  | Stash menu                                                                              |
| Enter         | Perform the diff of that commit. Can select range with visual line mode                 |
| q             | Quit                                                                                    |
| \<Leader\>gm  | Resolve the merge conflicts for that file (m stands for mergetool). Options below       |
| \<Leader\>g\<arrows\> | Select from which file (left or right) you want the code to solve the conflict  |
| \<Leader\>gP  | Git push                                                                                |
| \<Leader\>gPP | Git push (with --no-verify which skip hooks)                                            |
| \<Leader\>gc  | Git commit (modify to use "commitizen"                                                  |
| \<Leader\>gdf | Git diff of the current file wrt the previous commit                                    |
| \<Leader\>gDF | Git diff with all files wrt the previous commit                                         |
| \<Leader\>gdd | Git diff of the current file wrt the develop branch                                     |
| \<Leader\>gdm | Git diff of the current file wrt the master branch                                      |
| \<Leader\>gDD | Git diff all files wrt the develop branch                                               |
| \<Leader\>gDM | Git diff all files wrt the current file wrt the main branch                             |
|               | Use alt + up/down to move and alt + left to quit                                        |
| Ctrl + t      | Function to toggle/untoggle the folds found in the diff code                            |
| \<Leader\>gh  | History of commits that affected that function                                          |
| \<Alt\>Up/down  | Move between different diff hunk in a merge conflict                                  |
| \<Alt\>Left/Right | Take the left or right resutls from a 3-diff split merge conflict                   |
| :Git revert COMMIT-SHA | Rever a specific commit. You can write HEAD~0 to select last commit            |
| \<Leader\>gl  | Log to visualize commits at file level (close it with alt + left)                       |
| \<Leader\>gL  | Log graph. Different options available listed below. You can use them to filter out and locate a commit    |
| a             | Alternate between current branch and all branches in the repo                           |
| dd            | Diff between two selected commits                                                       |
| ri            | Interactive rebase with the branch selected                                             |
| gm            | Display the commits that have been not merged (commits with less than one parent)       |
| cob           | Checkout branch                                                                         |
| coo           | Checkout commit                                                                         |
| u             | Update graph                                                                            |
| g?            | See mapping                                                                             |

Git integration on the online repo (with octo nvim)
| Command/Shortcut  | Description |
| ------------- | --------------------------------------------------------------------------------------- |
| \<Leader\>ca/sa | In general (reviews or pr) writes a comment or suggestion                             |
| \<Leader\>gpp | Git PR pipeline checks                                                                  |
| \<Leader\>gpa | Git PR approve                                                                          |
| \<Leader\>gpr | Reload PR                                                                               |
| \<Leader\>gpl | List the PRs with telescope                                                             |
| \<Leader\>gpc | See commits of PR                                                                       |
| \<Leader\>gpn | New/Create PR                                                                           |
| \<Leader\>gpm | Merge the PR (squash by default)                                                        |
| \<Leader\>gpb | See the PR in the browser                                                               |
| \<Leader\>grs | Start a review                                                                          |
| \<Leader\>grc | Close a review                                                                          |
| \<Leader\>grr | Resume a review                                                                         |
| \<Leader\>gr\<CR\> | Publish a review                                                                   |
| \<Leader\>grd | Discard current review                                                                  |
| \<Leader\>grC | Review comments                                                                         |


Vim-easy-motion
| Command/Shortcut | Description                                                                  |
| ---------------- | ---------------------------------------------------------------------------- |
| \<Leader\>f      | displays how to jump to the start of a word                                  |
| \<Leader\>e      | displays how to jump to the end of a word                                    |
| \<Leader\>w      | displays how to jump to the start of every single word, including all splits |
| \<Leader\>.      | Repeat last vim-easy-motion command                                          |
| \<Leader\>j or k | Jump to specified line                                                       |


About the stubs automatically generated, this is done with "stubgen" (installed with
mypy) and it is done to detect more types mainly coming from modules outside of my
repo. This one is called with the flag -o $STUBSPATH to generate them where MYPY
searces by default. When generating the modules, you have two main options when
setting the flags:

- Flag -m: It will generate the stubs only for this module. Ex: If I have the
  following package: A.B.C and I do "stubgen -m C", the stubs for the module
  C will be generated, but I will also need to generate the ones from A and B
  (the previous ones). By doing this, the stubs I created are much more in
  control. Useful when the package is big.
- Flag -p: It will generate all modules found. Ex: If I have the module C as
  A.B.C, if I do "stubgen -p A I will be creating the stubs for themodules
  A, B and C. However, if the package is big this will take time and maybe
  some conflicts.

For both methods if the module was imported as an absolute path, this one needs to
be installed in the Python environment. This can be done with the pip framework.
If the import was relative, it won't be necessary to generate the stubs, as the
linters such as mypy will detect automatically.

## Quick fixes
-  If spotify is not working, go to its directory and peform "make".
-  If symbols cannot be properly seen, you need to isntall patched fonts.
-  If C++ linters are not working, check the compilation database

## Notes

Inspired by [igemnace][1] repository.

[1]: https://github.com/igemnace/vim-config
