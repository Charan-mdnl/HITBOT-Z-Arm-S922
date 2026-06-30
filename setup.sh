#!/bin/bash
# ═══════════════════════════════════════════════════════════════════
# setup.sh — Build the HITBOT Z-Arm S922 workspace
#
# Usage:
#   ./setup.sh          ← full build
#   ./setup.sh clean    ← clean + rebuild
# ═══════════════════════════════════════════════════════════════════

set -e

echo "═══════════════════════════════════════════════════"
echo " Building HITBOT Z-Arm S922 Workspace"
echo "═══════════════════════════════════════════════════"

# Remove Anaconda/Miniforge from paths (conflicts with ROS 2)
export LD_LIBRARY_PATH=$(echo "$LD_LIBRARY_PATH" | tr ':' '\n' | grep -v "miniforge\|anaconda\|conda\|miniconda" | tr '\n' ':' | sed 's/:$//')
export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v "miniforge\|anaconda\|conda\|miniconda" | tr '\n' ':' | sed 's/:$//')
export PYTHONPATH=$(echo "$PYTHONPATH" | tr ':' '\n' | grep -v "miniforge\|anaconda\|conda\|miniconda" | tr '\n' ':' | sed 's/:$//')

WORKSPACE_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$1" = "clean" ]; then
    echo "=> Cleaning build artifacts..."
    rm -rf "$WORKSPACE_DIR/build" "$WORKSPACE_DIR/install" "$WORKSPACE_DIR/log"
fi

source /opt/ros/humble/setup.bash

echo "=> Building with colcon..."
cd "$WORKSPACE_DIR"
colcon build \
    --cmake-args -DCMAKE_BUILD_TYPE=Release \
                 -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    --parallel-workers $(nproc)

echo ""
echo "═══════════════════════════════════════════════════"
echo " Build complete!"
echo ""
echo " Quick start:"
echo "   ./launch_hitbot_sim.sh       # Run HITBOT in simulation"
echo "   ./launch_hitbot_real.sh      # Run HITBOT on real hardware"
echo "═══════════════════════════════════════════════════"
