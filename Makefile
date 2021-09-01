#
#   Makefile
#
#   Copyright 2007, 2008 Lancer-X/ASCEAI
#
#   This file is part of Meritous.
#
#   Meritous is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   Meritous is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Meritous.  If not, see <http://www.gnu.org/licenses/>.
#

ifdef MIYOO
    CHAINPREFIX := /opt/miyoo
    CROSS_COMPILE := $(CHAINPREFIX)/usr/bin/arm-linux-
    CC  := $(CROSS_COMPILE)gcc
    CXX := $(CROSS_COMPILE)g++
    LD  := $(CROSS_COMPILE)gcc
endif

SYSROOT := $(shell $(CXX) --print-sysroot)
SDL_CFLAGS  := $(shell $(SYSROOT)/usr/bin/sdl-config --cflags)
SDL_LIBS    := $(shell $(SYSROOT)/usr/bin/sdl-config --libs)

export CHAINPREFIX CROSS_COMPILE CC CXX LD SYSROOT SDL_CFLAGS SDL_LIBS

LDFLAGS = $(SDL_LIBS) -lSDL_image -lSDL_mixer -lz -lm
CCFLAGS = -O2 -ggdb -Wall $(SDL_CFLAGS) -g -DWITH_HOME_DIR

ifdef MIYOO
    CCFLAGS += -march=armv5tej
endif

OBJS = 	src/levelblit.o \
		src/mapgen.o \
		src/demon.o \
		src/gamemap.o \
		src/tiles.o \
		src/save.o \
		src/help.o \
		src/audio.o \
		src/boss.o \
		src/ending.o

default:	meritous

%.o:		%.c
		$(CC) -c -o $@ $? ${CCFLAGS}

meritous:	${OBJS}
		$(CC) -o $@ $+ ${LDFLAGS}

clean:
		rm ${OBJS}
