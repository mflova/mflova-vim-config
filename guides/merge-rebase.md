# Merge and rebase

Be aware that in vim you can always use any git command with `:Git`. Meaning that
commands like `Git merge --abort`, `Git rebase --abort` will always be available.

## Merge

For merging two branches, you can open the branch menu `<leader>gb` and choose the
branch you want to merge into.
If there are conflicts, you will see when opening the status (`<leader>gs`) as unstaged
files. Solve them by pressing `dv` over each file. This will open a 3-splits diff.
Use `alt + up/down` to move between hunks and `alt + right/down` to choose from one or
another branch. When finished, you can stage the changes for that file. After finishing
with all of them, you can press `cc` on the git status window to commit the merge. If
everything is ok, a default merge message should appear in the commit message.

## Rebase

Recommended to always do the interactive one, as this one is more guided and easier.
To do so, open the branch menu `<leader>gb` and choose the branch you want to
intearctive rebase. A new window will be opened so that you can choose what to do with
each commit. They are ordered from most recent to least with a plugin. This means that,
if you choose the first one (top) to squash, it will appear in red. This is still ok
because when closing the window, the order will be reversed so that it can be
understood by the API. Same as with the merge conflict, unstaged files will appear in
the git status (`<leader>gs`) window. This one will also show the current progress and
next steps. Pressing `dv` will show the conflict (see `merge` about how to operate
there). When finished with all the files, press `rr` for continuing the rebase. This
will update the git status with the new merge conflicts to be solved if there are still
any. Be aware that VIM applied changes to the files, which means that you might need to
update the files in the buffer with `:e!` in the main window of the diff (you will
notice this because it will appear a warning when trying to save new changes to these
files). After finishing with all the commits, a final window will appear to confirm
everything.

You can also start a rebase with `:Flog` (`<leader>gL`) to see the git log graph of the
branch and pressing `a` (all) to visualize all branches. Then, by pressing `ri`, you
will start an interactive rebase with the commit you selected as base.
