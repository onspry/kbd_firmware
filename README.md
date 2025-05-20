## Setup

1. Clone repo with submodules:
   ```bash
   git clone --recurse-submodules [repo_url]
   ```

You can also use the Makefile for common development tasks:

## Makefile Usage

- **Build all firmware (QMK and Vial, both halves):**

  ```sh
  make all
  ```

- **Build only QMK firmware:**

  ```sh
  make qmk
  ```

- **Build only Vial firmware:**

  ```sh
  make vial
  ```

- **Build left/right halves individually:**

  ```sh
  make qmk-left
  make qmk-right
  make vial-left
  make vial-right
  ```

- **Clean all build files:**

  ```sh
  make clean
  ```

- **Flash firmware (keyboard must be in bootloader mode):**

  ```sh
  make flash         # QMK firmware
  make flash-vial    # Vial firmware
  ```

- **List available keyboards:**

  ```sh
  make list
  ```

- **Run code linting:**

  ```sh
  make lint
  ```

- **Show all available targets and usage:**

  ```sh
  make help
  ```

- **First-time setup (initialize submodules, etc):**

  ```sh
  make setup
  ```

- **Prepare files for QMK PR submission:**
  ```sh
  make prepare-pr
  ```

**Tip:**  
You can override variables like `KEYBOARD` and `KEYMAP` on the command line:

```sh
make qmk KEYBOARD=onspry_tmp/zero/rev1 KEYMAP=default
```

See the Makefile for more advanced options and details.

qmk
make git-submodule
