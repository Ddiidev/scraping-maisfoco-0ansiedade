@echo off

v -cc gcc -prod -cflags "-Os -s" -d no_backtrace . -o scraping_netflix.exe