SHELL = /bin/bash

OBJS = collector.py gathero.py relinkworkscratch.py setupcomsolsymlink.py setupcondasymlink.py updatekeys.py
PYTHON_PATH = /gpfs/group/dml129/default/sw7/python-3.9.4/bin/python3
NUITKA_FLAGS = --follow-imports

collector: collector.py
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} collector.py -o $@

gathero: gathero.py
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} gathero.py -o $@

relinkworkscratch: relinkworkscratch.py
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} relinkworkscratch.py -o $@

setupcomsolsymlink: setupcomsolsymlink.py
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} setupcomsolsymlink.py -o $@

setupcondasymlink: setupcondasymlink.py
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} setupcondasymlink.py -o $@

updatekeys: updatekeys.py
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} updatekeys.py -o $@

all:
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} collector.py -o collector
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} gathero.py -o gathero
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} relinkworkscratch.py -o relinkworkscratch
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} setupcomsolsymlink.py -o setupcomsolsymlink
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} setupcondasymlink.py -o setupcondasymlink
	${PYTHON_PATH} -m nuitka ${NUITKA_FLAGS} updatekeys.py -o updatekeys

clean:
	-rm -rf *.build

test:
	-./collector -h
	-./gathero -h
	-./relinkworkscratch -h
	-./setupcomsolsymlink -h
	-./setupcondasymlink -h
	-./updatekeys -h

install:
	-mkdir -p bin
	-mv collector bin
	-mv gathero bin
	-mv relinkworkscratch bin
	-mv setupcomsolsymlink bin
	-mv setupcondasymlink bin
	-mv updatekeys bin

uninstall:
	-rm -rf bin
