#ifndef FILTER_H
#define FILTER_H

#include "buffer.h"

namespace hardware {
namespace pipeline {

struct Filter {
    virtual void apply(Buffer &in, Buffer &out) = 0;
};

struct ConvertFilter : public Filter {
    void apply(Buffer &in, Buffer &out) override;
};

struct BlurFilter : public Filter {
    void apply(Buffer &in, Buffer &out) override;
};

struct SobelFilter : public Filter {
    void apply(Buffer &in, Buffer &out) override;
};

} }

#endif

