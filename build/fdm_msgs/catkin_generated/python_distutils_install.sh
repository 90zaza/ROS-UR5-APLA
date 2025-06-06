#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/tim/FDMPrinting/src/fdm_msgs"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/tim/FDMPrinting/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/tim/FDMPrinting/install/lib/python3/dist-packages:/home/tim/FDMPrinting/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/tim/FDMPrinting/build" \
    "/usr/bin/python3" \
    "/home/tim/FDMPrinting/src/fdm_msgs/setup.py" \
     \
    build --build-base "/home/tim/FDMPrinting/build/fdm_msgs" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/tim/FDMPrinting/install" --install-scripts="/home/tim/FDMPrinting/install/bin"
