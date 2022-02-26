# setup
## Neo-Vim
Use [vim-plug][] as the plugin manager

When creating a symlink, ensure your link creation was successful this may require you to use the physical path to the file.

Adding submodules
git submodule add https://github.com/anishathalye/dotbot dotbot
git submodule update --init --recursive

Delete submodules
mv a/submodule a/submodule_tmp
git submodule deinit -f -- a/submodule    
rm -rf .git/modules/a/submodule
git rm -f a/submodule

Install dotfiles
cp dotbot/tools/git-submodule/install .
or
cp dotbot/tools/git-submodule/install.ps1 .
