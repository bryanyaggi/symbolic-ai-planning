(define (domain road)
    (:requirements :strips :typing)
    
    (:types
        location
        agent
    )
    
    (:predicates
        (at ?agent - agent ?loc - location)
        (adjacent ?from ?to - location)
        (rubble ?loc - location)
        (dozer ?agent - agent)
    )
    
    (:action move
        :parameters (?agent - agent ?from ?to - location)
        :precondition (and
            (at ?agent ?from)
            (adjacent ?from ?to)
            (not (rubble ?from)))
        :effect (and
            (not (at ?agent ?from))
            (at ?agent ?to)
        )
    )

    (:action clear
        :parameters (?agent - agent ?loc - location)
        :precondition (and
            (at ?agent ?loc)
            (rubble ?loc)
            (dozer ?agent))
        :effect (not (rubble ?loc))
    )
)
