(define (problem road)
    (:domain road)
    (:objects
        robot1 robot2 - robot
        rubble1 - rubble
        rs1 rs2 rs3 - roadSection
    )
    (:init
        (canClearRubble robot2)
        (onRoadSection robot1 rs1)
        (onRoadSection robot2 rs1)
        (onRoadSection rubble1 rs2)
        (rightOf rs2 rs1)
        (rightOf rs3 rs2)
        (leftOf rs1 rs2)
        (leftOf rs2 rs3)
    )
    (:goal (onRoadSection robot1 rs3))
)