JMESH=./JMeshLib-1.2/
JMESH_INC=-I${JMESH}/include/
JMESH_LIB=-L${JMESH}/lib/ -ljmesh
JMESHEXT=./JMeshExt-1.0alpha_src/
JMESHEXT_INC=-I${JMESHEXT}/include/
JMESHEXT_LIB=-L${JMESHEXT}/lib -ljmeshext
NL=./OpenNL3.2.1/build/Darwin-Release
SUPERLU_LIB=-L/usr/local/lib -lsuperlu
NL_LIB=-L${NL}/binaries/lib/ -lnl ${SUPERLU_LIB} -framework Accelerate
JMESHEXT_LIB=-L${JMESHEXT}/lib -ljmeshext
LIBIGL_INCLUDE=-I${LIBIGL}/include/

INC=${JMESH_INC} ${JMESHEXT_INC}
LIB=${JMESH_LIB} ${JMESHEXT_LIB} ${NL_LIB}

CFLAGS+=-DIS64BITPLATFORM
OPTFLAGS+=-O3

meshfix: meshfix.o main.cpp
	g++ ${OPTFLAGS} -c main.cpp -o main.o ${INC} ${CFLAGS}
	g++ -o meshfix main.o meshfix.o ${LIB}

libigl_example: libmeshfix.a libigl_example.cpp
	g++ -std=c++11 ${OPTFLAGS} -c libigl_example.cpp -o libigl_example.o ${INC} ${CFLAGS} ${LIBIGL_INCLUDE}
	g++ -o libigl_example libigl_example.o libmeshfix.a ${LIB}

meshfix.o: meshfix.cpp meshfix.h
	g++ ${OPTFLAGS} -c meshfix.cpp -o meshfix.o ${INC} ${CFLAGS}

libmeshfix.a: meshfix.o
	ar rvs $@ meshfix.o

clean:
	rm -f libmeshfix.a
	rm -f meshfix.o main.o
	rm -f meshfix
