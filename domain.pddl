
(define (domain Ambulance)
(:requirements :strips :typing :fluents :durative-actions:equality)

(:types location
hospital
patient
vehicle
)

(:predicates 
(patient-at-hospital ?p - patient)
(at-vehicle ?t - vehicle ?l - location)
(hospital ?h - location)
(location-linked ?x ?y - location)
(at-patient ?p - patient ?l - location)
(vehicle-full ?v - vehicle)
(vehicle-empty ?v - vehicle)
 (patient-loaded ?p - patient ?v - vehicle)
    
)


(:functions 
    (distance-between ?x ?y - location) 
    (distance-travelled)   
    
)
(:durative-action drive-to-patient
    :parameters (?t - vehicle ?from ?to - location ?p - patient)
    :duration (= ?duration (distance-between ?from ?to))
    :condition (and (over all (location-linked ?from ?to))
                    (at start (at-vehicle ?t ?from))
                    (over all (vehicle-empty ?t)))
    :effect (and (at end (not (at-vehicle ?t ?from)))
                 (at end (at-vehicle ?t ?to))
                 (at end (increase (distance-travelled) (distance-between ?from ?to)))              
                 )
)

(:durative-action take-patient-to-hospital
    :parameters (?t - vehicle ?from ?to - location ?p - patient)
    :duration (= ?duration (distance-between ?from ?to))
    :condition (and (over all (location-linked ?from ?to))
                    (at start (at-vehicle ?t ?from)))
    :effect (and  (at end (not (at-vehicle ?t ?from)))
                  (at end (not (at-patient ?p ?from)))
                  (at end (at-patient ?p ?to))
                  (at end (at-vehicle ?t ?to))
                  (at end (increase (distance-travelled) (distance-between ?from ?to))))
                  )

(:durative-action drop-off-patient
    :parameters (?t - vehicle ?h - location ?p - patient)
    :duration (= ?duration 3)
    :condition (and (over all (hospital ?h))
                (over all (at-vehicle ?t ?h))
                (over all (at-patient ?p ?h))
                (at start (patient-loaded ?p ?t)))
    :effect (and (at end (patient-at-hospital ?p))
             (at end (at-patient ?p ?h))
             (at end (not (patient-loaded ?p ?t)))
             (at end (vehicle-empty ?t)))
)

(:durative-action stabilize-patient-and-pick-up
    :parameters (?t - vehicle ?p - patient ?l - location)
    :duration (= ?duration 10)
    :condition (and (over all (at-vehicle ?t ?l))
                    (over all (at-patient ?p ?l))
                    (over all (vehicle-empty ?t)))
    :effect (and    (at end (patient-loaded ?p ?t))
            (at end (vehicle-full ?t))
            (at end (not (vehicle-empty ?t)))            )
)

)