(defun grab-previous-id ()
  (save-excursion
    (search-backward "Id =")
    (forward-word)
    (forward-word)
    (backward-kill-word 1)
    (yank))
  (string-to-number (current-kill 0)))

(defun augment-previous-id ()
  (let ((a (grab-previous-id)))
    (+ 1 a)))

(defun replace-all-ids ()
  "Placing cursor on an end }, replace all Id's below the point with the Id right above the point increased by 1. Example:

...
{
    ...
    Id = 23;
}<point>,
{
    SomethingId = 24;
    ...
    Id = 24
    ...
    MyId = 24
}
"
  (interactive)
  (let ((a (augment-previous-id)))
    (save-excursion
      (replace-regexp "Id = [0-9]+" (format "Id = %d" a)))))
