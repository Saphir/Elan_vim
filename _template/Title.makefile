SRC := 
TARGET := a.out
DEPENDS := 

$(TARGET): $(SRC) $(DEPENDS)
	g++ --std=c++11 $(SRC) -o $(TARGET) 

demo: $(TARGET)
	./$(TARGET)

e:
	vim $(SRC) $(DEPENDS)

clean:
	rm $(TARGET)

