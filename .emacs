(package-initialize)


;; https://stackoverflow.com/a/18330742

(defvar --backup-directory
  (concat "/home/" (getenv "USER") "/.emacs.d/backups"))

(unless (file-exists-p --backup-directory)
  (make-directory --backup-directory t))

(add-to-list 'backup-directory-alist `("." . ,--backup-directory))

(setq make-backup-files         t
      backup-by-copying         t
      version-control           t
      delete-old-versions       t
      delete-by-moving-to-trash t
      kept-old-versions         2
      kept-new-versions         6
      auto-save-default         t
      auto-save-timeout         20
      auto-save-interval        200)


(load-theme 'wombat)


;; https://stackoverflow.com/a/17537564

;; (prefer-coding-system       'utf-8)
;; (set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (setq default-buffer-file-coding-system 'utf-8)
;; (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


;; F* symbols
(set-fontset-font t 'unicode (font-spec :name "Iosevka") nil 'prepend)
(set-fontset-font t 'greek (font-spec :name "Iosevka") nil 'prepend)


(global-hl-todo-mode)
(global-whitespace-cleanup-mode)
