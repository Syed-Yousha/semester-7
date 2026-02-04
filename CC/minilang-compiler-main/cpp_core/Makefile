# MiniLang Compiler - C++ Core
# Authors: Yousha Mehdi(22K-6007), Muhammad Yasir(22K-5090), Ghazi Abbass(22K-5041)

CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -O2
TARGET = minilang_compiler.exe

all: $(TARGET)

$(TARGET): main.cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) main.cpp

clean:
	del /Q $(TARGET)

.PHONY: all clean
