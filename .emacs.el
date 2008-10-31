;;migemo 英語が検索できなくなったぞ？
;; (setq migemo-command "migemo"
;;       migemo-options '("-t" "emacs"  "-i" "¥a"))
;; (setenv "RUBYLIB" "/Applications/Emacs.app/Contents/Resources/lib/ruby/site_ruby/")
;; (require 'migemo)

;;elisp load-path
(setq load-path
      (append
       (list
       (expand-file-name "~/Dropbox/site-lisp/")
       )
       load-path))
;;migemo
(load "migemo.el")
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)

;;;;;;;;;;;;;;;;;;;;
;;テスト中の機能
;;;;;;;;;;;;;;;;;;;;

;;ファイルを開く時に，カーソルキーだけで，ファイルを選択
;;カーソル上下で従来のヒストリ。ctrl+P,ctrl+nでファイル名補完
(require 'cycle-mini)
(define-key minibuffer-local-map [up] 'previous-history-element)
(define-key minibuffer-local-completion-map [up] 'previous-history-element)
(define-key minibuffer-local-must-match-map [up] 'previous-history-element)
(define-key minibuffer-local-ns-map [up] 'previous-history-element)
(define-key minibuffer-local-ns-map [down] 'next-history-element)
(define-key minibuffer-local-map [down] 'next-history-element)
(define-key minibuffer-local-completion-map [down] 'next-history-element)
(define-key minibuffer-local-must-match-map [down] 'next-history-element)

;; ;;最大化
;; (when (eq window-system 'mac)
;;   (add-hook 'window-setup-hook
;;             (lambda ()
;; ;;              (setq mac-autohide-menubar-on-maximize t)
;;               (set-frame-parameter nil 'fullscreen 'fullboth)
;;               )))


;; (defun mac-toggle-max-window ()
;;   (interactive)
;;   (if (frame-parameter nil 'fullscreen)
;;       (set-frame-parameter nil 'fullscreen nil)
;;     (set-frame-parameter nil 'fullscreen 'fullboth)))

;; Carbon Emacsの設定で入れられた. メニューを隠したり．
(custom-set-variables
 '(display-time-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))
(custom-set-faces
 )

;; anything
(require 'anything)
(require 'anything-config)
(setq anything-idle-delay 0.3)
(setq anything-input-idle-delay 0.2) 
(setq anything-sources (list anything-c-source-buffers
                             anything-c-source-bookmarks
                             anything-c-source-recentf
                             anything-c-source-file-name-history
                             anything-c-source-locate))
(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(global-set-key (kbd "C-;") 'anything)

;;;;;;;;;;;;;;;;;;;;
;;minibuffer i-search
;;;;;;;;;;;;;;;;;;;;
(require 'minibuf-isearch)

;;;;;;;;;;;;;;;;;;;;
;;セッション自動保存
;;;;;;;;;;;;;;;;;;;;
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
;;保存する数
(when (require 'session nil t)
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  ;; これがないと file-name-history に500個保存する前に max-string に達する
  (setq session-globals-max-string 100000000)
  ;; デフォルトでは30!
  (setq history-length t)
  (add-hook 'after-init-hook 'session-initialize)
  ;; 前回閉じたときの位置にカーソルを復帰
  (setq session-undo-check -1))

;;kill-ringが便利に
(autoload 'kill-summary "kill-summary" nil t)
(define-key global-map "\ey" 'kill-summary)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ミニバッファインクリメンタル補完 ヒストリ優先
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mcomplete)
(require 'cl)
(load "mcomplete-history")
(turn-on-mcomplete-mode)
;; history から重複を消す
(require 'cl)
(defun minibuffer-delete-duplicate ()
  (let (list)
    (dolist (elt (symbol-value minibuffer-history-variable))
      (unless (member elt list)
        (push elt list)))
    (set minibuffer-history-variable (nreverse list))))
(add-hook 'minibuffer-setup-hook 'minibuffer-delete-duplicate)

;;;;;;;;;;;;;;;;;;;;
;; mode毎の設定
;;;;;;;;;;;;;;;;;;;;

;;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.\\(yml\\|yaml\\)\\'" . yaml-mode))

;;CSS-mode
(autoload 'css-mode "css-mode")
(setq auto-mode-alist       
     (cons '("\\.css\\'" . css-mode) auto-mode-alist))

;;Javascript-mode
(add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|as\\|json\\|jsn\\)\\'" 'js2-mode))
(autoload 'js2-mode "js2" nil t)
(setq js-indent-level 2)

;; cperl mode
(autoload 'cperl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(setq auto-mode-alist
      (append '(("\\.\\([pP][Plm]\\|al\\|cgi\\|t\\)$" . cperl-mode))  auto-mode-alist ))
(setq interpreter-mode-alist (append interpreter-mode-alist
                                     '(("miniperl" . cperl-mode))))
(add-hook 'cperl-mode-hook
          (lambda ()
            ))

;;simple hatena mode
(require 'simple-hatena-mode)
(setq simple-hatena-default-id "goryugo")

;;;;;;;;;;;;;;;;;;;;
;;その他設定
;;;;;;;;;;;;;;;;;;;;

;;font
(if (eq window-system 'mac)
   (progn
    (require 'carbon-font)
     (fixed-width-set-fontset "hiramaru" 12)))
;; メニューバーの消去
(tool-bar-mode -1)
;; 初期フレームの設定
(setq default-frame-alist
      (append (list '(width . 234)
		    '(height . 63)
		    '(top . 0)
		    '(left . 0))
	      default-frame-alist))
;;C-hをバックスペースに
(global-set-key "\C-h" 'delete-backward-char)
;; 括弧の対応をハイライト.
(show-paren-mode 1)
;; BS で選択範囲を消す
(delete-selection-mode 1)
;;ビープ音を消す
(setq ring-bell-function 'ignore)
;;カラーテーマ
(require 'color-theme)
(color-theme-initialize);;(color-theme-deep-blue)
(color-theme-arjen)
;;半透明化
(setq default-frame-alist
      (append (list
               '(alpha . (90 85))
               ) default-frame-alist))
;;リージョン色づけ
(setq transient-mark-mode t)
;;カーソルでのリージョン選択
(pc-selection-mode)
;;一行カット
(setq kill-whole-line t)
;;モードラインにカーソルがある位置の文字数を表示
(column-number-mode 1)

;;;;;;;;;;;;;;;;;;;;
;;howm
;;;;;;;;;;;;;;;;;;;;
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))
;; howm directory
(setq howm-directory "~/Dropbox/howm/")

;; リンクを TAB で辿る
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-recent-title t)
;; 全メモ一覧時にタイトル表示
(setq howm-list-all-title t)
;; メニューを 2 時間キャッシュ
(setq howm-menu-expiry-hours 2)

;; howm の時は auto-fill で
;;(add-hook 'howm-mode-on-hook 'auto-fill-mode)

;; RET でファイルを開く際, 一覧バッファを消す
;; C-u RET なら残る
(setq howm-view-summary-persistent nil)

;; メニューの予定表の表示範囲
;; 10 日前から
(setq howm-menu-schedule-days-before 10)
;; 3 日後まで
(setq howm-menu-schedule-days 3)

;; howm のファイル名
;; 1 メモ 1 ファイル (デフォルト)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
;; 検索しないファイルの正規表現
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")

;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))

;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c で保存してバッファをキルする
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
         (buffer-file-name)
         (string-match "\\.howm"
                       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(eval-after-load "howm"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;バッファの切り替え
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar my-ignore-blst             ; 移動の際に無視するバッファのリスト
  '("*Help*" "*Compile-Log*" "*Mew completions*" "*Completions*"
    "*Shell Command Output*" "*Apropos*" "*Buffer List*" "*GNU Emacs*"
    ".howm-keys" "*Messages*" "*SimpleHatena*" ".howm-history"))
(defvar my-visible-blst nil)       ; 移動開始時の buffer list を保存
(defvar my-bslen 15)               ; buffer list 中の buffer name の最大長
(defvar my-blist-display-time 10)   ; buffer list の表示時間
(defface my-cbface                 ; buffer list 中で current buffer を示す face
  '((t (:foreground "wheat" :underline t))) nil)

(defun my-visible-buffers (blst)
  (if (eq blst nil) '()
    (let ((bufn (buffer-name (car blst))))
      (if (or (= (aref bufn 0) ? ) (member bufn my-ignore-blst))
          ;; ミニバッファと無視するバッファには移動しない
          (my-visible-buffers (cdr blst))
        (cons (car blst) (my-visible-buffers (cdr blst)))))))

(defun my-show-buffer-list (prompt spliter)
  (let* ((len (string-width prompt))
         (str (mapconcat
               (lambda (buf)
                 (let ((bs (copy-sequence (buffer-name buf))))
                   (when (> (string-width bs) my-bslen) ;; 切り詰め 
                     (setq bs (concat (substring bs 0 (- my-bslen 2)) "..")))
                   (setq len (+ len (string-width (concat bs spliter))))
                   (when (eq buf (current-buffer)) ;; 現在のバッファは強調表示
                     (put-text-property 0 (length bs) 'face 'my-cbface bs))
                   (cond ((>= len (frame-width)) ;; frame 幅で適宜改行
                          (setq len (+ (string-width (concat prompt bs spliter))))
                          (concat "\n" (make-string (string-width prompt) ? ) bs))
                         (t bs))))
               my-visible-blst spliter)))
    (let (message-log-max)
      (message "%s" (concat prompt str))
      (when (sit-for my-blist-display-time) (message nil)))))

(defun my-operate-buffer (pos)
  (unless (window-minibuffer-p (selected-window));; ミニバッファ以外で
    (unless (eq last-command 'my-operate-buffer)
      ;; 直前にバッファを切り替えてなければバッファリストを更新
      (setq my-visible-blst (my-visible-buffers (buffer-list))))
    (let* ((blst (if pos my-visible-blst (reverse my-visible-blst))))
      (switch-to-buffer (or (cadr (memq (current-buffer) blst)) (car blst))))
    (my-show-buffer-list (if pos "[-->] " "[<--] ") (if pos " > "  " < " )))
  (setq this-command 'my-operate-buffer))

(global-set-key [?\C-,] (lambda () (interactive) (my-operate-buffer nil)))
(global-set-key [?\C-.] (lambda () (interactive) (my-operate-buffer t)))

;;;;;;;;;;;;;;;;;;;;
;;Chamgelog Memo
;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "Ryusuke Goto")
(setq user-mail-address "goryugo33@gmail.com")
     (autoload 'clmemo "clmemo" "ChangeLog memo mode." t)
     ;; あなたの ChangeLog メモファイルへのパス
     (setq clmemo-file-name "~/Dropbox/clmemo.txt")
     ;; 好きなキーへバインド
     (global-set-key "\C-xM" 'clmemo)
;;changelogタイトル補完
(setq clmemo-title-list '("makata" "mankee" "log" "idea" "perl" "unix" "shell" "emacs"))
(setq clmemo-time-string-with-weekday 't)
;;clgrep
(autoload 'clgrep "clgrep" "ChangeLog grep." t)
(autoload 'clgrep-item "clgrep" "ChangeLog grep." t)
(autoload 'clgrep-item-header "clgrep" "ChangeLog grep for item header" t)
(autoload 'clgrep-item-tag "clgrep" "ChangeLog grep for tag" t)
(autoload 'clgrep-item-notag "clgrep" "ChangeLog grep for item except for tag" t)
(autoload 'clgrep-item-nourl "clgrep" "ChangeLog grep item except for url" t)
(autoload 'clgrep-entry "clgrep" "ChangeLog grep for entry" t)
(autoload 'clgrep-entry-header "clgrep" "ChangeLog grep for entry header" t)
(autoload 'clgrep-entry-no-entry-header "clgrep" "ChangeLog grep for entry except entry header" t)
(autoload 'clgrep-entry-tag "clgrep" "ChangeLog grep for tag" t)
(autoload 'clgrep-entry-notag "clgrep" "ChangeLog grep for tag" t)
(autoload 'clgrep-entry-nourl "clgrep" "ChangeLog grep entry except for url" t)
(add-hook 'clmemo-mode-hook
          '(lambda () (define-key clmemo-mode-map "\C-c\C-g" 'clgrep)))
