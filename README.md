#  Nuclear Fission & Chain Reaction Simulator

This project is a dynamic physics simulation developed with Flutter that visualizes **Nuclear Fission** and **Chain Reactions**, the fundamental operating principles of nuclear reactors. The algorithm is based on the reactor kinetics principles from Chapter 11 of Raymond Murray's book, "Nuclear Energy."

##  Project Aim
The main purpose of the application is to demonstrate the mathematics of exponential growth at the subatomic level and to visualize the real-time destructive or constructive effects of the Neutron Multiplication Factor (k) on the system.

# Working Logic and Algorithm

The simulation begins with a single free neutron launched into the environment. The user can dynamically adjust the **Multiplication Factor (k)** using the control slider on the interface:

* **k < 1 (Subcritical State):** The reaction dampens and eventually stops.
* **k = 1 (Critical State):** The chain reaction remains in equilibrium, and the number of splitting atoms is constant (the ideal operating state of a nuclear power plant).
* **k > 1 (Supercritical State):** Neutrons increase exponentially in a geometric progression (1, 2, 4, 8, 16...). The system quickly spirals out of control, reaching a "Meltdown/Explosion" point.

## Technologies and Structures Used

* **Dart & Flutter:** Core UI and logic construction.
* **StatefulWidget & setState:** Dynamic updating of the interface second by second.
* **Timer Class:** Asynchronous background management of the physical time flow and reaction speed.
* **Dynamic UI Rendering:** Real-time particle (icon) rendering on the screen based on the instantaneous neutron count using `Wrap` and `List.generate` widgets.
