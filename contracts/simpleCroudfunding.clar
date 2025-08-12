;; Simple Crowdfunding Contract
;; Allows contributions and goal checking

(define-data-var owner principal tx-sender)
(define-data-var goal uint u1000) ;; Crowdfunding goal in microSTX
(define-data-var total-raised uint u0)

;; 1. Contribute function
(define-public (contribute (amount uint))
  (begin
    (asserts! (> amount u0) (err u100)) ;; Amount must be positive
    (try! (stx-transfer? amount tx-sender (var-get owner)))
    (var-set total-raised (+ (var-get total-raised) amount))
    (ok true)))

;; 2. Check Goal Reached function
(define-read-only (goal-reached)
  (ok (>= (var-get total-raised) (var-get goal))))

  
