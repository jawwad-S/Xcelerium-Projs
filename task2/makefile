#MakeFile Example
all: task2_b calc
calc: calc.o 
	 g++ calc.o -o calc
task2_b: task2_b.o
	g++ task2_b.o -o task2_b
	 
calc.o: calc.cpp 
	 g++ -c calc.cpp

task2_b.o: task2_b.cpp
	g++ -c task2_b.cpp
clean:
	rm -f* .0 program

