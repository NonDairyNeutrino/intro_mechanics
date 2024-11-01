#let isPractice = false
#let isSolution = false
#let title = [= Physics 221&: Engineering Physics I #if isPractice [Practice] else [] Midterm]
#let thekraken = [*_The Kraken_*]

#set page(
  paper: "us-letter",
  header: [Physics 221&: Engineering Physics I #h(1fr) #if isPractice [Practice] else [] Midterm Exam #h(1fr) Name: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\ #line(length: 100%) #v(-10pt) #line(length: 100%)],
  margin: (top: auto, rest: 0.625in)
)
#set par(justify: true)
#set text(font: "New Computer Modern")
#set enum(numbering: "1.a)")

#align(center)[#title]
#v(11pt)
The purpose of the following questions is meant to assess the student's understanding of and skills in applying the following concepts:

- Kinematics in One Dimension: Motion with constant velocity, constant acceleration, and free fall

- Kinematics in Two Dimensions: Projectile motion

- Force and Motion: Free-body diagrams, the relationship between force and acceleration

During this exam you are allowed access to your notes.  Good luck.
#line(length: 100%)

You are a pirate in ye olden days sailing the high seas and taking your fill of legally and politley aquired riches.  
Part of your time aboard your trusty ship, _The Black Pearl_, is answering questions from your crewmates _Jack, Elizabeth, Will, Barbosa, and Commodore Norrington_.

+ With the wind at your back, you sail through the sea at an average of $10 m/s$.  
  As you pass by an island, you measure that it takes you $1 "hr"$ to cross it.

  + Draw the motion diagram for your journey over the course of the hour.

  + Draw the position-versus-time graph of your motion over the course of the hour.

  + How far across the island had you made it after 25 minutes?

  + Draw the velocity-versus-time graph of your motion over the course of the hour.

  + How fast were you going after 25 minutes?

+ As you're going along, the wind changes direction so that you slow down at a constant rate.  
  At the time you notice, you measure your speed to be 10 m/s, while 30 minutes later, you measure your speed to be 5 m/s.

  + Draw the velocity-versus-time graph over this period of time.

  + How fast were you moving after 15 minutes?

  + Draw the position-versus-time graph over this period of time.

+ While up at the helm, you notice two of your crewmates are playing with a cannonball.  
  Though after a second you see that one of them, _Pintel_ is about to *drop* (not throw) the cannonball from the crow's nest 20 m above the top of _Ragetti's_ head.  
  Not wanting to be down a crewmate, you quickly calculate how fast you need to run across the 15m to save _Ragetti_. 
  *Ignore air resistance*

  + Is the cannonball in free-fall?

  + Draw the motion diagram of the cannonball during its fall.

  + Draw the position-versus-time graph of the cannonball during its fall.

  + Draw the velocity-versus-time graph of the cannonball during its fall.

  + Just after the cannonball is dropped, what are its velocity and acceleration?  
    Remember: positive and negative directions are consequences of your choice of coordinate system.

  + When the cannonball has fallen half the distance, what are its velocity and acceleration?

  + Just before the cannonball is about to hit _Ragetti's_ head, what are the cannonball's velocity and acceleration?

  + What is the minimum speed you would need to travel with in order to save _Ragetti_?

+ All of a sudden, you see a giant tentacle rise out of the water just to your starboard (right side of the ship)!  
  You gather that _Davy Jones_ has released...#thekraken!  You must now calculate how to shoot your cannons to stave off the beast.

  + A cannonball is fired from a cannon on your ship toward #thekraken.  Once the cannonball leaves the cannon, is it in projectile motion?

  + Draw the motion diagram of the cannonball after it is fired from the cannon (at an angle) on your ship to when it hits the #thekraken.  Two dots before the cannonball reaches its apex, one dot at the apex, and two dots after the apex. #if not isPractice [*+1 Extra Credit*: Draw your best Kraken being hit by the cannonball.]

  + On your motion diagram, draw the velocity vector at each point you drew.

  + On your motion diagram, draw the acceleration vector at each point you drew.

  // + // Calculate the projectile motion/

  + Draw the free body diagram for the cannonball while it is at the highest point in its arc. Do *NOT* ignore air resistance.

  + On your free-body diagram, draw the net-force vector.

  + On your free-body diagram, draw the acceleration vector  of the cannonball.

+ Your current approach doesn't seem to be working as well as you'd hoped.  You think you should change your artillery, but aren't sure which combination of gun powder and cannonball would work best.
  You notice the bigger cannonballs move differently from the smaller ones when used with the same amount of gun powder.  
  Draw the acceleration-versus-force graph for three different cannonballs of mass 1/2, 1, and 2 kilograms.  Label each curve.
