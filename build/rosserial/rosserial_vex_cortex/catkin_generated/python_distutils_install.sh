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

echo_and_run cd "/home/jonny/veg_picker/src/rosserial/rosserial_vex_cortex"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/jonny/veg_picker/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/jonny/veg_picker/install/lib/python2.7/dist-packages:/home/jonny/veg_picker/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/jonny/veg_picker/build" \
    "/usr/bin/python2" \
    "/home/jonny/veg_picker/src/rosserial/rosserial_vex_cortex/setup.py" \
     \
    build --build-base "/home/jonny/veg_picker/build/rosserial/rosserial_vex_cortex" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/jonny/veg_picker/install" --install-scripts="/home/jonny/veg_picker/install/bin"
