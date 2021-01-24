all: library #all_samples

#CFLAGS=-arch i386 -arch x86_64 -O3  -I. -w
CFLAGS=-O2  -I. -w -s MODULARIZE=1 -s 'EXPORT_NAME="createLibRaw"' -s 'EXPORTED_FUNCTIONS=["_libraw_open_buffer"]'
CC=emcc
CXX=em++

# OpenMP support
#CFLAGS+=-fopenmp

# RawSpeed Support
#CFLAGS+=-pthread -DUSE_RAWSPEED -I../RawSpeed -I/usr/local/include/libxml2
#LDADD+=-L../RawSpeed/RawSpeed -lrawspeed -L/usr/local/lib -ljpeg -lxml2
#RAWSPEED_DATA=../RawSpeed/data/cameras.xml

# DNG SDK Support
# CFLAGS+=-DUSE_DNGSDK -I../dng_sdk/source
# LDADDD+=-L../dng_sdk/release -ldng -lXMPCore -ljpeg -lz

# Jasper support for RedCine
#CFLAGS+=-DUSE_JASPER -I/usr/local/include
#LDADD+=-L/usr/local/lib -ljasper

# JPEG support for lossy DNG
#CFLAGS+=-DUSE_JPEG -I/usr/local/include
#LDADD+=-L/usr/local/lib -ljpeg
# LIBJPEG8:
#CFLAGS+=-DUSE_JPEG8

# LCMS support
#CFLAGS+=-DUSE_LCMS -I/usr/local/include
#LDADD+=-L/usr/local/lib -llcms

# LCMS2.x support
#CFLAGS+=-DUSE_LCMS2 -I/usr/local/include
#LDADD+=-L/usr/local/lib -llcms2

CSTFLAGS=$(CFLAGS) -DLIBRAW_NOTHREADS

LIB_OBJECTS= object/libraw_datastream.o object/libraw_c_api.o \
  object/cameralist.o object/fuji_compressed.o \
  object/crx.o object/fp_dng.o object/decoders_libraw.o \
  object/unpack.o object/unpack_thumb.o \
  object/rawspeed_glue.o object/dngsdk_glue.o \
  object/colorconst.o object/utils_libraw.o object/init_close_utils.o \
  object/decoder_info.o object/open.o object/phaseone_processing.o \
  object/thumb_utils.o \
  object/tiff_writer.o object/subtract_black.o object/postprocessing_utils.o \
  object/dcraw_process.o object/raw2image.o object/mem_image.o \
  object/x3f_utils_patched.o object/x3f_parse_process.o \
  object/read_utils.o object/curves.o object/utils_dcraw.o \
  object/colordata.o \
  object/canon_600.o  object/decoders_dcraw.o \
  object/decoders_libraw_dcrdefs.o  object/generic.o \
  object/kodak_decoders.o object/dng.o object/smal.o \
  object/load_mfbacks.o \
  object/sony.o object/nikon.o object/samsung.o object/cr3_parser.o \
  object/canon.o  object/epson.o object/olympus.o object/leica.o \
  object/fuji.o object/adobepano.o object/pentax.o object/p1.o \
  object/makernotes.o object/exif_gps.o object/kodak.o \
  object/tiff.o object/ciff.o object/mediumformat.o object/minolta.o \
  object/identify_tools.o \
  object/hasselblad_model.o object/normalize_model.o object/identify.o \
  object/misc_parsers.o object/wblists.o \
  object/postprocessing_aux.o object/postprocessing_utils_dcrdefs.o \
  object/aspect_ratio.o \
  object/misc_demosaic.o object/xtrans_demosaic.o object/ahd_demosaic.o \
  object/dht_demosaic.o  object/aahd_demosaic.o  object/dcb_demosaic.o \
  object/file_write.o \
  object/ext_preprocess.o   object/apply_profile.o


LIB_MT_OBJECTS= object/libraw_datastream.mt.o object/libraw_c_api.mt.o \
  object/cameralist.mt.o object/fuji_compressed.mt.o \
  object/crx.mt.o object/fp_dng.mt.o object/decoders_libraw.mt.o \
  object/unpack.mt.o object/unpack_thumb.mt.o \
  object/rawspeed_glue.mt.o object/dngsdk_glue.mt.o \
  object/colorconst.mt.o object/utils_libraw.mt.o \
  object/init_close_utils.mt.o \
  object/decoder_info.mt.o object/open.mt.o object/phaseone_processing.mt.o \
  object/thumb_utils.mt.o \
  object/tiff_writer.mt.o object/subtract_black.mt.o \
  object/postprocessing_utils.mt.o object/dcraw_process.mt.o \
  object/raw2image.mt.o object/mem_image.mt.o \
  object/x3f_utils_patched.mt.o object/x3f_parse_process.mt.o \
  object/read_utils.mt.o object/curves.mt.o object/utils_dcraw.mt.o \
  object/colordata.mt.o \
  object/canon_600.mt.o  object/decoders_dcraw.mt.o \
  object/decoders_libraw_dcrdefs.mt.o  object/generic.mt.o \
  object/kodak_decoders.mt.o object/dng.mt.o object/smal.mt.o \
  object/load_mfbacks.mt.o \
  object/sony.mt.o object/nikon.mt.o object/samsung.mt.o \
  object/cr3_parser.mt.o object/canon.mt.o  object/epson.mt.o \
  object/olympus.mt.o object/leica.mt.o \
  object/fuji.mt.o object/adobepano.mt.o object/pentax.mt.o object/p1.mt.o \
  object/makernotes.mt.o object/exif_gps.mt.o object/kodak.mt.o \
  object/tiff.mt.o object/ciff.mt.o object/mediumformat.mt.o \
  object/minolta.mt.o \
  object/identify_tools.mt.o \
  object/hasselblad_model.o object/normalize_model.mt.o object/identify.mt.o \
  object/misc_parsers.mt.o object/wblists.mt.o \
  object/postprocessing_aux.mt.o object/postprocessing_utils_dcrdefs.mt.o \
  object/aspect_ratio.mt.o \
  object/misc_demosaic.mt.o object/xtrans_demosaic.mt.o \
  object/ahd_demosaic.mt.o object/dht_demosaic.mt.o \
  object/aahd_demosaic.mt.o object/dcb_demosaic.mt.o \
  object/file_write.mt.o \
  object/ext_preprocess.mt.o   object/apply_profile.mt.o


LR_INCLUDES=libraw/libraw.h libraw/libraw_alloc.h \
  libraw/libraw_const.h libraw/libraw_datastream.h \
  libraw/libraw_internal.h libraw/libraw_types.h \
  libraw/libraw_version.h

library: lib/libraw.a lib/libraw_r.a lib/libraw.wasm

all_samples: bin/raw-identify bin/simple_dcraw  bin/dcraw_emu bin/dcraw_half bin/half_mt bin/mem_image \
             bin/unprocessed_raw bin/4channels bin/multirender_test bin/postprocessing_benchmark \
	     bin/rawtextdump

install: library
	@if [ -d /usr/local/include ] ; then cp -R libraw /usr/local/include/ ; else echo 'no /usr/local/include' ; fi
	@if [ -d /usr/local/lib ] ; then cp lib/libraw.a lib/libraw_r.a /usr/local/lib/ ; else echo 'no /usr/local/lib' ; fi

install-binaries: all_samples
	@if [ -d /usr/local/bin ] ; then cp bin/[a-z]* /usr/local/bin/ ; else echo 'no /usr/local/bin' ; fi


## RawSpeed xml file

RawSpeed/rawspeed_xmldata.cpp: ${RAWSPEED_DATA}
	./rsxml2c.sh ${RAWSPEED_DATA} > RawSpeed/rawspeed_xmldata.cpp

#binaries

bin/raw-identify: lib/libraw.a samples/raw-identify.cpp
	${CXX} -DLIBRAW_NOTHREADS  ${CFLAGS} -o bin/raw-identify samples/raw-identify.cpp -L./lib -lraw  -lm ${LDADD}

bin/unprocessed_raw: lib/libraw.a samples/unprocessed_raw.cpp
	${CXX} -DLIBRAW_NOTHREADS  ${CFLAGS} -o bin/unprocessed_raw samples/unprocessed_raw.cpp -L./lib -lraw  -lm  ${LDADD}

bin/4channels: lib/libraw.a samples/4channels.cpp
	${CXX} -DLIBRAW_NOTHREADS  ${CFLAGS} -o bin/4channels samples/4channels.cpp -L./lib -lraw  -lm  ${LDADD}

bin/rawtextdump: lib/libraw.a samples/rawtextdump.cpp
	${CXX} -DLIBRAW_NOTHREADS  ${CFLAGS} -o bin/rawtextdump samples/rawtextdump.cpp -L./lib -lraw  -lm  ${LDADD}

bin/simple_dcraw: lib/libraw.a samples/simple_dcraw.cpp
	${CXX} -DLIBRAW_NOTHREADS   ${CFLAGS} -o bin/simple_dcraw samples/simple_dcraw.cpp -L./lib -lraw  -lm  ${LDADD}

bin/multirender_test: lib/libraw.a samples/multirender_test.cpp
	${CXX} -DLIBRAW_NOTHREADS   ${CFLAGS} -o bin/multirender_test samples/multirender_test.cpp -L./lib -lraw  -lm  ${LDADD}

bin/postprocessing_benchmark: lib/libraw.a samples/postprocessing_benchmark.cpp
	${CXX} -DLIBRAW_NOTHREADS   ${CFLAGS} -o bin/postprocessing_benchmark samples/postprocessing_benchmark.cpp -L./lib -lraw  -lm  ${LDADD}

bin/mem_image: lib/libraw.a samples/mem_image_sample.cpp
	${CXX} -DLIBRAW_NOTHREADS  ${CFLAGS} -o bin/mem_image samples/mem_image_sample.cpp -L./lib -lraw  -lm  ${LDADD}

bin/dcraw_half: lib/libraw.a object/dcraw_half.o
	${CC} -DLIBRAW_NOTHREADS  ${CFLAGS} -o bin/dcraw_half object/dcraw_half.o -L./lib -lraw  -lm -lstdc++  ${LDADD}

bin/half_mt: lib/libraw_r.a object/half_mt.o
	${CC}   -pthread ${CFLAGS} -o bin/half_mt object/half_mt.o -L./lib -lraw_r  -lm -lstdc++  ${LDADD}

bin/dcraw_emu: lib/libraw.a samples/dcraw_emu.cpp
	${CXX} -DLIBRAW_NOTHREADS  ${CFLAGS} -o bin/dcraw_emu samples/dcraw_emu.cpp -L./lib -lraw  -lm  ${LDADD}

#objects

object/dcraw_half.o: samples/dcraw_half.c
	${CC} -c -DLIBRAW_NOTHREADS   ${CFLAGS} -o object/dcraw_half.o samples/dcraw_half.c

object/half_mt.o: samples/half_mt.c
	${CC} -c -pthread   ${CFLAGS} -o object/half_mt.o samples/half_mt.c


lib/libraw.a: ${LIB_OBJECTS}
	rm -f lib/libraw.a
	ar crv lib/libraw.a ${LIB_OBJECTS}
	ranlib lib/libraw.a

lib/libraw_r.a: ${LIB_MT_OBJECTS}
	rm -f lib/libraw_r.a
	ar crv lib/libraw_r.a ${LIB_MT_OBJECTS}
	ranlib lib/libraw_r.a

lib/libraw.wasm: ${LIB_OBJECTS}
	emcc -O2 -o lib/libraw.js -s MODULARIZE=1 -s 'EXPORT_NAME="createLibRaw"' -s 'EXPORTED_FUNCTIONS=["_libraw_open_buffer","_libraw_init","_libraw_unpack","_libraw_raw2image","_libraw_dcraw_process","_libraw_dcraw_make_mem_image","_libraw_get_raw_image"]' -s ALLOW_MEMORY_GROWTH=1 ${LIB_OBJECTS}

clean:
	rm -fr bin/*.dSYM
	rm -f *.o *~ src/*~ samples/*~ internal/*~ libraw/*~ lib/lib*.a bin/[4a-z]* object/*o dcraw/*~ doc/*~ bin/*~ src/*/*~

### generated
object/libraw_c_api.o: src/libraw_c_api.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/libraw_c_api.o src/libraw_c_api.cpp
object/libraw_c_api.mt.o: src/libraw_c_api.cpp
	${CXX} -c ${CFLAGS} -o object/libraw_c_api.mt.o src/libraw_c_api.cpp
object/libraw_cxx.o: src/libraw_cxx.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/libraw_cxx.o src/libraw_cxx.cpp
object/libraw_cxx.mt.o: src/libraw_cxx.cpp
	${CXX} -c ${CFLAGS} -o object/libraw_cxx.mt.o src/libraw_cxx.cpp
object/libraw_datastream.o: src/libraw_datastream.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/libraw_datastream.o src/libraw_datastream.cpp
object/libraw_datastream.mt.o: src/libraw_datastream.cpp
	${CXX} -c ${CFLAGS} -o object/libraw_datastream.mt.o src/libraw_datastream.cpp
object/canon_600.o: src/decoders/canon_600.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/canon_600.o src/decoders/canon_600.cpp
object/canon_600.mt.o: src/decoders/canon_600.cpp
	${CXX} -c ${CFLAGS} -o object/canon_600.mt.o src/decoders/canon_600.cpp
object/crx.o: src/decoders/crx.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/crx.o src/decoders/crx.cpp
object/crx.mt.o: src/decoders/crx.cpp
	${CXX} -c ${CFLAGS} -o object/crx.mt.o src/decoders/crx.cpp
object/decoders_dcraw.o: src/decoders/decoders_dcraw.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/decoders_dcraw.o src/decoders/decoders_dcraw.cpp
object/decoders_dcraw.mt.o: src/decoders/decoders_dcraw.cpp
	${CXX} -c ${CFLAGS} -o object/decoders_dcraw.mt.o src/decoders/decoders_dcraw.cpp
object/decoders_libraw_dcrdefs.o: src/decoders/decoders_libraw_dcrdefs.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/decoders_libraw_dcrdefs.o src/decoders/decoders_libraw_dcrdefs.cpp
object/decoders_libraw_dcrdefs.mt.o: src/decoders/decoders_libraw_dcrdefs.cpp
	${CXX} -c ${CFLAGS} -o object/decoders_libraw_dcrdefs.mt.o src/decoders/decoders_libraw_dcrdefs.cpp
object/decoders_libraw.o: src/decoders/decoders_libraw.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/decoders_libraw.o src/decoders/decoders_libraw.cpp
object/decoders_libraw.mt.o: src/decoders/decoders_libraw.cpp
	${CXX} -c ${CFLAGS} -o object/decoders_libraw.mt.o src/decoders/decoders_libraw.cpp
object/dng.o: src/decoders/dng.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/dng.o src/decoders/dng.cpp
object/dng.mt.o: src/decoders/dng.cpp
	${CXX} -c ${CFLAGS} -o object/dng.mt.o src/decoders/dng.cpp
object/fp_dng.o: src/decoders/fp_dng.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/fp_dng.o src/decoders/fp_dng.cpp
object/fp_dng.mt.o: src/decoders/fp_dng.cpp
	${CXX} -c ${CFLAGS} -o object/fp_dng.mt.o src/decoders/fp_dng.cpp
object/fuji_compressed.o: src/decoders/fuji_compressed.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/fuji_compressed.o src/decoders/fuji_compressed.cpp
object/fuji_compressed.mt.o: src/decoders/fuji_compressed.cpp
	${CXX} -c ${CFLAGS} -o object/fuji_compressed.mt.o src/decoders/fuji_compressed.cpp
object/generic.o: src/decoders/generic.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/generic.o src/decoders/generic.cpp
object/generic.mt.o: src/decoders/generic.cpp
	${CXX} -c ${CFLAGS} -o object/generic.mt.o src/decoders/generic.cpp
object/kodak_decoders.o: src/decoders/kodak_decoders.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/kodak_decoders.o src/decoders/kodak_decoders.cpp
object/kodak_decoders.mt.o: src/decoders/kodak_decoders.cpp
	${CXX} -c ${CFLAGS} -o object/kodak_decoders.mt.o src/decoders/kodak_decoders.cpp
object/load_mfbacks.o: src/decoders/load_mfbacks.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/load_mfbacks.o src/decoders/load_mfbacks.cpp
object/load_mfbacks.mt.o: src/decoders/load_mfbacks.cpp
	${CXX} -c ${CFLAGS} -o object/load_mfbacks.mt.o src/decoders/load_mfbacks.cpp
object/smal.o: src/decoders/smal.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/smal.o src/decoders/smal.cpp
object/smal.mt.o: src/decoders/smal.cpp
	${CXX} -c ${CFLAGS} -o object/smal.mt.o src/decoders/smal.cpp
object/unpack_thumb.o: src/decoders/unpack_thumb.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/unpack_thumb.o src/decoders/unpack_thumb.cpp
object/unpack_thumb.mt.o: src/decoders/unpack_thumb.cpp
	${CXX} -c ${CFLAGS} -o object/unpack_thumb.mt.o src/decoders/unpack_thumb.cpp
object/unpack.o: src/decoders/unpack.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/unpack.o src/decoders/unpack.cpp
object/unpack.mt.o: src/decoders/unpack.cpp
	${CXX} -c ${CFLAGS} -o object/unpack.mt.o src/decoders/unpack.cpp
object/aahd_demosaic.o: src/demosaic/aahd_demosaic.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/aahd_demosaic.o src/demosaic/aahd_demosaic.cpp
object/aahd_demosaic.mt.o: src/demosaic/aahd_demosaic.cpp
	${CXX} -c ${CFLAGS} -o object/aahd_demosaic.mt.o src/demosaic/aahd_demosaic.cpp
object/ahd_demosaic.o: src/demosaic/ahd_demosaic.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/ahd_demosaic.o src/demosaic/ahd_demosaic.cpp
object/ahd_demosaic.mt.o: src/demosaic/ahd_demosaic.cpp
	${CXX} -c ${CFLAGS} -o object/ahd_demosaic.mt.o src/demosaic/ahd_demosaic.cpp
object/dcb_demosaic.o: src/demosaic/dcb_demosaic.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/dcb_demosaic.o src/demosaic/dcb_demosaic.cpp
object/dcb_demosaic.mt.o: src/demosaic/dcb_demosaic.cpp
	${CXX} -c ${CFLAGS} -o object/dcb_demosaic.mt.o src/demosaic/dcb_demosaic.cpp
object/dht_demosaic.o: src/demosaic/dht_demosaic.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/dht_demosaic.o src/demosaic/dht_demosaic.cpp
object/dht_demosaic.mt.o: src/demosaic/dht_demosaic.cpp
	${CXX} -c ${CFLAGS} -o object/dht_demosaic.mt.o src/demosaic/dht_demosaic.cpp
object/misc_demosaic.o: src/demosaic/misc_demosaic.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/misc_demosaic.o src/demosaic/misc_demosaic.cpp
object/misc_demosaic.mt.o: src/demosaic/misc_demosaic.cpp
	${CXX} -c ${CFLAGS} -o object/misc_demosaic.mt.o src/demosaic/misc_demosaic.cpp
object/xtrans_demosaic.o: src/demosaic/xtrans_demosaic.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/xtrans_demosaic.o src/demosaic/xtrans_demosaic.cpp
object/xtrans_demosaic.mt.o: src/demosaic/xtrans_demosaic.cpp
	${CXX} -c ${CFLAGS} -o object/xtrans_demosaic.mt.o src/demosaic/xtrans_demosaic.cpp
object/dngsdk_glue.o: src/integration/dngsdk_glue.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/dngsdk_glue.o src/integration/dngsdk_glue.cpp
object/dngsdk_glue.mt.o: src/integration/dngsdk_glue.cpp
	${CXX} -c ${CFLAGS} -o object/dngsdk_glue.mt.o src/integration/dngsdk_glue.cpp
object/rawspeed_glue.o: src/integration/rawspeed_glue.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/rawspeed_glue.o src/integration/rawspeed_glue.cpp
object/rawspeed_glue.mt.o: src/integration/rawspeed_glue.cpp
	${CXX} -c ${CFLAGS} -o object/rawspeed_glue.mt.o src/integration/rawspeed_glue.cpp
object/adobepano.o: src/metadata/adobepano.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/adobepano.o src/metadata/adobepano.cpp
object/adobepano.mt.o: src/metadata/adobepano.cpp
	${CXX} -c ${CFLAGS} -o object/adobepano.mt.o src/metadata/adobepano.cpp
object/canon.o: src/metadata/canon.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/canon.o src/metadata/canon.cpp
object/canon.mt.o: src/metadata/canon.cpp
	${CXX} -c ${CFLAGS} -o object/canon.mt.o src/metadata/canon.cpp
object/ciff.o: src/metadata/ciff.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/ciff.o src/metadata/ciff.cpp
object/ciff.mt.o: src/metadata/ciff.cpp
	${CXX} -c ${CFLAGS} -o object/ciff.mt.o src/metadata/ciff.cpp
object/cr3_parser.o: src/metadata/cr3_parser.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/cr3_parser.o src/metadata/cr3_parser.cpp
object/cr3_parser.mt.o: src/metadata/cr3_parser.cpp
	${CXX} -c ${CFLAGS} -o object/cr3_parser.mt.o src/metadata/cr3_parser.cpp
object/epson.o: src/metadata/epson.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/epson.o src/metadata/epson.cpp
object/epson.mt.o: src/metadata/epson.cpp
	${CXX} -c ${CFLAGS} -o object/epson.mt.o src/metadata/epson.cpp
object/exif_gps.o: src/metadata/exif_gps.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/exif_gps.o src/metadata/exif_gps.cpp
object/exif_gps.mt.o: src/metadata/exif_gps.cpp
	${CXX} -c ${CFLAGS} -o object/exif_gps.mt.o src/metadata/exif_gps.cpp
object/fuji.o: src/metadata/fuji.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/fuji.o src/metadata/fuji.cpp
object/fuji.mt.o: src/metadata/fuji.cpp
	${CXX} -c ${CFLAGS} -o object/fuji.mt.o src/metadata/fuji.cpp
object/identify_tools.o: src/metadata/identify_tools.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/identify_tools.o src/metadata/identify_tools.cpp
object/identify_tools.mt.o: src/metadata/identify_tools.cpp
	${CXX} -c ${CFLAGS} -o object/identify_tools.mt.o src/metadata/identify_tools.cpp
object/identify.o: src/metadata/identify.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/identify.o src/metadata/identify.cpp
object/identify.mt.o: src/metadata/identify.cpp
	${CXX} -c ${CFLAGS} -o object/identify.mt.o src/metadata/identify.cpp
object/kodak.o: src/metadata/kodak.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/kodak.o src/metadata/kodak.cpp
object/kodak.mt.o: src/metadata/kodak.cpp
	${CXX} -c ${CFLAGS} -o object/kodak.mt.o src/metadata/kodak.cpp
object/leica.o: src/metadata/leica.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/leica.o src/metadata/leica.cpp
object/leica.mt.o: src/metadata/leica.cpp
	${CXX} -c ${CFLAGS} -o object/leica.mt.o src/metadata/leica.cpp
object/makernotes.o: src/metadata/makernotes.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/makernotes.o src/metadata/makernotes.cpp
object/makernotes.mt.o: src/metadata/makernotes.cpp
	${CXX} -c ${CFLAGS} -o object/makernotes.mt.o src/metadata/makernotes.cpp
object/mediumformat.o: src/metadata/mediumformat.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/mediumformat.o src/metadata/mediumformat.cpp
object/mediumformat.mt.o: src/metadata/mediumformat.cpp
	${CXX} -c ${CFLAGS} -o object/mediumformat.mt.o src/metadata/mediumformat.cpp
object/minolta.o: src/metadata/minolta.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/minolta.o src/metadata/minolta.cpp
object/minolta.mt.o: src/metadata/minolta.cpp
	${CXX} -c ${CFLAGS} -o object/minolta.mt.o src/metadata/minolta.cpp
object/misc_parsers.o: src/metadata/misc_parsers.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/misc_parsers.o src/metadata/misc_parsers.cpp
object/misc_parsers.mt.o: src/metadata/misc_parsers.cpp
	${CXX} -c ${CFLAGS} -o object/misc_parsers.mt.o src/metadata/misc_parsers.cpp
object/nikon.o: src/metadata/nikon.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/nikon.o src/metadata/nikon.cpp
object/nikon.mt.o: src/metadata/nikon.cpp
	${CXX} -c ${CFLAGS} -o object/nikon.mt.o src/metadata/nikon.cpp
object/hasselblad_model.o: src/metadata/hasselblad_model.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/hasselblad_model.o src/metadata/hasselblad_model.cpp
object/hasselblad_model.mt.o: src/metadata/hasselblad_model.cpp
	${CXX} -c ${CFLAGS} -o object/hasselblad_model.mt.o src/metadata/hasselblad_model.cpp
object/normalize_model.o: src/metadata/normalize_model.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/normalize_model.o src/metadata/normalize_model.cpp
object/normalize_model.mt.o: src/metadata/normalize_model.cpp
	${CXX} -c ${CFLAGS} -o object/normalize_model.mt.o src/metadata/normalize_model.cpp
object/olympus.o: src/metadata/olympus.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/olympus.o src/metadata/olympus.cpp
object/olympus.mt.o: src/metadata/olympus.cpp
	${CXX} -c ${CFLAGS} -o object/olympus.mt.o src/metadata/olympus.cpp
object/p1.o: src/metadata/p1.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/p1.o src/metadata/p1.cpp
object/p1.mt.o: src/metadata/p1.cpp
	${CXX} -c ${CFLAGS} -o object/p1.mt.o src/metadata/p1.cpp
object/pentax.o: src/metadata/pentax.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/pentax.o src/metadata/pentax.cpp
object/pentax.mt.o: src/metadata/pentax.cpp
	${CXX} -c ${CFLAGS} -o object/pentax.mt.o src/metadata/pentax.cpp
object/samsung.o: src/metadata/samsung.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/samsung.o src/metadata/samsung.cpp
object/samsung.mt.o: src/metadata/samsung.cpp
	${CXX} -c ${CFLAGS} -o object/samsung.mt.o src/metadata/samsung.cpp
object/sony.o: src/metadata/sony.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/sony.o src/metadata/sony.cpp
object/sony.mt.o: src/metadata/sony.cpp
	${CXX} -c ${CFLAGS} -o object/sony.mt.o src/metadata/sony.cpp
object/tiff.o: src/metadata/tiff.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/tiff.o src/metadata/tiff.cpp
object/tiff.mt.o: src/metadata/tiff.cpp
	${CXX} -c ${CFLAGS} -o object/tiff.mt.o src/metadata/tiff.cpp
object/aspect_ratio.o: src/postprocessing/aspect_ratio.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/aspect_ratio.o src/postprocessing/aspect_ratio.cpp
object/aspect_ratio.mt.o: src/postprocessing/aspect_ratio.cpp
	${CXX} -c ${CFLAGS} -o object/aspect_ratio.mt.o src/postprocessing/aspect_ratio.cpp
object/dcraw_process.o: src/postprocessing/dcraw_process.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/dcraw_process.o src/postprocessing/dcraw_process.cpp
object/dcraw_process.mt.o: src/postprocessing/dcraw_process.cpp
	${CXX} -c ${CFLAGS} -o object/dcraw_process.mt.o src/postprocessing/dcraw_process.cpp
object/mem_image.o: src/postprocessing/mem_image.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/mem_image.o src/postprocessing/mem_image.cpp
object/mem_image.mt.o: src/postprocessing/mem_image.cpp
	${CXX} -c ${CFLAGS} -o object/mem_image.mt.o src/postprocessing/mem_image.cpp
object/postprocessing_aux.o: src/postprocessing/postprocessing_aux.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/postprocessing_aux.o src/postprocessing/postprocessing_aux.cpp
object/postprocessing_aux.mt.o: src/postprocessing/postprocessing_aux.cpp
	${CXX} -c ${CFLAGS} -o object/postprocessing_aux.mt.o src/postprocessing/postprocessing_aux.cpp
object/postprocessing_utils_dcrdefs.o: src/postprocessing/postprocessing_utils_dcrdefs.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/postprocessing_utils_dcrdefs.o src/postprocessing/postprocessing_utils_dcrdefs.cpp
object/postprocessing_utils_dcrdefs.mt.o: src/postprocessing/postprocessing_utils_dcrdefs.cpp
	${CXX} -c ${CFLAGS} -o object/postprocessing_utils_dcrdefs.mt.o src/postprocessing/postprocessing_utils_dcrdefs.cpp
object/postprocessing_utils.o: src/postprocessing/postprocessing_utils.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/postprocessing_utils.o src/postprocessing/postprocessing_utils.cpp
object/postprocessing_utils.mt.o: src/postprocessing/postprocessing_utils.cpp
	${CXX} -c ${CFLAGS} -o object/postprocessing_utils.mt.o src/postprocessing/postprocessing_utils.cpp
object/raw2image.o: src/preprocessing/raw2image.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/raw2image.o src/preprocessing/raw2image.cpp
object/raw2image.mt.o: src/preprocessing/raw2image.cpp
	${CXX} -c ${CFLAGS} -o object/raw2image.mt.o src/preprocessing/raw2image.cpp
object/ext_preprocess.o: src/preprocessing/ext_preprocess.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/ext_preprocess.o src/preprocessing/ext_preprocess.cpp
object/ext_preprocess.mt.o: src/preprocessing/ext_preprocess.cpp
	${CXX} -c ${CFLAGS} -o object/ext_preprocess.mt.o src/preprocessing/ext_preprocess.cpp
object/subtract_black.o: src/preprocessing/subtract_black.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/subtract_black.o src/preprocessing/subtract_black.cpp
object/subtract_black.mt.o: src/preprocessing/subtract_black.cpp
	${CXX} -c ${CFLAGS} -o object/subtract_black.mt.o src/preprocessing/subtract_black.cpp
object/cameralist.o: src/tables/cameralist.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/cameralist.o src/tables/cameralist.cpp
object/cameralist.mt.o: src/tables/cameralist.cpp
	${CXX} -c ${CFLAGS} -o object/cameralist.mt.o src/tables/cameralist.cpp
object/colorconst.o: src/tables/colorconst.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/colorconst.o src/tables/colorconst.cpp
object/colorconst.mt.o: src/tables/colorconst.cpp
	${CXX} -c ${CFLAGS} -o object/colorconst.mt.o src/tables/colorconst.cpp
object/colordata.o: src/tables/colordata.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/colordata.o src/tables/colordata.cpp
object/colordata.mt.o: src/tables/colordata.cpp
	${CXX} -c ${CFLAGS} -o object/colordata.mt.o src/tables/colordata.cpp
object/wblists.o: src/tables/wblists.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/wblists.o src/tables/wblists.cpp
object/wblists.mt.o: src/tables/wblists.cpp
	${CXX} -c ${CFLAGS} -o object/wblists.mt.o src/tables/wblists.cpp
object/curves.o: src/utils/curves.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/curves.o src/utils/curves.cpp
object/curves.mt.o: src/utils/curves.cpp
	${CXX} -c ${CFLAGS} -o object/curves.mt.o src/utils/curves.cpp
object/decoder_info.o: src/utils/decoder_info.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/decoder_info.o src/utils/decoder_info.cpp
object/decoder_info.mt.o: src/utils/decoder_info.cpp
	${CXX} -c ${CFLAGS} -o object/decoder_info.mt.o src/utils/decoder_info.cpp
object/init_close_utils.o: src/utils/init_close_utils.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/init_close_utils.o src/utils/init_close_utils.cpp
object/init_close_utils.mt.o: src/utils/init_close_utils.cpp
	${CXX} -c ${CFLAGS} -o object/init_close_utils.mt.o src/utils/init_close_utils.cpp
object/open.o: src/utils/open.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/open.o src/utils/open.cpp
object/open.mt.o: src/utils/open.cpp
	${CXX} -c ${CFLAGS} -o object/open.mt.o src/utils/open.cpp
object/phaseone_processing.o: src/utils/phaseone_processing.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/phaseone_processing.o src/utils/phaseone_processing.cpp
object/phaseone_processing.mt.o: src/utils/phaseone_processing.cpp
	${CXX} -c ${CFLAGS} -o object/phaseone_processing.mt.o src/utils/phaseone_processing.cpp
object/read_utils.o: src/utils/read_utils.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/read_utils.o src/utils/read_utils.cpp
object/read_utils.mt.o: src/utils/read_utils.cpp
	${CXX} -c ${CFLAGS} -o object/read_utils.mt.o src/utils/read_utils.cpp
object/thumb_utils.o: src/utils/thumb_utils.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/thumb_utils.o src/utils/thumb_utils.cpp
object/thumb_utils.mt.o: src/utils/thumb_utils.cpp
	${CXX} -c ${CFLAGS} -o object/thumb_utils.mt.o src/utils/thumb_utils.cpp
object/utils_dcraw.o: src/utils/utils_dcraw.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/utils_dcraw.o src/utils/utils_dcraw.cpp
object/utils_dcraw.mt.o: src/utils/utils_dcraw.cpp
	${CXX} -c ${CFLAGS} -o object/utils_dcraw.mt.o src/utils/utils_dcraw.cpp
object/utils_libraw.o: src/utils/utils_libraw.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/utils_libraw.o src/utils/utils_libraw.cpp
object/utils_libraw.mt.o: src/utils/utils_libraw.cpp
	${CXX} -c ${CFLAGS} -o object/utils_libraw.mt.o src/utils/utils_libraw.cpp
object/apply_profile.o: src/write/apply_profile.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/apply_profile.o src/write/apply_profile.cpp
object/apply_profile.mt.o: src/write/apply_profile.cpp
	${CXX} -c ${CFLAGS} -o object/apply_profile.mt.o src/write/apply_profile.cpp
object/file_write.o: src/write/file_write.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/file_write.o src/write/file_write.cpp
object/file_write.mt.o: src/write/file_write.cpp
	${CXX} -c ${CFLAGS} -o object/file_write.mt.o src/write/file_write.cpp
object/tiff_writer.o: src/write/tiff_writer.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/tiff_writer.o src/write/tiff_writer.cpp
object/tiff_writer.mt.o: src/write/tiff_writer.cpp
	${CXX} -c ${CFLAGS} -o object/tiff_writer.mt.o src/write/tiff_writer.cpp
object/x3f_parse_process.o: src/x3f/x3f_parse_process.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/x3f_parse_process.o src/x3f/x3f_parse_process.cpp
object/x3f_parse_process.mt.o: src/x3f/x3f_parse_process.cpp
	${CXX} -c ${CFLAGS} -o object/x3f_parse_process.mt.o src/x3f/x3f_parse_process.cpp
object/x3f_utils_patched.o: src/x3f/x3f_utils_patched.cpp
	${CXX} -c -DLIBRAW_NOTHREADS  ${CFLAGS} -o object/x3f_utils_patched.o src/x3f/x3f_utils_patched.cpp
object/x3f_utils_patched.mt.o: src/x3f/x3f_utils_patched.cpp
	${CXX} -c ${CFLAGS} -o object/x3f_utils_patched.mt.o src/x3f/x3f_utils_patched.cpp
