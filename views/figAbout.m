function varargout = figAbout(varargin)
% FIGABOUT M-file for figAbout.fig
%      FIGABOUT, by itself, creates a new FIGABOUT or raises the existing
%      singleton*.
%
%      H = FIGABOUT returns the handle to a new FIGABOUT or the handle to
%      the existing singleton*.
%
%      FIGABOUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIGABOUT.M with the given input arguments.
%
%      FIGABOUT('Property','Value',...) creates a new FIGABOUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before figAbout_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to figAbout_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help figAbout

% Last Modified by GUIDE v2.5 22-Jul-2013 14:15:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @figAbout_OpeningFcn, ...
                   'gui_OutputFcn',  @figAbout_OutputFcn, ...
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


% --- Executes just before figAbout is made visible.
function figAbout_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to figAbout (see VARARGIN)

% Choose default command line output for figAbout
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes figAbout wait for user response (see UIRESUME)
% uiwait(handles.figure1);
cFieldNames=fieldnames(handles);
nColor=[0.929 0.929 0.929];
for i=1:length(cFieldNames)  
    nThisHandle=getfield(handles,cFieldNames{i});
    if strcmpi(get(nThisHandle,'Tag'),'figure1');
        set(nThisHandle,'Color',nColor);
    elseif isprop(nThisHandle,'Style')
        sObjectStyle=get(nThisHandle,'Style');
        if any(strcmpi(sObjectStyle,{'text','panel'}))
            set(getfield(handles,cFieldNames{i}),'BackgroundColor',nColor);
        end
    elseif isprop(nThisHandle,'Tag')
        sTag=get(nThisHandle,'Tag');
        if length(sTag)>=3&strcmp(sTag(1:3),'pnl')
            set(getfield(handles,cFieldNames{i}),'BackgroundColor',nColor);
        end
    end
end


% --- Outputs from this function are returned to the command line.
function varargout = figAbout_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

axes(handles.p_logo);
imshow('docs/logo-smile.png');
varargout{1} = handles.output;


% --- Executes on button press in cmdOK.
function cmdOK_Callback(hObject, eventdata, handles)
% hObject    handle to cmdOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.figure1);
