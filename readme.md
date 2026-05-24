# Dotfiles
my dotfiles

1. install [GNU stow](https://www.gnu.org/software/stow/) (version 2.4.1) and [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
2. clone this repository into ~/dotfiles and do
```sh
  cd ~/dotfiles
```
3. run `make all` or `stow --verbose --target=$HOME --restow */`

## todo
- https://superuser.com/a/1664624 for git ssh key config
- use just instead of make
- Use rewrite in rust https://github.com/qboileau/rstow or https://github.com/cafkafk/seidr (both seem not maintained)
- checkout: https://github.com/RaphGL/Tuckr

## Resources
- https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html
- https://github.com/venthur/dotfiles
- https://github.com/madflow/dotfiles
