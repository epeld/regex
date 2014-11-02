
(defpackage :regex
  (:use :common-lisp))
(in-package :regex)

;; Idea: compile regex into fragments
;; each fragment has single entry point, max 2 exit points
;; After compilation, connect all fragments in sequence.
;; the two entry points of a sequence are both connected to the next
;; fragment


;; how do we represent individual steps?

;; fragments can be represented e.g by alists
;; keys:   :start, :end :end2
;; need util functions: 
;;  connect-fragments (frag1 frag2)

(defun make-split (s1 s2)
  "Construct a split between steps s1 and s2"
  (pairlis (list :type :out)
	   (list :split  (list s1 s2))))


(defun make-step (char)
  "Generate a standard step that matches a character"
  (pairlis (list :type :character :out)
	   (list :char char nil)))

(defun step-out (s)
  (cdr (assoc :out s)))


(defun make-fragment (start out)
  (pairlis (list :start :out)
	   (list start out)))


(defun patch-fragments! (f1 f2)
  (let ((start (cdr (assoc :start f2)))
	(outs (cdr (assoc :out f1))))
    (dolist (out outs)
      (setf (cdr out) start))))


(defun fragment-start (f)
  (cdr (assoc :start f)))

(defun fragment-out (f)
  (cdr (assoc :out f)))
;;
;; Fragment-List Operations
;;
;; remember: list is processed in reversed order so last fragment appears first


(defun concat-frags (fragments)
  "Concatenate the last two fragments"
  (let ((rest (cddr fragments))
	(f1 (caar fragments))
	(f2 (car fragments)))
    (patch-fragments! f1 f2)
    (cons (make-fragment (fragment-start f1) 
			 (fragment-out f2)) 
	  rest)))

(defun split-frags (fragments)
  "Create a split between the last two fragments"
  (let ((rest (cddr fragments))
	(f1 (caar fragments))
	(f2 (car fragments)))
    (cons (make-fragment (make-split (fragment-start f1) (fragment-start f2))
			 (append (fragment-out f1) (fragment-out f2)))
	  rest)))
      

(defun optional-frag (fragments)
  "Make the last fragment optional"
  (let* ((f (car fragments))
	 (split (make-split (fragment-start f) nil)))
    (cons (make-fragment split 
			 (append (fragment-out f) (list (step-out split))))
	  (cdr fragments))))


(defun compile-character-sequence (seq)
  (let ((steps nil))
    (dolist (char seq)
      (cond
	((or escape (not (specialp char)))
	 (setf steps (cons (generate-regex-step char) steps)))

	((eq #\\ char)
	 (setf escape T))

	((eq #\* char)
	 (setf steps (add-trivial-branch steps)))
	  
	)
	    
      (setf steps ))
  (if (null string)
      :end
      (let ((fst (car seq))
	    (rst (cdr seq)))
	(cond
	  ((eql #\+ fst) 

(car "test")

*package*
