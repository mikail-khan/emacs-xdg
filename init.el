;;; init.el --- modern Emacs init -*- lexical-binding: t; -*-

(defconst my/config-dir user-emacs-directory)
(defconst my/lisp-dir (expand-file-name "lisp/" my/config-dir))
(defconst my/core-dir (expand-file-name "core/" my/lisp-dir))
(defconst my/modules-dir (expand-file-name "modules/" my/lisp-dir))

(add-to-list 'load-path my/core-dir)
(add-to-list 'load-path my/modules-dir)

(setq custom-file (expand-file-name "custom.el" my/config-dir))
(when (file-exists-p custom-file)
(load custom-file))

(require 'core-perf)
(require 'core-packages)
(require 'core-ui)
(require 'core-keys)

(require 'mod-completion)
(require 'mod-project)
(require 'mod-vc)
(require 'mod-eglot)
(require 'mod-org)
(require 'mod-ui)

(let ((local-file (expand-file-name "local.el" my/config-dir)))
(when (file-exists-p local-file)
(load local-file)))

(message "Modern XDG Emacs config loaded.")
