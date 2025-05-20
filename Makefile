# QMK/Vial Firmware Makefile

# Variables - customize these for your keyboard/keymap
KEYBOARD ?= onspry_tmp/zero/rev1
KEYMAP ?= default
QMK_DIR ?= ./qmk/qmk_firmware
VIAL_DIR ?= ./vial/vial-qmk
BUILD_DIR ?= ./.build
PR_DIR ?= ./pr_submission

# Phony targets
.PHONY: all qmk vial clean flash flash-vial list debug lint help git-submodule init-qmk init-vial setup qmk-left qmk-right vial-left vial-right prepare-pr

# Default target
all: qmk vial # Build both left and right QMK firmware versions

# Build firmware versions
qmk: qmk-left qmk-right  # Initialize QMK and build both left and right versions
vial: vial-left vial-right  # Initialize Vial and build both left and right versions

# First time setup and git submodule initialization
setup: git-submodule
	@echo "First time setup completed. You can now use other make commands."

# Initialize QMK directory with keyboard files
init-qmk:
	@echo "Initializing QMK directory with keyboard files..."
	@rm -rf $(QMK_DIR)/keyboards/onspry_tmp
	@mkdir -p $(QMK_DIR)/keyboards/onspry_tmp/zero
	@cp -r zero/qmk/qmk_firmware/ $(QMK_DIR)/keyboards/onspry_tmp/zero/
	@find $(QMK_DIR)/keyboards/onspry_tmp -name ".DS_Store" -delete
	@echo "Cleaning local build directory..."
	@rm -rf $(BUILD_DIR)/qmk_firmware*
	@mkdir -p $(BUILD_DIR)/qmk_firmware

# Initialize Vial directory with keyboard files
init-vial:
	@echo "Initializing Vial directory with keyboard files..."
	@rm -rf $(VIAL_DIR)/keyboards/onspry_tmp
	@mkdir -p $(VIAL_DIR)/keyboards/onspry_tmp/zero
	@cp -r zero/qmk/qmk_firmware/ $(VIAL_DIR)/keyboards/onspry_tmp/zero/
	@cp -r zero/vial/vial-qmk/keymaps $(VIAL_DIR)/keyboards/onspry_tmp/zero/
	@find $(VIAL_DIR)/keyboards/onspry_tmp -name ".DS_Store" -delete
	@rm -rf $(BUILD_DIR)/vial_firmware
	@mkdir -p $(BUILD_DIR)/vial_firmware

# Define a function to build firmware with parameters
define build_qmk_firmware
	@echo "Building QMK firmware for $(KEYBOARD) with keymap $(KEYMAP) - $(1) version..."
	$(MAKE) -C $(QMK_DIR) $(KEYBOARD):$(KEYMAP) MASTER_LEFT=$(2)
	@for file in $(QMK_DIR)/.build/onspry_tmp*.uf2; do \
		if [ -f "$$file" ]; then \
			target="$${file%.*}"; \
			target="$${target//_tmp/}"; \
			mv "$$file" "$${target}_$(1).uf2"; \
		fi \
	done
	@mkdir -p $(BUILD_DIR)/qmk_firmware
	@cp $(QMK_DIR)/.build/*_$(1).uf2 $(BUILD_DIR)/qmk_firmware 2>/dev/null || echo "No .uf2 files found"
endef

# Define a function to build Vial firmware with parameters
define build_vial_firmware
	@echo "Building Vial firmware for $(KEYBOARD) with keymap vial - $(1) version..."
	$(MAKE) -C $(VIAL_DIR) $(KEYBOARD):vial MASTER_LEFT=$(2)
	@for file in $(VIAL_DIR)/.build/onspry_tmp*.uf2; do \
		if [ -f "$$file" ]; then \
			target="$${file%.*}"; \
			target="$${target//_tmp/}"; \
			mv "$$file" "$${target}_$(1).uf2"; \
		fi \
	done
	@mkdir -p $(BUILD_DIR)/vial_firmware
	@cp $(VIAL_DIR)/.build/*_$(1).uf2 $(BUILD_DIR)/vial_firmware 2>/dev/null || echo "No .uf2 files found"
endef

# Build standard QMK firmware - Left version
qmk-left: init-qmk
	@echo "Cleaning before left build..."
	$(MAKE) clean
	$(call build_qmk_firmware,left,true)

# Build standard QMK firmware - Right version
qmk-right: init-qmk
	@echo "Cleaning before right build..."
	$(MAKE) clean
	$(call build_qmk_firmware,right,false)

# Build Vial-enabled firmware - Left version
vial-left: init-vial
	@echo "Cleaning before left Vial build..."
	$(MAKE) clean
	$(call build_vial_firmware,left,true)

# Build Vial-enabled firmware - Right version
vial-right: init-vial
	@echo "Cleaning before right Vial build..."
	$(MAKE) clean
	$(call build_vial_firmware,right,false)

# Build both Vial versions
vial: vial-left vial-right

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

# Run lint/code checks
lint: init-qmk
	@echo "Running QMK lint checks for keyboard $(KEYBOARD)..."
	QMK_HOME=$(QMK_DIR) cd $(QMK_DIR) && qmk lint -kb $(KEYBOARD)

# Help message
help:
	@echo "QMK/Vial Firmware Build System"
	@echo "============================="
	@echo "Available targets:"
	@echo "  all        - Build both left and right QMK firmware versions"
	@echo "  qmk        - Build both left and right QMK firmware versions (same as 'all')"
	@echo "  qmk-left   - Build QMK firmware for left half only"
	@echo "  qmk-right  - Build QMK firmware for right half only"
	@echo "  vial       - Build both left and right Vial-enabled firmware versions"
	@echo "  vial-left  - Build Vial-enabled firmware for left half only"
	@echo "  vial-right - Build Vial-enabled firmware for right half only"
	@echo "  clean      - Clean all build files (QMK and Vial)"
	@echo "  flash      - Flash standard QMK firmware"
	@echo "  flash-vial - Flash Vial-enabled firmware"
	@echo "  list       - List all available keyboards in QMK and Vial"
	@echo "  debug      - Build QMK firmware with debugging enabled"
	@echo "  vial-json  - Compile Vial JSON definition (if needed)"
	@echo "  lint       - Run QMK code quality checks"
	@echo "  setup      - First-time setup and git submodule initialization"
	@echo "  help       - Show this help message"
	@echo ""
	@echo "Variables (can be overridden):"
	@echo "  KEYBOARD   = $(KEYBOARD)   # Keyboard target"
	@echo "  KEYMAP     = $(KEYMAP)     # Keymap to build"
	@echo "  QMK_DIR    = $(QMK_DIR)    # QMK firmware directory"
	@echo "  VIAL_DIR   = $(VIAL_DIR)   # Vial firmware directory"
	@echo "  BUILD_DIR  = $(BUILD_DIR)  # Output directory for built firmware"
	@echo ""
	@echo "Example usage:"
	@echo "  make all                   # Build both left and right QMK versions"
	@echo "  make qmk-left              # Build only left QMK version"
	@echo "  make qmk-right             # Build only right QMK version"
	@echo "  make vial                  # Build both left and right Vial versions"
	@echo "  make vial-left             # Build only left Vial version"
	@echo "  make vial-right            # Build only right Vial version"

# Update git submodules (only needed for setup or explicit updates)
git-submodule:
	@echo "Updating git submodules..."
	git submodule update --remote
	git submodule update --init --recursive --depth 1
	cd qmk/qmk_firmware && git submodule update --init --recursive --depth 1
	cd vial/vial-qmk && git submodule update --init --recursive --depth 1

# Prepare files for QMK PR submission
prepare-pr:
	@echo "Preparing files for QMK PR submission..."
	@rm -rf $(PR_DIR)
	@mkdir -p $(PR_DIR)/keyboards/onspry/zero
	
	# Copy keyboard files
	@cp -r zero/qmk/qmk_firmware/rev1 $(PR_DIR)/keyboards/onspry/zero/
	@cp -r zero/qmk/qmk_firmware/keymaps $(PR_DIR)/keyboards/onspry/zero/
	
	# Create required files
	@echo "# Zero\n\nA split ergonomic keyboard with 43 keys.\n\n* Keyboard Maintainer: [onspry](https://github.com/onspry)\n* Hardware Supported: RP2040\n* Hardware Availability: [GitHub](https://github.com/onspry/zero)\n\nMake example for this keyboard (after setting up your build environment):\n\n    make onspry/zero/rev1:default\n\nFlashing example for this keyboard:\n\n    make onspry/zero/rev1:default:flash\n\nSee the [build environment setup](https://docs.qmk.fm/#/getting_started_build_tools) and the [make instructions](https://docs.qmk.fm/#/getting_started_make_guide) for more information. Brand new to QMK? Start with our [Complete Newbs Guide](https://docs.qmk.fm/#/newbs)." > $(PR_DIR)/keyboards/onspry/zero/readme.md
	
	# Create info.json in the root directory
	@cp zero/qmk/qmk_firmware/info.json $(PR_DIR)/keyboards/onspry/zero/
	
	# Create rules.mk in the root directory
	@echo "# MCU name\nMCU = RP2040\n\n# Bootloader selection\nBOOTLOADER = rp2040\n\nDEFAULT_FOLDER = onspry/zero/rev1" > $(PR_DIR)/keyboards/onspry/zero/rules.mk
	
	# Create keyboard.c and keyboard.h
	@echo "/* Copyright 2024 Onspry\n *\n * This program is free software: you can redistribute it and/or modify\n * it under the terms of the GNU General Public License as published by\n * the Free Software Foundation, either version 2 of the License, or\n * (at your option) any later version.\n *\n * This program is distributed in the hope that it will be useful,\n * but WITHOUT ANY WARRANTY; without even the implied warranty of\n * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n * GNU General Public License for more details.\n *\n * You should have received a copy of the GNU General Public License\n * along with this program.  If not, see <http://www.gnu.org/licenses/>.\n */\n\n#include \"quantum.h\"\n\nvoid keyboard_pre_init_kb(void) {\n    // Call the keyboard pre init code.\n    keyboard_pre_init_user();\n}\n" > $(PR_DIR)/keyboards/onspry/zero/keyboard.c
	@echo "/* Copyright 2024 Onspry\n *\n * This program is free software: you can redistribute it and/or modify\n * it under the terms of the GNU General Public License as published by\n * the Free Software Foundation, either version 2 of the License, or\n * (at your option) any later version.\n *\n * This program is distributed in the hope that it will be useful,\n * but WITHOUT ANY WARRANTY; without even the implied warranty of\n * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n * GNU General Public License for more details.\n *\n * You should have received a copy of the GNU General Public License\n * along with this program.  If not, see <http://www.gnu.org/licenses/>.\n */\n\n#pragma once\n\n#include \"quantum.h\"\n\n/* This is a shortcut to help you visually see your layout.\n *\n * The first section contains all of the arguments representing the physical\n * layout of the board and position of the keys.\n *\n * The second converts the arguments into a two-dimensional array which\n * represents the switch matrix.\n */\n\n#define LAYOUT(\n    L00, L01, L02, L03, L04, L05,           R00, R01, R02, R03, R04, R05, \\\n    L10, L11, L12, L13, L14, L15,           R10, R11, R12, R13, R14, R15, \\\n    L20, L21, L22, L23, L24, L25,           R20, R21, R22, R23, R24, R25, \\\n                   L30, L31, L32,           R30, R31, R32 \\\n) \\\n{ \\\n    { L00, L01, L02, L03, L04, L05, KC_NO }, \\\n    { L10, L11, L12, L13, L14, L15, KC_NO }, \\\n    { L20, L21, L22, L23, L24, L25, KC_NO }, \\\n    { KC_NO, KC_NO, KC_NO, L30, L31, L32, KC_NO }, \\\n    { R00, R01, R02, R03, R04, R05, KC_NO }, \\\n    { R10, R11, R12, R13, R14, R15, KC_NO }, \\\n    { R20, R21, R22, R23, R24, R25, KC_NO }, \\\n    { KC_NO, KC_NO, KC_NO, R30, R31, R32, KC_NO } \\\n}\n" > $(PR_DIR)/keyboards/onspry/zero/keyboard.h
	
	# Clean up any macOS files
	@find $(PR_DIR) -name ".DS_Store" -delete
	
	@echo "PR submission files prepared in $(PR_DIR)"
	@echo "To submit to QMK:"
	@echo "1. Fork the QMK repository on GitHub"
	@echo "2. Clone your fork locally"
	@echo "3. Copy the contents of $(PR_DIR) to your local QMK fork"
	@echo "4. Commit and push changes to your fork"
	@echo "5. Create a Pull Request on GitHub" 