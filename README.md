# Counterstrike 1.5 Server

If you still have your old CS 1.5 installation around and want to play online with your friends, just use this image or build it yourself with a modified configuration.

## Setup

This uses and old Ubuntu (14.04) i386 installation. This has two reasons. Newer glibc version (~ >=2.25) won't work with the hlds executables and it's easier to compile the  shared libraries for a pure i386 system.

Copy the necessary files to files directory and run.

`$ docker build . -t slangenmaier/counterstrike-15`

## Caveats

The hl boom fix is not enabled. It's segfaulting for me.
