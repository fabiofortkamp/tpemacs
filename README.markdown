#tpemacs

Simple Taskpaper major mode for emacs.

Put taskpaper.el file somewhere (for instance in ~/emacs.d/taskpaper.el)
In .emacs, add: 
   (load-file "~/taskpaper.el/taskpaper.el")
   (require 'taskpaper-mode)

M-x taskpaper-mode to activate, or in .emacs:
   (add-to-list 'auto-mode-alist '("\\.taskpaper\\'" . taskpaper-mode))        
for files with .taskpaper extension

   Keyboard shortcuts:
   
   C-c d        Toggle done state
   C-c r	Reset all tasks (clear all "@done" tags)