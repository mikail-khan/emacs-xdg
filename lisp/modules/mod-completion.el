;;; mod-completion.el --- completion stack -*- lexical-binding: t; -*-

;; -----------------------------
;; Save minibuffer history
;; -----------------------------
(use-package savehist
  :init
  (savehist-mode))

;; -----------------------------
;; Vertico (minibuffer UI)
;; -----------------------------
(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-cycle t))

;; -----------------------------
;; Orderless (flexible matching)
;; -----------------------------
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides
        '((file (styles basic partial-completion))
          (eglot (styles orderless basic)))))

;; -----------------------------
;; Marginalia (minibuffer annotations)
;; -----------------------------
(use-package marginalia
  :init
  (marginalia-mode))

;; -----------------------------
;; Consult (search/navigation)
;; -----------------------------
(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)))

;; -----------------------------
;; Corfu (in-buffer completion UI)
;; -----------------------------

(defun my/corfu-ensure-in-region ()
  "Ensure Corfu handles completion in the current buffer."
  (when (bound-and-true-p corfu-mode)
    (setq-local completion-in-region-function #'corfu--in-region)))

(use-package corfu
  :init
  (global-corfu-mode)
  :hook
  ((corfu-mode . my/corfu-ensure-in-region)
   (eglot-managed-mode . my/corfu-ensure-in-region))
  :config
  (setq corfu-auto t
        corfu-auto-delay 0.0
        ;; allow popup after symbols like `os.`
        corfu-auto-prefix 0
        corfu-cycle t
        corfu-preselect 'prompt
        corfu-quit-no-match 'separator))

;; -----------------------------
;; Completion UX behavior
;; -----------------------------
(setq tab-always-indent 'complete
      completion-cycle-threshold 3)

(provide 'mod-completion)