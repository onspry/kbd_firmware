/* Copyright 2024 onspry
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

// Hardware pin definitions
#define USB_VBUS_PIN GP13
#define SPLIT_HAND_PIN GP21  // Determines left/right side
#define SPLIT_HAND_PIN_HIGH_IS_LEFT  // Switch to high = left

// QMK handle the UART initialization
#define SERIAL_DRIVER SERIAL_DRIVER_UART
#define SERIAL_USART_FULL_DUPLEX
#undef SERIAL_DRIVER_VENDOR  // Explicitly disable PIO

// Left half (master) uses pins 4/5
#ifdef MASTER_LEFT
    #define SERIAL_USART_TX_PIN GP4
    #define SERIAL_USART_RX_PIN GP5
#else
    #define SERIAL_USART_TX_PIN GP24
    #define SERIAL_USART_RX_PIN GP25
#endif

// UART configuration - let QMK handle this
#define SERIAL_USART_SPEED 115200  // Lower baud rate for reliability
#define SERIAL_USART_TX_TIMEOUT 2000
#define SERIAL_USART_RX_TIMEOUT 2000

// Split keyboard timings - more lenient for better reliability
#define SPLIT_USB_DETECT
#define SPLIT_USB_TIMEOUT 2000
#define SPLIT_USB_DETECT_POLL_RATE 100
#define SPLIT_MAX_CONNECTION_ERRORS 30  // Very lenient
#define SPLIT_CONNECTION_CHECK_INTERVAL 100
#define SPLIT_STARTUP_DELAY 2000

/* RP2040-specific config */
#define RP2040_BOOTLOADER_DOUBLE_TAP_RESET
#define RP2040_BOOTLOADER_DOUBLE_TAP_RESET_TIMEOUT 500U
#define PICO_XOSC_STARTUP_DELAY_MULTIPLIER 64