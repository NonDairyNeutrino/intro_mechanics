#let isPractice = false
#let isSolution = false
#let title = [= Physics 221&: Engineering Physics I #if isPractice [Practice] else [] Final Exam]
#let thekraken = [*_The Kraken_*]

#set page(
  paper: "us-letter",
  header: [Physics 221&: Engineering Physics I #h(1fr) #if isPractice [Practice] else [] Final Exam #h(1fr) Name: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\ #line(length: 100%) #v(-10pt) #line(length: 100%)],
  margin: (top: auto, rest: 0.625in)
)
#set par(justify: true)
#set text(font: "New Computer Modern")
#set enum(numbering: "1.a)")

#align(center)[#title]
#v(11pt)

Welcome aboard, brave crew! The time has come to test your mastery of mechanics as we recount the adventures of the HMS Kinematics. Each part of this exam unfolds a new chapter in the story. Solve the problems to guide our crew through their journey. Good luck, and may the winds of physics guide your calculations!
*Note:* Each question is worth 10 points.

// = Part I: Setting Sail

// *Kinematics in 1 Dimension*  
+ The ship’s anchor is hoisted at a constant acceleration. It takes 15 s for the anchor to travel 10.0 m vertically from rest.  
  + What is the acceleration of the anchor?  
  + What is the velocity of the anchor when it is fully hoisted?

// *Kinematics in 2 Dimensions*  
+ While the ship is moving at 4.0 m/s relative to the water, a crew member tosses a coconut directly upward from the deck. The coconut reaches a maximum height of 3.0 m relative to the deck.  
  + How long does it take for the coconut to return to the deck?  
  + What is the horizontal displacement of the coconut relative to the water when it lands back on the deck?  
  + If another pirate onshore sees the coconut’s trajectory, what shape would they observe?

// = Part II: Battle at Sea

// *Force and Dynamics in 1 Dimension*  
+ The pirate ship fires a harpoon cannon horizontally. The harpoon (mass 10.0 kg) is accelerated from rest to a speed of 25.0 m/s over a distance of 2.0 m inside the barrel.  
  + What is the average force exerted on the harpoon by the cannon?  
  + If the cannon recoils, calculate the recoil force and acceleration assuming the cannon has a mass of 200.0 kg.

// *Newton’s Third Law*  
+ During the battle, the rival pirate ship pulls the HMS Kinematics using a rope. If the tension in the rope is 500 N:  
  + What force is the HMS Kinematics exerting on the rival ship?  
  + Explain why these forces are equal and opposite despite the HMS Kinematics accelerating toward the rival ship.

// = Part III: The Treasure Island

// *Dynamics in 2 Dimensions*  
+ To recover treasure from an underwater cave, a diver pulls a chest (mass 50.0 kg) along a seabed. The chest is pulled with a force of 200 N at an angle of 30° above the horizontal. The coefficient of kinetic friction between the chest and the seabed is 0.1.  
  + Calculate the acceleration of the chest.  
  + If the diver pulls the chest for 10.0 s, how far does it move?

// *Impulse and Momentum*  
+ A parrot flying at 6.0 m/s horizontally grabs a sword (mass 3.0 kg) resting on the ground. The parrot’s mass is 1.0 kg.  
  + What is the final velocity of the parrot and sword system?  
  + If the parrot swoops down and grabs the sword over a time of 0.5 s, what average force is experienced by the sword?

// = Part IV: The Treasure Haul

// *Work and Kinetic Energy*  
+ The crew pushes two treasure chests, one with a mass of 50.0 kg and the other with a mass of 70.0 kg, across a flat deck. They push each chest with the same constant force of 200 N for 5.0 m. Both chests start at rest.  
  + How much work is done on each chest?  
  + What is the change in kinetic energy of each chest?  
  + Which chest will have the larger velocity at the end of the push?  
  + Which chest travels the distance in the least amount of time?

// *Interactions and Potential Energy*  
+ A pirate lifts a treasure chest (mass 30.0 kg) vertically 2.0 m from the ground to load it onto a platform. While climbing, the pirate slips and lets the chest fall. The chest falls 1.5 m before being stopped by a rope, which stretches like a spring.  
  The rope has an effective spring constant of 500 N/m. The potential energy stored in a spring is given by $U_s = 1/2 k x^2$, where $k$ is the spring constant and $x$ is the stretch or compression of the spring.  
  + What is the potential energy of the chest relative to the ground when it is at the starting height of 2.0 m?  
  + What is the potential energy of the chest relative to the ground after it has fallen 1.5 m?  
  + Assuming the rope stretches just enough to stop the chest without rebounding, calculate the maximum elastic potential energy stored in the rope.

// = Part V: Celebration!

// *Energy Conservation*  
+ Captain Newton swings from the mast to the deck using a rope of length 6.0 m. She starts from rest at an angle of 45° from the vertical.  
  + Calculate her speed at the bottom of the swing.  
  + If air resistance does 20 J of work on her during the swing, what is her speed at the bottom now?

// *Uniform Circular Motion*  
+ To celebrate their treasure haul, the pirates rig a rope to swing a barrel of rum (mass 25.0 kg) in a horizontal circle above the deck. The rope is 2.5 m long and remains taut throughout the motion.  
  + If the barrel completes one full revolution every 3.0 s, what is its speed?  
  + What is the tension in the rope during the circular motion?  
  + If the rope can withstand a maximum tension of 500 N, what is the maximum speed the barrel can have without snapping the rope?

// = Extra Credit: The Pirate Ship's Cannonball Launch  

+ *EXTRA CREDIT:* The pirate ship is preparing to fire a cannonball from a cannon. The cannon is mounted on a platform that can tilt, and it is initially set at a 30° angle from the horizontal. The cannonball (mass 5.0 kg) is fired with an initial velocity of 40.0 m/s at this angle. Air resistance is negligible, and we’ll assume the cannonball lands at the same height from which it was launched.  
  + *Using Forces:*  
   Explain the motion of the cannonball after it is fired. Describe the forces acting on the cannonball throughout its trajectory, including the role of gravity, the initial launch velocity, and how these forces change over time.  
  + *Using Energy:*  
   Explain the motion of the cannonball in terms of energy. Describe the changes in the cannonball's kinetic and potential energy throughout its flight. How does the conservation of mechanical energy apply to this system?

