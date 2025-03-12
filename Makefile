# QMK/Vial Firmware Makefile

# Variables - customize these for your keyboard/keymap
KEYBOARD ?= onspry/thypoono/rev1
KEYMAP ?= default
QMK_DIR ?= ./qmk/qmk_firmware
VIAL_DIR ?= ./vial/vial-qmk

# Phony targets
.PHONY: all qmk vial clean flash flash-vial list debug lint vial-json help git-submodule init-qmk init-vial setup

# Default target
all: qmk

# First time setup and git submodule initialization
setup: git-submodule
	@echo "First time setup completed. You can now use other make commands."

# Initialize QMK directory with keyboard files
init-qmk:
	@echo "Initializing QMK directory with keyboard files..."
	@rm -rf $(QMK_DIR)/keyboards/onspry
	@mkdir -p $(QMK_DIR)/keyboards/onspry/thypoono
	@cp thypoono/qmk/qmk_firmware/readme.md $(QMK_DIR)/keyboards/onspry/thypoono/
	@cp -r thypoono/qmk/qmk_firmware/rev1 $(QMK_DIR)/keyboards/onspry/thypoono/
	@cp -r thypoono/qmk/qmk_firmware/keymaps $(QMK_DIR)/keyboards/onspry/thypoono/
	@find $(QMK_DIR)/keyboards/onspry -name ".DS_Store" -delete

# Initialize Vial directory with keyboard files
init-vial:
	@echo "Initializing Vial directory with keyboard files..."
	@rm -rf $(VIAL_DIR)/keyboards/onspry
	@mkdir -p $(VIAL_DIR)/keyboards/onspry/thypoono
	@cp thypoono/qmk/qmk_firmware/readme.md $(VIAL_DIR)/keyboards/onspry/thypoono/
	@cp -r thypoono/qmk/qmk_firmware/rev1 $(VIAL_DIR)/keyboards/onspry/thypoono/
	@cp -r thypoono/qmk/qmk_firmware/keymaps $(VIAL_DIR)/keyboards/onspry/thypoono/
	@find $(VIAL_DIR)/keyboards/onspry -name ".DS_Store" -delete

# Build standard QMK firmware
qmk: init-qmk
	@echo "Building QMK firmware for $(KEYBOARD) with keymap $(KEYMAP)..."
	$(MAKE) -C $(QMK_DIR) $(KEYBOARD):$(KEYMAP)

# Build Vial-enabled firmware
vial: init-vial
	@echo "Building Vial-enabled firmware for $(KEYBOARD) with keymap $(KEYMAP)..."
	$(MAKE) -C $(VIAL_DIR) $(KEYBOARD):$(KEYMAP)

# Clean the build files
clean:
	@echo "Cleaning QMK build files..."
	$(MAKE) -C $(QMK_DIR) clean
	@echo "Cleaning Vial build files..."
	$(MAKE) -C $(VIAL_DIR) clean

# Flash standard QMK firmware
flash:
	@echo "Flashing QMK firmware to $(KEYBOARD) with keymap $(KEYMAP)..."
	$(MAKE) -C $(QMK_DIR) $(KEYBOARD):$(KEYMAP):flash

# Flash Vial-enabled firmware
flash-vial:
	@echo "Flashing Vial-enabled firmware to $(KEYBOARD) with keymap $(KEYMAP)..."
	$(MAKE) -C $(VIAL_DIR) $(KEYBOARD):$(KEYMAP):flash

# List all available keyboards
list:
	@echo "Available keyboards in QMK:"
	$(MAKE) -C $(QMK_DIR) list-keyboards
	@echo "\nAvailable keyboards in Vial:"
	$(MAKE) -C $(VIAL_DIR) list-keyboards

# Build with debug enabled
debug:
	@echo "Building QMK firmware with debug enabled..."
	$(MAKE) -C $(QMK_DIR) $(KEYBOARD):$(KEYMAP):debug

# Compile Vial JSON definition (if applicable)
vial-json:
	@echo "Compiling Vial JSON definition..."
	# Add your JSON compilation commands here, if needed

# Run lint/code checks
lint: init-qmk
	@echo "Running QMK lint checks for keyboard $(KEYBOARD)..."
	QMK_HOME=$(QMK_DIR) cd $(QMK_DIR) && qmk lint -kb onspry/thypoono/rev1

# Help message
help:
	@echo "QMK/Vial Firmware Build System"
	@echo "============================="
	@echo "Available targets:"
	@echo "  all        - Default target, runs 'qmk'"
	@echo "  qmk        - Build standard QMK firmware"
	@echo "  vial       - Build Vial-enabled firmware"
	@echo "  clean      - Clean all build files"
	@echo "  flash      - Flash standard QMK firmware"
	@echo "  flash-vial - Flash Vial-enabled firmware"
	@echo "  list       - List all available keyboards"
	@echo "  debug      - Build with debugging enabled"
	@echo "  vial-json  - Compile Vial JSON definition (if needed)"
	@echo "  lint       - Run code quality checks"
	@echo "  help       - Show this help message"
	@echo ""
	@echo "Variables (can be overridden):"
	@echo "  KEYBOARD   = $(KEYBOARD)"
	@echo "  KEYMAP     = $(KEYMAP)"
	@echo "  QMK_DIR    = $(QMK_DIR)"
	@echo "  VIAL_DIR   = $(VIAL_DIR)"
	@echo "  BOOTLOADER = $(BOOTLOADER)"
	@echo ""
	@echo "Example usage:"
	@echo "  make KEYBOARD=planck/rev6 KEYMAP=default vial"
	@echo "  make KEYBOARD=dz60 KEYMAP=custom flash-vial"

# Update git submodules (only needed for setup or explicit updates)
git-submodule:
	@echo "Updating git submodules..."
	git submodule update --remote
	git submodule update --init --recursive --depth 1
	cd qmk/qmk_firmware && git submodule update --init --recursive --depth 1
	cd vial/vial-qmk && git submodule update --init --recursive --depth 1 