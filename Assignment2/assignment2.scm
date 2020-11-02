;;; 1.
;;; (fromTo k n) returns the list of integers from k to n. The size
;;;              of the problem can be seen as the number of integers
;;;              between k and n, inclusively
;;; Base Case: if k < n (i.e. if the size of problem is 0), then the
;;;            result is the empty list.
;;; Hypothesis: Assume (fromTo (+ k 1) n) returns the list of integers
;;;             from k+1 to n, since the size of that problem is one
;;;             less than the size of the original problemm (fromTo k n)
;;; Recursive step: (fromTo k n) = (cons k (fromTo (+ k 1) n)
(define (fromTo k n)
  (if (> k n) '()
      (cons k (fromTo (+ k 1) n))))

;;; 2.
;;; (removeMults m L) returns a list containing all the elements of L
;;;                   that are not multiples of m. The size of the
;;;                   problem can be seen as the number of integers in L
;;; Base Case: if L is empty (i.e. the size of problem is 0), then the
;;;            result is the empty list
;;; Hypothesis: Assume (removeMults m (cdr L)) returns the non multiples
;;;             of m in (cdr L), since the size of that problem is one
;;;             less than the size of the original problem (removeMults m L)
;;; Recursive step: (removeMults m L) = (cons (car L) (removeMults m (cdr L)))
(define (removeMults m L)
  (cond ((null? L) '())
        (else (if (= (modulo (car L) m) 0)
                  (removeMults m (cdr L))
                  (cons (car L) (removeMults m (cdr L)))))))

;;; 3.
;;; (removeAllMults L) returns a list containing those elements of L that
;;;                    are not multiples of each other, where L is in
;;;                    strictly increasing order
;;; Base Case: if L is empty, then results is empty
;;; Hypothesis: Assume (removeAllMults (cdr L)) returns the elements of
;;;             (cdr L) that are not multiples of each other
;;; Recursive step: (removeAllMults L) = (cons (car L) (removeMults (car L) (removeAllMults (cdr L))))
(define (removeAllMults L)
 (if (null? L) '()
     (cons (car L) (removeMults (car L) (removeAllMults (cdr L))))))

;;; 4.
;;; (primes n) returns the list of all primes less than or equal to n
;;; Base Cases: N/A
;;; Hypothesis: N/A
;;; Recursive step: N/A
(define (primes n) (removeAllMults (fromTo 2 n)))

;;; 5.
;;; (maxDepth L) returns the maximum nesting depth of any element within L
;;; Base Case: if L is a number, then depth is -1
;;; Hypothesis: Assume (maxDepth (car L)) returns max depth of (car L) and
;;;             (maxDepth (cdr L)) returns max depth of (cdr L), their max + 1
;;;             is the max depth of L
;;; Recursive step: (maxDepth L) = 1 + max(maxDepth (car L), maxDepth (cdr L))
(define (maxDepth L)
  (if (not (pair? L)) -1
      (let ((d1 (+ 1 (maxDepth (car L)))) (d2 (maxDepth (cdr L)))) (apply max (list d1 d2)))))

;;; 6.
;;; (prefix exp) transforms an infix arithmetic expression exp into prefix notation
;;; Base Case: if exp is a number, return it. If exp is a length 1 list, return (car exp)
;;; Hypothesis: Assume (prefix (cddr exp)) returns prefix of (cddr exp)
;;; Recursive step: (prefix exp) = (list (cadr exp) (prefix (car exp)) (prefix (cddr exp)))
(define (prefix exp)
  (cond ((not (pair? exp)) exp)
        ((null? (cdr exp)) (car exp))
        (else (list (cadr exp) (prefix (car exp)) (prefix (cddr exp))))))

;;; 7.
;;; (composition fns) takes a list of functions fns and returns a function
;;;                   that is the composition of the functions in fns
;;; Base Case: if fns is empty, just return x
;;; Hypothesis: Assume (apply (cdr fns) x) returns composition of the functions
;;;             in (cdr fns)
;;; Recursive step: (apply fns x) = ((car fns) (apply (cdr fns) x))
(define (composition fns)
  (define (apply fns x)
    (if (null? fns) x ((car fns) (apply (cdr fns) x))))
  (lambda (x) (apply fns x)))

;;; 8.
;;; (bubble-to-nth L N) sorts L such that the largest element among the first
;;;                     N elements of L is now the Nth element of the resulting
;;;                     list, and the elements after the Nth element are left
;;;                     in their original order
;;; Base Case: when only one number remains in L, return L
;;; Hypothesis: Assume (bubble-to-nth (cdr L) (- N 1)) sorts such that the largest
;;;             element among (cdr L) is the (N-1)th element of the resulting list
;;; Recursive step: (bubble-to-nth L N) = (cons min((car L), (cadr L)) (bubble-to-nth (cons max((car L), (cadr L)) (cddr L)) (- N 1)))
(define (bubble-to-nth L N)
  (if (= N 1) L
      (cons (min (car L) (cadr L)) (bubble-to-nth (cons (max (car L) (cadr L)) (cddr L)) (- N 1)))))

;;; 9.
;;; (b-s L N) returns the a list containing the elements of L in their original
;;;           order except that the first N elements are in sorted order
;;; Base Case: if N is 1, return L
;;; Hypothesis: Assume (b-s (bubble-to-nth L N) (- N 1)) returns the list in which
;;;             first (N-1) elements are in sorted order
;;; Recursive step: (b-s L N) = (b-s (bubble-to-nth L N) (- N 1))
(define (b-s L N)
  (if (= N 1) L (b-s (bubble-to-nth L N) (- N 1))))

;;; 10.
;;; (bubble-sort L) return a list of the elements of L in sorted order
;;; Base Case: N/A
;;; Hypothesis: N/A
;;; Recursive step: N/A
(define (bubble-sort L) (b-s L (length L)))

