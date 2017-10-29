:: -------------------------------------------------------------------
:: Batch creation - 17/02/2015
:: Creator        - Peter Birksmith 
:: -------------------------------------------------------------------

::--------------------------------------------------------------------
:: Get date
::--------------------------------------------------------------------
	for /f "tokens=2-4 delims=/:, " %%a in ('date /t') do (
	        set day=%%a
	        set month=%%b
	        set yy=%date:~12,2%
	        set yyyy=%date:~10,4%
		set mm=%date:~7,2%
		set dd=%date:~4,2%)
			       
	        if "%date:~6,1%"==" " set yy=0%yy:~1,1%
		if "%date:~3,1%"==" " set mm=0%mm:~1,1%
		if "%date:~0,1%"==" " set dd=0%dd:~1,1%  
	      
	      
		ECHO %date%	      
	        :: Day of Week minus 1 day
	        SET /A dwDAY=%date:1~4,2%-100
	        
	        :: Day of Week
	        set dd2=%date:~0,2%
	        set dd3=%date:~0,3%
	        
	        :: Day before
		set /A daybf=1%dd%-101
		if /i %daybf% LSS 10 set daybf=0%daybf%
		
		:: Month before
		set /A mnbf=1%mm%-101
		if /i %mnbf% LSS 10 set mnbf=0%mnbf%
		
		ECHO %dwDAY%
		ECHO %daybf%
		ECHO %mnbf%

	set ESRDATE=%day%%month%%year%
	
	
:: ------------------------------------------------------------------
:: Get_Time
:: ------------------------------------------------------------------
	for /f "Tokens=1" %%i in ('time /t') do set tm=%%i
	set tm=%tm::=%

:: ------------------------------------------------------------------
::  SET PATH SOURCE and Destinations
:: ------------------------------------------------------------------

SET ESRCSVINPUT=D:\ArcGISData\Data\GEP\Hailstorm\input
SET ESRARCHFOLDER=D:\Archive\Hail_csv
SET ESRARCHLOG=D:\Archive\Logs

SET GBMAILER=D:\Apps\gmail
SET MXSRV=smtp.com
SET MXPORT=25

SET EMAILRECP1=
SET RECPIENTS=%EMAILRECP1% 
::%EMAILRECP2%
SET FROMADDR=RD-ROBOT@iag.com.au
 
SET EMAILMSG1="Files arrived"
SET EMAILMSG2="Files have not arrived"

SET SUCCESSMSG="Move succeeded"


:: -------------------------------------------------------------------
:: Make Archive Directory
:: -------------------------------------------------------------------

mkdir %ESRARCHFOLDER%\%day%_%month%_%year%

:: -------------------------------------------------------------------
:: Move File to Archive Directory
:: -------------------------------------------------------------------

move %ESRCSVINPUT%\%year%%month%%daybf%_*.csv %ESRARCHFOLDER%\%day%_%month%_%year% >> %ESRARCHLOG%\CSV_%day%_%month%_%year%.log

	::================================================
	::Email 
	::================================================

:EMAIL
%GBMAILER% -to %RECPIENTS% -h %MXSRV% -p %MXPORT% -from %FROMADDR% -s %SUCCESSMSG%

:END
exit;
