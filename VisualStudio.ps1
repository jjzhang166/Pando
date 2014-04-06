<####################################################################################
# VisualStudio Environment Process Script VisualStudio 2013
# Note:  This Script Support Visual Studio 2013   
# Author: Mr.Lee
# Copyright © By Huxizero.Studio
# ToolChain: X86
####################################################################################>
#Global

<####################################################################################
#  Default Visual Studio 2013 x86 native
#  VisualStudio 110
#  VisualStudio 120
#  X86 X64 ARM
####################################################################################>

<#==========================================================================########
#  Visual Studio 100,110,120 
#  x86 AMD64 ARM
#
# $>>2013.10.29 Add .Net Framework Support,Framework 4.0 or Later;
# 
######============================================================================#>
<##--------------------------------------------------------------------------------
# $VSKit= '8.1' or '8.0' or '7.0A'
# $SysNode='SOFTWARE\Wow6432Node' or 'SOFTWARE'
#
#----------------------------------------------------------------------------#######>

Function Get-RegistryValue($key, $value) { 
                  (Get-ItemProperty $key $value).$value 
}
Function Get-PathExist($InputPath)
{

}
Function Print-VisualStudioNotFound($VSVer,$VSPATH)
{
  Write-Host -ForegroundColor Red "Can not find $VSVer, Please seized car in this directory(${VSPATH}) VisualStudio version and installation"
  Start-Sleep 3
}
 
If($args.Count -ge 2)
{
 $VisualStudio=$args[0]
 $Platform=$args[1]
 #$args[2]
}
ELSE
{
 exit
}
$InvokeScript=[System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)
#Set-Location $InvokeScript

IF($profile -eq $null -and $PSCommandPath -eq $null){
if( ([System.Environment]::OSVersion.Version.Major -gt 5) -and ( # Vista and ...
         new-object Security.Principal.WindowsPrincipal (
            [Security.Principal.WindowsIdentity]::GetCurrent()) # current user is admin
            ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) )
 {
$EnvTitle="${env:UserName}@${env:UserDomain} [A] (X86)"
}
ELSE
{
$EnvTitle="${env:UserName}@${env:UserDomain} (X86) "
}
$Host.UI.RawUI.WindowTitle="$EnvTitle - $PWD"
}

IF(${env:ProgramFiles(x86)} -eq $null)
  {
   $SystemType=32
   $ProgramDir=${env:ProgramFiles}
  }
ELSE
  {
   $SystemType=64
   #SDK Install On ${ProgramDir}
   $ProgramDir=${env:ProgramFiles(x86)}
  }
#$VS_120 =
Write-Host "Your Select Visual Studio is: $VisualStudio,And Your Select Platform:$Platform, And Your Host System is: $SystemType"  
$reI=[System.String]::Compare($VisualStudio,"VS120",$True)
$reII=[System.String]::Compare($VisualStudio,"VS110",$True)
$reIII=[System.String]::Compare($VisualStudio,"VS100",$True)
IF($reI -eq 0)
  {
    #Write-host "VS120 LALALAL"
    Write-Host "Check Visual Studio 2013 Install !!!!!"
    $DefaultFramework=4.51
    IF($env:VS120COMNTOOLS -eq $null)
    {
      Print-VisualStudioNotFound 'VisualStudio 2013' "${env:VS120COMNTOOLS}"
      exit
    }
    $IDE="${env:VS120COMNTOOLS}..\IDE"
    if($SystemType -eq 64)
    {
    $VSInstall=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VS7' '12.0'
    $VCDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' '12.0'
    $SDKDIR=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v8.1' 'InstallationFolder'
    $NetTools=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools-x64' 'InstallationFolder'
    $FrameworkDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' 'FrameworkDir64'
    $FrameworkVer=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' 'FrameworkVer64'
    $FSharpDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\12.0\Setup\F#' 'ProductDir'
    
    
    }
    else
    {
    $VSInstall=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VS7' '12.0'
    $VCDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' '12.0'
    $SDKDIR=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.1' 'InstallationFolder'
    $NetTools=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools' 'InstallationFolder'
    $FrameworkDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' 'FrameworkDir32'
    $FrameworkVer=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' 'FrameworkVer32'
    $FSharpDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\12.0\Setup\F#' 'ProductDir'
    
    }
    $KitBin32="${SDKDIR}bin\x86"
    $kitBin64="${SDKDIR}bin\x64"
    $KitBinARM="${SDKDIR}bin\ARM"   
    $KitInc="${SDKDIR}Include\um;${SDKDIR}Include\Shared;${SDKDIR}Include\WinRT"
    $KitLib32="${SDKDIR}Lib\winv6.3\um\x86"
    $KitLib64="${SDKDIR}Lib\winv6.3\um\x64"
    $KitLibARM="${SDKDIR}LIB\winv6.3\um\ARM"
    $db=[System.String]::Compare($Platform,"X64",$True)
    $dbx=[System.String]::Compare($Platform,"X86",$True)
    IF($db -eq 0)
    {
     $env:Path="${SDKDIR}Debuggers\x64;$env:Path"
    }ELSEIF($dbx -eq 0)
    {
     $env:Path="${SDKDIR}Debuggers\x86;$env:Path"
    }
  }
ELSEIF($reII -eq 0)
  {
    $DefaultFramework=4.5
    Write-Host "Check Visual Studio 2012 Install !!!!!"
    IF($env:VS110COMNTOOLS -eq $null)
    {
      Print-VisualStudioNotFound 'VisualStudio 2012' "${env:VS110COMNTOOLS}"
      exit
    }
    $IDE="${env:VS110COMNTOOLS}..\IDE"
    if($SystemType -eq 64)
    {
    $VSInstall=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VS7' '11.0'
    $VCDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' '11.0'
    $SDKDIR=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v8.0' 'InstallationFolder'
    $NetTools=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools-x64' 'InstallationFolder'
    $FrameworkDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' 'FrameworkDir64'
    $FrameworkVer=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' 'FrameworkVer64'
    $FSharpDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\11.0\Setup\F#' 'ProductDir'
    #$NetTools="${NetTools}bin"
    }
    else
    {
    $VSInstall=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VS7' '11.0'
    $VCDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' '11.0'
    $SDKDIR=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0' 'InstallationFolder'
    $NetTools=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools' 'InstallationFolder'
    $FrameworkDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' 'FrameworkDir32'
    $FrameworkVer=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' 'FrameworkVer32'
    $FSharpDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\11.0\Setup\F#' 'ProductDir'
    }
    $KitBin32="${SDKDIR}bin\x86"
    $kitBin64="${SDKDIR}bin\x64"
    $KitBinARM="${SDKDIR}bin\ARM"
    $KitInc="${SDKDIR}Include\um;${SDKDIR}Include\Shared;${SDKDIR}Include\WinRT"
    $KitLib32="${SDKDIR}Lib\win8\um\x86"
    $KitLib64="${SDKDIR}Lib\win8\um\x64"
    $KitLibARM="${SDKDIR}LIB\win8\um\ARM"
  }
ELSEIF($reIII -eq 0)
  {
    Write-Host "Check Visual Studio 2010 Install !!!!!"
    IF($env:VS100COMNTOOLS -eq $null)
    {
      Print-VisualStudioNotFound 'VisualStudio 2010' "${env:VS100COMNTOOLS}"
      exit
    }
    ELSE
    {
      $Result=Test-Path "$env:VS100COMNTOOLS"
      if($Result -eq $false)
      {
        Print-VisualStudioNotFound 'VisualStudio 2010' "${env:VS100COMNTOOLS}"
        exit
      }
    }
    $Perr=[System.String]::Compare($Platform,"ARM",$True)
    IF($Perr -eq 0)
    {
      Write-Host -ForegroundColor Red "Error! Visual Studio Not Support ARM Platform."
      Start-Sleep 5
      Exit
    }
    $DefaultFramework=4.0
    
    $IDE="${env:VS100COMNTOOLS}..\IDE"
    if($SystemType -eq 64)
    {
    $VSInstall=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VS7' '10.0'
    $VCDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' '10.0'
    $SDKDIR=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v7.0A' 'InstallationFolder'
    $NetTools=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v7.0A\WinSDK-NetFx40Tools-x64' 'InstallationFolder'
    $FrameworkDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' 'FrameworkDir64'
    $FrameworkVer=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' 'FrameworkVer64'
    $FSharpDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\10.0\Setup\F#' 'ProductDir'
    #$NetTools="${NetTools}bin"
    }
    else
    {
    $VSInstall=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VS7' '10.0'
    $VCDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' '10.0'
    $SDKDIR=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v7.0A' 'InstallationFolder'
    $NetTools=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v7.0A\WinSDK-NetFx40Tools' 'InstallationFolder'
    $FrameworkDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' 'FrameworkDir32'
    $FrameworkVer=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' 'FrameworkVer32'
    $FSharpDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\10.0\Setup\F#' 'ProductDir'
    }
    $KitBin32="${SDKDIR}bin"
    $kitBin64="${SDKDIR}bin\x64"
    $KitInc="${SDKDIR}Include"
    $KitLib32="${SDKDIR}Lib"
    $KitLib64="${SDKDIR}Lib\x64"
  
  }
ELSE
  {
    #Write-host "VS120 LALALAL"
    Write-Host "Check Visual Studio 2013 Install !!!!!"
    $DefaultFramework=4.51
    
    $IDE="${env:VS120COMNTOOLS}..\IDE"
    if($SystemType -eq 64)
    {
    $VSInstall=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VS7' '12.0'
    $VCDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' '12.0'
    $SDKDIR=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v8.1' 'InstallationFolder'
    $NetTools=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools-x64' 'InstallationFolder'
    $FrameworkDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' 'FrameworkDir64'
    $FrameworkVer=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\SxS\VC7' 'FrameworkVer64'
    $FSharpDir=Get-RegistryValue 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\VisualStudio\12.0\Setup\F#' 'ProductDir'
    }
    else
    {
    $VSInstall=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VS7' '12.0'
    $VCDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' '12.0'
    $SDKDIR=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.1' 'InstallationFolder'
    $NetTools=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\Microsoft SDKs\Windows\v8.0A\WinSDK-NetFx40Tools' 'InstallationFolder'
    $FrameworkDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' 'FrameworkDir32'
    $FrameworkVer=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\SxS\VC7' 'FrameworkVer32'
    $FSharpDir=Get-RegistryValue 'HKLM:\SOFTWARE\Microsoft\VisualStudio\12.0\Setup\F#' 'ProductDir'
    }
    $KitBin32="${SDKDIR}bin\x86"
    $kitBin64="${SDKDIR}bin\x64"
    $KitBinARM="${SDKDIR}bin\ARM"
    $KitInc="${SDKDIR}Include\um;${SDKDIR}Include\Shared;${SDKDIR}Include\WinRT"
    $KitLib32="${SDKDIR}Lib\winv6.3\um\x86"
    $KitLib64="${SDKDIR}Lib\winv6.3\um\x64"
    $KitLibARM="${SDKDIR}LIB\winv6.3\um\ARM"
  }
IF($SystemType -eq 64)
{
  $FrameworkDir="${FrameworkDir}\"
  #$env:PATH="$FSharpDir;$env:PATH"
}

$env:Path="$FSharpDir;$NetTools;${FrameworkDir}${FrameworkVer};$env:Path"

$re1=[System.String]::Compare($Platform,"X64",$True)
$re2=[System.String]::Compare($Platform,"X86",$True)
$re3=[System.String]::Compare($Platform,"ARM",$True)

IF($re1 -eq 0){
IF($SystemType -eq 32)
{
$Compiler="${VCDir}bin\x86_amd64"
$Library="${VCDir}lib\amd64"
$env:Path="$Compiler;$KitBin32;$IDE;${VCDIR}bin;$env:PATH"
$env:INCLUDE="$KitInc;${VCDir}Include;$env:INCLUDE"
$env:LIB="$KitLib64;${VCDir}Lib\amd64;$env:LIB"
}
ELSE{
$Compiler="${VCDir}bin\amd64"
$Library="${VCDir}lib\amd64"
$env:Path="$Compiler;$KitBin64;$IDE;$env:PATH"
$env:INCLUDE="$KitInc;${VCDir}Include;$env:INCLUDE"
$env:LIB="$KitLib64;${VCDir}Lib\amd64;$env:LIB"
}
#Test OK
}
ELSEIF($re2 -eq 0){
$Compiler="${VCDir}bin"
$Library="${VCDir}lib"
$env:Path="$Compiler;$KitBin32;$IDE;$env:PATH"
$env:INCLUDE="$KitInc;${VCDir}Include;$env:INCLUDE"
#VS120 OK
$env:LIB="$KitLib32;${VCDir}LIB;$env:LIB"
#echo $Compiler
}
ELSEIF($re3 -eq 0){
$Compiler="${VCDir}bin\x86_ARM"
$Library="${VCDir}lib\arm"
$env:Path="$Compiler;${VCDir}bin;$KitBinARM;$KitBin32;$IDE;$env:PATH"
$env:INCLUDE="$KitInc;${VCDir}Include;$env:INCLUDE"
$env:LIB="$KitLibARM;${VCDir}LIB\arm;$env:LIB"
}ELSE
{
$Compiler="${VCDir}bin"
$Library="${VCDir}lib"
$env:Path="$Compiler;$KitBin32;$IDE;$env:PATH"
$env:INCLUDE="$KitInc;${VCDir}Include;$env:INCLUDE"
#VS120 OK
$env:LIB="$KitLib32;${VCDir}LIB;$env:LIB"
}

#Base C/C++ Native Environment Support
#///////////////////////////////////////////////////////////////////////#

#Write-Host "${VCDir}..\Common7\IDE"
#Write-Host $Compiler $Library

#Write-Host $Global:WindowTitlePrefix.ToString()
#Find Visual Studio 2013

#//////////////////////////////////////////////////////////////////////#
#Extend C/C++ Environment


#.Net Framework Check
#Framework or Framework64
#dir variable: show value