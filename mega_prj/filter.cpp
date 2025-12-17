// filters.cpp
#include "filter.h"
#include <algorithm>

// GRAYSCALE
void GrayScaleFilter::apply(FrameBuffer &fb) {
    for(int i = 0; i < fb.height; i++){
        for(int j = 0; j < fb.width; j++){
            Pixel &p = fb.buffer[i][j];
            uint8_t gray = (p.r + p.g + p.b)/3;
            p.r = p.g = p.b = gray;
        }
    }
}

// INVERT
void InvertFilter::apply(FrameBuffer &fb) {
    for(int i = 0; i < fb.height; i++){
        for(int j = 0; j < fb.width; j++){
            Pixel &p = fb.buffer[i][j];
            p.r = 255 - p.r;
            p.g = 255 - p.g;
            p.b = 255 - p.b;
        }
    }
}

// BLUR (3x3 Average)
void BlurFilter::apply(FrameBuffer &fb) {
    int w = fb.width, h = fb.height;
    Pixel **temp = new Pixel*[h];
    for(int i=0;i<h;i++) temp[i] = new Pixel[w];

    for(int y=0;y<h;y++){
        for(int x=0;x<w;x++){
            int r=0,g=0,b=0,count=0;
            for(int dy=-1;dy<=1;dy++){
                for(int dx=-1;dx<=1;dx++){
                    int nx = x+dx, ny = y+dy;
                    if(nx>=0 && nx<w && ny>=0 && ny<h){
                        Pixel &p = fb.buffer[ny][nx];
                        r += p.r; g += p.g; b += p.b; count++;
                    }
                }
            }
            temp[y][x].r = r/count;
            temp[y][x].g = g/count;
            temp[y][x].b = b/count;
        }
    }

    for(int i=0;i<h;i++)
        for(int j=0;j<w;j++)
            fb.buffer[i][j] = temp[i][j];

    for(int i=0;i<h;i++) delete[] temp[i];
    delete[] temp;
}

// SOBEL
void SobelFilter::apply(FrameBuffer &fb) {
    int w = fb.width, h = fb.height;
    int Gx[3][3] = {{-1,0,1},{-2,0,2},{-1,0,1}};
    int Gy[3][3] = {{-1,-2,-1},{0,0,0},{1,2,1}};
    Pixel **temp = new Pixel*[h]; for(int i=0;i<h;i++) temp[i] = new Pixel[w];

    for(int y=1;y<h-1;y++){
        for(int x=1;x<w-1;x++){
            int sumX=0,sumY=0;
            for(int ky=-1;ky<=1;ky++){
                for(int kx=-1;kx<=1;kx++){
                    Pixel &p = fb.buffer[y+ky][x+kx];
                    int gray = (p.r+p.g+p.b)/3;
                    sumX += gray*Gx[ky+1][kx+1];
                    sumY += gray*Gy[ky+1][kx+1];
                }
            }
            int mag = std::min(std::max(int(sqrt(sumX*sumX + sumY*sumY)),0),255);
            temp[y][x].r = temp[y][x].g = temp[y][x].b = mag;
        }
    }

    for(int y=0;y<h;y++)
        for(int x=0;x<w;x++)
            fb.buffer[y][x] = temp[y][x];

    for(int i=0;i<h;i++) delete[] temp[i];
    delete[] temp;
}
