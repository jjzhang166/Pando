/*********************************************************************************************************
* PandoTaskAbout.cpp
* Copyright (C) 2014 The ForceStudio All Rights Reserved.
* Note: Pando Editor Taskdialog About
* E-mail:<forcemz@outlook.com>
* @2014.09
**********************************************************************************************************/
#include <Windows.h>
#include <stdio.h>
#include <asssert.h>
#include <commctrl.h>
#include <strsafe.h>

#ifndef ASSERT
#ifdef _DEBUG
#include <assert.h>
#define ASSERT(x) assert( x )
#define ASSERT_HERE assert( FALSE )
#else
#define ASSERT(x) 
#endif
#endif

#ifndef _tsizeof 
#define _tsizeof( s )  (sizeof(s)/sizeof(s[0]))
#endif

#include <comdef.h>
#include <taskschd.h>
#include "resource.h"

HRESULT CALLBACK
TaskDialogCallbackProc(
__in HWND hwnd,
__in UINT msg,
__in WPARAM wParam,
__in LPARAM lParam,
__in LONG_PTR lpRefData
)
{
	switch (msg)
	{
	case TDN_CREATED:
		::SetForegroundWindow(hwnd);
		break;
	case TDN_RADIO_BUTTON_CLICKED:
		break;
	case TDN_BUTTON_CLICKED:
		break;
	case TDN_HYPERLINK_CLICKED:
		ShellExecute(hwnd, NULL, (LPCTSTR) lParam, NULL, NULL, SW_SHOWNORMAL);
		break;
	}

	return S_OK;
}

LRESULT CreateTaskDialogIndirectFd(
	__in HWND		hwndParent,
	__in HINSTANCE	hInstance,
	__out_opt int *	pnButton,
	__out_opt int *	pnRadioButton
	)
{
	TASKDIALOGCONFIG tdConfig;
	BOOL bElevated = FALSE;
	memset(&tdConfig, 0, sizeof(tdConfig));

	tdConfig.cbSize = sizeof(tdConfig);

	tdConfig.hwndParent = hwndParent;
	tdConfig.hInstance = hInstance;
	tdConfig.dwFlags =
		TDF_ALLOW_DIALOG_CANCELLATION |
		TDF_EXPAND_FOOTER_AREA |
		TDF_POSITION_RELATIVE_TO_WINDOW|
		TDF_ENABLE_HYPERLINKS;

	//tdConfig.cRadioButtons = ARRAYSIZE(buttons);
	//tdConfig.pRadioButtons = buttons;
	tdConfig.nDefaultRadioButton = *pnRadioButton;

	tdConfig.pszWindowTitle = _T("About ForceShell ForwardUI Host");

	tdConfig.pszMainInstruction = _T("Force Shell Forward");

	//tdConfig.pszMainIcon = bElevated ? TD_SHIELD_ICON : TD_INFORMATION_ICON;
	tdConfig.hMainIcon = static_cast<HICON>(LoadIcon(GetModuleHandle(nullptr), MAKEINTRESOURCE(IDI_PANDO_ICON)));
	tdConfig.dwFlags |= TDF_USE_HICON_MAIN;

	TCHAR szContent[256]; // should be long enough

	wcscpy_s(szContent, ALLCOPYNAME);

	tdConfig.pszContent = szContent;

	tdConfig.pszExpandedInformation = _T("For more information about this tool, ")
	 	_T("Visit: <a href=\"http://my.oschina.net/GIIoOS\">Huxizero\xAEStudio</a>");

	tdConfig.pszCollapsedControlText = _T("More information");
	tdConfig.pszExpandedControlText = _T("Less information");
	tdConfig.pfCallback = TaskDialogCallbackProc;

	HRESULT hr = TaskDialogIndirect(&tdConfig, pnButton, pnRadioButton, NULL);

	return hr;
}



LRESULT WINAPI    PandoTaskAboutShow(HWND hParent)
{
	ASSERT(hParent);
	return 0;
}

