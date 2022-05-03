@REM https://github.com/MSFPT/Matrix
@REM good luck deciphering this mess
@echo off
title MSFPT/Matrix
setlocal enabledelayedexpansion
for /f "tokens=2 delims=[]" %%a in ('ver') do for /f "tokens=2 delims=. " %%a in ("%%a") do set /a "FullScreen=-((%%a-6)>>31)"

if "%1"=="" (
  for %%a in (FontSize:00080008 FontFamily:00000030 WindowSize:00320050 ScreenColors:0000000a CodePage:000001b5 ScreenBufferSize:00320050 FullScreen:!FullScreen!
  ) do for /f "tokens=1,2 delims=:" %%b in ("%%a") do (
    >nul reg add HKCU\Console\TheMatrix /v %%b /t reg_dword /d 0x%%c /f
  )
  start "TheMatrix" /max "%ComSpec%" /c "%~f0" 1 & exit
) else ( >nul reg delete HKCU\Console\TheMatrix /f )

set "Matrix="
set /a "wid=80,hei=50,iMax=wid*hei, sumOfStream=wid*2/2"
for /l %%i in (1 1 !iMax!) do set "Matrix= !Matrix!"
set "bss=!Matrix: =!"

set "dic=~@#$&*()_+{}|<>?`[]\;',./1234567890"
set "dicLen=35"

for /l %%# in (1 1 !wid!) do set "s%%#=0"
for /l %%* in (0 0 0) do (
  for /l %%# in (1 1 !sumOfStream!) do (
    if !s%%#! leq 1 (
      set /a "h%%#=!random!%%(hei-1)+2,p0%%#=!random!%%(wid*(hei+1-h%%#))+1,l%%#=h%%#+!random!%%hei+1,s%%#=l%%#+h%%#,h%%#+=1,p%%#=p0%%#"
    )
    set /a "s%%#-=1,l%%#-=1,h%%#-=1,old=(l%%#-1)>>31,grow=-h%%#>>31,act=grow|old,old0=-^!l%%#,p%%#=(old0&p0%%#)|(~old0&p%%#)"

    if !act! neq 0 (
      set /a "lL=p%%#-1, lR=iMax-p%%#, r=!random! %% dicLen"
      if !old! neq 0 (set "chr= ") else for %%r in (!r!) do set "chr=!dic:~%%r,1!"
      for /f "tokens=1-3" %%a in ("!lL! !p%%#! !lR!") do (set "Matrix=!Matrix:~0,%%a!!chr!!Matrix:~%%b,%%c!")
      set /a "p%%#+=wid"
    )
  )
  cls & <nul set /p "=!Matrix:~0,-1!!bss!"
)
