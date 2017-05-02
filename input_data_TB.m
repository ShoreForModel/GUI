function input_data

global H T dnum data dates_survey w dx m mm dtShoreline iShore 
global iCal iWave k ihardWire iWaveCal iConstC dataStd dataStdCal
global HCal TCal wCal dnumCal dataCal mCal dxCal mmCal datesCal
global hWaveH hWaveC A cutoff site omegaFilterCutOff contShore contShoreCal
global dataFile HFile fileWave fileShoreline iswitchCal fileWaveCal fileShorelineCal dataFileCal s1 s2 HFileCal
global tide tideCal tideSwitch tideSwitchCal beta betaCal zShore zShoreCal calStats hindStats Hb HbCal

% Loads userData file, 
load([pwd '/userData.mat'])

%% HINDCAST DATA SET
% Load files separately to avoid issues with variable of same name
% Wave data
    load(fileWave);
    H=eval(char(HFile)); H=H(:);
    T=eval(char(TFile)); T=T(:);
    dnum=eval(char(datesFileWave));
    clear y mo d hr mi s
    [y,mo,d,hr,mi,s]=datevec(dnum(:));
    dnum=datenum([y,mo,d,round(hr+mi./60),zeros(size(y)),zeros(size(y))]);
% Shoreline data    
    load(fileShoreline);
    data=eval(char(dataFile));
    if ~isempty(dataStdFile)
       dataStd=eval(char(dataStdFile));
    else
       dataStd=[];
    end
    keep = find(isnan(data)==0);
    data=data(keep); data=data(:);
    if ~isempty(dataStd)
        dataStd=dataStd(keep); dataStd=dataStd(:);
    end
    dates_survey=eval(char(datesFile)); dates_survey=dates_survey(:);
    [y,mo,d,hr,mi,~]=datevec(dates_survey(keep));
    dates_survey=datenum([y,mo,d,round(hr+mi./60),zeros(size(y)),zeros(size(y))]);
    zShore=eval(char(zFile));
    if isnan(contShore)==1 
        contShore=nanmean(zShore);
    end
    ch=std(diff(dnum));
  
%     Commented this out on 11/2/15, replaced with section below it
%     if ch>1E-6
%         step=mode(diff(dnum*24)); %converts to hours and finds mode step
%         dnum2 = [dnum(1):step/24:dnum(end)]';
%         keep=find(dnum==dnum2);
%         H=H(keep);
%     end

    if ch>1E-6
        step=mode(diff(dnum*24)); %converts to hours and finds mode step
        dnum2 = [dnum(1):step/24:dnum(end)]';
        [~,ia,ib]=intersect(dnum,dnum2);
        H=H(ia);
        T=T(ia);
        dnum=dnum(ia);
    end
  
     w = fallvelocity(d50/1000,15);
     hindStats.d50=d50;

% Length of time-series
    m=length(dnum);
    [~,iShore,iWave]=intersect(dates_survey,dnum);
    dtShoreline=24*mean(diff(dates_survey)); % Average shoreline sampling in hours
    mm=length(iShore);

%%CALIBRATION DATA SET
   if iswitchCal==0 | iswitchCal==3
       dataStdCal=dataStd;
       iCal=iShore;
       iWaveCal=iWave;
       HCal=H;
       TCal=T;
       dataCal=data;
       dnumCal=dnum;
       datesCal=dates_survey;
       wCal=w;
       calStats.d50=d50;
       dxCal=dx;
       mCal=length(dnumCal);
      mmCal=length(iCal);
       fileWaveCal=fileWave;
       fileShorelineCal=fileShoreline;
      HFileCal=HFile;
      dataFileCal=dataFile;
      zShoreCal=zShore;
      contShoreCal=contShore;
      hWaveC=hWaveH;
%       if strcmp(tideSwitch,'y')==1
%       TideFileCal=TideFile;
%       datesFileTideCal=datesFileTide;
%       tideOffsetCal=tideOffset;
%       betaCal=beta;
%       tideCal=tide;
%       end
%        tideSwitchCal=tideSwitch;

   elseif iswitchCal==1
       t1 = datenum(s1);
       t2 = datenum(s2);
       icalW = find(dnum>=t1 & dnum <= t2);
       dnumCal=dnum(icalW);
       HCal=H(icalW);
       TCal=T(icalW);
       icalS = find(dates_survey>=t1 & dates_survey <= t2);
       datesCal = dates_survey(icalS);
       dataCal=data(icalS);
       [~,iCal,iWaveCal]=intersect(dates_survey(icalS),dnum(icalW));
       wCal=w;
       calStats.d50=d50;
       dxCal=dx;
       mCal=length(dnumCal);
       mmCal=length(iCal);
       fileWaveCal=fileWave;
       fileShorelineCal=fileShoreline;
       HFileCal=HFile;
       dataFileCal=dataFile;
       zShoreCal=zShore(icalS);
       contShoreCal=contShore;
       try
       dataStdCal=dataStd(icalS);
       end
       hWaveC=hWaveH;
%       if strcmp(tideSwitch,'y')==1
%       tideCal=tide(icalW);
%       TideFileCal=TideFile;
%       datesFileTideCal=datesFileTide;
%       tideOffsetCal=tideOffset;
%       betaCal=beta;
%       end
%         tideSwitchCal=tideSwitch;
   elseif iswitchCal==2 %else
       Htmp=H; Ttmp=T; datatmp=data; dnumtmp=dnum; tidetmp=tide; dates_surveytmp=dates_survey;
       % load file
       clear H T data dnum dates_survey keep
       load(fileWaveCal);
       load(fileShorelineCal);
    dataCal=eval(char(dataFileCal));  
    keep = find(isnan(dataCal)==0);
    dataCal=dataCal(keep);
    if ~isempty(dataStdFileCal)
        dataStdCal=eval(char(dataStdFileCal));
    else
        dataStdCal=[];
    end
    datesCal=eval(char(datesFileCal));
    clear y mo d hr mi s
    [y,mo,d,hr,mi,s]=datevec(datesCal(keep));
    datesCal=datenum([y,mo,d,round(hr+mi/60),zeros(size(y)),zeros(size(y))]);
    HCal=eval(char(HFileCal));
    dnumCal=eval(char(datesFileWaveCal));
    zShoreCal=eval(char(zFileCal));
    if isnan(contShoreCal)==1 
         contShoreCal=nanmean(zShoreCal);
    end
  
    clear y mo d hr mi s
   [y,mo,d,hr,mi,s]=datevec(dnumCal);
    dnumCal=datenum([y,mo,d,round(hr+mi./60),zeros(size(y)),zeros(size(y))]);

    TCal = eval(char(TFileCal));
    [rw cl]=size(HCal);
    if rw==1    
        TCal=TCal';
        HCal=HCal';
    end
    [rw cl]=size(dataCal);
    if rw==1    
        dataCal=dataCal';
    end
    [rw cl]=size(dataStdCal);
    if rw==1    
        dataStdCal=dataStdCal';
    end
%     if strcmp(tideSwitchCal,'y')==1
%     tideCal=eval(char(TideFileCal))+tideOffsetCal;
%     datesTideCal=eval(char(datesFileTideCal));
%     end
%check data is equally spaced and only covers the time frame covered in
  
    %shoreline data
    ch=std(diff(dnumCal));
    if ch>1E-10
        step=mode(diff(dnumCal*24)); %converts to hours and finds mode step
        dnum2 = [dnumCal(1):step2/24:dnumCal(end)]';
        keep=find(dnumCal==dnum2);
        HCal=HCal(keep);
        TCal=TCal(keep);
% %         H2 = interp1(dnumCal,HCal,dnum2);
% %         T2 = interp1(dnumCal,TCal,dnum2);
%      if strcmp(tideSwitchCal,'y')==1       
%         tide2 = interp1(datesTideCal,tideCal,dnum2);
%         clear tideCal
%         tideCal=tide2; clear tide2
%      end
% %         clear HCal  TCal dnumCal
% %         HCal = H2; clear H2
% %         TCal = T2; clear T2
% %         dnumCal = dnum2; clear dnum2
    end

    wCal = fallvelocity(d50Cal/1000,15);
    calStats.d50=d50Cal;
% Length of time-series
    mCal=length(dnumCal);
    [~,iCal,iWaveCal]=intersect(datesCal,dnumCal);
    mmCal=length(iCal);
         %make sure full data sets are correct
        clear H T dates_survey dnum data
        H = Htmp;
        T = Ttmp;
        dates_survey=dates_surveytmp;
        dnum = dnumtmp;
        data=datatmp;
        hWaveC=hWaveHCal;
%        tide=tidetmp;
   end
   
% Quick fix for 0 and negative values in input data, should we also consider bad values for other variables? e.g. T   
bad_H=find(H(:)<0|H(:)==0);
H(bad_H)=1e-6;
bad_HCal=find(HCal(:)<0|HCal(:)==0);
HCal(bad_HCal)=1e-6;
bad_T=find(T(:)<0|T(:)==0);
T(bad_T)=1e-6;
bad_TCal=find(TCal(:)<0|TCal(:)==0);
TCal(bad_TCal)=1e-6;
   
Ho = calcHoShoal(H,T,hWaveH);  %calculate deep water equivalent
HoCal = calcHoShoal(HCal,TCal,hWaveC);
g=9.81;
Hb = 0.39.*g.^(1./5).*(T.*Ho.^2).^(2./5);
HbCal=0.39.*g.^(1./5).*(TCal.*HoCal.^2).^(2./5);
