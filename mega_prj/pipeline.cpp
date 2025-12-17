// pipeline.cpp

#include "pipeline.h"

void Pipeline::addFilter(Filter* f){
    filters[filterCount++] = f;
}

void Pipeline::run(FrameBuffer &fb){
    for(int i=0;i<filterCount;i++)
        filters[i]->apply(fb);
}
