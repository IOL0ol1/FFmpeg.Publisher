- **BtbN/FFmpeg-Builds** only provides x64 binaries    
- Can be used in either C# or C++ projects

This nuget package contains headers, import libraries, and runtime    
dlls for FFmpeg for use with Visual Studio. It is based on the     
FFmpeg windows builds from:   
https://github.com/BtbN/FFmpeg-Builds/releases    

FFmpeg is a pure C project, so to use the libraries within your C++    
application you must encompass your FFmpeg includes using extern "C".    
Otherwise, you will experience link errors. For more details, see    
https://ffmpeg.org/faq.html or build\native\doc\faq.html    

In the build\native folder of this nuget package, you can find a copy     
of the license which applies to this build (LICENSE.txt).    

For more information on FFmpeg's license, see:    
https://ffmpeg.org/legal.html    
