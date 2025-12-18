all:program

program: main.o framebuffer.o pipeline.o filters.o
	g++ main.o framebuffer.o pipeline.o filters.o -o program

main.o: main.cpp pipeline.h framebuffer.h filter.h
	g++ -c main.cpp

framebuffer.o: framebuffer.cpp framebuffer.h
	g++ -c framebuffer.cpp

filters.o: filters.cpp filter.h
	g++ -c filters.cpp

pipeline.o: pipeline.cpp pipeline.h
	g++ -c pipeline.cpp

clean:
	rm -f *.o program
