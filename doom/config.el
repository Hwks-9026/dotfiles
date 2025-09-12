;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;

;; Remap movement keys for Colemak layout in Evil normal and visual modes
(map!
 ;; Normal mode remaps
 :n "j" #'evil-search-next
 :n "J" #'evil-search-previous
 :n "l" #'evil-forward-word-end
 :n "n" #'evil-next-line
 :n "k" #'evil-insert
 :n "e" #'evil-previous-line
 :n "i" #'evil-forward-char

 ;; Visual mode remaps
 :v "j" #'evil-search-next
 :v "J" #'evil-search-previous
 :v "l" #'evil-forward-word-end
 :v "n" #'evil-next-line
 :v "k" #'evil-insert
 :v "e" #'evil-previous-line
 :v "i" #'evil-forward-char
)


;; Enable Vertico for vertical minibuffer completion UI
(use-package vertico
  :init (vertico-mode))

;; Enable richer annotations with Marginalia (optional)
(use-package marginalia
  :init (marginalia-mode))

;; Completion UI actions (like Telescope actions)
(use-package embark
  :bind
  (("C-." . embark-act))) ;; Default action menu

;; Fuzzy matching
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)))

;; Search and file finding
(use-package consult
  :bind
  (("C-c f" . consult-find)          ;; Find files like Telescope
   ("C-c g" . consult-grep)          ;; Grep-like search
   ("C-c r" . consult-ripgrep)       ;; If ripgrep is installed
   ("C-c b" . consult-buffer)        ;; Switch buffers
   ("C-c m" . consult-mode-command))) ;; Search current major-mode cmds

;; Optional: Projectile for project navigation
(use-package projectile
  :init (projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :config (setq projectile-project-search-path '("~/projects/")))

;; Optional: Find file in project (uses ripgrep)
(use-package find-file-in-project
  :bind (("C-c F" . find-file-in-project)))


;; Set Victor Mono Nerd Font as the default font
(set-face-attribute 'default nil
                    :family "VictorMono Nerd Font"
                    :height 180) ;; Adjust height as needed (e.g., 120 = 12pt)

;; Optional: Also set it for other important faces
(dolist (face '(fixed-pitch variable-pitch))
  (set-face-attribute face nil :family "VictorMono Nerd Font"))

;; Ensure the font is used in GUI mode only
(when (display-graphic-p)
  (add-to-list 'default-frame-alist '(font . "VictorMono Nerd Font-20")))
