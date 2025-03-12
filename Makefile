# QMK/Vial Firmware Makefile

# Variables - customize these for your keyboard/keymap
KEYBOARD ?= thypoono
KEYMAP ?= vial
QMK_DIR ?= ./qmk/qmk_firmware
VIAL_DIR ?= ./vial/vial-qmk

# Phony targets
.PHONY: all qmk vial clean flash flash-vial list debug lint vial-json help git-submodule

# Default target
all: qmk

# Build standard QMK firmware
qmk: git-submodule
	@echo "Building QMK firmware for $(KEYBOARD) with keymap $(KEYMAP)..."
	@rm -rf $(QMK_DIR)/keyboards/$(KEYBOARD)
	@mkdir -p $(QMK_DIR)/keyboards/$(KEYBOARD)
	@cp -r keyboards/$(KEYBOARD)/qmk/* $(QMK_DIR)/keyboards/$(KEYBOARD)/
	$(MAKE) -C $(QMK_DIR) $(KEYBOARD):$(KEYMAP)

# Build Vial-enabled firmware
vial: git-submodule
	@echo "Building Vial-enabled firmware for $(KEYBOARD) with keymap $(KEYMAP)..."
	@rm -rf $(VIAL_DIR)/keyboards/$(KEYBOARD)
	@mkdir -p $(VIAL_DIR)/keyboards/$(KEYBOARD)
	@cp -r keyboards/$(KEYBOARD)/qmk/* $(VIAL_DIR)/keyboards/$(KEYBOARD)/
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
lint:
	@echo "Running QMK lint checks for keyboard $(KEYBOARD)..."
	@rm -rf $(QMK_DIR)/keyboards/$(KEYBOARD)
	@mkdir -p $(QMK_DIR)/keyboards/$(KEYBOARD)
	@cp -r keyboards/$(KEYBOARD)/qmk/qmk_firmware/* $(QMK_DIR)/keyboards/$(KEYBOARD)/
	QMK_HOME=$(QMK_DIR) cd $(QMK_DIR) && qmk lint -kb $(KEYBOARD)

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

# Ensure submodules are initialized before building
build: git-submodule
	@echo "Building firmware..."
	@QMK_HOME=$(QMK_PATH) qmk compile -kb $(KEYBOARD) -km $(KEYMAP)

git-submodule:
	git submodule update --remote
	git submodule update --init --recursive --depth 1
	cd qmk/qmk_firmware && git submodule update --init --recursive --depth 1
	cd vial/vial-qmk && git submodule update --init --recursive --depth 1 