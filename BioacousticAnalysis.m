function varargout = BioacousticAnalysis(varargin)
% BIOACOUSTICANALYSIS MATLAB code for BioacousticAnalysis.fig
%      BIOACOUSTICANALYSIS, by itself, creates a new BIOACOUSTICANALYSIS or raises the existing
%      singleton*.
%
%      H = BIOACOUSTICANALYSIS returns the handle to a new BIOACOUSTICANALYSIS or the handle to
%      the existing singleton*.
%
%      BIOACOUSTICANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BIOACOUSTICANALYSIS.M with the given input arguments.
%
%      BIOACOUSTICANALYSIS('Property','Value',...) creates a new BIOACOUSTICANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BioacousticAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BioacousticAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BioacousticAnalysis

% Last Modified by GUIDE v2.5 06-Dec-2017 11:58:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BioacousticAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @BioacousticAnalysis_OutputFcn, ...
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

% --- Executes just before BioacousticAnalysis is made visible.
function BioacousticAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BioacousticAnalysis (see VARARGIN)

% Choose default command line output for BioacousticAnalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
 % Inicialization of the variable before the GUI made visible

% UIWAIT makes BioacousticAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = BioacousticAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global devices
devices = daq.getDevices;%%Shows the available devices
if isempty(devices)
    msgbox('There is no daq devices','Warning')%% if there are no devices connected, it shows a warning message
else
    global s 
    global lh
    global i;i=1;
    global channels  %Create a vector with the name of the channels that are going to be used
    s = daq.createSession('ni'); %name of the session
    s.Rate = 11025;%sample rate
    s.IsContinuous = true; %To get the signals until stop the sesion and monitor the name of the channels
    if isempty(channels)%the value of channels is given by the function setChannels triggered by the checkbox mic        
        msgbox('There are no mics selected','Warning')
    else 
        ch=addAnalogInputChannel(s,'Dev1', channels, 'Voltage');%% ch is an object composed by the analog inputs named by channels 
        %For each channel change the configuration and create the vector for the
        %plot
        for i=1:length(ch)
            ch(i).InputType='SingleEnded'; %Configures every input channel to measure the signal compared to the reference
            i
        end

        plotFFT = @(src, event) continuous_fft(event.Data, src.Rate);
        lh = addlistener(s,'DataAvailable',plotFFT); %listener triggered by session s amd executes fuction plotFFT
        startBackground(s); %starts the background session
    end
    
end


% --- Executes on button press in PauseButton.
function PauseButton_Callback(hObject, eventdata, handles)
% hObject    handle to PauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s
global lh

delete(lh);
stop(s);
s.IsContinuous = false;

% 

global data3
uisave('data3')
clear data3

% --- Executes on button press in Mic1.
function Mic1_Callback(hObject, eventdata, handles)
% hObject    handle to Mic1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global channels
mics='ai13';
if hObject.Value==1        
    setChannels(mics,hObject.Value);    
else
    setChannels(mics,hObject.Value);
end




% Hint: get(hObject,'Value') returns toggle state of Mic1

% --- Executes on button press in Mic2.
function Mic2_Callback(hObject, eventdata, handles)
% hObject    handle to Mic2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Mic2
global channels
mics='ai5';
if hObject.Value==1        
    setChannels(mics,hObject.Value);    
else
    setChannels(mics,hObject.Value);
end

% --- Executes on button press in Mic3.
function Mic3_Callback(hObject, eventdata, handles)
% hObject    handle to Mic3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Mic3
global channels
mics='ai14';
if hObject.Value==1        
    setChannels(mics,hObject.Value);    
else
    setChannels(mics,hObject.Value);
end

% --- Executes on button press in Mic4.
function Mic4_Callback(hObject, eventdata, handles)
% hObject    handle to Mic4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Mic4
global channels
mics='ai6';
if hObject.Value==1        
    setChannels(mics,hObject.Value);    
else
    setChannels(mics,hObject.Value);
end

% --- Executes on button press in Mic5.
function Mic5_Callback(hObject, eventdata, handles)
% hObject    handle to Mic5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Mic5

% --- Executes on button press in Mic6.
function Mic6_Callback(hObject, eventdata, handles)
% hObject    handle to Mic6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Mic6

% --- Executes on button press in Mic7.
function Mic7_Callback(hObject, eventdata, handles)
% hObject    handle to Mic7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Mic7

% --- Executes on button press in Mic8.
function Mic8_Callback(hObject, eventdata, handles)
% hObject    handle to Mic8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Mic8
