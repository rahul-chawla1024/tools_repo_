#!/bin/bash
# setup_all.sh
# Master script to run both logic and verible setup scripts

set -e  # Exit on any error

echo "=== Starting Full Setup ==="

echo "Running Logic Infra Setup..."
bash logic_infra_setup.sh

echo "Running Verible Setup..."
bash logic_infra_verible.sh

echo "=== Full Setup Completed Successfully ==="
