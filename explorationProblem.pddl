(define (problem e1)
    (:domain exploration)
    
    (:objects
        B G - robot
        l13 l23 l33
        l12 l22 l32
        l11 l21 l31 - location
    )

    (:init
        ;; Robot starting positions
        (at B l11)
        (at G l11)

        ;; Adjacency (4-connected grid)
        (adjacent l11 l12) (adjacent l12 l11)
        (adjacent l12 l13) (adjacent l13 l12)
        (adjacent l11 l21) (adjacent l21 l11)
        (adjacent l12 l22) (adjacent l22 l12)
        (adjacent l13 l23) (adjacent l23 l13)
        (adjacent l21 l22) (adjacent l22 l21)
        (adjacent l22 l23) (adjacent l23 l22)
        (adjacent l21 l31) (adjacent l31 l21)
        (adjacent l22 l32) (adjacent l32 l22)
        (adjacent l23 l33) (adjacent l33 l23)
        (adjacent l31 l32) (adjacent l32 l31)
        (adjacent l32 l33) (adjacent l33 l32)

        ;; Traversability
        (can-traverse B l11) (can-traverse G l11)
        (can-traverse B l12) ; only B
        (can-traverse B l13) (can-traverse G l13)
        (can-traverse B l21) (can-traverse G l21)
        (can-traverse B l22) (can-traverse G l22) ; both with difficulty
        (can-traverse B l23) (can-traverse G l23)
        (can-traverse B l31) (can-traverse G l31)
        (can-traverse B l32) (can-traverse G l32)
        (can-traverse B l33) (can-traverse G l33)

        ;; Observation capabilities
        (can-observe B l11) (can-observe G l11)
        (can-observe B l12) (can-observe G l12)
        (can-observe B l13) (can-observe G l13)
        (can-observe B l21) (can-observe G l21)
        (can-observe B l22) (can-observe G l22)
        (can-observe G l23) ; only G
        (can-observe B l31) ; only B
        (can-observe B l32) (can-observe G l32)
        (can-observe B l33) (can-observe G l33)

        ;; Traverse cost: default 1, except higher for l22
        (= (traverse-cost B l11) 1)
        (= (traverse-cost G l11) 1)
        (= (traverse-cost B l12) 1)
        (= (traverse-cost B l13) 1)
        (= (traverse-cost G l13) 1)
        (= (traverse-cost B l21) 1)
        (= (traverse-cost G l21) 1)
        (= (traverse-cost B l22) 5)
        (= (traverse-cost G l22) 5)
        (= (traverse-cost B l23) 1)
        (= (traverse-cost G l23) 1)
        (= (traverse-cost B l31) 1)
        (= (traverse-cost G l31) 1)
        (= (traverse-cost B l32) 1)
        (= (traverse-cost G l32) 1)
        (= (traverse-cost B l33) 1)
        (= (traverse-cost G l33) 1)

        (= (total-cost) 0)
    )

    (:goal (and
        ;; All regions explored
        (explored l11) (explored l21) (explored l31)
        (explored l12) (explored l22) (explored l32)
        (explored l13) (explored l23) (explored l33)
        ;; Both robots at goal
        (at B l33)
        (at G l33)
    ))

    (:metric minimize (total-cost))
)