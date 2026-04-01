;;; mod-rss.el --- RSS / Atom feeds (Elfeed) -*- lexical-binding: t; -*-

;; Elfeed configuration
;; - XDG compliant
;; - Terminal-friendly
;; - Tag-based dashboards
;; - Full-article fetching support
;; - Deterministic behavior

(use-package elfeed
  :ensure t
  :commands (elfeed)
  :init

  ;; ---------------------------------------------------------------------------
  ;; XDG-Compliant Data Directory
  ;; ---------------------------------------------------------------------------

  (defconst my/elfeed-data-dir
    (expand-file-name
     "elfeed"
     (or (getenv "XDG_DATA_HOME")
         (expand-file-name "~/.local/share/"))))

  (unless (file-directory-p my/elfeed-data-dir)
    (make-directory my/elfeed-data-dir t))

  (setq elfeed-db-directory my/elfeed-data-dir)

  ;; ---------------------------------------------------------------------------
  ;; Feed Definitions
  ;; ---------------------------------------------------------------------------

  (setq elfeed-feeds
        '(
          ;; Tech
          ("https://www.theregister.com/headlines.atom" tech)
          ("https://hnrss.org/frontpage" tech)
          ("https://rss.slashdot.org/Slashdot/slashdotMain" tech)

          ;; Linux
          ("https://www.linuxfoundation.org/blog/rss.xml" linux)
          ("https://lwn.net/headlines/rss" linux)
          ("https://www.phoronix.com/rss.php" linux)
          ("https://archlinux.org/feeds/news/" arch linux)

          ;; Science / Space
          ("https://www.nasa.gov/rss/dyn/breaking_news.rss" space science)
          ("https://phys.org/rss-feed/" science)

          ;; Mathematics
          ("https://www.quantamagazine.org/feed/" math science)
          ("https://www.ams.org/rss-notices.xml" math academic)
          ("https://mathoverflow.net/feeds" math research)
          ("https://export.arxiv.org/rss/math" math research)
          ))

  ;; Default search filter
  (setq elfeed-search-filter "@2-weeks-ago +unread"))

;; ---------------------------------------------------------------------------
;; Search View Configuration
;; ---------------------------------------------------------------------------

(with-eval-after-load 'elfeed-search

  ;; Wider titles for terminal readability
  (setq elfeed-search-title-max-width 110)

  ;; ---------------------------------------------------------------------------
  ;; Saved Dashboards
  ;; ---------------------------------------------------------------------------

  (setq elfeed-search-saved-filters
        '(("All Unread" "@2-weeks-ago +unread")
          ("Math"       "@1-month-ago +math")
          ("Linux"      "@2-weeks-ago +linux")
          ("Science"    "@2-weeks-ago +science")
          ("Tech"       "@2-weeks-ago +tech")))

  ;; ---------------------------------------------------------------------------
  ;; Quick Dashboard Keybindings
  ;; ---------------------------------------------------------------------------

  ;; a → All unread
  (define-key elfeed-search-mode-map (kbd "a")
    (lambda () (interactive)
      (elfeed-search-set-filter "@2-weeks-ago +unread")))

  ;; m → Math
  (define-key elfeed-search-mode-map (kbd "m")
    (lambda () (interactive)
      (elfeed-search-set-filter "@1-month-ago +math")))

  ;; l → Linux
  (define-key elfeed-search-mode-map (kbd "l")
    (lambda () (interactive)
      (elfeed-search-set-filter "@2-weeks-ago +linux")))

  ;; s → Science
  (define-key elfeed-search-mode-map (kbd "s")
    (lambda () (interactive)
      (elfeed-search-set-filter "@2-weeks-ago +science")))

  ;; t → Tech
  (define-key elfeed-search-mode-map (kbd "t")
    (lambda () (interactive)
      (elfeed-search-set-filter "@2-weeks-ago +tech")))

  ;; R → Mark all visible entries as read
  (define-key elfeed-search-mode-map (kbd "R")
    (lambda ()
      (interactive)
      (mark-whole-buffer)
      (elfeed-search-untag-all-unread))))

(provide 'mod-rss)
