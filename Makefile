# ================================================
# Makefile for Logic Infra (Final Improved)
# ================================================

# Default target
SIM_PATH ?= ./default
SIM_DIR := $(dir $(SIM_PATH))
SIM_TARGET := $(notdir $(SIM_PATH))

# Tools
IVERILOG ?= iverilog
VVP ?= vvp
VERIBLE ?= verible-verilog-lint
YOSYS ?= yosys
NETLISTSVG ?= netlistsvg

# Directories
LOG_DIR ?= ./logs
WAVE_DIR ?= ./wave
TB_DIR ?= ./tb
SIM_OUT ?= ./sim_out
SYNTH_OUT ?= ./synth_out

# Timestamp
TIMESTAMP := $(shell date +"%Y%m%d_%H%M%S")

# Error limits (can be parameterized later)
MAX_ERRORS_LINT ?= 1
MAX_ERRORS_SIM ?= 1
MAX_ERRORS_SYNTH ?= 1

# ================================================
# Lint Target
# ================================================
lint:
	@echo "=== Linting $(SIM_TARGET).v in $(SIM_PATH) ==="
	@if [ ! -d "$(LOG_DIR)" ]; then mkdir -p $(LOG_DIR); fi
	@$(VERIBLE) $(SIM_PATH).v > $(LOG_DIR)/$(SIM_TARGET)lint$(TIMESTAMP).log 2>&1
	@LINT_EXIT=$$?; \
	if [ $$LINT_EXIT -ne 0 ]; then \
		echo "Lint FAILED. Check $(LOG_DIR)/$(SIM_TARGET)lint$(TIMESTAMP).log"; \
		exit 1; \
	else \
		echo "Lint PASSED"; \
	fi

# ================================================
# Simulation Target
# ================================================
sim:
	@echo "=== Compiling $(SIM_TARGET).v with Icarus ==="
	@if [ ! -d "$(LOG_DIR)" ]; then mkdir -p $(LOG_DIR); fi
	@if [ ! -d "$(WAVE_DIR)" ]; then mkdir -p $(WAVE_DIR); fi
	@if [ ! -d "$(SIM_OUT)" ]; then mkdir -p $(SIM_OUT); fi
	@$(IVERILOG) -o $(SIM_OUT)/$(SIM_TARGET).out $(SIM_PATH).v $(SIM_DIR)tb/$(SIM_TARGET)_tb.v > $(LOG_DIR)/$(SIM_TARGET)_compile$(TIMESTAMP).log 2>&1
	@COMP_EXIT=$$?; \
	if [ $$COMP_EXIT -ne 0 ]; then \
		echo "Compilation FAILED. Check $(LOG_DIR)/$(SIM_TARGET)compile$(TIMESTAMP).log"; \
		exit 1; \
	else \
		echo "Compilation PASSED"; \
	fi
	@echo "=== Running Simulation ==="
	@$(VVP) $(SIM_OUT)/$(SIM_TARGET).out > $(LOG_DIR)/$(SIM_TARGET)sim$(TIMESTAMP).log 2>&1
	@SIM_EXIT=$$?; \
	if [ $$SIM_EXIT -ne 0 ]; then \
		echo "Simulation FAILED. Check $(LOG_DIR)/$(SIM_TARGET)sim$(TIMESTAMP).log"; \
		exit 1; \
	else \
		echo "Simulation PASSED."; \
		if ls *.vcd > /dev/null 2>&1 ; then \
			mv *.vcd $(WAVE_DIR)/$(SIM_TARGET).vcd; \
		fi \
	fi

# ================================================
# Synthesis Target
# ================================================
synth:
	@echo "=== Synthesizing $(SIM_PATH).v with Yosys ==="
	@if [ ! -d "$(LOG_DIR)" ]; then mkdir -p $(LOG_DIR); fi
	@if [ ! -d "$(SYNTH_OUT)" ]; then mkdir -p $(SYNTH_OUT); fi
	@$(YOSYS) -p "read_verilog $(SIM_PATH).v; synth; write_json $(SYNTH_OUT)/$(SIM_TARGET).json" > $(LOG_DIR)/$(SIM_TARGET)synth$(TIMESTAMP).log 2>&1
	@jq .  $(SYNTH_OUT)/$(SIM_TARGET).json > $(SYNTH_OUT)/$(SIM_TARGET)_clean.json
	@SYNTH_EXIT=$$?; \
	if [ $$SYNTH_EXIT -ne 0 ]; then \
		echo "Synthesis FAILED. Check $(LOG_DIR)/$(SIM_TARGET)synth$(TIMESTAMP).log"; \
		exit 1; \
	else \
		echo "Synthesis PASSED. Netlist: $(SIM_TARGET).json"; \
	fi

# ================================================
# Schematic Target
# ================================================
sch:
	@echo "=== Schematic for $(SIM_PATH).v with netlistsvg ==="
	@$(NETLISTSVG) $(SYNTH_OUT)/$(SIM_TARGET)_clean.json -o $(SYNTH_OUT)/$(SIM_TARGET).svg

# ================================================
# Full Flow Target
# ================================================
all: lint sim synth sch

# ================================================
# Clean
# ================================================
clean:
	@echo "=== Cleaning build, logs, waveforms ==="
	@rm -rf $(LOG_DIR)
	@rm -rf $(WAVE_DIR)
	@rm -rf $(SYNTH_OUT)
	@rm -rf $(SIM_OUT)
