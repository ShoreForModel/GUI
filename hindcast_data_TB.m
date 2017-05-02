function hindcast_data(H,T,w,dnum,data)

global iShore iWave m k dates_survey iWave omegaRecordMean hindStats
global omegaFiltered contShore Alin calStats dataStd dx

A = calStats.A; A=A(:);
r = calStats.r;
phi = calStats.phi;
D = calStats.D;

% Initialise model data array & omegaFiltered array
x=zeros(size(iShore));

% Model/Data timestep - seconds - NB must be a regular time-step in data!
dt=round((dnum(2)-dnum(1))*24*60*60);
% Linear model (for comparison)
t=[0:m-1].*dt;t=t';
C=data;
B2=[ones(m,1),t];
% loop to solve for best fit offset in hindcast data set
%    Atest = [min(data):1:max(data)];
%     for ii=1:length(Atest)
%     xbt(ii)=0;
%     end
% Catch if data nd iwave are not same length:
if length(data)~=length(iWave)
    data_temp=data;
    data=data(iShore);
end
xb=B2*Alin;
xbr = data-xb(iWave);
if exist('data_temp')==1
    data=data_temp;
end
Atest = [ones(length(xbr),1)]\xbr;
Alin(1)=Alin(1)+Atest; clear xb;
xb=B2*Alin;
% compute raw omega series
omega=H(:)./(w*T(:));
trendOmega=omega-detrend(omega);
% Equilibrium omega value for the whole record (info only)
omegaRecordMean=mean(omega(iWave(1):end));%
P = calcPb(H,T); %(1025*9.81.^2/(64*pi))*H.^2 .* T; %
fs=(60*60)/dt;
omegaFiltered = nan(size(omega));
if phi==Inf
    omegaFiltered(iWave(1):end)=  nanmean(omegaRecordMean);
else
    omegaFiltered=WS85FilterConv_TB(detrend(omega), D, phi, dt)+trendOmega;
    omegaFiltered(1:iWave(1)-1)=NaN;
end
ie= omegaFiltered-omega <=0;
ia= omegaFiltered-omega  >0;

diss=(omegaFiltered-omega);
diss=diss./nanstd(diss);
F=(P.^k.*diss);
keep = find(isnan(F)==0);
F = F(keep);
ie = ie(keep); ia = ia(keep);
mm2 = length(keep);
iShore2 = iShore(find(iWave>=keep(1),1,'first'):end);
iWave2 = iWave(find(iWave>=keep(1),1,'first'):end)-keep(1)+1;
t2 = t(keep)-t(keep(1));
dnum2 = dnum(keep);
X1=F;
X2=X1;
X2(ie)=0;
X1(ia)=0;
X=cumtrapz(X1.*r + X2)*dt;
B=[ones(mm2,1),t2, X];
x=B*A;  % Full

xr = data(iShore)-x(iWave2);
Atest = [ones(length(xr),1)]\xr;
A(1)=A(1)+Atest; clear xr x
x = B*A;

clear B
xb = xb(keep);
dti=round(30./mean(diff(dates_survey(iShore2))));
try
    dxB=dx+nanmean(dataStd);
catch
    dxB=dx;
end
c=corrcoef(data(iShore2),x(iWave2)); cc=c(1,2);
rmsError=sqrt(mean((data(iShore2)-x(iWave2)).^2));
nmsError = sum((data(iShore2)-x(iWave2)).^2)./sum((data(iShore2)-mean(data(iShore2))).^2);
BSS=brierss(data(iShore2),x(iWave2),xb(iWave2),dxB);
AIC = akaikeIC(data(iShore2),x(iWave2),4);
% Bench mark values using linear trend
cr=corrcoef(data(iShore2),xb(iWave2));
[AIClin]=akaikeIC(data(iShore2),xb(iWave2),2);
rmstrend=sqrt(mean((data(iShore2)-xb(iWave2)).^2));
nmstrend = sum((data(iShore2)-xb(iWave2)).^2)./sum((data(iShore2)-mean(data(iShore2))).^2);
dataMean=mean(data);
rmsErrorMean=sqrt(mean((data(iShore2)-dataMean).^2));
if ~isempty(dataStd)
    tmpP=find(abs(data(iShore2)-x(iWave2))<=(dataStd(iShore2)+dx));
else
    tmpP=find(abs(data(iShore2)-x(iWave2))<=dx);
end
PTimeCorrect=length(tmpP)./length(data(iShore2)); clear tmpP
% Plot the best results
check2=evalin('base','check2');
if check2==1
    figure('name','Hindcast Results','numbertitle','off')
    ax(1)=subplot(2,1,1);
    plot(dnum(keep),omega(keep),'Color',[0 0 0],'LineWidth',1)
    datetick('x','yyyy')
    xlim([dates_survey(iShore(1)) dates_survey(iShore(end))])
    ylabel('\Omega')
    grid on
    title('Hindcast Results')
    ax(2)=subplot(2,1,2);
    hold on
    if ~isempty(dataStd)
        Lerror=dataStd(iShore)+dx;
        Uerror=dataStd(iShore)+dx;
    else
        Lerror=repmat(dx,size(data(iShore)));
        Uerror=Lerror;
    end
    errorbar(dates_survey(iShore),data(iShore)-nanmean(x),Lerror,Uerror,'ks','markersize',5,'markerFaceColor','k')
    plot(dnum2,x-nanmean(x),'color',[0.7 0.7 0.7],'LineWidth',4)
    datetick('x','yyyy')
    xlim([dates_survey(iShore(1)) dates_survey(iShore(end))])
    xlabel('Time (years)')
    ylabel('\Delta shoreline position (m)')
    grid on
    legend('Data','Model')
end

% hind_modelled=x-nanmean(x);
hind_modelled=x;
hind_inputted=data;
hind_dates=dates_survey;
hind_datesModel=dnum2;
uisave({'hind_modelled','hind_inputted','hind_dates','hind_datesModel'},'Hindcast_data')
% uisave({'x','dnum2','Lerror','Uerror','dx'},'Hindcast_data')
% save('ShorelineData_Hindcast','Inputted','Modelled','Dates')
clear hind_modelled hind_inputted hind_dates

hindStats.dates=dates_survey;
hindStats.varShore = var(data(iShore2));
hindStats.varOmega = var(omega);
hindStats.Nyr = (dates_survey(iShore2(end))-dates_survey(iShore2(1)))/365;
hindStats.Alin = Alin;
hindStats.A = A;
hindStats.r = r;
hindStats.cc=cc;
hindStats.rmse=rmsError;
hindStats.nmse=nmsError;
hindStats.BSS=BSS;
hindStats.AIC=AIC;
hindStats.PTimeCorrect=PTimeCorrect;
hindStats.omegaRecordMean=omegaRecordMean;
hindStats.dx=dx;
hindStats.stdyShore=nanmean(dataStd);
hindStats.cr=cr(1,2);
hindStats.rmstrend=rmstrend;
hindStats.nmstrend=nmstrend;
hindStats.AIClin=AIClin;
hindStats.omegaFilter=omegaFiltered;
hindStats.F=F;
hindStats.k=k;
hindStats.dt=dt;
hindStats.omega=omega;
hindStats.x=x(iWave2);
hindStats.shore=data(iShore2);
hindStats.contourShore=contShore;
hindStats.linModel = xb;

