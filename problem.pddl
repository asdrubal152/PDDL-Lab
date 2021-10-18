(define (problem problem12)
  (:domain Ambulance2
  (:objects
      t1 - vehicle
      p1 p2 - patient
      l1 l2 l3 l4 - location
  )
  (:init

  (location-linked l1 l2)
  (location-linked l2 l1)

  (location-linked l2 l4)
  (location-linked l4 l2)

  (location-linked l3 l4)
  (location-linked l4 l3)

  (= (distance-between l1 l2) 10)
  (= (distance-between l2 l1) 10)


  (= (distance-between l2 l4) 14)
  (= (distance-between l4 l2) 14)



  (= (distance-between l3 l4) 100)
  (= (distance-between l4 l3) 100)


  (= (distance-travelled) 0)



  (at-vehicle t1 l1)

  (at-patient p1 l2)
  

  (at-patient p2 l3)
  

  (hospital l1)
  (vehicle-empty t1)



  )

  (:goal (and
              (patient-at-hospital p1)
              (patient-at-hospital p2)
              ))

              (:metric minimize (total-time))
  )