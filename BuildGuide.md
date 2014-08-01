# Build Guide #

## Microsoft NMAKE Visual C++ ##
Option:

1. `cd scintilla/win32 `
2. `nmake -f scintilla.mk`
3. `cd Pando/win32`
4. `nmake -f Pando.mk`
5. `copy Pando/bin`

***Note:***
Build Target for ARM Must use VisualStudio 2013 or Later
VS2013 ARM Cross Tools Command Prompt 
## Clang Base Visual C++ ##
use ClangNM.mak

## GCC  ##
use makefile

## MSBuild ##
use Pando.sln


