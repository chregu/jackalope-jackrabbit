#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pidfile=${TMPDIR:-/tmp}/jack.pid

# kills jackrabbit and sleeps till process dies
# prints the id of the process previously active process (or empty if it wasn't running)
stop_jackrabbit() {
    local id=$(cat $pidfile 2>/dev/null)

    if [ -n "$id" ]; then
        kill $id 2>/dev/null

        # wait till process dies
        kill -0 $id
        while [[ $? -eq 0 ]]; do
            sleep 1
            kill -0 $id 2>/dev/null
        done
    fi
    rm -f $pidfile
    echo $id
}

cd $DIR

VERSION=2.4.1

JAR=jackrabbit-standalone-$VERSION.jar

if [ ! -f "$DIR/$JAR" ]; then
    wget http://mirror.switch.ch/mirror/apache/dist/jackrabbit/$VERSION/$JAR
fi

if [ -e $pidfile ]; then
    echo "jackrabbit seems to be running ($pidfile)"
    echo "killing and restarting it"
    stop_jackrabbit
fi

java -jar $DIR/$JAR&
echo $! > $pidfile

echo "Waiting until Jackrabbit is ready on port 8080"
while [[ -z `curl -s 'http://localhost:8080' ` ]]
do
        echo -n "."
        sleep 2s
done

echo "Jackrabbit is up"
