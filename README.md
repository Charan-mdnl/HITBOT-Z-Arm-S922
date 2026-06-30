# HITBOT Z-Arm S922 ROS 2 Workspace

A dedicated, self-contained ROS 2 Humble workspace for controlling the **HITBOT Z-Arm S922** (6 DoF SCARA-like robot arm) in both Gazebo simulation and real-world hardware.

## 📂 Repository Structure
```
.
├── setup.sh                 # Cleans and builds the workspace
├── launch_hitbot_sim.sh     # Usage: ./launch_hitbot_sim.sh
├── launch_hitbot_real.sh    # Usage: ./launch_hitbot_real.sh
├── ZARM/                    # Original STEP visual meshes and URDF reference
├── S922*.STEP               # STEP 3D CAD assembly model of the Z-Arm
└── src/
    ├── hitbot_description/   # Visual/collision meshes and robot URDF files
    ├── hitbot_moveit_config/ # MoveIt 2 configs for motion planning
    ├── hitbot_hardware/      # ros2_control TCP hardware driver interface
    ├── hitbot_imitation/     # Imitation learning package for recording/playback
    ├── hitbot-api/           # Python API wrapper (native TCP communication)
    ├── cwsfa_hitbot_api/     # Alternative Python API wrapper
    └── Z-Arm-S922-Brochure*.pdf # Datasheet and product specs
```

---

## 🛠️ Installation & Setup

### Prerequisites
- Ubuntu 22.04 LTS
- ROS 2 Humble Hawksbill
- MoveIt 2 for ROS 2 Humble

### 1. Build the Workspace
Clone and run the compilation script:
```bash
git clone https://github.com/Charan-mdnl/HITBOT-Z-Arm-S922.git ~/hitbot_ws
cd ~/hitbot_ws
./setup.sh clean
```

---

## 💻 Running the Simulation
To run the robot arm in simulation using fake mock controllers:
```bash
./launch_hitbot_sim.sh
```
This will launch:
1. `ros2_control_node` with simulated hardware interfaces.
2. `robot_state_publisher` publishing the visual model.
3. MoveIt 2 `move_group` server.
4. RViz with the interactive markers.

---

## 🤖 Controlling Real Hardware

### 1. Subnet Setup
The HITBOT S922 controller box has a default IP of `192.168.58.2` and communicates on port `8080`. Your control PC must be put on the same subnet:
```bash
# Add IP for HITBOT subnet (e.g. 192.168.58.100) on your ethernet interface
sudo ip addr add 192.168.58.100/24 dev enp1s0
sudo ip link set enp1s0 up

# Verify connection
ping 192.168.58.2
```

### 2. Launch the Hardware Controller
To connect to the controller box and start MoveIt:
```bash
./launch_hitbot_real.sh
```

---

## 🎮 Moving the Robot in RViz
1. In the bottom-left **MotionPlanning** panel of RViz, click the **Planning** tab.
2. Under **Planning Group**, select `hitbot_arm`.
3. Drag the interactive marker ball at the tool tip to set the target pose.
4. Click **Plan** to visualize, then **Execute** to move.
