# Godot Piscine - Street Hockey Game

This project is a 2-player air hockey game built for the Godot Piscine educational series. Two players compete to score goals by hitting a puck with their taxis.

## 🏒 Game Rules

- **Objective:** Score 3 goals to win!
- **Scoring:** Hit the puck into your opponent's goal (left goal = Player 2 scores, right goal = Player 1 scores).
- **Movement:** Players are restricted to their half of the field.

## ✨ Features & Bonus (Week 0)

### Mandatory
- [x] Taxi-shaped character implemented.
- [x] 4-directional movement.
- [x] Sprite changes based on movement direction (Up, Down, Left, Right).

### Bonus Features
- [x] **Physics-based Movement:** The taxi features acceleration and deceleration curves for a "drifty" driving feel, rather than instant movement.
- [x] **Modified Character Sprites:** Modified the "Sayan" character sprite by adding red visual elements.
- [x] **Particle Effects:** Added exhaust particles (`GPUParticles2D`) that emit when the taxi is moving.
- [x] **Dynamic Animation:** The taxi uses multi-frame animations (e.g., wheels turning) that play while moving and stop when stationary for a realistic look.
- [x] **Smoother Collisions:** Uses a capsule collision shape for better interaction with round objects like the Puck.

# Godot Piscine - Week 1: City & Obstacles

In this week, we expanded the simulation by building a city environment and adding interactive obstacles.

## 🏙️ Features (Week 1)

### Mandatory
- [x] **TileMap City:** Built a road network using `StreetTileset`.
- [x] **Houses (Walls):** Added houses as `StaticBody2D` obstacles that block the taxi's path.
- [x] **Traffic Cones:** Added cones that slow down the taxi upon collision (reduces speed to 25%).

### Bonus Features
- [x] **Oil Spills:** Added slippery oil zones. When the taxi drives over them, traction is drastically reduced, causing a "drifting" effect where it's hard to turn or stop.
- [x] **Boost Pads:** Added speed boost zones that triple the taxi's speed for a racing feel (3x multiplier).
- [x] **Modular Obstacle System:** Created a reusable code structure where different obstacles can modify the taxi's properties (Speed, Traction) via a common interface.
- [x] **2-Player Competitive Mode:** Full scoring system with goal detection, win conditions, and game state management.

## 🛠️ Technical Details

- **Engine:** Godot 4.x
- **Language:** GDScript
- **Physics:** RigidBody2D interactions implemented for the Puck.
- **Display:** Configured for **Exclusive Fullscreen** with `canvas_items` stretch mode for responsive scaling on any monitor.

## 🔄 Recent Updates

- **Obstacle Effect Duration:**
  - Effects now persist after leaving the area.
  - **Boost & Cone:** Effect lasts for **3 seconds** (reduced from 5s).
  - **Oil:** Effect lasts for **1 second**.
- **Gameplay Balance:**
  - **Oil Spills:** Traction reduced to **10%** (was 50%), making it much harder to control the car.
  - **Taxi Stats:** Base **Max Speed** set to **1000.0** and **Acceleration** set to **1500.0** for snappier movement.
- **Improved Collision Physics:**
  - The taxi's velocity is now reset to zero immediately upon hitting screen bounds or static obstacles (houses). This ensures a natural "stop-and-go" feel where the car accelerates from scratch after a collision.
- **Puck Physics:**
  - Reduced `linear_damp` (friction) from 0.5 to 0.1 to make the puck slide more freely, resembling a real air hockey puck.

# Godot Piscine - Week 2: HUD & Game Flow

Week 2 introduces a polished user interface with fuel management, distance tracking, and proper game flow screens.

## 🎯 Features (Week 2)

### Mandatory
- [x] **Start Screen:** Game begins with a welcome screen. Press `SPACE` to start, or `E` to exit.
- [x] **Fuel Counter:** Visual fuel gauge with animated sprites from Week 2 assets. **Each player has their own fuel system.**
- [x] **Fuel Consumption:** Fuel decreases as taxis move (5 fuel/second). **Separate tracking for Player 1 and Player 2.**
- [x] **Game Over Screen:** Displays when a player runs out of fuel, showing both players' distances.

### Bonus Features
- [x] **Pause Menu:** Press `ESC` to pause the game anytime. Press `SPACE` to resume, `R` to restart, or `E` to exit.
- [x] **Proper Pause System:** Game completely freezes when paused (using `process_mode` system).
- [x] **Distance Counter:** Tracks total distance traveled by both players separately in real-time.
- [x] **Dual HUD System:** Each player has their own HUD (Player 1: top-left, Player 2: top-right).
- [x] **Fuel Refill Mechanic:** Hitting the puck refills your fuel to 100%!
- [x] **Animated Fuel Gauge:** Uses 3-stage visual feedback:
  - **100%-67%**: Green gauge (`Tachimetro6/Tachimetrofull6`)
  - **66%-34%**: Orange gauge (`Tachimetro4/Tachimetrofull4`)
  - **33%-0%**: Red gauge (`Tachimetro1/Tachimetrofull1`)
  - Needle (`lancetta`) rotates counter-clockwise from 0° (100% fuel) to -270° (0% fuel).

## 🎮 Updated Controls

- **SPACE** - Start game (from start screen)
- **Player 1 (Left side):** Use `WASD` to move the taxi.
- **Player 2 (Right side):** Use `Arrow Keys` to move the taxi.
- **ESC** - Pause/Resume game
- **R** - Restart game (from pause or game over)
- **E** - Exit game (from pause or game over)

## 🔄 Game Flow

1. **Start Screen** → Press SPACE
2. **Gameplay** → Move taxis, consume fuel, track distance
3. **Pause Menu** → Press ESC anytime
4. **Game Over** → When fuel reaches 0, or 3 goals scored

## 🚀 How to Run

1. Open Godot Engine.
2. Import this folder.
3. Run the project (F5) or open `scenes/main.tscn`.