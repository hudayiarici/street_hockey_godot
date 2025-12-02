# Godot Piscine - Week 0: Taxi Driver

This project is the first assignment for the Godot Piscine. The goal is to create a 2D character controller with specific movement mechanics and interactions.

## 🎮 Controls

- **Movement:** Use `WASD` or `Arrow Keys` to move the taxi.
- **Interaction:** Collide with the "Puck" to push it around!

## ✨ Features & Bonus (Week 0)

### Mandatory
- [x] Taxi-shaped character implemented.
- [x] 4-directional movement.
- [x] Sprite changes based on movement direction (Up, Down, Left, Right).

### Bonus Features
- [x] **Physics-based Movement:** The taxi features acceleration and deceleration curves for a "drifty" driving feel, rather than instant movement.
- [x] **Custom Sprites:** Used a custom character sprite ("Sayan") instead of the default assets.
- [x] **Particle Effects:** Added exhaust particles (`GPUParticles2D`) that emit when the taxi is moving.
- [x] **Dynamic Animation:** The taxi uses multi-frame animations (e.g., wheels turning) that play while moving and stop when stationary for a realistic look.
- [x] **Smoother Collisions:** Uses a capsule collision shape for better interaction with round objects like the Puck.

# Godot Piscine - Week 1: City & Obstacles

In this week, we expanded the simulation by building a city environment and adding interactive obstacles.

## 🏙️ Features (Week 1)

### Mandatory
- [x] **TileMap City:** Built a road network using `StreetTileset`.
- [x] **Houses (Walls):** Added houses as `StaticBody2D` obstacles that block the taxi's path.
- [x] **Traffic Cones:** Added cones that slow down the taxi upon collision (Speed -50%).

### Bonus Features
- [x] **Oil Spills:** Added slippery oil zones. When the taxi drives over them, traction is drastically reduced, causing a "drifting" effect where it's hard to turn or stop.
- [x] **Boost Pads:** Added speed boost zones that temporarily double the taxi's speed for a racing feel.
- [x] **Chaos Puck:** The Puck (ball) also reacts to Boost Pads! Hitting a boost pad launches the puck at high speed, adding chaotic fun to the gameplay.
- [x] **Modular Obstacle System:** Created a reusable code structure where different obstacles can modify the taxi's properties (Speed, Traction) via a common interface.

## 🛠️ Technical Details

- **Engine:** Godot 4.x
- **Language:** GDScript
- **Physics:** RigidBody2D interactions implemented for the Puck.
- **Display:** Configured for **Exclusive Fullscreen** with `canvas_items` stretch mode for responsive scaling on any monitor.

## 🚀 How to Run

1. Open Godot Engine.
2. Import this folder (`Week1`).
3. Run the project (F5) or open `scenes/main.tscn`.