#include "pipeline.h"
#include <utility>

using namespace hardware::pipeline;

void Pipeline::addStage(Filter *f) {
    stages[stageCount++] = f;
}

void Pipeline::run(Buffer &input, Buffer &output) {
    Buffer reg1(input.width, input.height);
    Buffer reg2(input.width, input.height);

    Buffer *in = &input;
    Buffer *out = &reg1;

    for(int i=0;i<stageCount;i++){
        stages[i]->apply(*in, *out);
        std::swap(in, out);   // pipeline register swap
    }

    for(int i=0;i<input.width*input.height;i++)
        output.data[i] = in->data[i];
}

