% SHOREFOR v 1.2
% Main program that calls subroutines to calibrate, hindcast, forecast and
% output shoreline predictions for a given site. 
% Mark Davidson, Kristen Splinter, Ian Turner
% Last edit: Jan 16, 2014.

% list all variables needed to be passed among codes here
global H T dnum data dates_survey w Hb HbCal
global  A cutoff vShoreFor
global HCal TCal wCal dnumCal dataCal mCal dxCal 
global  mCal dates_survey iswitchCal
global  hindStats calStats iShore site hWaveC hWaveH

    format SHORT ENG
% version number
    vShoreFor='v1.0';
% an input file (userData.mat) listing file names and variables can be 
% created instead of manullay inputting this info in input_data. A matlab 
% program (genUserData.m)is provided for this purpose. input_data
% checks if this file exists and if it doesn't, prompts user for info.

input_data_TB

%check sizes
if length(data) ~=length(dates_survey); errordlg('Warning: Length of shoreline data dates file does not match the length of data file, programme aborted'); break; end    
if length(H) ~=length(dnum); errordlg('Warning: Length of wave dates file does not match the length of wave file, programme aborted'); break; end    

calibrate_modelWSG85_TB(HbCal,TCal,wCal,dnumCal,dataCal)
hindcast_data_TB(Hb,T,w,dnum,data)

output_results_TB
