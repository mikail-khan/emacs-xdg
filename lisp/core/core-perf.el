;;; core-perf.el --- performance settings -*- lexical-binding: t; -*-

(add-hook 'emacs-startup-hook
(lambda ()
(setq gc-cons-threshold (* 16 1024 1024)
gc-cons-percentage 0.1)))

(setq read-process-output-max (* 1024 1024))

(provide 'core-perf)
