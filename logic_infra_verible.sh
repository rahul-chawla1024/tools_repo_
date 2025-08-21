#!/bin/bash
# install_verible.sh
# Script to install Verible (Verilog linter) using a direct download link

set -e  # Exit on any error

echo "=== Installing Verible ==="

# Check if verible-verilog-lint already exists
if ! command -v verible-verilog-lint &> /dev/null; then
    echo "Verible not found, installing..."

    # Direct download link (replace with latest if needed)
    DOWNLOAD_LINK="https://github.com/chipsalliance/verible/releases/download/v0.0-4017-g62aee204/verible-v0.0-4017-g62aee204-linux-static-x86_64.tar.gz"

    # Create a dedicated temp folder in current directory
    mkdir -p ./temp_ver/verible_install
    wget -O ./temp_ver/verible_install/verible.tar.gz $DOWNLOAD_LINK
    tar -xzf ./temp_ver/verible_install/verible.tar.gz -C ./temp_ver/verible_install

    # Find the extracted folder dynamically
    EXTRACTED_DIR=$(find ./temp_ver/verible_install -maxdepth 1 -type d -name "verible*")
    sudo cp -r $EXTRACTED_DIR/bin/* /usr/local/bin/

    # Cleanup
    rm -rf ./temp_ver

    echo "Verible installed successfully!"
else
    echo "Verible already installed: $(verible-verilog-lint --version)"
fi
