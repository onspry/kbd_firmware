/* Copyright 2024 Onspry
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#pragma once

// Enable required HAL subsystems
// #define HAL_USE_I2C TRUE    // For OLED displays and other I2C devices
// #define HAL_USE_PAL TRUE    // Required for GPIO control
// #define HAL_USE_PIO TRUE    // For LED control
// #define HAL_USE_USB TRUE    // For USB CDC debug
#define HAL_USE_SERIAL_USB TRUE  // For USB CDC ACM

// Enable callbacks
// #define PAL_USE_CALLBACKS TRUE

// Disable standard serial driver since we're using the vendor driver
// #define HAL_USE_SERIAL FALSE

// Enable USB serial for debug output
// #define HAL_USE_USB_CDC TRUE

#include_next <halconf.h>