;;; core-keys.el --- keybindings -*- lexical-binding: t; -*-

(keymap-global-set "C-x k" #'kill-this-buffer)
(keymap-global-set "M-o" #'other-window)

(provide 'core-keys)
