;;; mod-python.el --- Python development -*- lexical-binding: t; -*-

(require 'project)

(defun my/python--project-root ()
  "Return the current project root, or nil."
  (when-let ((proj (project-current)))
    (project-root proj)))

(defun my/python-activate-venv ()
  "Use PROJECT/.venv for subprocesses in the current buffer when present."
  (when-let* ((root (my/python--project-root))
              (venv (expand-file-name ".venv" root))
              (bin (expand-file-name "bin" venv))
              ((file-directory-p bin)))
    ;; Keep PATH/VIRTUAL_ENV changes local to this buffer.  Processes
    ;; launched from the buffer, including Eglot, inherit this environment.
    (setq-local process-environment
                (copy-sequence process-environment))
    (setq-local exec-path
                (cons bin exec-path))
    (setq-local python-shell-virtualenv-root venv)

    (setenv "VIRTUAL_ENV" venv)
    (setenv "PATH"
            (concat bin path-separator (getenv "PATH")))))

(defun my/python-settings ()
  "Apply local Python editing defaults."
  (setq-local indent-tabs-mode nil
              tab-width 4
              python-indent-offset 4))

(defun my/python-format-buffer ()
  "Format the current Python file using Ruff."
  (interactive)
  (unless (derived-mode-p 'python-mode 'python-ts-mode)
    (user-error "Not a Python buffer"))
  (unless buffer-file-name
    (user-error "Buffer is not visiting a file"))
  (unless (executable-find "ruff")
    (user-error "ruff executable not found"))

  ;; Ruff formats the file on disk.  Saving first prevents `revert-buffer'
  ;; from discarding unsaved edits.
  (save-buffer)

  (let ((status
         (call-process "ruff" nil "*ruff-format*" nil
                       "format" buffer-file-name)))
    (if (zerop status)
        (revert-buffer :ignore-auto :noconfirm)
      (display-buffer "*ruff-format*")
      (user-error "ruff format failed with exit status %s" status))))

(use-package python
  :ensure nil
  :mode ("\\.py\\'" . python-mode)
  :hook
  ((python-mode . my/python-activate-venv)
   (python-mode . my/python-settings)
   ;; Run after venv activation so the server inherits the local
   ;; subprocess environment.
   (python-mode . eglot-ensure))
  :bind
  (:map python-mode-map
        ("C-c C-f" . my/python-format-buffer)))

(provide 'mod-python)
