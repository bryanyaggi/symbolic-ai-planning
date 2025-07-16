(define (domain exploration)
    (:requirements :strips :typing :equality :action-costs)
    
    (:types
        robot location terrain - object
    )

    (:predicates
        (at ?r - robot ?l - location)
        (explored ?l - location)
        (can-observe ?r - robot ?l - location)
        (is-terrain ?l - location ?t - terrain)
        (can-traverse-terrain ?r - robot ?t - terrain)
        (adjacent ?l1 - location ?l2 - location)
    )

    (:functions
        (total-cost)
        (traverse-cost ?t - terrain)
    )

    (:action move
        :parameters (?r - robot ?from ?to - location ?t - terrain)
        :precondition (and
            (at ?r ?from)
            (adjacent ?from ?to)
            (is-terrain ?to ?t)
            (can-traverse-terrain ?r ?t)
        )
        :effect (and
            (not (at ?r ?from))
            (at ?r ?to)
            (increase (total-cost) (traverse-cost ?t))
        )
    )
    (:action observe
        :parameters (?r - robot ?l - location)
        :precondition (and
            (at ?r ?l)
            (can-observe ?r ?l)
        )
        :effect (explored ?l)
    )
)
