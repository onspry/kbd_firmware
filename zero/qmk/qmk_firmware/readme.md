# Zero Keyboard

A custom mechanical keyboard designed for optimal typing experience and ergonomics.

- Keyboard Maintainer: [Onspry](https://github.com/onspry)
- Hardware Supported: Zero PCB, Pro Micro compatible controllers
- Hardware Availability: [GitHub](https://github.com/onspry/kbd_firmware)

Make example for this keyboard (after setting up your build environment):

    make zero:default

Flashing example for this keyboard:

    make zero:default:flash

See the [build environment setup](https://docs.qmk.fm/#/getting_started_build_tools) and the [make instructions](https://docs.qmk.fm/#/getting_started_make_guide) for more information. Brand new to QMK? Start with our [Complete Newbs Guide](https://docs.qmk.fm/#/newbs).

## Bootloader

Enter the bootloader in 3 ways:

- **Bootmagic reset**: Hold down the key at (0,0) in the matrix (usually the top left key) and plug in the keyboard
- **Physical reset button**: Briefly press the button on the back of the PCB
- **Keycode in layout**: Press the key mapped to `QK_BOOT`
