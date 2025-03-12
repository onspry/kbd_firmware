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

#include_next <mcuconf.h>

// I2C configuration
#undef RP_I2C_USE_I2C1
#define RP_I2C_USE_I2C1 TRUE

// Enable hardware UART1 for split communication
#undef RP_UART_USE_UART1
#define RP_UART_USE_UART1 TRUE

// UART1 configuration for split
#define RP_UART1_PARITY UART_PARITY_NONE
#define RP_UART1_STOP_BITS UART_STOP_BITS_1
#define RP_UART1_DATA_BITS UART_DATA_BITS_8
#define RP_UART1_FLOW_CONTROL UART_FLOW_CONTROL_NONE
#define RP_UART1_BAUDRATE 115200  // Match the baudrate in config.h

// Enable USB for CDC
#undef RP_USB_USE_USBD
#define RP_USB_USE_USBD TRUE

// Enable PIO0 for LEDs and PIO1 for split communication
#undef RP_PIO_USE_PIO0
#define RP_PIO_USE_PIO0 TRUE   // Keep enabled for LED control


// Enable USB CDC for debug
#undef RP_USB_USE_USB1
#define RP_USB_USE_USB1 TRUE
