include $(top_srcdir)/build/autotools/Makefile.am.silent

NULL = #

SUBDIRS = shaders

CLEANFILES = #
DISTCLEANFILES = #
EXTRA_DIST = #
BUILT_SOURCES = #

# glib-mkenums
glib_enum_h = clutter-gst-enum-types.h
glib_enum_c = clutter-gst-enum-types.c
glib_enum_headers =					\
	$(addprefix $(srcdir)/, $(source_srcdir_h))	\
	$(addprefix $(builddir)/, $(source_builddir_h))	\
	$(NULL)
include $(top_srcdir)/build/autotools/Makefile.am.enums

# glib-genmarshal
glib_marshal_list = clutter-gst-marshal.list
glib_marshal_prefix = _clutter_gst_marshal
include $(top_srcdir)/build/autotools/Makefile.am.marshal

source_srcdir_h = 				\
	clutter-gst.h				\
	clutter-gst-types.h			\
	clutter-gst-util.h			\
	clutter-gst-video-sink.h		\
	clutter-gst-video-texture.h 		\
	clutter-gst-player.h			\
	$(NULL)

source_builddir_h = 				\
	clutter-gst-version.h			\
	$(NULL)

source_priv_h =					\
	clutter-gst-debug.h			\
	clutter-gst-marshal.h			\
	clutter-gst-private.h			\
	$(NULL)

source_c = 					\
	clutter-gst-debug.c			\
	clutter-gst-player.c			\
	clutter-gst-video-sink.c		\
	clutter-gst-video-texture.c		\
	clutter-gst-util.c			\
	$(NULL)

source_priv_c =					\
	clutter-gst-marshal.c			\
	$(NULL)

libclutter_gst_@CLUTTER_GST_MAJORMINOR@_la_SOURCES =	\
	$(MARSHALFILES)  				\
	$(source_priv_c)      				\
	$(source_c)      				\
	$(source_priv_h) 				\
	$(source_srcdir_h)				\
	$(source_builddir_h)				\
	$(glib_enum_c)					\
	$(glib_enum_h)					\
	$(NULL)

AM_CPPFLAGS =					\
	-DCLUTTER_GST_COMPILATION		\
	-DG_DISABLE_SINGLE_INCLUDES		\
	-DCOGL_ENABLE_EXPERIMENTAL_API		\
	-DCLUTTER_ENABLE_EXPERIMENTAL_API	\
	-DG_LOG_DOMAIN=\"Clutter-Gst\"		\
	-I$(top_srcdir)				\
	-I$(top_builddir)/clutter-gst/shaders	\
	-I$(top_srcdir)/clutter-gst/shaders	\
	$(NULL)

AM_CFLAGS = 				\
	$(MAINTAINER_CFLAGS)		\
	$(CLUTTER_GST_DEBUG_CFLAGS)	\
	$(CLUTTER_GST_CFLAGS)		\
	$(GST_CFLAGS)			\
	$(HW_CFLAGS)			\
	$(NULL)

lib_LTLIBRARIES = libclutter-gst-@CLUTTER_GST_MAJORMINOR@.la

libclutter_gst_@CLUTTER_GST_MAJORMINOR@_la_LIBADD  = @CLUTTER_GST_LIBS@ $(GST_LIBS) $(HW_LIBS)
libclutter_gst_@CLUTTER_GST_MAJORMINOR@_la_LDFLAGS =	\
	$(CLUTTER_GST_LT_LDFLAGS)			\
	$(GL_LDFLAGS)					\
	-export-dynamic					\
	-export-symbols-regex "^clutter_gst.*"		\
	-rpath $(libdir)
	$(NULL)

cluttergstheadersdir = $(includedir)/clutter-gst-@CLUTTER_GST_API_VERSION@/clutter-gst
cluttergstheaders_HEADERS = $(glib_enum_h)		\
	$(addprefix $(srcdir)/, $(source_srcdir_h))	\
	$(addprefix $(builddir)/, $(source_builddir_h))	\
	$(NULL)

#
# GStreamer plugin
#

plugin_source_c = 				\
	clutter-gst-plugin.c			\
	clutter-gst-video-sink.c		\
	clutter-gst-auto-video-sink.c		\
	clutter-gst-auto-video-sink.h		\
	$(NULL)

libgstclutter_la_SOURCES =	\
	$(plugin_source_c)      \
	$(NULL)

plugin_LTLIBRARIES = libgstclutter.la

libgstclutter_la_LIBADD  = $(PLUGIN_LIBS) $(HW_LIBS)
libgstclutter_la_LDFLAGS =	\
	$(GL_LDFLAGS)		\
	-module -avoid-version	\
	-no-undefined		\
	$(NULL)

#
# Introspection data
#

if HAVE_INTROSPECTION
BUILT_GIRSOURCES =

ClutterGst-@CLUTTER_GST_API_VERSION@.gir: $(INTROSPECTION_SCANNER) libclutter-gst-@CLUTTER_GST_API_VERSION@.la
	$(QUIET_GEN) \
		GST_PLUGIN_SYSTEM_PATH_1_0="" GST_PLUGIN_PATH_1_0="" GST_REGISTRY_UPDATE=no DISPLAY="" \
		$(INTROSPECTION_SCANNER) -v \
		--namespace ClutterGst --nsversion=@CLUTTER_GST_API_VERSION@ \
		$(AM_CPPFLAGS) \ 
		$(CLUTTER_GST_CFLAGS) \
		$(GST_CFLAGS) \
		$(HW_CFLAGS) \
		-D GST_USE_UNSTABLE_API \
		--quiet --warn-all \
		--add-include-path=$(srcdir) --add-include=path=. \
		--c-include="clutter-gst/clutter-gst.h" \
		--include=GObject-2.0 \
		--include=Clutter-1.0 \
		--add-include-path=`$(PKG_CONFIG) --variable=girdir gstreamer-1.0` \
		--include=Gst-1.0 \
		--add-include-path=`$(PKG_CONFIG) --variable=girdir gstreamer-base-1.0` \
		--include=GstBase-1.0 \
		--add-include-path=`$(PKG_CONFIG) --variable=girdir gstreamer-video-1.0` \
		--include=GstVideo-1.0 \
		--add-include-path=`$(PKG_CONFIG) --variable=girdir gstreamer-audio-1.0` \
		--include=GstAudio-1.0 \
		--add-init-section="gst_init(0,NULL);" \
		--library=libclutter-gst-@CLUTTER_GST_API_VERSION@.la \
		--libtool="${LIBTOOL}" \
		--output $@ \
		--pkg gobject-2.0 \
		--pkg clutter-1.0 \
		--pkg gstreamer-1.0 \
		--pkg gstreamer-base-1.0 \
		--pkg-export clutter-gst-@CLUTTER_GST_API_VERSION@ \
		$(cluttergstheaders_HEADERS) \
		$(addprefix $(srcdir)/, $(source_c))

BUILT_GIRSOURCES += ClutterGst-@CLUTTER_GST_API_VERSION@.gir

# INTROSPECTION_GIRDIR/INTROSPECTION_TYPELIBDIR aren't the right place to
# install anything - we need to install inside our prefix.
girdir = $(datadir)/gir-1.0
gir_DATA = $(BUILT_GIRSOURCES)

typelibsdir = $(libdir)/girepository-1.0/
typelibs_DATA = $(BUILT_GIRSOURCES:.gir=.typelib)

%.typelib: %.gir $(INTROSPECTION_COMPILER)
	$(QUIET_GEN)$(INTROSPECTION_COMPILER) \
		--includedir=$(srcdir) \
		--includedir=. \
		--includedir=`$(PKG_CONFIG) --variable=girdir gstreamer-1.0` \
		--includedir=`$(PKG_CONFIG) --variable=girdir gstreamer-base-1.0` \
		--includedir=`$(PKG_CONFIG) --variable=girdir gstreamer-video-1.0` \
		--includedir=`$(PKG_CONFIG) --variable=girdir gstreamer-audio-1.0` \
		$(INTROSPECTION_COMPILER_OPTS) $< -o $(builddir)/$(@F)

CLEANFILES += $(BUILT_GIRSOURCES) $(typelibs_DATA)
endif
