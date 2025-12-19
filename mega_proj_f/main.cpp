#include <iostream>
#include "framebuffer.h"
#include "pipeline.h"
#include "filter.h"

using namespace hardware::pipeline;

int main() {
    FrameBuffer fb(1,1);
    fb.loadPPM("cat.ppm");

    Buffer input(fb.width, fb.height);
    Buffer output(fb.width, fb.height);

    for(int y=0;y<fb.height;y++)
        for(int x=0;x<fb.width;x++)
            input.at(x,y) = fb.buffer[y][x];

    Pipeline p;
    ConvertFilter convert;
    BlurFilter blur;
    SobelFilter sobel;

    p.addStage(&convert);
    p.addStage(&blur);
    p.addStage(&sobel);

    p.run(input, output);

    for(int y=0;y<fb.height;y++)
        for(int x=0;x<fb.width;x++)
            fb.buffer[y][x] = output.at(x,y);

    fb.savePPM("output_c.ppm");
    std::cout << "output saved in output_c.ppm \n";

}

