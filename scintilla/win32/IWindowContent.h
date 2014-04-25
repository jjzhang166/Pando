/*
*
*
*
*
**/
#ifndef MDS_IWINDOWCONTENT_H

#define MDS_IWINDOWCONTENT_H
#if defined(_MSC_VER)
#include <atlbase.h>
#include <atlwin.h>
#include <atlsimpstr.h>

template <class T>

class MdScitntillaWindowImpl{
public:
MdScitntillaWindowImpl();
static LRESULT  WINAPI StartWindowProc(HWND hWnd,UINT msg,WPARAM wParam,LPARAM lParam)
{
   //
   return S_OK;
}
static LRESULT  WINAPI  FirstWindowProc(HWND hWnd,UINT msg,WPARAM wParam,LPARAM lParam)
{
  return S_OK;
}
private:
   CWinProcThunk m_thunk;
};


#endif


#endif