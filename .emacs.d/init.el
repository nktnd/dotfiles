;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; OS independent settings
;; Cask
(require 'cask)
(cask-initialize)

(pallet-mode t)
;; User interface
(column-number-mode t) ; Show column number in mode bar
(line-number-mode t) ; Show column number in mode bar
;; (global-linum-mode t) ; Show line number on each line
(show-paren-mode t) ; Highlight corresponding parenthesis
(save-place-mode 1) ; Save cursor position
(setq scroll-conservatively 1) ; Scroll by line
(setq scroll-margin 5) ; Scroll before cursor reaches top/bottom of frame
(setq next-screen-context-lines 5) ; Continuity lines for full screen scroll
(icomplete-mode 1) ; Minibuffer completion
(setq vc-follow-symlinks t) ; Allow to load vcs-controlled symlink files
(setq auto-revert-check-vc-info t) ; Auto revert when vcs updates files

;; Keybindings
(keyboard-translate ?\C-h ?\C-?) ; Set [C-h] to delete key
(global-unset-key "\C-\\") ; Disable "toggle-input-method"

;; Backup settings
(setq backup-by-copying t ; Prevent backup from breaking hard links
      backup-directory-alist '(("." . "~/.saves"))
      version-control t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2)

;; OS specific settings
;; Mac
(if (eq system-type 'darwin)
    (progn
      (setq ns-command-modifier (quote meta)) ; Set [command] to meta key
      (setq ns-alternate-modifier (quote super)) ; Set [option] to super key
      ;; Initial frame size
      (setq initial-frame-alist '((top . 80)
				  (left . 200)
				  (width . 120)
				  (height . 50)))
      ;; Font setting
      (custom-set-faces
       '(default ((t (:family "SF Mono" :foundry "nil" :slant normal :weight normal :height 120 :width normal)))))
      ))
;; Automatic ascii mode for mini buffer
(when (fboundp 'mac-auto-ascii-mode) (mac-auto-ascii-mode 1))
;; Change cursor color when Japanese input method is enabled
  (when (fboundp 'mac-input-source)
    (defun my-mac-selected-keyboard-input-source-chage-function ()
      "Cursor color settings: dim gray for English and brown for Japanse"
      (let ((mac-input-source (mac-input-source)))
        (set-cursor-color
         (if (string-match "\\.ABC$" mac-input-source)
             "dim gray" "brown"))))
    (add-hook 'mac-selected-keyboard-input-source-change-hook
              'my-mac-selected-keyboard-input-source-chage-function))

;; GUI specific settings
(if window-system
    (progn
      (tool-bar-mode 0) ; Hide tool bar
      (set-frame-parameter nil 'alpha 90) ; Transparency
      ))
