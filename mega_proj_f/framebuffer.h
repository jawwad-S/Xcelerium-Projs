#ifndef FRAMEBUFFER_H
#define FRAMEBUFFER_H

#include "pixel.h"

class FrameBuffer {
public:
    int width, height;
    Pixel **buffer;

    FrameBuffer(int w, int h);
    ~FrameBuffer();

    void loadPPM(const char *filename);
    void savePPM(const char *filename);
};

#endif

