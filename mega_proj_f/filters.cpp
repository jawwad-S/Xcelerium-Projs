#include "filter.h"
#include "kernel.h"
#include <cmath>
#include <algorithm>

using namespace hardware::pipeline;

// ================= CONVERT =================
void ConvertFilter ::apply(Buffer &in, Buffer &out)  {
        for(int y=0;y<in.height;y++)
            for(int x=0;x<in.width;x++){
                Pixel p = in.at(x,y);
                uint8_t g = (p.r + p.g + p.b) / 3;
                out.at(x,y) = {g,g,g};
            }
};

// ================= BLUR ================


void BlurFilter ::apply(Buffer &in, Buffer &out)  {

ConvKernel blurKernel;
blurKernel.size = 3;
blurKernel.data = new int[9]{1,1,1,1,1,1,1,1,1};

       /* for(int y=1;y<in.height-1;y++)
            for(int x=1;x<in.width-1;x++){
                int sum = 0;
                for(int ky=-1;ky<=1;ky++)
                    for(int kx=-1;kx<=1;kx++)
                        sum += in.at(x+kx,y+ky).r;
                uint8_t avg = sum / 9;
                out.at(x,y) = {avg,avg,avg};
            }*/

	int half = blurKernel.size / 2;
for(int y=0; y<in.height; y++){
    for(int x=0; x<in.width; x++){
        int sum = 0;
        for(int ky=0; ky<blurKernel.size; ky++){
            for(int kx=0; kx<blurKernel.size; kx++){
                int nx = x + kx - half;
                int ny = y + ky - half;
                if(nx>=0 && nx<in.width && ny>=0 && ny<in.height){
                    sum += in.at(nx, ny).r * blurKernel.data[ky*blurKernel.size + kx];
                }
            }
        }
        uint8_t avg = sum / 9;
        out.at(x,y) = {avg, avg, avg};
    }
}
delete[] blurKernel.data;

};

// ================= SOBEL =================



void SobelFilter ::apply(Buffer &in, Buffer &out) {

ConvKernel Gx = {3, new int[9]{-1,0,1,-2,0,2,-1,0,1}};
ConvKernel Gy = {3, new int[9]{-1,-2,-1,0,0,0,1,2,1}};

    //    int Gx[3][3]={{-1,0,1},{-2,0,2},{-1,0,1}};
    //    int Gy[3][3]={{-1,-2,-1},{0,0,0},{1,2,1}};

      /*  for(int y=1;y<in.height-1;y++)
            for(int x=1;x<in.width-1;x++){
                int sx=0, sy=0;
                for(int ky=-1;ky<=1;ky++)
                    for(int kx=-1;kx<=1;kx++){
                        int v = in.at(x+kx,y+ky).r;
                        sx += v * Gx[ky+1][kx+1];
                        sy += v * Gy[ky+1][kx+1];
                    }
                   
		int mag = std::min(255, abs(sx)+abs(sy));
		uint8_t val = static_cast<uint8_t>(mag);
		out.at(x,y) = {val, val, val};

            }*/

	int half = Gx.size / 2;
for(int y=0; y<in.height; y++){
    for(int x=0; x<in.width; x++){
        int sx=0, sy=0;
        for(int ky=0; ky<Gx.size; ky++){
            for(int kx=0; kx<Gx.size; kx++){
                int nx = x + kx - half;
                int ny = y + ky - half;
                if(nx>=0 && nx<in.width && ny>=0 && ny<in.height){
                    int v = in.at(nx, ny).r;
                    sx += v * Gx.data[ky*Gx.size + kx];
                    sy += v * Gy.data[ky*Gy.size + kx];
                }
            }
        }
        int mag = std::min(255, abs(sx)+abs(sy));
        uint8_t val = static_cast<uint8_t>(mag);
        out.at(x,y) = {val, val, val};
    }
}
delete[] Gx.data;
delete[] Gy.data;

};

