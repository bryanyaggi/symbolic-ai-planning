(define (problem road)
    (:domain road)
    (:objects
        loc1 loc2 loc3 - location
        agent1 agent2 - agent)
    (:init
        (dozer agent2)
        (at agent1 loc1)
        (at agent2 loc1)
        (rubble loc2)
        (adjacent loc1 loc2)
        (adjacent loc2 loc1)
        (adjacent loc2 loc3)
        (adjacent loc3 loc2)
    )
    (:goal (at agent1 loc3))
)
