#!/bin/bash
# Script to install Icarus Verilog, Yosys, and GTKWave

set -e  # Exit on any error

echo "=== Updating system packages ==="
sudo apt update
sudo apt upgrade -y

echo "=== Installing Icarus Verilog ==="
if ! command -v iverilog &> /dev/null; then
    sudo apt install -y iverilog
else
    echo "Icarus Verilog already installed: $(iverilog -v)"
fi

echo "=== Installing Yosys ==="
if ! command -v yosys &> /dev/null; then
    sudo apt install -y yosys
else
    echo "Yosys already installed: $(yosys -V)"
fi

echo "=== Installing GTKWave ==="
if ! command -v gtkwave &> /dev/null; then
    sudo apt install -y gtkwave
else
    echo "GTKWave already installed: $(gtkwave --version)"
fi

echo "=== Installing NETLISTSVG ==="
if ! command -v netlistsvg &> /dev/null; then
    sudo apt install -y nodejs npm
    sudo npm install -g netlistsvg
else
    echo "netlistsvg already installed: $(netlistsvg --version)"
fi

echo "✅ Core logic design tools installation complete!"
