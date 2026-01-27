#ifndef CONFIG_H
#define CONFIG_H

// String used to delimit block outputs in the status.
#define DELIMITER "  "

// Maximum number of Unicode characters that a block can output.
#define MAX_BLOCK_OUTPUT_LENGTH 17

// Control whether blocks are clickable.
#define CLICKABLE_BLOCKS 1

// Control whether a leading delimiter should be prepended to the status.
#define LEADING_DELIMITER 0

// Control whether a trailing delimiter should be appended to the status.
#define TRAILING_DELIMITER 0

// Define blocks for the status feed as X(icon, cmd, interval, signal).
#define BLOCKS(X)             \
    X("", "/home/xor/.config/dwmblocks-async/scripts/packagestoupdate", 3600, 18) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/memory", 30, 5) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/wifi", 10, 8) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/bluetooth", 10, 9) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/weather", 30, 10) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/disc", 900, 11) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/music", 30, 12) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/email", 30, 13) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/clipmenu", 0, 14) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/todolist", 30, 15) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/uptime", 30, 16) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/temp", 30, 17) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/moonphases", 30, 19) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/volume", 0, 7) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/battery", 10, 6) \
    X("", "/home/xor/.config/dwmblocks-async/scripts/time", 1, 4)  \


#endif  // CONFIG_H
