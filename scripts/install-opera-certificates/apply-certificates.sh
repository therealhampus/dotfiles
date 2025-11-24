#!/bin/sh

echo "Current JAVA_HOME folder: $JAVA_HOME"
echo

for f in *.crt
do
    filename=${f%.*}
    echo "Adding $filename..."
    keytool -import -trustcacerts -alias $filename -file ./$f -cacerts -noprompt -storepass changeit
    #keytool -delete -alias $filename -cacerts -noprompt -storepass changeit
done

echo "All certificates added." 