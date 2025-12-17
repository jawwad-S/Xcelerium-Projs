// framebuffer.cpp
#include "framebuffer.h"
#include <fstream>
#include <iostream>
using namespace std;

FrameBuffer::FrameBuffer(int w, int h) : width(w), height(h) {
    buffer = new Pixel*[height];
    for(int i = 0; i < height; i++)
        buffer[i] = new Pixel[width];
}

FrameBuffer::~FrameBuffer() {
    for(int i = 0; i < height; i++)
        delete[] buffer[i];
    delete[] buffer;
}

void FrameBuffer::loadPPM(const char* filename) {
    ifstream file(filename, ios::binary);
    if(!file) { cout << "Cannot open image!\n"; return; }

    string magic;
    file >> magic;
    if(magic != "P6") { cout << "Only P6 PPM supported!\n"; return; }

    file >> width >> height;
    int maxVal;
    file >> maxVal;
    file.ignore(1);

    buffer = new Pixel*[height];
    for(int i = 0; i < height; i++)
        buffer[i] = new Pixel[width];

    for(int i = 0; i < height; i++){
        for(int j = 0; j < width; j++){
            uint8_t rgb[3];
            file.read((char*)rgb, 3);
            buffer[i][j] = Pixel(rgb[0], rgb[1], rgb[2]);
        }
    }
}

void FrameBuffer::savePPM(const char* filename) {
    ofstream out(filename, ios::binary);
    out << "P6\n" << width << " " << height << "\n255\n";
    for(int i = 0; i < height; i++){
        for(int j = 0; j < width; j++){
            uint8_t rgb[3] = {buffer[i][j].r, buffer[i][j].g, buffer[i][j].b};
            out.write((char*)rgb, 3);
        }
    }
}

