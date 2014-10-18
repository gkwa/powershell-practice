(fset 'tm-keep
   "\C-ce\C-x\C-ftodo.ini\C-m[\C-y\C-?\C-?\C-?\C-?]\C-mkeep=\C-y\C-?\C-?\C-?\C-?\C-m\C-x\C-s\C-xk\C-m\C-xb\C-m\C-xk\C-m\C-xb\C-m\C-n\C-m")

(fset 'tm-toss
   "\C-ce\C-x\C-ftodo.ini\C-m\C-[>[\C-y\C-?\C-?\C-?\C-?]\C-mkeep=toos\C-?\C-?ss\C-m\C-x\C-s\C-xk\C-m\C-xb\C-m\C-xk\C-m\C-xb\C-m\C-n\C-m")

(global-set-key [3 116] (quote tm-toss))
(global-set-key [3 107] (quote tm-keep))
