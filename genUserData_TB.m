function genUserData

global H T dnum data dates_survey w dx m mm dtShoreline iShore 
global iCal iWave k ihardWire iWaveCal iConstC dataStd dataStdCal
global HCal TCal wCal dnumCal dataCal mCal dxCal mmCal datesCal
global hWaveH hWaveC A cutoff site omegaFilterCutOff contShore contShoreCal
global dataFile HFile fileWave fileShoreline iswitchCal filePathNameCal dataFileCal s1 s2 HFileCal
global tide tideCal tideSwitch tideSwitchCal beta betaCal zShore zShoreCal calStats hindStats 

% Saves the file locations for later use
    fileWave=evalin('base','fileWave');
    fileShoreline=evalin('base','fileShoreline');

% Retrieves all user input within GUI
    site=evalin('base','siteGUI');
    dataFile=evalin('base','FileData');
    dataStdFile=evalin('base','FileSTD');
    zFile=evalin('base','FileZ');
    datesFile=evalin('base','FileShoreDate');
    HFile=evalin('base','FileH');
    TFile=evalin('base','FileT');    
    datesFileWave=evalin('base','FileWaveDate'); 

    hWaveH=evalin('base','hWaveHGUI');
    hWaveH=str2double(hWaveH); % Converts input string to double
    d50=evalin('base','d50GUI');
    d50=str2double(d50);
    dx=evalin('base','dxGUI');
    dx=str2double(dx);

 %% CALIBRATION DATA SET
   % 0 for FULL data set
   % 1 for PARTIAL data set
   % 2 for DIFFERENT data set
   % 3 for PARAMETERIZED COEFFICIENTS based on Splinter et al. (2014)

    iswitchCal=evalin('base','iswitchCalGUI');
    if iswitchCal==1 %gets start and end date from GUI input
        s1=evalin('base','s1GUI');
        s2=evalin('base','s2GUI');
    elseif iswitchCal==2 %evaluates secondary user input
        fileWaveCal=evalin('base','fileWaveCal')
        fileShorelineCal=evalin('base','fileShorelineCal')       
        
        dataFileCal=evalin('base','FileDataCal');
        dataStdFileCal=evalin('base','FileSTDCal');
        zFileCal=evalin('base','FileZCal');
        datesFileCal=evalin('base','FileShoreDateCal');
        HFileCal=evalin('base','FileHCal');
        TFileCal=evalin('base','FileTCal');   
        datesFileWaveCal=evalin('base','FileWaveDateCal');  

        hWaveHCal=evalin('base','hWaveHGUICal');
        hWaveHCal=str2double(hWaveHCal);
        d50Cal=evalin('base','d50GUICal');
        d50Cal=str2double(d50Cal);
        dxCal=evalin('base','dxGUICal');
        dxCal=str2double(dxCal);
    end
    
    if iswitchCal~=3
        ihardWire=evalin('base','ihardwireGUI');
        
        if (ihardWire==0)
            omegaFilterCutOff=evalin('base','omegaFilterCutOffGUI')
        end
    end
   
	iConstC=0;
   

 	k=0.5;  % exponent in equation (hard wired)

save userData.mat