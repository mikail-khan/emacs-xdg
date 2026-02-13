;;; early-init.el --- early startup settings -*- lexical-binding: t; -*-

(setq package-enable-at-startup nil)

;; Disable UI elements safely
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; XDG cache location for native compilation
(let ((cache-dir (or (getenv "XDG_CACHE_HOME")
(expand-file-name "~/.cache"))))
(when (fboundp 'startup-redirect-eln-cache)
(startup-redirect-eln-cache
(expand-file-name "emacs/eln-cache/" cache-dir))))

;; Startup performance
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)
