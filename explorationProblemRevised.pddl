(define (problem e1)
    (:domain exploration)
    
    (:objects
        B G - robot
        l13 l23 l33
        l12 l22 l32
        l11 l21 l31 - location
        nominal rocky restricted - terrain
    )

    (:init
        ;; Robot starting positions
        (at B l11)
        (at G l11)

        ;; Adjacency (4-connected grid)
        (south l11 l12) (north l12 l11)
        (south l12 l13) (north l13 l12)
        (west l11 l21) (east l21 l11)
        (west l12 l22) (east l22 l12)
        (west l13 l23) (east l23 l13)
        (south l21 l22) (north l22 l21)
        (south l22 l23) (north l23 l22)
        (west l21 l31) (east l31 l21)
        (west l22 l32) (east l32 l22)
        (west l23 l33) (east l33 l23)
        (south l31 l32) (north l32 l31)
        (south l32 l33) (north l33 l32)
        
        ;; Terrain
        (is-terrain l13 nominal) (is-terrain l23 nominal) (is-terrain l33 nominal)
        (is-terrain l12 restricted) (is-terrain l22 rocky) (is-terrain l32 nominal)
        (is-terrain l11 nominal) (is-terrain l21 nominal) (is-terrain l31 nominal)

        ;; Traversability
        (can-traverse-terrain G nominal)
        (can-traverse-terrain G rocky)
        (can-traverse-terrain B nominal)
        (can-traverse-terrain B rocky)
        (can-traverse-terrain B restricted)

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

        ;; Traverse cost
        (= (traverse-cost nominal) 1)
        (= (traverse-cost rocky) 5)
        (= (traverse-cost restricted) 1)

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
