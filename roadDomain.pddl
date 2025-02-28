(define (domain road)
    (:requirements :strips :typing)
    (:types
        vehicle location - object
        bulldozer - vehicle
    )
    
    (:predicates
        (at ?v - vehicle ?l - location)
        (adjacent ?l1 ?l2 - location)
        (rubble ?l - location)
    )
    
    (:action move
        :parameters (?v - vehicle ?from ?to - location)
        :precondition (and (at ?v ?from) (adjacent ?from ?to) (not (rubble ?from)))
        :effect (and (not (at ?v ?from)) (at ?v ?to))
    )
    (:action clear
        :parameters (?b - bulldozer ?l - location)
        :precondition (and (at ?b ?l) (rubble ?l))
        :effect (not (rubble ?l))
    )
)