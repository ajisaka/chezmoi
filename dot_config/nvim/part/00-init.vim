augroup Meowrc
  autocmd!
augroup END
command! -bang -nargs=* MeowtoCmd autocmd<bang> Meowrc <args>


let g:anekos_vim_remote = get(g:, 'remote_running') == 1
let g:anekos_vim_hostname = systemlist('hostname 2> /dev/null || echo unknown')[0]

let g:anekos_vim_gui = g:anekos_vim_remote || has('gui_running') || exists("$SSH_CONNECTION")

let g:anekos_vim_neovim_qt_mac = has('mac') && g:anekos_vim_gui
let g:anekos_vim_neovim_qt_wsl = $_ == '/usr/sbin/nvim-qt' && has('windows')
let g:anekos_vim_neovim_qt_linux = $NVIM_QT_LINUX == 1 || ($_ == '/bin/nvim-qt' && has('linux'))
let g:anekos_vim_neovim_qt = g:anekos_vim_neovim_qt_mac || g:anekos_vim_neovim_qt_wsl || g:anekos_vim_neovim_qt_linux
let g:anekos_vim_gui_qt = g:anekos_vim_neovim_qt
let g:anekos_vim_hyprland = $XDG_CURRENT_DESKTOP == 'Hyprland'
let g:anekos_vim_wayland = g:anekos_vim_hyprland

let g:anekos_vim_interface = 'unknown'
if g:anekos_vim_gui_qt
  let g:anekos_vim_interface = 'qt'
elseif exists('g:neovide')
  let g:anekos_vim_interface = 'neovide'
elseif exists('g:goneovim')
  let g:anekos_vim_interface = 'goneovim'
elseif g:anekos_vim_gui
  let g:anekos_vim_interface = 'gui'
else
  let g:anekos_vim_interface = 'terminal'
endif
