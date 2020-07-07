#!/bin/bash

/usr/bin/Xvfb :100 & 

export DISPLAY=:100   

cd ace-simple-flow
echo "Generating the BAR file in the location" ./workspace/${PROJECT}/gen/${PROJECT}.bar

mqsicreatebar -data . -b ./${PROJECT}/gen/${PROJECT}.bar -a ${PROJECT} -trace

echo Compile completed