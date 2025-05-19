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
 
#include "quantum.h"

#ifdef RGB_MATRIX_ENABLE
// RGB Matrix LED layout
// Physical layout for reference:
// Left half (23 LEDs)
// Right half (23 LEDs)
led_config_t g_led_config = {
    // Key matrix to LED index mapping
    {
        // Left half
        { 18, 17, 12,  11,  4,  3, NO_LED },
        { 19, 16, 13,  10,  5,  2, NO_LED },
        { 20, 15, 14,   9,  6,  1, NO_LED },
        { NO_LED, NO_LED, NO_LED, 8, 7, 0, NO_LED },
        // Right half
        { 41, 40, 35, 34, 27, 26, NO_LED },
        { 42, 39, 36, 33, 28, 25, NO_LED },
        { 43, 38, 37, 32, 29, 24, NO_LED },
        { NO_LED, NO_LED, NO_LED, 31, 30, 23, NO_LED }
    },
    // LED index to physical position
    {
        // Left half
        { 95, 63 }, { 85, 39 }, { 85, 21 }, { 85, 4 }, { 68, 2 }, { 68, 19 }, { 68, 37 }, { 80, 58 }, { 60, 55 }, { 50, 35 }, 
        { 50, 13 }, { 50, 0 }, { 33, 3 }, { 33, 20 }, { 33, 37 }, { 16, 42 }, { 16, 24 }, { 16, 7 }, { 0, 7 }, { 0, 24 }, 
        { 0, 41 }, { 103, 17 }, { 103, 24 },
        // Right half
        { 129, 63 }, { 139, 39 }, { 139, 21 }, { 139, 4 }, { 156, 2 }, { 156, 19 }, { 156, 37 }, { 144, 58 }, { 164, 55 }, { 174, 35 }, 
        { 174, 13 }, { 174, 0 }, { 191, 3 }, { 191, 20 }, { 191, 37 }, { 208, 42 }, { 208, 24 }, { 208, 7 }, { 224, 7 }, { 224, 24 }, 
        { 224, 41 }, { 122, 17 }, { 122, 24 }
    },
    // LED index to flag
    {
        // All LEDs use the same flags - all keys and underglow
        LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, 
        LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, 
        LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL,
        LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, 
        LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL, 
        LED_FLAG_ALL, LED_FLAG_ALL, LED_FLAG_ALL
    }
};
#endif // RGB_MATRIX_ENABLE
