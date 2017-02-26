LINK_TARGET = test.exe
OBJECT_FILES = main.o MyClass.o
BUILDABLES = $(LINK_TARGET) $(OBJECT_FILES) $(LINK_TARGET).dSYM
INCLUDES = -I MyClass
COMPILE_COMMAND = g++ -Wall -g -c $(INCLUDES) $<

all: $(LINK_TARGET) 

$(LINK_TARGET):  $(OBJECT_FILES)
	g++ -g -o $@ $^

main.o: main.cpp
	$(COMPILE_COMMAND)

MyClass.o: MyClass/MyClass.cpp
	$(COMPILE_COMMAND)

MyClass.o: MyClass/MyClass.h
main.o: MyClass/MyClass.h

clean:
	rm -rf $(BUILDABLES)
