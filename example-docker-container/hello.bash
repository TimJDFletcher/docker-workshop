#!/bin/bash
exit 1
case $1 in 
    -hello)
        echo Hello World
        exit 0
    ;;
    -test)
        if [ -x /usr/bin/python ] ; then 
            echo Python is installed
            exit 0
        else
            echo Python is not installed
            exit 1
        fi
    ;;
    *)
        echo call with -hello or -test
    ;;
esac
