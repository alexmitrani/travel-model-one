
:: ------------------------------------------------------------------------------------------------------
::
:: Step 0:  Set up folder structure and copy inputs from base and non-base
::
:: ------------------------------------------------------------------------------------------------------

SET computer_prefix=%computername:~0,4%

:: copy over CTRAMP
set GITHUB_DIR= %USERPROFILE%\Documents\GitHub\travel-model-one
mkdir CTRAMP\model
mkdir CTRAMP\runtime
mkdir CTRAMP\scripts
mkdir CTRAMP\scripts\metrics
c:\windows\system32\Robocopy.exe /E %GITHUB_DIR%\model-files\model       CTRAMP\model
c:\windows\system32\Robocopy.exe /E %GITHUB_DIR%\model-files\runtime     CTRAMP\runtime
c:\windows\system32\Robocopy.exe /E %GITHUB_DIR%\model-files\scripts     CTRAMP\scripts
c:\windows\system32\Robocopy.exe /E %GITHUB_DIR%\utilities\RTP\metrics   CTRAMP\scripts\metrics
:: copy /Y %GITHUB_DIR%\utilities\monitoring\notify_slack.py                CTRAMP\scripts
copy /Y %GITHUB_DIR%\model-files\RunModel.bat                            .
copy /Y %GITHUB_DIR%\model-files\RestartRunModel.bat                     .
copy /Y %GITHUB_DIR%\model-files\LogRunModel.bat 						 .
copy /Y %GITHUB_DIR%\model-files\LogRestartRunModel.bat					 .
copy /Y %GITHUB_DIR%\model-files\LogRestartRunModel0.bat					 .
copy /Y %GITHUB_DIR%\model-files\RunIteration.bat                        CTRAMP
copy /Y %GITHUB_DIR%\model-files\FullRunIteration.bat                    CTRAMP
copy /Y %GITHUB_DIR%\model-files\RestartRunIteration.bat                 CTRAMP
copy /Y %GITHUB_DIR%\model-files\RunLogsums.bat                          .
copy /Y %GITHUB_DIR%\model-files\RunCoreSummaries.bat                    .
copy /Y %GITHUB_DIR%\model-files\RunPrepareEmfac.bat                     .
copy /Y %GITHUB_DIR%\utilities\RTP\RunMetrics.bat                        .
copy /Y %GITHUB_DIR%\utilities\RTP\RunScenarioMetrics.bat                .
copy /Y %GITHUB_DIR%\utilities\RTP\RestartExtractKeyFiles.bat                   .
copy /Y %GITHUB_DIR%\utilities\RTP\QAQC\Run_QAQC.bat                     .
copy /Y %GITHUB_DIR%\utilities\check-setupmodel\Check_SetupModelLog.py   .


:: if %COMPUTER_PREFIX% == BIGI    (copy %GITHUB_DIR%\utilities\monitoring\notify_slack.py  CTRAMP\scripts\notify_slack.py)
if %COMPUTER_PREFIX% == BIGI    set HOST_IP_ADDRESS=10.60.10.70

:: copy over CUBE6_VoyagerAPI
set MODEL_ROOT_DIR=F:\23791501
c:\windows\system32\Robocopy.exe /E %MODEL_ROOT_DIR%\CUBE6_VoyagerAPI                       	CUBE6_VoyagerAPI

:: copy over INPUTs from baseline
set MODEL_SETUP_BASE_DIR=F:\23791501\mtcdrive\2015_TM152_IPA_16
c:\windows\system32\Robocopy.exe /E %MODEL_SETUP_BASE_DIR%\INPUT\landuse                       INPUT\landuse
c:\windows\system32\Robocopy.exe /E %MODEL_SETUP_BASE_DIR%\INPUT\logsums                       INPUT\logsums
c:\windows\system32\Robocopy.exe /E %MODEL_SETUP_BASE_DIR%\INPUT\metrics                       INPUT\metrics
c:\windows\system32\Robocopy.exe /E %MODEL_SETUP_BASE_DIR%\INPUT\nonres                        INPUT\nonres
c:\windows\system32\Robocopy.exe /E %MODEL_SETUP_BASE_DIR%\INPUT\popsyn                        INPUT\popsyn
c:\windows\system32\Robocopy.exe /E %MODEL_SETUP_BASE_DIR%\INPUT\warmstart                     INPUT\warmstart
c:\windows\system32\Robocopy.exe /E %MODEL_SETUP_BASE_DIR%\INPUT\hwy                           INPUT\hwy
c:\windows\system32\Robocopy.exe /E %MODEL_SETUP_BASE_DIR%\INPUT\trn                           INPUT\trn

:: params2015.properties copied to params.properties as the version from %MODEL_SETUP_BASE_DIR%\INPUT was producing an error: "Couldn't find Bike_Infra_C_IVT_Multiplier in INPUT\params.properties"
:: copy /Y %MODEL_SETUP_BASE_DIR%\INPUT\params.properties                                         INPUT\params.properties
copy /Y %GITHUB_DIR%\config\params_2015.properties						INPUT\params.properties
:: the following line was taken from SetUpModel_PBA50.bat
copy /Y %GITHUB_DIR%\utilities\telecommute\telecommute_max_rate_county.csv                  INPUT\landuse


::-----------------------------------------------------------------------
:: add folder name to the command prompt window 
::-----------------------------------------------------------------------
set MODEL_DIR=%CD%
set PROJECT_DIR=%~p0
set PROJECT_DIR2=%PROJECT_DIR:~0,-1%
:: get the base dir only
for %%f in (%PROJECT_DIR2%) do set myfolder=%%~nxf

title %myfolder%


::-----------------------------------------------------------------------
:: create a shortcut of the project directory using a temporary VBScript
::-----------------------------------------------------------------------

:: set TEMP_SCRIPT=%CD%\temp_script_to_create_shortcut.vbs
:: set PROJECT_DIR=%~p0
:: set ALPHABET=%computername:~7,1%

:: echo Set oWS = WScript.CreateObject(WScript.Shell) >> %TEMP_SCRIPT%
:: echo sLinkFile = %M_DIR%/model_run_on_%computername%.lnk >> %TEMP_SCRIPT%
:: echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %TEMP_SCRIPT%
:: echo oLink.TargetPath = F: >> %TEMP_SCRIPT%
:: echo oLink.TargetPath = \\%computername%\%PROJECT_DIR% >> %TEMP_SCRIPT%

:: echo oLink.Save >> %TEMP_SCRIPT%

:: C:\Windows\SysWOW64\cscript.exe /nologo %TEMP_SCRIPT%
:: C:\Windows\SysWOW64\cscript.exe %TEMP_SCRIPT%
:: del %TEMP_SCRIPT%