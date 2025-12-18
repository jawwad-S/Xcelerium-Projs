#ifndef PIPELINE_H
#define PIPELINE_H

#include "filter.h"

namespace hardware {
namespace pipeline {

class Pipeline {
public:
    Filter *stages[5];
    int stageCount = 0;

    void addStage(Filter *f);
    void run(Buffer &input, Buffer &output);
};

} }

#endif

