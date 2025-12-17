// main.cpp
#include <iostream>
#include "pipeline.h"
#include "framebuffer.h"
using namespace std;

int main() {
    FrameBuffer fb(1,1);
    //fb.loadPPM("C:/Users/AK TECHNOLOGY/Downloads/cat.ppm");
     fb.loadPPM("cat.ppm");

    Pipeline p;

    GrayScaleFilter gray;
    InvertFilter invert;
    BlurFilter blur;
    SobelFilter sobel;

    p.addFilter(&gray);   // optional
   // p.addFilter(&invert); // optional
   // p.addFilter(&blur);   // optional
    p.addFilter(&sobel);  // optional
    p.addFilter(&invert);
    p.addFilter(&blur);

    p.run(fb);
    fb.savePPM("output_f1.ppm");
    cout << "Processing Complete! Saved as output_f1.ppm\n";
}
