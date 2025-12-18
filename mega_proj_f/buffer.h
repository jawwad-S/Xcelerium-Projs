#ifndef BUFFER_H
#define BUFFER_H

#include "pixel.h"

struct Buffer {
    Pixel *data;
    int width, height;

    Buffer(int w, int h) : width(w), height(h) {
        data = new Pixel[w * h];
    }

    ~Buffer() {
        delete[] data;
    }

    Pixel& at(int x, int y) {
        return data[y * width + x];
    }
};

#endif

