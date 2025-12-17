// pixel.h
#ifndef PIXEL_H
#define PIXEL_H

#include <stdint.h>

struct Pixel {
    uint8_t r, g, b;

    Pixel() : r(0), g(0), b(0) {}
    Pixel(uint8_t rr, uint8_t gg, uint8_t bb) : r(rr), g(gg), b(bb) {}
};

#endif
