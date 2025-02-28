(define (domain road)
    (:requirements :strips :typing)
    (:types
        agent roadSection - object
        robot rubble - agent
    )
    
    (:predicates
        (canClearRubble ?r - robot)
        (onRoadSection ?a - agent ?rs - roadSection)
        (leftOf ?l ?r - roadSection)
        (rightOf ?r ?l - roadSection)
    )
    
    (:action goRight
        :parameters (?rob - robot ?rub - rubble ?from ?to - roadSection)
        :precondition (and (onRoadSection ?rob ?from) (rightOf ?to ?from) (not (onRoadSection ?rub ?from)))
        :effect (and (not (onRoadSection ?rob ?from)) (onRoadSection ?rob ?to))
    )
    (:action goLeft
        :parameters (?rob - robot ?rub - rubble ?from ?to - roadSection)
        :precondition (and (onRoadSection ?rob ?from) (leftOf ?to ?from) (not (onRoadSection ?rub ?from)))
        :effect (and (not (onRoadSection ?rob ?from)) (onRoadSection ?rob ?to))
    )
    (:action clearRubble
        :parameters (?rob - robot ?rub - rubble ?rs - roadSection)
        :precondition (and (onRoadSection ?rob ?rs) (onRoadSection ?rub ?rs) (canClearRubble ?rob))
        :effect (not (onRoadSection ?rub ?rs))
    )
)