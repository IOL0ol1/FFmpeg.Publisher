

!!!!!!!!!!!!!!!!!!!!!!!!! Only x64 supported !!!!!!!!!!!!!!!!!!!!!!!!!

This nuget package contains headers, import libraries, and runtime
dlls for FFmpeg for use with Visual Studio. It is based on the 
FFmpeg windows builds from https://github.com/BtbN/FFmpeg-Builds/releases

FFmpeg is a pure C project, so to use the libraries within your C++
application you must encompass your FFmpeg includes using extern "C".
Otherwise, you will experience link errors. For more details, see
https://ffmpeg.org/faq.html or build\native\doc\faq.html

Note that this build incorporates parts that are covered by the GPLv3
license. Consequently, if you use this nuget package in your
application, then you must comply with the terms of the GPLv3 license.

In the build\native folder of this nuget package, you can find a copy 
of the GPLv3 license which applies to this build (LICENSE.txt).

For more information on FFmpeg's license, see:

* https://ffmpeg.org/legal.html
