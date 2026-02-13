;;; mod-completion.el --- completion stack -*- lexical-binding: t; -*-

(use-package vertico
:init (vertico-mode))

(use-package orderless
:init
(setq completion-styles '(orderless basic)
completion-category-defaults nil))

(use-package marginalia
:init (marginalia-mode))

(use-package consult
:bind (("C-s" . consult-line)
("C-x b" . consult-buffer)))

(use-package corfu
:hook (prog-mode . corfu-mode)
:init
(setq corfu-auto t))

(provide 'mod-completion)
