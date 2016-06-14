#! /bin/sh
srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.
( cd "$srcdir" && gtkdocize ) || exit 1
( cd "$srcdir" && autoreconf -v --install ) || exit 1
if test -z "$NOCONFIGURE"; then
    "$srcdir/configure" "$@" || exit 1
fi
