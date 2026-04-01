;;; mod-python.el --- Python development -*- lexical-binding: t; -*-

(require 'project)

;;;; -------------------------------------------------------------------
;;;; Virtual Environment Auto-Activation
;;;; -------------------------------------------------------------------

(defun my/python--project-root ()
  (when-let ((proj (project-current)))
    (project-root proj)))

(defun my/python-activate-venv ()
  "Activate .venv in project root if it exists."
  (when-let* ((root (my/python--project-root))
              (venv (expand-file-name ".venv" root))
              (bin  (expand-file-name "bin" venv)))
    (when (file-directory-p bin)
      (setenv "VIRTUAL_ENV" venv)
      (setq-local python-shell-virtualenv-root venv)

      ;; Prepend venv/bin to exec-path
      (setq-local exec-path (cons bin exec-path))

      ;; Update PATH for subprocesses
      (setenv "PATH"
              (concat bin path-separator (getenv "PATH"))))))

;;;; -------------------------------------------------------------------
;;;; Formatting (Ruff)
;;;; -------------------------------------------------------------------

(defun my/python-format-buffer ()
  "Format current Python buffer using ruff."
  (interactive)
  (when (and (eq major-mode 'python-mode)
             buffer-file-name)
    (call-process "ruff" nil "*ruff-format*" nil
                  "format" buffer-file-name)
    (revert-buffer t t t)))

;;;; -------------------------------------------------------------------
;;;; Python Mode Configuration
;;;; -------------------------------------------------------------------

(use-package python
  :ensure nil
  :mode ("\\.py\\'" . python-mode)
  :hook ((python-mode . my/python-activate-venv)
         ;; IMPORTANT: eglot runs AFTER venv activation
         (python-mode . eglot-ensure)
         (python-mode . (lambda ()
                          (setq-local indent-tabs-mode nil)
                          (setq-local tab-width 4)
                          (setq-local python-indent-offset 4))))
  :bind (:map python-mode-map
              ("C-c C-f" . my/python-format-buffer)))

(provide 'mod-python)
