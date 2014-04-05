# Build Guide #

## Microsoft NMAKE Visual C++ ##
Option:

1. `cd scintilla/win32 `
2. `nmake -f scintilla.mk`
3. `cd ForwardEdit/win32`
4. `nmake -f ForwardEdit.mk`
5. `copy ForwardEdit/bin`

***Note:***
Build Target for ARM Must use VisualStudio 2013 or Later
VS2013 ARM Cross Tools Command Prompt
## Clang Base Visual C++ ##
use ClangNM.mak

## GCC  ##
use makefile

## MSBuild ##
use forwardedit.sln


