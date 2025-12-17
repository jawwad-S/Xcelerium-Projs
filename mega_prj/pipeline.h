// pipeline.h
#ifndef PIPELINE_H
#define PIPELINE_H

#include "filter.h"

class Pipeline {
public:
    Filter* filters[5];
    int filterCount=0;
    void addFilter(Filter* f);
    void run(FrameBuffer &fb);
};

#endif
