#!/bin/sh
cd ../../src
patch -p2 -R < ../inst/patch/02-clib.patch
patch -p2 -R < ../inst/patch/03-cpp.patch
patch -p2 -R < ../inst/patch/04-cpp.patch
patch -p2 -R < ../inst/patch/05-test-load-context.patch
patch -p2 -R < ../inst/patch/06-patch-qlf.patch
patch -p2 -R < ../inst/patch/07-init.patch
