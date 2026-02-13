;;; core-packages.el --- package setup -*- lexical-binding: t; -*-

(require 'package)

;; XDG data directory for packages
(let ((data-dir (or (getenv "XDG_DATA_HOME")
(expand-file-name "~/.local/share"))))
(setq package-user-dir
(expand-file-name "emacs/elpa" data-dir)))

(setq package-archives
'(("gnu" . "https://elpa.gnu.org/packages/")
("nongnu" . "https://elpa.nongnu.org/nongnu/")
("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
(package-refresh-contents))

(unless (package-installed-p 'use-package)
(package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-always-defer t)

(provide 'core-packages)
