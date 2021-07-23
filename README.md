# setup
## Neo-Vim
Use [vim-plug][] as the plugin manager

When creating a symlink, ensure your link creation was successful this may require you to use the physical path to the file.



Delete submodules
mv a/submodule a/submodule_tmp
git submodule deinit -f -- a/submodule    
rm -rf .git/modules/a/submodule
git rm -f a/submodule



