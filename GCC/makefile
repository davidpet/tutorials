all: test.exe

test.exe: main.o MyClass.o
	g++ -g -o test.exe $^

main.o: main.cpp MyClass/MyClass.h
	g++ -Wall -g -c -I MyClass $<

MyClass.o: MyClass/MyClass.cpp MyClass/MyClass.h
	g++ -Wall -g -c $<

clean:
	rm -rf test.exe test.exe.dSYM main.o MyClass.o
