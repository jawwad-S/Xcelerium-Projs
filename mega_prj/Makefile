all:program

program: main.o framebuffer.o filter.o pipeline.o
	g++ main.o framebuffer.o filter.o pipeline.o -o program

main.o: main.cpp pipeline.h framebuffer.h
	g++ -c main.cpp

framebuffer.o: framebuffer.cpp framebuffer.h
	g++ -c framebuffer.cpp

filter.o: filter.cpp filter.h
	g++ -c filter.cpp

pipeline.o: pipeline.cpp pipeline.h
	g++ -c pipeline.cpp

clean:
	rm -f *.o program
