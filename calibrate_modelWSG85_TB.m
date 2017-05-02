function calibrate_modelWSG85(H,T,w,dnum,data)

global iCal iWaveCal k omegaRecordMeanCal
global datesCal calStats contShoreCal ihardWire omegaFilterCutOff
global Alin mCal D phi dxCal dataStdCal iswitchCal
mm=length(iCal);
dx=dxCal;

% Initialise model data array & omegaFiltered array
x=zeros(size(dnum));    %iCal
omegaFiltered=zeros(size(dnum))';   %iCal

% Model/Data timestep - seconds - NB must be a regular time-step in data!
dt=round((dnum(2)-dnum(1))*24*60*60);
%fs=(60*60)/dt;

% Linear model (for comparison)
t=[0:mCal-1].*dt;t=t';
C=data;
B2=[ones(mCal,1),t];
Alin=B2(iWaveCal,:)\C(iCal);
xb=B2*Alin;

% Bench mark values using linear trend
cr=corrcoef(data(iCal),xb(iWaveCal));
[AIClin]=akaikeIC(data(iCal),xb(iWaveCal),2);
rmstrend=sqrt(mean((data(iCal)-xb(iWaveCal)).^2));
nmstrend = sum((data(iCal)-xb(iWaveCal)).^2)./sum((data(iCal)-mean(data(iCal))).^2);
dataMean=mean(data);
rmsErrorMean=sqrt(mean((data(iCal)-dataMean).^2));

% compute raw omega series

omega=H./(w.*T);
% Equilibrium omega value for the whole record (info only)
omegaRecordMean=mean(omega(iWaveCal(1):end));%
omegaRecordMeanCal=omegaRecordMean;

P = calcPb(H,T); %(1025*9.81.^2/(64*pi))*H.^2 .* T; % Offshore Wave Power
meanP=nanmean(P);

if iswitchCal~=3 & ihardWire==1
    % Define detrended shoreline data for optimisation
    C=data;
    phitest = [1:1:10 10:5:95 100:10:380 400:50:1000 Inf];
    Dtest = 2.*phitest;
    combo = [Dtest(:) phitest(:)];
    
    %Creates the text box that will be used to show user calculations
    fig=figure('menubar','none','toolbar','none','name','Calculating...Please wait.','numbertitle','off');
    figpos=get(fig,'position');
    set(fig,'position',[figpos(1) figpos(2) 500 100])
    text=uicontrol('style','text');
    set(text,'position',[0 0 500 100])
    set(text,'fontsize',10)
    figurehandle=gcf;
    
    % Begin loop for trying different lags in omega calculations
    for kk=1:length(Dtest)
        pause(0.001)
        if ishandle(figurehandle)==0
            warndlg('The program is still running, if you wish to abort the program, type Ctrl+C in the Matlab main window.')
            fig=figure('menubar','none','toolbar','none','name','Calculating...Please wait.','numbertitle','off','visible','off');
            figpos=get(fig,'position');
            set(fig,'position',[figpos(1) figpos(2) 500 100])
            text=uicontrol('style','text');
            set(text,'position',[0 0 500 100])
            set(text,'fontsize',10)
            figurehandle=gcf;
        end
        % Low-pass filter omega time-series with increasing cut-off period to simulate
        % slowly changing equilibrium conditions
        omegaFiltered = nan(size(omega));
        if phitest(kk)==Inf
            omegaFiltered(iWaveCal(1):end)=  omegaRecordMeanCal;
        else
            omegaFiltered=WS85FilterConv_TB(omega, Dtest(kk), phitest(kk), dt);
            omegaFiltered(1:iWaveCal(1)-1)=NaN;
        end
        % Find erosion & accretion times
        ie= omegaFiltered-omega <=0;
        ia= omegaFiltered-omega  >0;
        
        diss=(omegaFiltered-omega);
        diss=diss./nanstd(diss);
        F=(P.^k.*diss);
        keep = find(isnan(F)==0);
        F = F(keep);
        FOrig=F;
        ie = ie(keep); ia = ia(keep);
        mCal2 = length(keep);
        iCal2 = iCal(find(iWaveCal>=keep(1),1,'first'):end);
        iWaveCal2 = iWaveCal(find(iWaveCal>=keep(1),1,'first'):end)-keep(1)+1;
        t2 = t(keep)-t(keep(1));
        
        meanF=mean(F);
        F=detrend(F) + meanF;
        X1=F;
        X2=X1;
        X2(ie)=0;
        X1(ia)=0;
        r(kk)=abs(trapz(X2)./trapz(X1));
        clear F
        F=FOrig;
        X1=F;
        X2=X1;
        X2(ie)=0;
        X1(ia)=0;
        X=cumtrapz(X1.*r(kk) + X2)*dt;
        B=[ones(mCal2,1),t2, X];
        A=B(iWaveCal2,:)\C(iCal2);  % least squares using detrended shoreline series
        x=B*A;  % Full model including cross-shore plus other trends (e.g. longshore transport)
        clear B
        
        
        % Compute correlation coefficient, rms error & BSS
        c=corrcoef(data(iCal2),x(iWaveCal2));cc(kk)=c(1,2);
        set(text,'string',{[];['Cut-off period for omega (days) D = ' num2str(Dtest(kk)) ', phi = ' num2str(phitest(kk)), ' Correlation coefficient = ' num2str(cc(kk))]});
        %pause(0.001)
        rmsError(kk)=sqrt(mean((data(iCal2)-x(iWaveCal2)).^2));
        format SHORT ENG
        try
            dxB=dx+nanmean(dataStdCal);
        catch
            dxB=dx;
        end
        [BSS(kk)]=brierss(data(iCal2),x(iWaveCal2),xb(iWaveCal2+keep(1)-1),dxB);
        [AIC(kk)]=akaikeIC(data(iCal2),x(iWaveCal2),5);
        nmsError(kk) = sum((data(iCal2)-x(iWaveCal2)).^2)./sum((data(iCal2)-mean(data(iCal2))).^2);
        if ~isempty(dataStdCal)
            tmpP=find(abs(data(iCal2)-x(iWaveCal2))<=(dataStdCal(iCal2)+dx));
        else
            tmpP=find(abs(data(iCal2)-x(iWaveCal2))<=dx);
        end
        
        PTimeCorrect(kk)=length(tmpP)./length(data(iCal2)); clear tmpP
        Aarray(1:3,kk)=A; clear A x
        Aarray(4,kk)=r(kk);
        
    end % end major loop
    delete(fig)
    
    % find the maximum correlation index and recompute the model for best
    % values
    %jj=max(find(cc==max(cc)));
    [~,jj]=min(nmsError);
    keep=find(cc.^2>0.9.*max(cc.^2));
    cutoff = [Dtest(jj) phitest(jj)];
    D = Dtest(jj);
    phi = phitest(jj);
    clear A r
    A=Aarray(1:3,jj);    % best least squares value
    r = Aarray(4,jj);
    omegaFiltered = nan(size(omega));
    if phi ==Inf
        omegaFiltered(iWaveCal(1):end)=  nanmean(omega);
    else
        omegaFiltered=WS85FilterConv_TB(omega, D, phi, dt);
        omegaFiltered(1:iWaveCal(1)-1)=NaN;
    end
    ie= omegaFiltered-omega <=0;
    ia= omegaFiltered-omega  >0;
    
    diss=(omegaFiltered-omega);
    diss=diss./nanstd(diss);
    F=(P.^k.*diss);
    keep = find(isnan(F)==0);
    F = F(keep);
    ie = ie(keep); ia = ia(keep);
    mCal2 = length(keep);
    iCal2 = iCal(find(iWaveCal>=keep(1),1,'first'):end);
    iWaveCal2 = iWaveCal(find(iWaveCal>=keep(1),1,'first'):end)-keep(1)+1;
    t2 = t(keep)-t(keep(1));
    dnum = dnum(keep);
    omega=omega(keep);
    X1=F;
    X2=X1;
    X2(ie)=0;
    X1(ia)=0;
    X=cumtrapz(X1.*r + X2)*dt;
    B=[ones(length(t2),1),t2, X];
    x=B*A;  % Full
    
    % Compute correlation coefficient, rms error & BSS
    ccFinal=cc(jj);
    rmsErrorFinal=rmsError(jj);
    BSSFinal=BSS(jj);
    AkaikeFinal = AIC(jj);
    nmsErrorFinal = nmsError(jj);
    PTimeCorrectFinal=PTimeCorrect(jj);
    
elseif iswitchCal==3
    
    keep = find(dnum>=datesCal(1)); %set to same size as shoreline start
    H = H(keep); T = T(keep); omega = omega(keep);
    dnum=dnum(keep);
    mCal2 = length(keep);
    iCal2 = iCal(find(iWaveCal>=keep(1),1,'first'):end);
    iWaveCal2 = iWaveCal(find(iWaveCal>=keep(1),1,'first'):end)-keep(1)+1;
    t2 = t(keep)-t(keep(1));
    xb=xb(keep);
    P=P(keep);
    clear keep
    [yy,mo,~,~,~,~]=datevec(dnum);
    yr=[min(yy):1:max(yy)];
    for ii=1:length(yr)
        tmp=[];
        for jj=1:length(unique(mo))
            keep=find(yy==yr(ii) & mo==jj);
            stdOmega(ii,jj)=nanstd(omega(keep));
            tmp=[tmp;omega(keep)];
        end
        stdYearOmega(ii)=std(tmp);
    end
    clear ii
    
    omegaRep = nanmean(omega).*nanmean(stdYearOmega(:))./nanmean(stdOmega(:));
    phi=min(1000,2+omegaRep.^2+exp(omegaRep-4.65).^3);
    D=2*phi;
    CParam = 3.05e-8 + (1.55e-6*nanmean(omega))./exp(nanmean(omega));
    
    omegaFiltered=WS85FilterConv_TB(omega, D, phi, dt);
    
    dOmega = omegaFiltered-repmat(omega,1,size(omegaFiltered,2));
    diss=dOmega./repmat(nanstd(dOmega),length(dOmega),1);  %normalizing
    clear kk
    ie= diss <=0;
    ia= diss  >0;
    F=(P.^k.*diss);
    FOrig=F;
    meanF=mean(F);
    F=detrend(F) + meanF;
    X1=F;
    X2=X1;
    X2(ie)=0;
    X1(ia)=0;
    r=abs(trapz(X2)./trapz(X1));
    clear F
    F=FOrig;
    X1=F;
    X2=X1;
    X2(ie)=0;
    X1(ia)=0;
    X=CParam.*cumtrapz(X1.*r + X2)*dt;
    B=[ones(mCal2,1),t2];
    A=B(iWaveCal2,:)\(C(iCal2)-X(iWaveCal2));  % least squares using detrended shoreline series
    x=B*A+X;  % Full model including cross-shore plus other trends (e.g. longshore transport)
    clear B
    
    % Compute correlation coefficient, rms error & BSS
    c=corrcoef(data(iCal2),x(iWaveCal2));cc=c(1,2);
    rmsError=sqrt(mean((data(iCal2)-x(iWaveCal2)).^2));
    format SHORT ENG
    try
        dxB=dx+nanmean(dataStdCal);
    catch
        dxB=dx;
    end
    
    [BSS]=brierss(data(iCal2),x(iWaveCal2),xb(iWaveCal2),dxB);
    [AIC]=akaikeIC(data(iCal2),x(iWaveCal2),2);
    nmsError = sum((data(iCal2)-x(iWaveCal2)).^2)./sum((data(iCal2)-mean(data(iCal2))).^2);
    if ~isempty(dataStdCal)
        tmpP=find(abs(data(iCal2)-x(iWaveCal2))<=(dataStdCal(iCal2)+dx));
    else
        tmpP=find(abs(data(iCal2)-x(iWaveCal2))<=dx);
    end
    PTimeCorrect=length(tmpP)./length(data(iCal2)); clear tmpP
    Aarray(1:2)=A; clear A
    Aarray(3)=CParam;
    Aarray(4)=r;
    cutoff = [D phi]
    clear A r
    A=Aarray(1:3);    % best least squares value
    r = Aarray(4);
    
    % Compute correlation coefficient, rms error & BSS
    ccFinal=cc;
    rmsErrorFinal=rmsError;
    BSSFinal=BSS;
    AkaikeFinal = AIC;
    nmsErrorFinal = nmsError;
    PTimeCorrectFinal=PTimeCorrect;
elseif iswitchCal~=3 & ihardWire==0
    % Define detrended shoreline data for optimisation
    C=data;
    phitest = omegaFilterCutOff;
    Dtest = 2.*phitest;
    combo = [Dtest(:) phitest(:)];
    
    % Begin loop for trying different lags in omega calculations
    % Low-pass filter omega time-series with increasing cut-off period to simulate
    % slowly changing equilibrium conditions
        omegaFiltered = nan(size(omega));
        if phitest==Inf
            omegaFiltered(iWaveCal(1):end)=  omegaRecordMeanCal;
        else
            omegaFiltered=WS85FilterConv_TB(omega, Dtest, phitest, dt);
            omegaFiltered(1:iWaveCal(1)-1)=NaN;
        end
        % Find erosion & accretion times
        ie= omegaFiltered-omega <=0;
        ia= omegaFiltered-omega  >0;
        
        diss=(omegaFiltered-omega);
        diss=diss./nanstd(diss);
        F=(P.^k.*diss);
        keep = find(isnan(F)==0);
        F = F(keep);
        FOrig=F;
        ie = ie(keep); ia = ia(keep);
        mCal2 = length(keep);
        iCal2 = iCal(find(iWaveCal>=keep(1),1,'first'):end);
        iWaveCal2 = iWaveCal(find(iWaveCal>=keep(1),1,'first'):end)-keep(1)+1;
        t2 = t(keep)-t(keep(1));
        
        meanF=mean(F);
        F=detrend(F) + meanF;
        X1=F;
        X2=X1;
        X2(ie)=0;
        X1(ia)=0;
        r=abs(trapz(X2)./trapz(X1));
        clear F
        F=FOrig;
        X1=F;
        X2=X1;
        X2(ie)=0;
        X1(ia)=0;
        X=cumtrapz(X1.*r + X2)*dt;
        B=[ones(mCal2,1),t2, X];
        A=B(iWaveCal2,:)\C(iCal2);  % least squares using detrended shoreline series
        x=B*A;  % Full model including cross-shore plus other trends (e.g. longshore transport)
        clear B 
        
        % Compute correlation coefficient, rms error & BSS
        c=corrcoef(data(iCal2),x(iWaveCal2)); cc=c(1,2);
        rmsError=sqrt(mean((data(iCal2)-x(iWaveCal2)).^2));
        format SHORT ENG
        try
            dxB=dx+nanmean(dataStdCal);
        catch
            dxB=dx;
        end
        [BSS]=brierss(data(iCal2),x(iWaveCal2),xb(iWaveCal2+keep(1)-1),dxB);
        [AIC]=akaikeIC(data(iCal2),x(iWaveCal2),5);
        nmsError = sum((data(iCal2)-x(iWaveCal2)).^2)./sum((data(iCal2)-mean(data(iCal2))).^2);
        if ~isempty(dataStdCal)
            tmpP=find(abs(data(iCal2)-x(iWaveCal2))<=(dataStdCal(iCal2)+dx));
        else
            tmpP=find(abs(data(iCal2)-x(iWaveCal2))<=dx);
        end
        
        PTimeCorrect=length(tmpP)./length(data(iCal2)); clear tmpP
        Aarray(1:3)=A; clear A x
        Aarray(4)=r;
    
    % find the maximum correlation index and recompute the model for best
    % values
    %jj=max(find(cc==max(cc)));
    keep=find(cc.^2>0.9.*max(cc.^2));
    cutoff = [Dtest phitest];
    D = Dtest;
    phi = phitest;
    clear A r
    A=Aarray(1:3); A=A';   % best least squares value
    r = Aarray(4);
    omegaFiltered = nan(size(omega));
    if phi ==Inf
        omegaFiltered(iWaveCal(1):end)=  nanmean(omega);
    else
        omegaFiltered=WS85FilterConv_TB(omega, D, phi, dt);
        omegaFiltered(1:iWaveCal(1)-1)=NaN;
    end
    ie= omegaFiltered-omega <=0;
    ia= omegaFiltered-omega  >0;
    
    diss=(omegaFiltered-omega);
    diss=diss./nanstd(diss);
    F=(P.^k.*diss);
    keep = find(isnan(F)==0);
    F = F(keep);
    ie = ie(keep); ia = ia(keep);
    mCal2 = length(keep);
    iCal2 = iCal(find(iWaveCal>=keep(1),1,'first'):end);
    iWaveCal2 = iWaveCal(find(iWaveCal>=keep(1),1,'first'):end)-keep(1)+1;
    t2 = t(keep)-t(keep(1));
    dnum = dnum(keep);
    omega=omega(keep);
    X1=F;
    X2=X1;
    X2(ie)=0;
    X1(ia)=0;
    X=cumtrapz(X1.*r + X2)*dt;
    B=[ones(length(t2),1),t2, X];
    x=B*A;  % Full
    
    % Compute correlation coefficient, rms error & BSS
    ccFinal=cc;
    rmsErrorFinal=rmsError;
    BSSFinal=BSS;
    AkaikeFinal = AIC;
    nmsErrorFinal = nmsError;
    PTimeCorrectFinal=PTimeCorrect;
end

% Plot the best results
check1=evalin('base','check1');
if check1==1
    figure('name','Calibration Results','numbertitle','off')
    clf
    subplot(2,1,1)
    plot(dnum,omega,'Color',[0 0 0],'LineWidth',1)
    datetick('x','yyyy')
    ylabel('\Omega')
    grid on
    title('Calibration Results')
    subplot(2,1,2)
    if ~isempty(dataStdCal)
        Lerror=dataStdCal(iCal2)+dx;
        Uerror=dataStdCal(iCal2)+dx;
    else
        Lerror=repmat(dx,size(data(iCal2)));
        Uerror=Lerror;
    end
    errorbar(datesCal(iCal2),data(iCal2),Lerror,Uerror,'ks','markersize',5,'markerFaceColor','k')
    
    hold on
    plot(dnum(iWaveCal2),x(iWaveCal2),'color',[0.7 0.7 0.7],'LineWidth',4)
    datetick('x','yyyy')
    xlabel('Time (years)')
    ylabel('\Delta shoreline position (m)')
    grid on
    legend('Data','Model')
end

if iswitchCal~=3 && ihardWire==1
    check3=evalin('base','check3');
    if check3==1
        figure('name','Accuracy Results','numbertitle','off')
        subplot(2,2,1)% BSS Plot
        plot(phitest, BSS,'k.--')
        hold on
        xlabel('phi  (days)')
        ylabel('Brier Skills Score')
        grid on
        legend('BSS')
        %         plot([0 phitest(end)], [0.3 0.3],'k--')
        %         plot([0 phitest(end)], [0.6 0.6],'k--')
        %         plot([0 phitest(end)], [0.8 0.8],'k--')
        
        subplot(2,2,2) % Akaike Info criteria Plot
        plot(phitest,AIC-AIClin,'k','LineWidth',2)
        hold on
        xlabel('phi (days)')
        ylabel('Relative AIC')
        grid on
        plot([0 phitest(end)], [-1 -1],'k--','LineWidth',2)
        
        subplot(2,2,3) % Correlation Coefficient Plot
        plot(phitest,cc.^2,'k','LineWidth',2)
        hold on
        xlabel('phi (days)')
        ylabel('Correlation squared')
        grid on
        plot([0 phitest(end-1)], [cr(1,2).^2 cr(1,2).^2],'k--','LineWidth',2)
        legend('R^2','Linear trend R^2')
        
        subplot(2,2,4) % NMS error plot
        plot(phitest, nmsError,'k-.')
        hold on
        xlabel('phi (days)')
        ylabel('NMSE (m)')
        grid on
        plot([0 phitest(end-1)], [nmstrend nmstrend],'k--')
        legend('NMSE','Linear trend NMSE')
    end
end

cal_modelled=x(iWaveCal2);
cal_inputted=data;
cal_dates=datesCal;
if iswitchCal==3
    %     sigma30=stdOmega;
    %     sigma360=stdYearOmega;
    uisave({'cal_modelled','cal_inputted','cal_dates','stdOmega','stdYearOmega'},'Calibration_data')
else
    uisave({'cal_modelled','cal_inputted','cal_dates'},'Calibration_data')
end
clear cal_modelled cal_inputted cal_dates

calStats.datesCal=datesCal;
calStats.Nyr = (datesCal(end)-datesCal(1))/365;
calStats.A=A;
calStats.r=r;
calStats.cutoff=cutoff;
calStats.phi = phi;
calStats.D = D;
calStats.cc=ccFinal;
calStats.rmse=rmsErrorFinal;
calStats.nmse = nmsErrorFinal;
calStats.BSS=BSSFinal;
calStats.AIC = AkaikeFinal;
calStats.PTimeCorrect=PTimeCorrectFinal;
calStats.omegaRecordMean=omegaRecordMean;
calStats.varOmega = var(omega);
calStats.varShore = var(data(iCal));
calStats.dx=dx;
calStats.stdyShore=nanmean(dataStdCal);
calStats.cr=cr(1,2);
calStats.rmstrend=rmstrend;
calStats.nmstrend=nmstrend;
calStats.AIClin = AIClin;
calStats.omegaFilter=omegaFiltered;
calStats.omega=omega;
calStats.F=F;
calStats.k=k;
calStats.dt=dt;
calStats.linModelA=Alin;
calStats.contourShore=contShoreCal;
calStats.meanP=meanP;
if iswitchCal==3
    calStats.stdOmega=mean(nanmean(stdOmega));
    calStats.stdYearOmega=nanmean(stdYearOmega);
    calStats.omegaRep=omegaRep;
end