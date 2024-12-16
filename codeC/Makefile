all : exe

fileCreation.o: fileCreation.c fileCreation.h
	gcc -c $< -o $@

foncAvl.o: foncAvl.c foncAvl.h
	gcc -c $< -o $@

AvlTravel.o: AvlTravel.c AvlTravel.h
	gcc -c $< -o $@

main.o: main.c fileCreation.h
	gcc -c $< -o $@

exe: main.o AvlTravel.o foncAvl.o fileCreation.o
	gcc $^ -o $@

clean:
	rm -f *.o
	rm exe
