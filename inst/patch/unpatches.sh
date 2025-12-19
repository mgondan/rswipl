#!/bin/sh
cd ../../src
patch -p2 -R < ../inst/patch/01-clib.patch
patch -p2 -R < ../inst/patch/01-cpp.patch
patch -p2 -R < ../inst/patch/01-swi.patch
patch -p2 -R < ../inst/patch/01-thread.patch
patch -p2 -R < ../inst/patch/02-clib.patch
patch -p2 -R < ../inst/patch/03-cpp.patch
patch -p2 -R < ../inst/patch/04-cpp.patch
patch -p2 -R < ../inst/patch/05-variant.patch
patch -p2 -R < ../inst/patch/06-incl.patch
patch -p2 -R < ../inst/patch/06-cont.patch
