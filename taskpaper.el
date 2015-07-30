(defvar taskpaper-mode-map nil "Keymap for taskpaper-mode")
(when (not taskpaper-mode-map)
  (setq taskpaper-mode-map (make-sparse-keymap))
  (define-key taskpaper-mode-map (kbd "C-c d") 'taskpaper-toggle-done)
  (define-key taskpaper-mode-map (kbd "C-c r") 'taskpaper-reset-tasks)
  )

(setq tpKeywords
      '(
        (".*@done.*" . font-lock-comment-face)
        (".*:$" . font-lock-function-name-face)
        ("@.*" . font-lock-variable-name-face)
        
        )
      )

(defun taskpaper-functions()


  (defun taskpaper-toggle-done()
    "Toggle done status on task, this sets @done-tag with date."
    (interactive)
    (let ((startpoint (point)) (line (line-number-at-pos)))
      (back-to-indentation)
      (re-search-forward "@done(.*)" nil 2)
      (if (= line (line-number-at-pos))
          (progn
            (end-of-line)
            (re-search-backward "@")
            (backward-char)
            (kill-line)
            )
        (progn
          (goto-char startpoint)
          (end-of-line)
          (insert (concat " @done(" (format-time-string "%Y-%m-%d") ")"))
          )
        )
      (when (not (equal (point) (line-end-position)))
        (goto-char startpoint))
      )
    )

  (defun taskpaper-reset-tasks()
    "Clear all @done tasks"
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "@done(.*)"  nil t)
	(replace-match "" nil nil)
	)
      )
    )

  )

(defun taskpaper-mode ()
  "Major mode for editing taskpaper styled files."
  (interactive)
  (kill-all-local-variables)

  (setq major-mode 'taskpaper-mode)
  (setq mode-name "Taskpaper") ; for display purposes in mode line
  (use-local-map taskpaper-mode-map)
  
  (taskpaper-functions)
  (setq font-lock-defaults '(tpKeywords))
  
  ;; Dont wrap lines
  (toggle-truncate-lines t)
  
  ;; ... other code here

  (run-hooks 'taskpaper-mode-hook))

(provide 'taskpaper-mode)
