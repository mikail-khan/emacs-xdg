;;; mod-eglot.el --- LSP via eglot -*- lexical-binding: t; -*-

(use-package eglot
:ensure nil
:hook ((python-mode . eglot-ensure)
(rust-ts-mode . eglot-ensure)
(js-ts-mode . eglot-ensure)
(typescript-ts-mode . eglot-ensure)))

(use-package flymake
:ensure nil
:hook (prog-mode . flymake-mode))

(provide 'mod-eglot)
