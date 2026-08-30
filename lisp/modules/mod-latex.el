;;; mod-latex.el --- LaTeX and mathematics editing -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; LaTeX environment for:
;;
;;   - GNU Emacs 30.x / emacs-nox
;;   - AUCTeX 14.x
;;   - LuaLaTeX
;;   - TeX Live
;;   - latexmk
;;   - Okular
;;   - SyncTeX forward/inverse search
;;   - RefTeX
;;   - CDLaTeX
;;
;; PDF viewing is external: Okular.
;; LuaLaTeX is the default engine, while individual files/projects may
;; override `TeX-engine' when compatibility requires another engine.
;;
;; Standalone .tex files are treated as their own master by default.
;; Multi-file projects can override `TeX-master' explicitly with a
;; file-local variable.

;;; Code:

;; ---------------------------------------------------------------------------
;; Per-buffer setup
;; ---------------------------------------------------------------------------

(defun my/latex-mode-setup ()
  "Configure a LaTeX buffer for the local terminal/Okular workflow."
  (visual-line-mode 1)

  ;; AUCTeX 14.x provides LaTeXMk natively.  With `TeX-engine' set to
  ;; `luatex', its built-in LaTeXMk command selects latexmk's LuaLaTeX mode.
  (when (executable-find "latexmk")
    (setq-local TeX-command-default "LaTeXMk")))

;; ---------------------------------------------------------------------------
;; AUCTeX
;; ---------------------------------------------------------------------------

(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . LaTeX-mode)

  :init

  ;; Default to LuaLaTeX.
  ;; AUCTeX uses the symbol `luatex' for the LuaLaTeX engine.
  (setq-default TeX-engine 'luatex)

  ;; Treat ordinary .tex files as their own master.
  ;; This prevents AUCTeX from prompting when opening a new standalone file.
  ;;
  ;; Multi-file projects should override this in included files, for example:
  ;;
  ;;   %%% Local Variables:
  ;;   %%% TeX-master: "main"
  ;;   %%% End:
  ;;
  (setq-default TeX-master t)

  :custom

  ;; -------------------------------------------------------------------------
  ;; Document parsing
  ;; -------------------------------------------------------------------------

  ;; Parse and cache document structure, packages, macros, labels, etc.
  (TeX-auto-save t)
  (TeX-parse-self t)

  ;; Save document buffers automatically before compilation.
  (TeX-save-query nil)

  ;; -------------------------------------------------------------------------
  ;; Output
  ;; -------------------------------------------------------------------------

  ;; Produce PDF output directly.
  (TeX-PDF-mode t)

  ;; -------------------------------------------------------------------------
  ;; SyncTeX / Okular
  ;; -------------------------------------------------------------------------

  ;; Generate source/PDF correlation information.
  (TeX-source-correlate-mode t)

  ;; Explicitly use SyncTeX.
  (TeX-source-correlate-method 'synctex)

  ;; Start an Emacs server when needed so Okular can perform inverse search
  ;; back into the existing terminal Emacs session via emacsclient.
  (TeX-source-correlate-start-server t)

  ;; Use AUCTeX's built-in Okular viewer definition for PDF output.
  (TeX-view-program-selection
   '((output-pdf "Okular")))

  ;; -------------------------------------------------------------------------
  ;; Compilation diagnostics
  ;; -------------------------------------------------------------------------

  ;; Parse the complete TeX log.
  (TeX-parse-all-errors t)

  ;; Show AUCTeX's navigable diagnostic overview after failed/problematic runs.
  (TeX-error-overview-open-after-TeX-run t)

  ;; In emacs-nox, keep the error overview in the current terminal frame.
  (TeX-error-overview-setup nil)

  :hook
  (LaTeX-mode . my/latex-mode-setup))

;; ---------------------------------------------------------------------------
;; RefTeX
;; ---------------------------------------------------------------------------

(use-package reftex
  :ensure nil
  :after tex

  :custom
  (reftex-plug-into-AUCTeX t)

  :hook
  (LaTeX-mode . reftex-mode))

;; ---------------------------------------------------------------------------
;; CDLaTeX
;; ---------------------------------------------------------------------------

(use-package cdlatex
  :after tex

  :hook
  ((LaTeX-mode . turn-on-cdlatex)
   (org-mode   . turn-on-org-cdlatex)))

(provide 'mod-latex)

;;; mod-latex.el ends here