// filters.h
#ifndef FILTERS_H
#define FILTERS_H

#include "framebuffer.h"
#include <cmath>

class Filter {
public:
    virtual void apply(FrameBuffer &fb) = 0;
};

class GrayScaleFilter : public Filter {
public:
    void apply(FrameBuffer &fb) override;
};

class InvertFilter : public Filter {
public:
    void apply(FrameBuffer &fb) override;
};

class BlurFilter : public Filter {
public:
    void apply(FrameBuffer &fb) override;
};

class SobelFilter : public Filter {
public:
    void apply(FrameBuffer &fb) override;
};

#endif
