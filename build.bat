@echo off

if exist build (
    echo del build
    rmdir /s/q build
)

md build
md build\db

v -prod -cflags "-s -Os" . -o build\crawler-maisfoco-zeroansiedade.exe

md build\src\shareds
xcopy src\shareds build\src\shareds /E /H /C /I

copy .env build

md build\translations
xcopy translations build\translations /E /H /C /I


md build\webview
xcopy webview build\webview /E /H /C /I