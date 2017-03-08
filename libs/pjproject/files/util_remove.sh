#!/bin/sh

	# Remove target name from lib names
	sed -i -e 's/-$(TARGET_NAME)//g' \
		-e 's/= $(TARGET_NAME).a/= .a/g' \
		-e 's/-$(LIB_SUFFIX)/$(LIB_SUFFIX)/g' \
		$(find . -name '*.mak*' -o -name Makefile) || return 1

	# Fix hardcoded prefix and flags
	sed -i \
		-e 's/poll@/poll@\nexport PREFIX := @prefix@\n/g' \
		-e 's!prefix = /usr/local!prefix = $(PREFIX)!' \
		-e '/PJLIB_CFLAGS/ s/(_CFLAGS)/(_CFLAGS) -fPIC/g' \
		-e '/PJLIB_UTIL_CFLAGS/ s/(_CFLAGS)/(_CFLAGS) -fPIC/g' \
		Makefile \
		build.mak.in || return 1

	# Use libsamplerate instead of bundled resample
	sed -i -e "s/resample//" third_party/build/Makefile
	sed -i -e "s#../../third_party/libsamplerate/src/samplerate.h#samplerate.h#" pjmedia/src/pjmedia/resample_libsamplerate.c
