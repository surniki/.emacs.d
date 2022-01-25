
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-font-lock-mode 0)
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(blink-cursor-mode -1)

(let ((filename "~/.emacs.d/custom.el"))
  (unless (file-exists-p filename)
    (with-temp-buffer
      (write-file filename)))
  (setq custom-file filename)
  (load custom-file))

(let ((directory "~/.emacs.d/backups"))
  (unless (file-directory-p directory)
    (make-directory directory))
  (setq backup-directory-alist `(("." . ,directory))))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(evil-mode 1)

(setq inferior-lisp "/usr/bin/sbcl")
(push 'slime-media slime-contribs)
(setq slime-enable-evaluate-in-emacs t)

(setq c-basic-style "k&r"
      c-basic-offset 8
      c-backslash-max-column 120)

(c-set-offset 'case-label '+)
(c-set-offset 'brace-list-intro '+)
(c-set-offset 'func-decl-cont '-)

(setq-default fill-column 80)
(put 'upcase-region 'disabled nil)

(pdf-tools-install)
(add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode)

(let ((directory "~/.trash"))
  (unless (file-directory-p directory)
    (make-directory directory))
  (setq trash-directory directory)
  (setq delete-by-moving-to-trash t))

;;(powerline-center-theme)

;; logic for colors when in tty
(defvar face-list '(Info-quoted
		    bold                                
		    bold-italic                         
		    border                              
		    browse-url-button                   
		    buffer-menu-buffer                  
		    button                              
		    calc-nonselected-face               
		    calc-selected-face                  
		    comint-highlight-input              
		    comint-highlight-prompt             
		    completions-annotations             
		    completions-common-part             
		    completions-first-difference        
		    default                             
		    eldoc-highlight-function-argument   
		    error                               
		    escape-glyph                        
		    evil-ex-commands                    
		    evil-ex-info                        
		    evil-ex-lazy-highlight              
		    evil-ex-search                      
		    evil-ex-substitute-matches          
		    evil-ex-substitute-replacement      
		    file-name-shadow                    
		    fill-column-indicator               
		    fixed-pitch                         
		    fixed-pitch-serif                   
		    flyspell-duplicate                  
		    flyspell-incorrect                  
		    font-lock-builtin-face              
		    font-lock-comment-delimiter-face    
		    font-lock-comment-face              
		    font-lock-constant-face             
		    font-lock-doc-face                  
		    font-lock-function-name-face        
		    font-lock-keyword-face              
		    font-lock-negation-char-face        
		    font-lock-preprocessor-face         
		    font-lock-regexp-grouping-backslash 
		    font-lock-regexp-grouping-construct 
		    font-lock-string-face               
		    font-lock-type-face                 
		    font-lock-variable-name-face        
		    font-lock-warning-face              
		    fringe                              
		    glyphless-char                      
		    header-line                         
		    header-line-highlight               
		    help-argument-name                  
		    highlight                           
		    homoglyph                           
		    info-header-node                    
		    info-header-xref                    
		    info-index-match                    
		    info-menu-header                    
		    info-menu-star                      
		    info-node                           
		    info-title-1                        
		    info-title-2                        
		    info-title-3                        
		    info-title-4                        
		    info-xref                           
		    info-xref-visited                   
		    internal-border                     
		    isearch                             
		    isearch-fail                        
		    italic                              
		    line-number                         
		    line-number-current-line            
		    line-number-major-tick              
		    line-number-minor-tick              
		    link                                
		    link-visited                        
		    match                               
		    menu                                
		    minibuffer-prompt                   
		    mode-line                           
		    mode-line-buffer-id                 
		    mode-line-emphasis                  
		    mode-line-highlight                 
		    mode-line-inactive                  
		    mouse                               
		    mouse-drag-and-drop-region          
		    next-error                          
		    nobreak-hyphen                      
		    nobreak-space                       
		    package-description                 
		    package-help-section-name           
		    package-name                        
		    package-status-avail-obso           
		    package-status-available            
		    package-status-built-in             
		    package-status-dependency           
		    package-status-disabled             
		    package-status-external             
		    package-status-held                 
		    package-status-incompat             
		    package-status-installed            
		    package-status-new                  
		    package-status-unsigned             
		    query-replace                       
		    read-multiple-choice-face           
		    rectangle-preview                   
		    region                              
		    scroll-bar                          
		    secondary-selection                 
		    shadow                              
		    show-paren-match                    
		    show-paren-match-expression         
		    show-paren-mismatch
		    success                             
		    tab-bar                             
		    tab-bar-tab                         
		    tab-bar-tab-inactive                
		    tab-line                            
		    tabulated-list-fake-header          
		    tool-bar                            
		    tooltip                             
		    trailing-whitespace                 
		    tty-menu-disabled-face              
		    tty-menu-enabled-face               
		    tty-menu-selected-face              
		    underline                           
		    variable-pitch                      
		    vc-conflict-state                   
		    vc-edited-state                     
		    vc-locally-added-state              
		    vc-locked-state                     
		    vc-missing-state                    
		    vc-needs-update-state               
		    vc-removed-state                    
		    vc-state-base                       
		    vc-up-to-date-state                 
		    vertical-border                     
		    warning                             
		    window-divider                      
		    window-divider-first-pixel          
		    window-divider-last-pixel))

(if (display-graphic-p)
    (progn
      (defun set-plain (face)
	(set-face-attribute face nil :family "Terminus" :height 90)
	(set-face-attribute face nil :foreground "#f9f1a5" :background "#000000"))
      (defun set-highlight (face)
	(set-face-attribute face nil :family "Terminus" :height 90)
	(set-face-attribute face nil :foreground "#000000" :background "#f9f1a5")
	(delete face face-list)))
  (progn
    (defun set-plain (face)
      (set-face-attribute face nil :foreground "#f9f1a5" :background "#000000"))
    (defun set-highlight (face)
      (set-face-attribute face nil :foreground "#000000" :background "#f9f1a5")
      (delete face face-list))))

(set-highlight 'mode-line-buffer-id)
(set-highlight 'buffer-menu-buffer)
(set-highlight 'button)
(set-highlight 'evil-ex-lazy-highlight)
(set-highlight 'evil-ex-search)
(set-highlight 'evil-ex-substitute-matches)
(set-highlight 'header-line-highlight)
(set-highlight 'highlight)
(set-highlight 'info-index-match)
(set-highlight 'isearch)
(set-highlight 'isearch-fail)
(set-highlight 'line-number-major-tick)
(set-highlight 'line-number-minor-tick)
(set-highlight 'match)
(set-highlight 'menu)
(set-highlight 'mode-line)
(set-highlight 'mode-line-highlight)
(set-highlight 'mode-line-inactive)
(set-highlight 'mouse-drag-and-drop-region)
(set-highlight 'next-error)
(set-highlight 'nobreak-space)
(set-highlight 'query-replace)
(set-highlight 'rectangle-preview)
(set-highlight 'region)
(set-highlight 'secondary-selection)
(set-highlight 'show-paren-match)
(set-highlight 'show-paren-match-expression)
(set-highlight 'show-paren-mismatch)
(set-highlight 'tab-bar)
(set-highlight 'tab-bar-tab-inactive)
(set-highlight 'tab-line)
(set-highlight 'tooltip)
(set-highlight 'trailing-whitespace)
(set-highlight 'tty-menu-disabled-face)
(set-highlight 'tty-menu-enabled-face)
(set-highlight 'tty-menu-selected-face)
(set-highlight 'vertical-border)
(set-highlight 'window-divider)
(set-highlight 'window-divider-first-pixel)
(set-highlight 'window-divider-last-pixel)

(mapcar #'set-plain face-list)
(set-face-attribute 'cursor nil :foreground "#ba3232" :background "#ba3232")

;; TODO: Make it so that "compile" searched backwards for a Makefile
(global-set-key [f5] '(lambda () (interactive) (compile "make -k clean")))
(global-set-key [f6] '(lambda () (interactive) (compile "make -k test")))
(global-set-key [f7] '(lambda () (interactive) (compile "make -k cpp")))
(global-set-key [f8] '(lambda () (interactive) (compile "make -k")))

(sage-shell:define-alias)

(setq processing-location "/home/saurn/build/processing/processing-4.0b2/processing-java")
;;(global-set-key [f5] 'processing-sketch-run)
