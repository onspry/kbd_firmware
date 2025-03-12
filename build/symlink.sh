# Example: Symlink your keyboard directory to QMK
ln -sf ../../keyboards/Typoono qmk/qmk_firmware/keyboards/thypoono

# Build the firmware
cd qmk/qmk_firmware
make thypoono:default

