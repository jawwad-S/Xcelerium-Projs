#include "framebuffer.h"
#include <fstream>
#include <iostream>

FrameBuffer::FrameBuffer(int w, int h) : width(w), height(h) {
    buffer = new Pixel*[h];
    for(int i=0;i<h;i++)
        buffer[i] = new Pixel[w];
}

FrameBuffer::~FrameBuffer() {
    for(int i=0;i<height;i++)
        delete[] buffer[i];
    delete[] buffer;
}

void FrameBuffer::loadPPM(const char *filename) {
    std::ifstream file(filename, std::ios::binary);
    std::string magic;
    file >> magic >> width >> height;
    int maxVal;
    file >> maxVal;
    file.ignore(1);

    buffer = new Pixel*[height];
    for(int i=0;i<height;i++)
        buffer[i] = new Pixel[width];

    for(int y=0;y<height;y++)
        for(int x=0;x<width;x++){
            uint8_t rgb[3];
            file.read((char*)rgb,3);
            buffer[y][x] = {rgb[0], rgb[1], rgb[2]};
        }
}

void FrameBuffer::savePPM(const char *filename) {
    std::ofstream out(filename, std::ios::binary);
    out << "P6\n" << width << " " << height << "\n255\n";

    for(int y=0;y<height;y++)
        for(int x=0;x<width;x++){
            uint8_t rgb[3] = {
                buffer[y][x].r,
                buffer[y][x].g,
                buffer[y][x].b
            };
            out.write((char*)rgb,3);
        }
}

