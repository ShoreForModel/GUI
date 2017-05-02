function output_results
global site dnum dnumCal iShore datesCal dates_survey iCal
global dataFile HFile filePathName filePathNameCal dataFileCal HFileCal 
global  calStats hindStats vShoreFor hWaveC hWaveH iswitchCal



% Model/Data timestep - seconds - NB must be a regular time-step in data!
    dt=round((dnum(2)-dnum(1))*24*60*60);
    dtCal=round((dnumCal(2)-dnumCal(1))*24*60*60);
    dtShoreline=mean(diff(dates_survey));
    dtShoreCal = mean(diff(datesCal));
        

% Output model results to screen:
clc
 % Save output first go is quick and dirty - i.e. save whole workspace!
 %uisave 
%  fid = fopen(['Results_' site '.txt'],'w');
try
    [FileName, PathName]=uiputfile('','Select where to save data output (.txt)',['Full_Results_' site]);
    [~, Name, ~] = fileparts(FileName);
    fid = fopen([PathName Name '.txt'],'w');
catch
    errordlg(['A valid file location and name was not selected, results have been saved as Results_' site '.txt in the current directory.'])
    fid = fopen(['Full_Results_' site '.txt'],'w');
end 
%  disp('Saving output to file')
% Output model results to file:
        fprintf(fid, '%s\r\n', '++++++++++++++++++++PROGRAM RESULTS+++++++++++++++++++++++++++++++++++++++++++++');
        fprintf(fid, '%s\r\n', ['Site modelled : ' site]);
        fprintf(fid, '%s\r\n', ['Model used : ShoreFor ' vShoreFor]);
        
        fprintf(fid, '%s\r\n', '++++++++++++++++++++CALIBRATION RESULTS+++++++++++++++++++++++++++++++++++++++++++++');
        fprintf(fid, '%s\r\n', ['File analysed : ' filePathNameCal]);
        fprintf(fid, '%s\r\n', ['Shoreline data analysed : ' char(dataFileCal)]);
        fprintf(fid, '%s\r\n', ['Shoreline contour elevation (m) : ' num2str(calStats.contourShore)]);
        fprintf(fid, '%s\r\n', ['Median grain size, d50 (mm) : ' num2str(calStats.d50)]);
        fprintf(fid, '%s\r\n', ['Wave height variable selected : ' char(HFileCal)]);
        fprintf(fid, '%s\r\n', ['Shoreline data sampling interval (days) = ' num2str(dtShoreCal)]);
        fprintf(fid, '%s\r\n', ['Wave data sampling interval (hours) = ' num2str(dtCal./(60*60))]);        
         fprintf(fid, '%s\r\n', ['Wave data depth = ' num2str(hWaveC)]);        
        fprintf(fid, '%s\r\n', ['Omega low pass filter cutoff in days = D = ' num2str(calStats.D), ' phi = ', num2str(calStats.phi)]);
 %       fprintf(fid, '%s\r\n', ['Include tidal exposure index (y/n) : ' char(tideSwitchCal)])
        fprintf(fid, '%s\r\n', ['Omega record mean = ' num2str(calStats.omegaRecordMean)]);
        if iswitchCal==3
            fprintf(fid, '%s\r\n', ['Monthly mean omega std = ' num2str(calStats.stdOmega)]);
            fprintf(fid, '%s\r\n', ['Yearly mean omega std = ' num2str(calStats.stdYearOmega)]);
            fprintf(fid, '%s\r\n', ['Representative mean omega = ' num2str(calStats.omegaRep)]);
        end 
        fprintf(fid, '%s\r\n', ['Power record mean = ' num2str(calStats.meanP)]);
        fprintf(fid, '%s\r\n', ['Linear trend term in linear model (m/yr) = ' num2str(calStats.linModelA(2).*(60*60*24*365))]);
        fprintf(fid, '%s\r\n', ['Optimal coefficients (a, b, c) = ']);
        fprintf(fid, '%s\r\n', ['Shoreline offset (m) = ' num2str(calStats.A(1))]);
        fprintf(fid, '%s\r\n', ['Shoreline trend (m/yr) = ' num2str(calStats.A(2).*(60*60*24*365))]);
        fprintf(fid, '%s\r\n', ['Shoreline response rate ((m/s)/(W/m).^0.5) = ' num2str(calStats.A(3))]);
        fprintf(fid, '%s\r\n', ['Erosion:Accretion ratio = ' num2str(calStats.r)]) ;
        fprintf(fid, '%s\r\n', ['RMS Error for ShoreFor (m) = ' num2str(calStats.rmse)]);
        fprintf(fid, '%s\r\n', ['RMS Error for linear model (m) = ' num2str(calStats.rmstrend)]);
        fprintf(fid, '%s\r\n', ['NMS Error for ShoreFor  = ' num2str(calStats.nmse)]);
        fprintf(fid, '%s\r\n', ['NMS Error for linear model  = ' num2str(calStats.nmstrend)]);
        fprintf(fid, '%s\r\n', ['Correlation coefficient = ' num2str(calStats.cc)]);
        fprintf(fid, '%s\r\n', ['Linear trend corr coeff = ' num2str(calStats.cr)]);
        fprintf(fid, '%s\r\n', ['Akaike Information Criteria ShoreFor = ' num2str(calStats.AIC)]);
        fprintf(fid, '%s\r\n', ['Akaike Information Criteria  linear model = ' num2str(calStats.AIClin)]);
        fprintf(fid, '%s\r\n', ['Brier Skills Score = ' num2str(calStats.BSS)]);
        fprintf(fid, '%s\r\n', ['Percent time correct (within +/- dx)   = ' num2str(calStats.PTimeCorrect*100)]);
        fprintf(fid, '%s\r\n', ['Error specified for shoreline position (m) = ' num2str(calStats.dx)]) ;
        fprintf(fid, '%s\r\n', ['Average alongshore variability specified for shoreline position (m) = ' num2str(calStats.stdyShore)]); 
        fprintf(fid, '%s\r\n', ['Number of survey data points used in calibration= ' num2str(length(iCal))]);
        fprintf(fid, '%s\r\n', '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
        fprintf(fid, '%s\r\n', '++++++++++++++++++++HINDCAST RESULTS+++++++++++++++++++++++++++++++++++++++++++++');
        fprintf(fid, '%s\r\n', ['File analysed : ' filePathName]);
        fprintf(fid, '%s\r\n', ['Shoreline data analysed : ' char(dataFile)]);
        fprintf(fid, '%s\r\n', ['Shoreline contour elevation (m) : ' num2str(hindStats.contourShore)]);
%        fprintf(fid, '%s\r\n', ['Include tidal exposure index (y/n) : ' char(tideSwitch)])
        fprintf(fid, '%s\r\n', ['Median grain size, d50 (mm) : ' num2str(hindStats.d50)]);
        fprintf(fid, '%s\r\n', ['Wave height variable selected : ' char(HFile)]);
        fprintf(fid, '%s\r\n', ['Shoreline data sampling interval (days) = ' num2str(dtShoreline)]);
        fprintf(fid, '%s\r\n', ['Wave data sampling interval (hours) = ' num2str(dt./(60*60))]);
        fprintf(fid, '%s\r\n', ['Wave data depth = ' num2str(hWaveH)]);        
        fprintf(fid, '%s\r\n', ['Error specified for shoreline position (m) = ' num2str(hindStats.dx)]) ;
        fprintf(fid, '%s\r\n', ['Average alongshore variability specified for shoreline position (m) = ' num2str(hindStats.stdyShore)]); 
        fprintf(fid, '%s\r\n', ['Number of survey data points used in hindcast= ' num2str(length(iShore))]);
        fprintf(fid, '%s\r\n', ['Omega record mean = ' num2str(hindStats.omegaRecordMean)]);
        fprintf(fid, '%s\r\n', ['Shoreline offset (m) a = ' num2str(hindStats.A(1))]);
        fprintf(fid, '%s\r\n', ['Shoreline trend (m/yr) b = ' num2str(hindStats.A(2).*(60*60*24*365))]);
        fprintf(fid, '%s\r\n', ['Shoreline response rate ((m/s).(W/m).^0.5) = c ' num2str(hindStats.A(3))]);
        fprintf(fid, '%s\r\n', ['Erosion:Accretion ratio = ' num2str(hindStats.r)]) ;

        fprintf(fid, '%s\r\n', '++++++LINEAR MODEL+++++++++++++++++++++++++++++++++++++++++++++');
        fprintf(fid, '%s\r\n', ['RMS Error for linear model (m) = ' num2str(hindStats.rmstrend)]);
        fprintf(fid, '%s\r\n', ['NMS Error for linear model (m) = ' num2str(hindStats.nmstrend)]);
        fprintf(fid, '%s\r\n', ['Akaike Information Criteria  linear model = ' num2str(hindStats.AIClin)]);
        fprintf(fid, '%s\r\n', ['Linear trend corr coeff = ' num2str(hindStats.cr)]);
        fprintf(fid, '%s\r\n', '+++++++SHOREFOR MODEL+++++++++++++++++++++++++++++++');
        fprintf(fid, '%s\r\n', ['RMS Error for ShoreFor(m) = ' num2str(hindStats.rmse)]);
        fprintf(fid, '%s\r\n', ['NMS Error for ShoreFor  = ' num2str(hindStats.nmse)]);
        fprintf(fid, '%s\r\n', ['Correlation coefficient = ' num2str(hindStats.cc)]);
        fprintf(fid, '%s\r\n', ['Brier Skills Score = ' num2str(hindStats.BSS)]);
        fprintf(fid, '%s\r\n', ['Akaike Information Criteria   = ' num2str(hindStats.AIC)]);
        fprintf(fid, '%s\r\n', ['Percent time correct (within +/- dx)   = ' num2str(hindStats.PTimeCorrect*100)]);
%     check4=evalin('base','check4');
%     if check4==1
%          open(fopen(fid));
%           !Notepad fid
%     else
%         fclose(fid);
%     end
fclose(fid);
