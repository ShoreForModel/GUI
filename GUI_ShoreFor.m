function varargout = GUI_ShoreFor(varargin)
% GUI_SHOREFOR M-file for GUI_ShoreFor.fig
%      GUI_SHOREFOR, by itself, creates a new GUI_SHOREFOR or raises the existing
%      singleton*.
%
%      H = GUI_SHOREFOR returns the handle to a new GUI_SHOREFOR or the handle to
%      the existing singleton*.
%
%      GUI_SHOREFOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SHOREFOR.M with the given input arguments.
%
%      GUI_SHOREFOR('Property','Value',...) creates a new GUI_SHOREFOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_ShoreFor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_ShoreFor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_ShoreFor

% Last Modified by GUIDE v2.5 04-Aug-2014 12:07:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_ShoreFor_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_ShoreFor_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_ShoreFor is made visible.
function GUI_ShoreFor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_ShoreFor (see VARARGIN)

% Choose default command line output for GUI_ShoreFor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

evalin( 'base', 'clearvars *' )

try
axes(handles.axes24)
imshow('Image.png')
catch
end

% --- Outputs from this function are returned to the command line.
function varargout = GUI_ShoreFor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%=================================================================
%   Buttons
%=================================================================


% --- Executes on button press in wavefile1.
function wavefile1_Callback(hObject, eventdata, handles)
% hObject    handle to wavefile1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile({'*.mat;*.txt'});
if FilterIndex==1
    [~,~,ext]=fileparts(FileName);
    set(handles.ok2,'Visible','Off')
    set(handles.proceed1,'Visible','Off')
    set(handles.clear1,'Visible','Off')
    set(handles.text1,'Visible','Off')
    set(handles.text2,'Visible','Off')
    set(handles.text3,'Visible','Off')
    set(handles.text4,'Visible','Off')
    set(handles.text5,'Visible','Off')
    set(handles.text6,'Visible','Off')
    set(handles.text7,'Visible','Off')
    set(handles.popupmenu1,'Value',1)
    set(handles.popupmenu2,'Value',1)
    set(handles.popupmenu3,'Value',1)
    set(handles.popupmenu4,'Value',1)
    set(handles.popupmenu5,'Value',1)
    set(handles.popupmenu6,'Value',1)
    set(handles.popupmenu7,'Value',1)
    set(handles.popupmenu1,'Visible','Off')
    set(handles.popupmenu2,'Visible','Off')
    set(handles.popupmenu3,'Visible','Off')
    set(handles.popupmenu4,'Visible','Off')
    set(handles.popupmenu5,'Visible','Off')
    set(handles.popupmenu6,'Visible','Off')
    set(handles.popupmenu7,'Visible','Off')
    if ext=='.mat'
        % Assesses and saves file contents and name to guidata
        fileWave=[PathName,FileName];
        set(handles.wavetext1,'String',fileWave)
        waveContents=who('-file', fileWave);
        % Saves the pathname, file and file contents to the guidata
        % and the base workspace
        handles.waveContents=waveContents;
        handles.fileWave=fileWave;
        assignin('base','fileWave',fileWave);
        guidata(hObject,handles)
    elseif ext=='.txt'
        set(handles.wavetext1,'String',[PathName,FileName])
        data=importdata([PathName FileName],' ',1);
        for ii=1:length(data.colheaders)
            fields(ii)={data.colheaders{ii}};
            values(ii)={data.data(:,ii)};
        end
        s=cell2struct(values, fields, 2);
        [~,FileName,~]=fileparts(FileName);
        FileName=[FileName '.mat'];
        save(FileName, '-struct', 's')
        % Assesses and saves file contents and name to guidata
        fileWave=[PathName,FileName];
        waveContents=who('-file', fileWave);
        % Saves the pathname, file and file contents to the guidata
        % and the base workspace
        handles.waveContents=waveContents;
        handles.fileWave=fileWave;
        assignin('base','fileWave',fileWave);
        guidata(hObject,handles)
        clear ii fields values s
    end
elseif FilterIndex==0
    % Returns empty string is user cancels input
    set(handles.wavetext1,'String',[])
end

% --- Executes on button press in wavefile2.
function wavefile2_Callback(hObject, eventdata, handles)
% hObject    handle to wavefile2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile({'*.mat;*.txt'});
if FilterIndex==1
    [~,~,ext]=fileparts(FileName);
    set(handles.text17,'Visible','Off')
    set(handles.text18,'Visible','Off')
    set(handles.text19,'Visible','Off')
    set(handles.popupmenu8,'Visible','Off')
    set(handles.popupmenu9,'Visible','Off')
    set(handles.popupmenu10,'Visible','Off')
    set(handles.proceed5,'Visible','Off')
    if ext=='.mat'
        fileWaveCal=[PathName,FileName];
        set(handles.wavetext2,'String',fileWaveCal)
        waveContentsCal=who('-file', fileWaveCal);
        handles.waveContentsCal=waveContentsCal;
        handles.fileWaveCal=fileWaveCal;
        assignin('base','fileWaveCal',fileWaveCal)
        guidata(hObject,handles)
    elseif ext=='.txt'
        set(handles.wavetext2,'String',[PathName,FileName])
        data=importdata([PathName FileName],' ',1);
        for ii=1:length(data.colheaders)
            fields(ii)={data.colheaders{ii}};
            values(ii)={data.data(:,ii)};
        end
        s=cell2struct(values, fields, 2);
        [~,FileName,~]=fileparts(FileName);
        FileName=[FileName '.mat'];
        save(FileName, '-struct', 's')
        fileWaveCal=[PathName,FileName];
        waveContentsCal=who('-file', fileWaveCal);
        handles.waveContentsCal=waveContentsCal;
        handles.fileWaveCal=fileWaveCal;
        assignin('base','fileWaveCal',fileWaveCal)
        guidata(hObject,handles)
        clear ii fields values s
    end
elseif FilterIndex==0
    % Returns empty string is user cancels input
    set(handles.wavetext2,'String',[])
end

% --- Executes on button press in shorefile1.
function shorefile1_Callback(hObject, eventdata, handles)
% hObject    handle to shorefile1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile({'*.mat;*.txt'});
if FilterIndex==1
    [~,~,ext]=fileparts(FileName);
    set(handles.ok2,'Visible','Off')
    set(handles.proceed1,'Visible','Off')
    set(handles.clear1,'Visible','Off')
    set(handles.text1,'Visible','Off')
    set(handles.text2,'Visible','Off')
    set(handles.text3,'Visible','Off')
    set(handles.text4,'Visible','Off')
    set(handles.text5,'Visible','Off')
    set(handles.text6,'Visible','Off')
    set(handles.text7,'Visible','Off')
    set(handles.popupmenu1,'Value',1)
    set(handles.popupmenu2,'Value',1)
    set(handles.popupmenu3,'Value',1)
    set(handles.popupmenu4,'Value',1)
    set(handles.popupmenu5,'Value',1)
    set(handles.popupmenu6,'Value',1)
    set(handles.popupmenu7,'Value',1)
    set(handles.popupmenu1,'Visible','Off')
    set(handles.popupmenu2,'Visible','Off')
    set(handles.popupmenu3,'Visible','Off')
    set(handles.popupmenu4,'Visible','Off')
    set(handles.popupmenu5,'Visible','Off')
    set(handles.popupmenu6,'Visible','Off')
    set(handles.popupmenu7,'Visible','Off')
    if ext=='.mat'
        % Assesses and saves file contents and name to guidata
        fileShoreline=[PathName,FileName];
        set(handles.shoretext1,'String',fileShoreline)
        shoreContents=who('-file', fileShoreline);
        handles.shoreContents=shoreContents;
        handles.fileShoreline=fileShoreline;
        assignin('base','fileShoreline',fileShoreline);
        guidata(hObject,handles)
    elseif ext=='.txt'
        set(handles.shoretext1,'String',[PathName,FileName])
        data=importdata([PathName FileName],' ',1);
        for ii=1:length(data.colheaders)
            fields(ii)={data.colheaders{ii}};
            values(ii)={data.data(:,ii)};
        end
        s=cell2struct(values, fields, 2);
        [~,FileName,~]=fileparts(FileName);
        FileName=[FileName '.mat'];
        save(FileName, '-struct', 's')
        fileShoreline=[PathName,FileName];
        shoreContents=who('-file', fileShoreline);
        handles.shoreContents=shoreContents;
        handles.fileShoreline=fileShoreline;
        assignin('base','fileShoreline',fileShoreline);
        guidata(hObject,handles)
        clear ii fields values s
    end
elseif FilterIndex==0
    % Returns empty string is user cancels input
    set(handles.shoretext1,'String',[])
end

% --- Executes on button press in shorefile2.
function shorefile2_Callback(hObject, eventdata, handles)
% hObject    handle to shorefile2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile({'*.mat;*.txt'});
if FilterIndex==1
    [~,~,ext]=fileparts(FileName);
    set(handles.text20,'Visible','Off')
    set(handles.text21,'Visible','Off')
    set(handles.text22,'Visible','Off')
    set(handles.text23,'Visible','Off')
    set(handles.popupmenu11,'Visible','Off')
    set(handles.popupmenu12,'Visible','Off')
    set(handles.popupmenu13,'Visible','Off')
    set(handles.popupmenu14,'Visible','Off')
    set(handles.ok5,'Visible','Off')
    if ext=='.mat'
        fileShorelineCal=[PathName,FileName];
        set(handles.shoretext2,'String',fileShorelineCal)
        shoreContentsCal=who('-file', fileShorelineCal);
        handles.shoreContentsCal=shoreContentsCal;
        handles.fileShorelineCal=fileShorelineCal;
        assignin('base','fileShorelineCal',fileShorelineCal)
        guidata(hObject,handles)
    elseif ext=='.txt'
        set(handles.shoretext2,'String',[PathName,FileName])
        data=importdata([PathName FileName],' ',1);
        for ii=1:length(data.colheaders)
            fields(ii)={data.colheaders{ii}};
            values(ii)={data.data(:,ii)};
        end
        s=cell2struct(values, fields, 2);
        [~,FileName,~]=fileparts(FileName);
        FileName=[FileName '.mat'];
        save(FileName, '-struct', 's')
        fileShorelineCal=[PathName,FileName];
        shoreContentsCal=who('-file', fileShorelineCal);
        handles.shoreContentsCal=shoreContentsCal;
        handles.fileShorelineCal=fileShorelineCal;
        assignin('base','fileShorelineCal',fileShorelineCal)
        guidata(hObject,handles)
        clear ii fields values s
    end
elseif FilterIndex==0
    set(handles.shoretext2,'String',[])
end

    
% --- Executes on button press in startdate.
function startdate_Callback(hObject, eventdata, handles)
% hObject    handle to startdate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    s1GUI=datestr(uigetdate);
    if ~isempty(s1GUI)
        set(handles.text15,'String',s1GUI)
        assignin('base','s1GUI',s1GUI)
        handles.s1GUI=datenum(s1GUI);
        guidata(hObject,handles)
    end

% --- Executes on button press in enddate.
function enddate_Callback(hObject, eventdata, handles)
% hObject    handle to enddate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    s2GUI=datestr(uigetdate);
    if ~isempty(s2GUI)
        set(handles.text16,'String',s2GUI)
        assignin('base','s2GUI',s2GUI)
        handles.s2GUI=datenum(s2GUI);
        guidata(hObject,handles)
    end
  
    
% --- Executes on button press in ok1.
function ok1_Callback(hObject, eventdata, handles)
% hObject    handle to ok1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wavestring=get(handles.wavetext1,'string');
shorestring=get(handles.shoretext1,'string');
    if isempty(wavestring)
        errordlg('Please select a wave data file.')
    elseif isempty(shorestring)
        errordlg('Please select a shoreline data file.')
    elseif strcmp(wavestring,'File Name')==1
        errordlg('Please select a wave data file.')
    elseif strcmp(shorestring,'File Name')==1
        errordlg('Please select a shoreline data file.')
    else
        % Clears graphs to avoid creating multiple axes
        cla(handles.wavegraph1,'reset')
        cla(handles.shoregraph1,'reset')
        % Makes next step visible
        set(handles.ok2,'Visible','On')
        set(handles.proceed1,'Visible','Off')
        set(handles.clear1,'Visible','Off')
        set(handles.text1,'Visible','On')
        set(handles.text2,'Visible','On')
        set(handles.text3,'Visible','On')
        set(handles.text4,'Visible','On')
        set(handles.text5,'Visible','On')
        set(handles.text6,'Visible','On')
        set(handles.text7,'Visible','On')
        set(handles.popupmenu1,'Value',1)
        set(handles.popupmenu2,'Value',1)
        set(handles.popupmenu3,'Value',1)
        set(handles.popupmenu4,'Value',1)
        set(handles.popupmenu5,'Value',1)
        set(handles.popupmenu6,'Value',1)
        set(handles.popupmenu7,'Value',1)
        set(handles.popupmenu1,'Visible','On')
        set(handles.popupmenu2,'Visible','On')
        set(handles.popupmenu3,'Visible','On')
        set(handles.popupmenu4,'Visible','On')
        set(handles.popupmenu5,'Visible','On')
        set(handles.popupmenu6,'Visible','On')
        set(handles.popupmenu7,'Visible','On')
        % Populates the pop-up menus with relevant options
        set(handles.popupmenu1,'String',handles.waveContents)
        set(handles.popupmenu2,'String',handles.waveContents)
        set(handles.popupmenu3,'String',handles.waveContents)
        set(handles.popupmenu4,'String',handles.shoreContents)
        set(handles.popupmenu5,'String',handles.shoreContents)
        set(handles.popupmenu6,'String',handles.shoreContents)
        stdContents=[handles.shoreContents;'-'];
        set(handles.popupmenu7,'String',stdContents)
    end

% --- Executes on button press in ok2.
function ok2_Callback(hObject, eventdata, handles)
% hObject    handle to ok2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
    error=0;
    
    %Clears graphs
	cla(handles.wavegraph1,'reset')
	cla(handles.shoregraph1,'reset') 
    %Loads file
    load(handles.fileWave)
    %Identifies user inputs in dropdown menu
    Hstring = get(handles.popupmenu1,'String'); 
    Hstring = Hstring{get(handles.popupmenu1,'Value')};
    Tstring = get(handles.popupmenu2,'String'); 
    Tstring = Tstring{get(handles.popupmenu2,'Value')};
    waveDatestring = get(handles.popupmenu3,'String'); 
    waveDatestring = waveDatestring{get(handles.popupmenu3,'Value')};
    %Saves the selections for later use
    handles.Hstring=Hstring;
    handles.Tstring=Tstring;
    handles.waveDatestring=waveDatestring;
    guidata(hObject,handles)
    %Matches the drop down menus selection to the corresponding data
    Hdata=eval(Hstring);
    Tdata=eval(Tstring);
    waveDatedata=eval(waveDatestring);
    
    %Plots the graph
    if numel(Hdata)==numel(Tdata) & numel(Hdata)==numel(waveDatedata)
    axes(handles.wavegraph1);
    [AX,h1,h2] = plotyy(waveDatedata,Hdata,waveDatedata,Tdata);
    %Converts x-axis to dates
    datetick(AX(1),'x','yy')
    set(AX(2),'xtick',[])
    datetick(AX(2),'x','yy')
    %set(h1,'color','green')
    %set(h2,'color','blue')
    set(AX(1),'ycolor','black','fontsize',10)
    set(AX(2),'ycolor','black','fontsize',10)
    set(AX(2),'xcolor','black','fontsize',10)
    legend([h1;h2],'Wave Height','Wave Period')
    %Labels Axes
    axes(AX(1))
    ylabel('Wave Height (m)','color','black','fontweight','bold')
    axes(AX(2))
    ylabel('Wave Period (s)','color','black','fontweight','bold')
    xlabel('Time','color','black','fontweight','bold')
    title('Wave Data','color','black','fontweight','bold')    
    
    else
    cla(handles.wavegraph1,'reset')
        
	axes(handles.wavegraph1);
	x=[0:0.2:1];
	y=[0:0.2:1];
	z=[1:-0.2:0];
	[AX,h1,h2]=plotyy(x,y,x,z);
	title('Error','color','black','fontweight','bold')
	set(h1,'color','red')
	set(h2,'color','red')
	set(AX(1),'ycolor','black','fontsize',10)
    set(AX(2),'ycolor','black','fontsize',10)
	set(AX(2),'xcolor','black','fontsize',10)    

    error=1;
    
    %Makes proceed and clear button disappear
    set(handles.proceed1,'Visible','Off')
    set(handles.clear1,'Visible','Off')
    set(handles.ok2,'visible','on')
    end
    
    %Loads shoreline file
    load(handles.fileShoreline)
    %Identifies user inputs in dropdown menu
    shoreDatastring = get(handles.popupmenu4,'String'); 
    shoreDatastring = shoreDatastring{get(handles.popupmenu4,'Value')};
    Zstring = get(handles.popupmenu5,'String'); 
    Zstring = Zstring{get(handles.popupmenu5,'Value')};
    shoreDatestring = get(handles.popupmenu6,'String'); 
    shoreDatestring = shoreDatestring{get(handles.popupmenu6,'Value')};
    STDstring = get(handles.popupmenu7,'String'); 
    STDstring = STDstring{get(handles.popupmenu7,'Value')};
    %Saves the selections for later use
    handles.shoreDatastring=shoreDatastring;
    handles.Zstring=Zstring;
    handles.shoreDatestring=shoreDatestring;
    handles.STDstring=STDstring;
    %Matches the drop down menu selection to the corresponding data
    shoreData=eval(shoreDatastring);
    Zdata=eval(Zstring);
    shoreDatedata=eval(shoreDatestring);
    if STDstring ~= '-'
        STDdata=eval(STDstring);
    else
        STDdata='-';
        STDstring=[];
        handles.STDstring=STDstring;
    end
    
    guidata(hObject,handles)
    
    %Plots the graph
    if (numel(shoreData)==numel(Zdata) & numel(shoreData)==numel(shoreDatedata) & numel(shoreData)==numel(STDdata)) | ...
       (numel(shoreData)==numel(Zdata) & numel(shoreData)==numel(shoreDatedata) & STDdata=='-')
    axes(handles.shoregraph1);
    [AX,h1,h2] = plotyy(shoreDatedata,shoreData,shoreDatedata,Zdata);
    %Converts x-axis to dates
    datetick(AX(1),'x','yy')
    set(AX(2),'xtick',[])
    datetick(AX(2),'x','yy')
        %set(h1,'color','black')
        %set(h2,'color',[1 .7 0])
    set(AX(1),'ycolor','black','fontsize',10)
    set(AX(2),'ycolor','black','fontsize',10)
    set(AX(2),'xcolor','black','fontsize',10)
    legend([h1;h2],'Shoreline Position','Shoreline Elevation')
    %Labels Axes
    axes(AX(1))
    ylabel('Shore Position (m)','color','black','fontweight','bold')
    axes(AX(2))
    ylabel('Shore Elevation (m)','color','black','fontweight','bold')
    xlabel('Time','color','black','fontweight','bold')
    title('Shoreline Data','color','black','fontweight','bold')
    %Adds error bars
    if STDstring ~= '-'
        hold(AX(1), 'on');
        errorbar(AX(1), shoreDatedata, shoreData, STDdata);%,'color','black');
    end
    
    else
	cla(handles.shoregraph1,'reset')        
        
    axes(handles.shoregraph1);
	x=[0:0.2:1];
	y=[0:0.2:1];
	z=[1:-0.2:0];
	[AX,h1,h2]=plotyy(x,y,x,z);
	title('Error','color','black','fontweight','bold')
	set(h1,'color','red')
	set(h2,'color','red')
	set(AX(1),'ycolor','black','fontsize',10)
	set(AX(2),'ycolor','black','fontsize',10)
	set(AX(2),'xcolor','black','fontsize',10)    
    
    error=1;
    
    end
    
    if error==1
        errordlg('Incompatible data selected, please try again.')
    else
        set(handles.proceed1,'Visible','On')
        set(handles.clear1,'Visible','On')
        set(handles.ok2,'visible','off')        
    end
    
% --- Executes on button press in ok3.
function ok3_Callback(hObject, eventdata, handles)
% hObject    handle to ok3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wavestring=get(handles.wavetext2,'string');
    if isempty(wavestring)
        errordlg('Please select a wave data file.')
    elseif strcmp(wavestring,'File Name')==1
        errordlg('Please select a wave data file.')
    else
        % Clears graph to avoid overlapping axes creation
        cla(handles.wavegraph2,'reset')
        % Makes next step visible
        set(handles.ok5,'Visible','On')
        set(handles.clear2,'visible','off')
        set(handles.proceed6,'visible','off')
        set(handles.proceed5,'Visible','On')
        set(handles.text17,'Visible','On')
        set(handles.text18,'Visible','On')
        set(handles.text19,'Visible','On')
        set(handles.popupmenu8,'Value',1)
        set(handles.popupmenu9,'Value',1)
        set(handles.popupmenu10,'Value',1)        
        set(handles.popupmenu8,'Visible','On')
        set(handles.popupmenu9,'Visible','On')
        set(handles.popupmenu10,'Visible','On')
        % Populates the pop-up menus with relevant options
        set(handles.popupmenu8,'String',handles.waveContentsCal)
        set(handles.popupmenu9,'String',handles.waveContentsCal)
        set(handles.popupmenu10,'String',handles.waveContentsCal)
    end

% --- Executes on button press in ok4.
function ok4_Callback(hObject, eventdata, handles)
% hObject    handle to ok4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
shorestring=get(handles.shoretext2,'string');
    if isempty(shorestring)
        errordlg('Please select a shoreline data file.')
    elseif strcmp(shorestring,'File Name')==1
        errordlg('Please select a shoreline data file.')
    else
        % Clears graph to avoid overlapping axes creation
        cla(handles.shoregraph2,'reset')
        % Makes next step visible
        set(handles.ok5,'Visible','On')
        set(handles.clear2,'visible','off')
        set(handles.proceed6,'visible','off')
        set(handles.text20,'Visible','On')
        set(handles.text21,'Visible','On')
        set(handles.text22,'Visible','On')
        set(handles.text23,'Visible','On')
        set(handles.popupmenu11,'Value',1)
        set(handles.popupmenu12,'Value',1)
        set(handles.popupmenu13,'Value',1)
        set(handles.popupmenu14,'Value',1)        
        set(handles.popupmenu11,'Visible','On')
        set(handles.popupmenu12,'Visible','On')
        set(handles.popupmenu13,'Visible','On')
        set(handles.popupmenu14,'Visible','On')
        % Populates the pop-up menus with relevant options
        set(handles.popupmenu11,'String',handles.shoreContentsCal)
        set(handles.popupmenu12,'String',handles.shoreContentsCal)
        set(handles.popupmenu13,'String',handles.shoreContentsCal)
        stdContents=[handles.shoreContentsCal;'-'];
        set(handles.popupmenu14,'String',stdContents)
    end

% --- Executes on button press in ok5.
function ok5_Callback(hObject, eventdata, handles)
% hObject    handle to ok5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.uipanel5,'visible','off')
    set(handles.uipanel13,'visible','on')
    
    error=0;
    
    %Clears graphs
    cla(handles.wavegraph2,'reset')
    cla(handles.shoregraph2,'reset')    
    %Loads file
    load(handles.fileWaveCal)
    %Identifies user inputs in dropdown menu
    HstringCal = get(handles.popupmenu8,'String'); 
    HstringCal = HstringCal{get(handles.popupmenu8,'Value')};
    TstringCal = get(handles.popupmenu9,'String'); 
    TstringCal = TstringCal{get(handles.popupmenu9,'Value')};
    waveDatestringCal = get(handles.popupmenu10,'String'); 
    waveDatestringCal = waveDatestringCal{get(handles.popupmenu10,'Value')};
    %Saves the selections for later use
    handles.HstringCal=HstringCal;
    handles.TstringCal=TstringCal;
    handles.waveDatestringCal=waveDatestringCal;
    guidata(hObject,handles)
    %Matches the drop down menus election to the corresponding data
    HdataCal=eval(HstringCal);
    TdataCal=eval(TstringCal);
    waveDatedataCal=eval(waveDatestringCal);
    %Plots the graph
    if numel(HdataCal)==numel(TdataCal) & numel(HdataCal)==numel(waveDatedataCal)
    axes(handles.wavegraph2);
    drawnow
    [AX,h1,h2] = plotyy(waveDatedataCal,HdataCal,waveDatedataCal,TdataCal);
    drawnow
    %Converts x-axis to dates
    datetick(AX(1),'x','yy')
    set(AX(2),'xtick',[])
    datetick(AX(2),'x','yy')
    %set(h1,'color','black')
    %set(h2,'color',[1 .7 0])
    set(AX(1),'ycolor','black','fontsize',10)
    set(AX(2),'ycolor','black','fontsize',10)
    set(AX(2),'xcolor','black','fontsize',10)
    legend([h1;h2],'Wave Height','Wave Period')
    %Labels axes
    axes(AX(1))
    ylabel('Wave Height (m)','color','black','fontweight','bold')
    axes(AX(2))
    ylabel('Wave Period (s)','color','black','fontweight','bold')
    xlabel('Time','color','black','fontweight','bold')
    title('Calibration Wave Data','color','black','fontweight','bold')
    
    else
    cla(handles.wavegraph2,'reset')
        
	axes(handles.wavegraph2);
	x=[0:0.2:1];
	y=[0:0.2:1];
	z=[1:-0.2:0];
	[AX,h1,h2]=plotyy(x,y,x,z);
	title('Error','color','black','fontweight','bold')
	set(h1,'color','red')
	set(h2,'color','red')
	set(AX(1),'ycolor','black','fontsize',10)
    set(AX(2),'ycolor','black','fontsize',10)
	set(AX(2),'xcolor','black','fontsize',10)

    error=1;
    end
    
    % Clears graph
    cla(handles.shoregraph2,'reset')
    %Loads calibration shoreline file
    load(handles.fileShorelineCal)
    %Identifies user inputs in dropdown menu
    shoreDatastringCal = get(handles.popupmenu11,'String'); 
    shoreDatastringCal = shoreDatastringCal{get(handles.popupmenu11,'Value')};
    ZstringCal = get(handles.popupmenu12,'String'); 
    ZstringCal = ZstringCal{get(handles.popupmenu12,'Value')};
    shoreDatestringCal = get(handles.popupmenu13,'String'); 
    shoreDatestringCal = shoreDatestringCal{get(handles.popupmenu13,'Value')};
    STDstringCal = get(handles.popupmenu14,'String'); 
    STDstringCal = STDstringCal{get(handles.popupmenu14,'Value')};
    %Saves the selections for later use
    handles.shoreDatastringCal=shoreDatastringCal;    
    handles.ZstringCal=ZstringCal;
    handles.STDstringCal=STDstringCal;
    handles.shoreDatestringCal=shoreDatestringCal;
    guidata(hObject,handles)
    %Matches the drop down menus election to the corresponding data
    shoreDataCal=eval(shoreDatastringCal);
    ZdataCal=eval(ZstringCal);
    shoreDatedataCal=eval(shoreDatestringCal);
    if STDstringCal ~= '-'
        STDdataCal=eval(STDstringCal);
    else
        STDdataCal='-';
        STDstringCal=[];
        handles.STDstringCal=STDstringCal;
    end
    
    guidata(hObject,handles)
    
    %Plots the graph
    if (numel(shoreDataCal)==numel(ZdataCal) & numel(shoreDataCal)==numel(shoreDatedataCal) & numel(shoreDataCal)==numel(STDdataCal)) | ...
       (numel(shoreDataCal)==numel(ZdataCal) & numel(shoreDataCal)==numel(shoreDatedataCal) & STDdataCal=='-')
    axes(handles.shoregraph2);
    drawnow
    [AX,h1,h2] = plotyy(shoreDatedataCal,shoreDataCal,shoreDatedataCal,ZdataCal);
    drawnow
    %Converts x-axis to dates
    datetick(AX(1),'x','yy')
    set(AX(2),'xtick',[])
    datetick(AX(2),'x','yy')
    %set(h1,'color','black')
    %set(h2,'color',[1 .7 0])
    set(AX(1),'ycolor','black','fontsize',10)
    set(AX(2),'ycolor','black','fontsize',10)
    set(AX(2),'xcolor','black','fontsize',10)
    legend([h1;h2],'Shoreline Position','Shoreline Elevation')
    %Labels axes
    axes(AX(1))
    ylabel('Shore Position (m)','color','black','fontweight','bold')
    axes(AX(2))
    ylabel('Shore Elevation (m)','color','black','fontweight','bold')
    xlabel('Time','color','black','fontweight','bold')
    title('Calibration Shoreline Data','color','black','fontweight','bold')    
    %Adds error bars
    if STDstringCal ~= '-'
        hold(AX(1), 'on');
        errorbar(AX(1), shoreDatedataCal, shoreDataCal, STDdataCal);%,'color','black');
    end    
        
    else
	cla(handles.shoregraph2,'reset')        
        
    axes(handles.shoregraph2);
	x=[0:0.2:1];
	y=[0:0.2:1];
	z=[1:-0.2:0];
	[AX,h1,h2]=plotyy(x,y,x,z);
	title('Error','color','black','fontweight','bold')
	set(h1,'color','red')
	set(h2,'color','red')
	set(AX(1),'ycolor','black','fontsize',10)
	set(AX(2),'ycolor','black','fontsize',10)
	set(AX(2),'xcolor','black','fontsize',10)
    
    error=1;    
    
    end
    
    if error==1
        errordlg('Incompatible data selected, please try again.')
    else
        %Makes proceed and clear button appear
        set(handles.proceed6,'Visible','On')
        set(handles.clear2,'Visible','On')
        set(handles.ok5,'visible','off')
        
        %Makes toggle buttons appear
        set(handles.toggle1,'visible','on')
        set(handles.toggle2,'visible','on')
        
    end
    
% --- Executes on button press in proceed1.
function proceed1_Callback(hObject, eventdata, handles)
% hObject    handle to proceed1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel3,'visible','on')

% --- Executes on button press in proceed2.
function proceed2_Callback(hObject, eventdata, handles)
% hObject    handle to proceed2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sitestring=get(handles.edit1,'String');
errorstring=get(handles.edit2,'string');
depthstring=get(handles.edit3,'string');
d50string=get(handles.edit4,'string');
    if isempty(sitestring)
        errordlg('Please insert a site name.')
    elseif isempty(errorstring)
        errordlg('Please insert a number in the shoreline error box.')
    elseif isempty(str2num(errorstring))
        errordlg('Please insert a number in the shoreline error box.')
    elseif isempty(depthstring)
        errordlg('Please insert a number in the water depth box.')
    elseif isempty(str2num(depthstring))
        errordlg('Please insert a number in the water depth box.')
    elseif isempty(d50string)
        errordlg('Please insert a number in the d50 value box.')
    elseif isempty(str2num(d50string))
        errordlg('Please insert a number in the d50 value box.')
    else
        % Simple statement to make sure uipanel4 can't become visible
        % when it isn't supposed to. Checks to see if a check box has been
        % ticked.
        try
            iswitchCal=handles.iswitchCalGUI;
        catch
            set(handles.uipanel4,'visible','on')
        end
    end
    
% --- Executes on button press in proceed3.
function proceed3_Callback(hObject, eventdata, handles)
% hObject    handle to proceed3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    checkedbox=handles.iswitchCalGUI;
    backcheck=0;
    handles.backcheck=backcheck;
    guidata(hObject,handles)  
    if checkedbox==0
        set(handles.uipanel6,'visible','on')
        set(handles.uipanel4,'visible','off')
    elseif checkedbox==1
        set(handles.uipanel7,'visible','on')
        set(handles.uipanel4,'visible','off')
    elseif checkedbox==2
        set(handles.uipanel8,'visible','on')
        set(handles.uipanel4,'visible','off')
    elseif checkedbox==3
        set(handles.uipanel11,'visible','on')
        set(handles.uipanel4,'visible','off')
    else
        errordlg('Please select a calibration option.')
    end
catch
	errordlg('Please select a calibration option.')
end

% --- Executes on button press in proceed4.
function proceed4_Callback(hObject, eventdata, handles)
% hObject    handle to proceed4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(get(handles.text15,'String'))
    errordlg('Please select a start date.')
elseif strcmp(get(handles.text15,'string'),'00-00-0000 00:00:00')
    errordlg('Please select a start date.')
elseif isempty(get(handles.text16,'String'))
    errordlg('Please select an end date.')    
elseif strcmp(get(handles.text16,'string'),'00-00-0000 00:00:00')
    errordlg('Please select an end date.')
elseif handles.s2GUI<handles.s1GUI
    errordlg('Please pick an end date that is after the start date.')
else
    set(handles.uipanel6,'visible','on')
    set(handles.uipanel7,'visible','off')
    backcheck=1;
    handles.backcheck=backcheck;
    guidata(hObject,handles) 
end
     
% --- Executes on button press in proceed5.
function proceed5_Callback(hObject, eventdata, handles)
% hObject    handle to proceed5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Clear the graph
%Makes proceed button appear
set(handles.uipanel9,'Visible','On')
set(handles.uipanel8,'Visible','Off')
    
% --- Executes on button press in proceed6.
function proceed6_Callback(hObject, eventdata, handles)
% hObject    handle to proceed6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Clears the graph
%Makes proceed button appear
set(handles.uipanel10,'Visible','On')
set(handles.uipanel9,'Visible','Off')
    
% --- Executes on button press in proceed7.
function proceed7_Callback(hObject, eventdata, handles)
% hObject    handle to proceed7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
errorstring=get(handles.edit7,'string');
depthstring=get(handles.edit8,'string');
d50string=get(handles.edit9,'string');
    if isempty(errorstring)
        errordlg('Please insert a number in the shoreline error box.')
    elseif isempty(str2num(errorstring))
        errordlg('Please insert a number in the shoreline error box.')
    elseif isempty(depthstring)
        errordlg('Please insert a number in the water depth box.')
    elseif isempty(str2num(depthstring))
        errordlg('Please insert a number in the water depth box.')
    elseif isempty(d50string)
        errordlg('Please insert a number in the d50 value box.')
    elseif isempty(str2num(d50string))
        errordlg('Please insert a number in the d50 value box.')
    else
        set(handles.uipanel6,'visible','on')
        set(handles.uipanel10,'visible','off')
        backcheck=2;
        handles.backcheck=backcheck;
        guidata(hObject,handles)   
    end

% --- Executes on button press in proceed8.
function proceed8_Callback(hObject, eventdata, handles)
% hObject    handle to proceed8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel12,'visible','on')
set(handles.uipanel3,'visible','off')
set(handles.uipanel11,'visible','off')
set(handles.checkbox9,'ForegroundColor','r')
set(handles.checkbox9,'Value',0)
backcheck=3;
handles.backcheck=backcheck;
guidata(hObject,handles)
    
% --- Executes on button press in proceed9.
function proceed9_Callback(hObject, eventdata, handles)
% hObject    handle to proceed9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filter=evalin('base','ihardwireGUI');
if filter==0
    text=get(handles.edit5,'String');
    if isempty(text)
        errordlg('Please insert a number in the filter value box.')
    elseif isempty(str2num(text))  
        errordlg('Please insert a number in the filter value box.')
    else
        omegaFilterCutOffGUI=str2double(text);
        assignin('base','omegaFilterCutOffGUI',omegaFilterCutOffGUI)        
        set(handles.uipanel12,'visible','on')
        set(handles.uipanel6,'visible','off')
        set(handles.uipanel3,'visible','off')
        backcheck=4;
        handles.backcheck=backcheck;
        guidata(hObject,handles)
        set(handles.checkbox9,'ForegroundColor','r')
        set(handles.checkbox9,'Value',0)
    end
elseif filter==1
    set(handles.uipanel12,'visible','on')
    set(handles.uipanel6,'visible','off')
    set(handles.uipanel3,'visible','off')
    backcheck=4;
    handles.backcheck=backcheck;
    guidata(hObject,handles)
else
    errordlg('Please make a selection.')
end


% --- Executes on button press in back1.
function back1_Callback(hObject, eventdata, handles)
% hObject    handle to back1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel7,'visible','off')
set(handles.uipanel4,'visible','on')

% --- Executes on button press in back2.
function back2_Callback(hObject, eventdata, handles)
% hObject    handle to back2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel8,'visible','off')
set(handles.uipanel4,'visible','on')

set(handles.uipanel13,'visible','off')
set(handles.uipanel5,'visible','on')

% --- Executes on button press in back3.
function back3_Callback(hObject, eventdata, handles)
% hObject    handle to back3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel9,'visible','off')
set(handles.uipanel8,'visible','on')

% --- Executes on button press in back4.
function back4_Callback(hObject, eventdata, handles)
% hObject    handle to back4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel10,'visible','off')
set(handles.uipanel9,'visible','on')

% --- Executes on button press in back5.
function back5_Callback(hObject, eventdata, handles)
% hObject    handle to back5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel11,'visible','off')
set(handles.uipanel4,'visible','on')

% --- Executes on button press in back6.
function back6_Callback(hObject, eventdata, handles)
% hObject    handle to back6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel6,'visible','off')
backcheck=handles.backcheck;
set(handles.checkbox9,'ForegroundColor','black')
if backcheck==1
    set(handles.uipanel7,'visible','on')    
elseif backcheck==2
    set(handles.uipanel10,'visible','on')
elseif backcheck==3
    set(handles.uipanel11,'visible','on')
else
    set(handles.uipanel4,'visible','on')
end

% --- Executes on button press in back7.
function back7_Callback(hObject, eventdata, handles)
% hObject    handle to back7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
backcheck=handles.backcheck;
set(handles.checkbox9,'ForegroundColor','black')
if backcheck==3
    set(handles.uipanel12,'visible','off')
    set(handles.uipanel11,'visible','on')
    set(handles.uipanel3,'visible','on')
else
    set(handles.uipanel12,'visible','off')
    set(handles.uipanel6,'visible','on')
    set(handles.uipanel3,'visible','on')
end


% --- Executes on button press in clear1.
function clear1_Callback(hObject, eventdata, handles)
% hObject    handle to clear1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.wavegraph1,'reset')
cla(handles.shoregraph1,'reset')

set(handles.proceed1,'Visible','Off')
set(handles.clear1,'Visible','Off')
set(handles.ok2,'visible','on')
 
% --- Executes on button press in clear2.
function clear2_Callback(hObject, eventdata, handles)
% hObject    handle to clear2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.wavegraph2,'reset')
cla(handles.shoregraph2,'reset')

set(handles.proceed6,'Visible','Off')
set(handles.clear2,'Visible','Off')
set(handles.ok5,'visible','on')


% --- Executes on button press in runmodel.
function runmodel_Callback(hObject, eventdata, handles)
% hObject    handle to runmodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
datatype=handles.datatype;

if datatype == 1 %formatted
    ShoreFor1_0_TB
elseif datatype == 2 %raw
% Saves the result selections made by the user
    check1=get(handles.checkbox7,'Value');
    check2=get(handles.checkbox8,'Value');
    check3=get(handles.checkbox9,'Value');
    assignin('base','check1',check1);
    assignin('base','check2',check2);
    assignin('base','check3',check3);

% Identifies original files
    FileH=handles.Hstring;
    assignin('base','FileH',FileH)
    FileT=handles.Tstring;
    assignin('base','FileT',FileT)
    FileWaveDate=handles.waveDatestring;
    assignin('base','FileWaveDate',FileWaveDate)
    FileData=handles.shoreDatastring;
    assignin('base','FileData',FileData)
    FileZ=handles.Zstring;
    assignin('base','FileZ',FileZ)
    FileSTD=handles.STDstring;
    assignin('base','FileSTD',FileSTD)
    FileShoreDate=handles.shoreDatestring;
    assignin('base','FileShoreDate',FileShoreDate)

% Saves user specified site name
    siteGUI=get(handles.edit1,'String');
    assignin('base','siteGUI',siteGUI)
% Error in shoreline measurements
    dxGUI=get(handles.edit2,'String');
    assignin('base','dxGUI',dxGUI)
% Wave height
    hWaveHGUI=get(handles.edit3,'String');
    assignin('base','hWaveHGUI',hWaveHGUI)
% d50
    d50GUI=get(handles.edit4,'String');
    assignin('base','d50GUI',d50GUI)
% identifies calibration method selected
    iswitchCalGUI=handles.iswitchCalGUI;
    assignin('base','iswitchCalGUI',iswitchCalGUI)

% different data set calibration
    if iswitchCalGUI==2
% Identifies relevant files    
        FileHCal=handles.HstringCal;
        assignin('base','FileHCal',FileHCal)
        FileTCal=handles.TstringCal;
        assignin('base','FileTCal',FileTCal)
        FileWaveDateCal=handles.waveDatestringCal;
        assignin('base','FileWaveDateCal',FileWaveDateCal)
        FileDataCal=handles.shoreDatastringCal;
        assignin('base','FileDataCal',FileDataCal)
        FileZCal=handles.ZstringCal;
        assignin('base','FileZCal',FileZCal)
        FileSTDCal=handles.STDstringCal;
        assignin('base','FileSTDCal',FileSTDCal)
        FileShoreDateCal=handles.shoreDatestringCal;
        assignin('base','FileShoreDateCal',FileShoreDateCal)
% Calibration Error in shoreline measurements
        dxGUICal=get(handles.edit7,'String');
        assignin('base','dxGUICal',dxGUICal)
% Calibration Wave height
        hWaveHGUICal=get(handles.edit8,'String');
        assignin('base','hWaveHGUICal',hWaveHGUICal)
% Calibration d50
        d50GUICal=get(handles.edit9,'String');
        assignin('base','d50GUICal',d50GUICal)
    end

% Runs codes
genUserData_TB

ShoreFor1_0_TB

end


% --- Executes on button press in toggle1.
function toggle1_Callback(hObject, eventdata, handles)
% hObject    handle to toggle1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of toggle1
togglestate=get(hObject,'Value');
if togglestate==get(hObject,'Max')
    set(handles.toggle2,'value',0)
    set(handles.uipanel13,'visible','off')
    set(handles.uipanel5,'visible','on')
else
    set(handles.toggle2,'value',1)
    set(handles.uipanel13,'visible','on')
    set(handles.uipanel5,'visible','off')
end

% --- Executes on button press in toggle2.
function toggle2_Callback(hObject, eventdata, handles)
% hObject    handle to toggle2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of toggle2
togglestate=get(hObject,'Value');
if togglestate==get(hObject,'Max')
    set(handles.toggle1,'value',0)
    set(handles.uipanel5,'visible','off')
    set(handles.uipanel13,'visible','on')
else
    set(handles.toggle1,'value',1)
    set(handles.uipanel5,'visible','on')
    set(handles.uipanel13,'visible','off')
end



% --- Executes on button press in format.
function format_Callback(hObject, eventdata, handles)
% hObject    handle to format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if exist('userData.mat')~=2
    errordlg('No valid file named "userData.mat" in the directory, please fix the file or try using raw data.')
else
    set(handles.back7,'visible','off')
    set(handles.uipanel12,'visible','on')
    datatype=1; %formatted
    handles.datatype=datatype;
    guidata(hObject,handles)
    delete(handles.uipanel17)    
end

% --- Executes on button press in raw.
function raw_Callback(hObject, eventdata, handles)
% hObject    handle to raw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel2,'visible','on')
set(handles.uipanel5,'visible','on')
datatype=2; %raw
handles.datatype=datatype;
guidata(hObject,handles)
delete(handles.uipanel17)
delete(handles.uipanel19)


% --- Executes on button press in restart.
function restart_Callback(hObject, eventdata, handles)
% hObject    handle to restart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcbf)
GUI_ShoreFor

%=================================================================
%   Pop-up Menus
%=================================================================


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9


% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu12.
function popupmenu12_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu12


% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu13.
function popupmenu13_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu13


% --- Executes during object creation, after setting all properties.
function popupmenu13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu14.
function popupmenu14_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu14


% --- Executes during object creation, after setting all properties.
function popupmenu14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%=================================================================
%   Check boxes
%=================================================================

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
    check1state=get(hObject,'Value');
    if check1state==get(hObject,'Max')
        set(handles.checkbox2,'Value',0)
        set(handles.checkbox3,'Value',0)
        set(handles.checkbox4,'Value',0)
        set(hObject,'value',1)
        iswitchCalGUI=0;
        handles.iswitchCalGUI=iswitchCalGUI;
        guidata(hObject,handles)
    else
        iswitchCalGUI='';
        handles.iswitchCalGUI=iswitchCalGUI;
        guidata(hObject,handles)
    end

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
    check2state=get(hObject,'Value');
    if check2state==get(hObject,'Max')
        set(handles.checkbox1,'Value',0)
        set(handles.checkbox3,'Value',0)
        set(handles.checkbox4,'Value',0)
        set(hObject,'value',1)        
        iswitchCalGUI=1;
        handles.iswitchCalGUI=iswitchCalGUI;
        guidata(hObject,handles)
    else
        iswitchCalGUI='';
        handles.iswitchCalGUI=iswitchCalGUI;
        guidata(hObject,handles)
    end

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
    check3state=get(hObject,'Value');
    if check3state==get(hObject,'Max')
        set(handles.checkbox1,'Value',0)
        set(handles.checkbox2,'Value',0)
        set(handles.checkbox4,'Value',0)
        set(hObject,'value',1)        
        iswitchCalGUI=2;
        handles.iswitchCalGUI=iswitchCalGUI;
        guidata(hObject,handles)
    else
        iswitchCalGUI='';
        handles.iswitchCalGUI=iswitchCalGUI;
        guidata(hObject,handles)
    end

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
    check4state=get(hObject,'Value');
    if check4state==get(hObject,'Max')
        set(handles.checkbox1,'Value',0)
        set(handles.checkbox2,'Value',0)
        set(handles.checkbox3,'Value',0)
        set(hObject,'value',1)        
        iswitchCalGUI=3;
        handles.iswitchCalGUI=iswitchCalGUI;
        guidata(hObject,handles)
    else
        iswitchCalGUI='';
        handles.iswitchCalGUI=iswitchCalGUI;
        guidata(hObject,handles)
    end    
    
% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
if get(hObject,'Value')==get(hObject,'Max')
    set(handles.text14,'Visible','Off')
    set(handles.edit5,'Visible','Off')
    set(handles.checkbox6,'Value',0)
    set(handles.proceed9,'Visible','On')
    filtervalueGUI=1;
    handles.filtervalueGUI=filtervalueGUI;
    guidata(hObject,handles)
    assignin('base','ihardwireGUI',filtervalueGUI)
else
    set(handles.proceed9,'Visible','Off')
    filtervalueGUI='';
    handles.filtervalueGUI=filtervalueGUI;
    guidata(hObject,handles)
    assignin('base','ihardwireGUI',filtervalueGUI)  
end

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
if get(hObject,'Value')==get(hObject,'Max')
    set(handles.text14,'Visible','On')
    set(handles.edit5,'Visible','On')
    set(handles.checkbox5,'Value',0)   
    set(handles.proceed9,'Visible','On')
    filtervalueGUI=0;
    handles.filtervalueGUI=filtervalueGUI;
    guidata(hObject,handles)
    assignin('base','ihardwireGUI',filtervalueGUI)
else
    set(handles.text14,'Visible','Off')
    set(handles.edit5,'Visible','Off')
    set(handles.proceed9,'Visible','Off')
    filtervalueGUI='';
    handles.filtervalueGUI=filtervalueGUI;
    guidata(hObject,handles)
    assignin('base','ihardwireGUI',filtervalueGUI)
end


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7

% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8

% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9
iswitchCalGUI=handles.iswitchCalGUI;
ihardWire=handles.filtervalueGUI;
if iswitchCalGUI==3 || ihardWire==0
    set(hObject,'Value',0)
    helpdlg('Accuracy results not available when using the "Parameterize" calibration option or the "Hardwire Filter Value" option.')
end


%=================================================================
%   Edit Boxes
%=================================================================

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok6.
function ok6_Callback(hObject, eventdata, handles)
% hObject    handle to ok6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runforecast.
function runforecast_Callback(hObject, eventdata, handles)
% hObject    handle to runforecast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hindcast.
function hindcast_Callback(hObject, eventdata, handles)
% hObject    handle to hindcast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in forecast.
function forecast_Callback(hObject, eventdata, handles)
% hObject    handle to forecast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
