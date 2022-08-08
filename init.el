;; 文件默认保存为 utf-8
(set-buffer-file-coding-system 'utf-8)
(set-default buffer-file-coding-system 'utf8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)

;; 关闭工具栏
(tool-bar-mode -1)
;; 关闭菜单栏
(menu-bar-mode -1)
;; 关闭滚动条
(scroll-bar-mode -1)
;; 关闭欢迎页面
(setq-default inhibit-startup-screen t)
;; 高亮匹配的括号
(show-paren-mode t)
;; 行号右对齐
(setq display-line-numbers-width-start t)
;; 光标所在行高亮
(global-hl-line-mode 1)
;; 显示行号
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
;; 显示当前行
(global-hl-line-mode t)
;; 设置光标类型
(setq-default cursor-type 'bar)


;; 文字以像素单位滚动
(pixel-scroll-mode t)
;; 大于100后，光标不会自动居中（超出上下屏不会自动居中）
(setq scroll-conservatively 222)
;; 滚动时维持光标位置
(setq scroll-preserve-screen-position t)

;; 禁止鼠标滚轮滚动
(mouse-wheel-mode -1)
;; 隐藏滚轮时间
(global-set-key [wheel-up] 'ignore)
(global-set-key [wheel-down] 'ignore)
(global-set-key [double-wheel-up] 'ignore)
(global-set-key [double-wheel-down] 'ignore)
(global-set-key [triple-wheel-up] 'ignore)
(global-set-key [triple-wheel-down] 'ignore)


(setq org-default-notes-file "~/.emacs.d/notes.org")
(setq org-agenda-files "~/.emacs.d/agenda")

;; agenda 快捷键
(global-set-key (kbd "C-c a") 'org-agenda)
;; capture 快捷键
(global-set-key (kbd "C-c c") 'org-capture)


(setq-default  org-export-with-sub-superscripts nil)


;; hidden minibuffer message: indentation setup for shell type sh
(advice-add 'sh-set-shell :around
            (lambda (orig-fun &rest args)
              (let ((inhibit-message t))
                (apply orig-fun args))))


;; enalbe <s TAB completion emacs v27.2
(if (version= emacs-version "27.2")
	(require 'org-tempo))


;; 开启最近打开文件的记录功能
(recentf-mode t)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; 设置打开配置文件快捷键
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)



;; 禁止生产备份文件
(setq make-backup-files nil)

;; 禁止自动保存文件生产
(setq auto-save-default nil)




;; 添加源（用于包的安装）
;;(require 'package)
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line



;; 定义变量
;; 指定使用的包
(defvar package-list '(
		       company ;; global补全
		       modus-themes
		       counsel ;; minibuffer 补全提示
		       htmlize ;; org 导出 html
		       cnfonts;; 等宽字体对齐
		       smartparens ;; 补全括号、引号之类的
		       hungry-delete ;;智能删除
		       popwin ;; 新打开的辅助窗口时光标自适应
		       yasnippet;; abbreviation 
		       ))

;; 设置变量方便管理包（如：使用命令可以自动删除包）
(setq package-selected-packages package-list)
;; fetch the list of packages available
;; 获取可用包信息
(unless package-archive-contents
  (package-refresh-contents))
;; install the missing packages
;; 安装缺少的包
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))




;; 补全延迟时间
(setq-default company-idle-delay 0.5)
;; 开始补全的最小字符
(setq-default company-minimum-prefix-length 2)
;; ;; 全局补全
(add-hook 'after-init-hook 'global-company-mode)




(require 'modus-themes)

;; Add all your customizations prior to loading the themes
(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs nil
      modus-themes-region '(bg-only no-extend))

;; Load the theme files before enabling a theme
(modus-themes-load-themes)

;; Load the theme of your choice:
;;(modus-themes-load-operandi) ;; OR (modus-themes-load-vivendi)
(modus-themes-load-vivendi)


;;(define-key global-map (kbd "<f5>") #'modus-themes-toggle)



;;counsel
;; 使minibuffer 可读性变得很强，搜索也很爽
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; C-n/C-p 可以选择 minibuffer 中的选项
;; C-x b 可以切换 buffer
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)



;; 打开窗口，光标自动匹配
(require 'popwin)
(popwin-mode 1)
;; setting align command
;; M+x cnfonts-edit-profile


;; 补全引号、括号之类的
(require 'smartparens-config)
(smartparens-global-mode t)


;; yasnippet
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 158 :width normal)))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-display-line-numbers-mode t)
 '(tool-bar-mode nil))


;; 字体
(require 'cnfonts)
;; 让 cnfonts 在 Emacs 启动时自动生效。
(cnfonts-mode 1)
