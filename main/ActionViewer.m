function varargout = ActionViewer(varargin)
% ActionViewer MATLAB code for ActionViewer.fig
%      ActionViewer, by itself, creates a new ActionViewer or raises the existing
%      singleton*.
%
%      H = ActionViewer returns the handle to a new ActionViewer or the handle to
%      the existing singleton*.
%
%      ActionViewer('CALLBACK',hObject,eventData,Hds,...) calls the local
%      function named CALLBACK in ActionViewer.M with the given input arguments.
%
%      ActionViewer('Property','Value',...) creates a new ActionViewer or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ActionViewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ActionViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ActionViewer

% Last Modified by GUIDE v2.5 09-Jan-2018 01:27:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ActionViewer_OpeningFcn, ...
    'gui_OutputFcn',  @ActionViewer_OutputFcn, ...
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


% --- Executes just before ActionViewer is made visible.
function ActionViewer_OpeningFcn(hObject, eventdata, Hds, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
% varargin   command line arguments to ActionViewer (see VARARGIN)

% Determine whether ExemplarFinder is already running
hdlAllFigs=findall(0,'Type','figure');
sFigureNames=get(hdlAllFigs,'Name');
sVisible=get(hdlAllFigs,'Visible');
if any(strcmp(sFigureNames,'ActionViewer')&strcmp(sVisible,'on'))
    fprintf('WARNING:  ActionViewer is already running.\n\n');
    
    % Verify that the user wishes to open another session
    sInput=questdlg('Would you like to start a new session?', ...
        'WARNING: Program running','Yes','No','No');
    if isempty(sInput) || strcmpi(sInput,'no')
        %         Quit_Program();
        return;
    else
        Quit_Program();
    end
    
end

tmp = fileparts(which('ActionViewer'));
Hds.rootdir = [fileparts(tmp(1:end-3)) '/'];

axes(Hds.logo_smile);
imshow([Hds.rootdir 'docs/logo-smile.png']);
axes(Hds.logo_nu);
imshow([Hds.rootdir 'docs/nu_logo.png']);

axis(Hds.axis_preview);

% Choose default command line output for ActionViewer
Hds.output = hObject;
do_preview = 0;
% imshow('logo-smile.png');
if ~exist( varargin, 'var' ) && isfield(varargin,'images')
    
    video_data.frames = varargin.frames;
    video_data.display = true;
    video_data.current_index = 1;
    video_data.nframes = numel(video_data.image_record);
    video_data.unsaved = false;
    %     video_data.fpath = ['./fd_' video_data.corpus.info.collection_id{1} '.mat'];
    
    
    if video_data.nframes > 0,     do_preview = 1;     end
    
else
    video_data = {};
    %     video_data = clean_corpus(video_data);
end

Hds.video_data = video_data;
% Update Hds structure
guidata(hObject, Hds);
if do_preview,      display_frame (video_data.frames{1},Hds);
    set_buttons(Hds);
    set_display (Hds)
end


% --- Outputs from this function are returned to the command line.
function varargout = ActionViewer_OutputFcn(hObject, eventdata, Hds)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)

% Get default command line output from Hds structure
varargout{1} = Hds.output;

% --- Executes on button press in pb_load.
function pb_load_Callback(hObject, ~, Hds)       %#ok<DEFNU>
% open M file; preview set to index 1

Hds = load_video(hObject, Hds);
set_display (Hds);
set_buttons (Hds);

% if isempty (cur_frame), return;  end
% axis(Hds.axis_preview);
display_frame (Hds);




%% Scroll Pad Panel
% --- Executes on button press in pb_prev, pb_play, pb_next, pb_last, pb_first
function pb_scroll_Callback(hObject, ~, Hds) %#ok<DEFNU>


culprit_varname = get(hObject,'Tag');   % component event triggered upon

% --- Executes next button press.
if strcmp(culprit_varname, 'pb_next')
    
    video_data = Hds.video_data;  % localize corpus vals
    
    % increment index to point at next exemplar in corpus
    Hds.video_data.current_index = video_data.current_index + 1;
    
    % check index stays within bounds, i.e. less than equal to # exemplars
    if Hds.video_data.current_index > Hds.video_data.nframes
        % logic governing this source should prevent this, but to ensure ...
        Hds.video_data.current_index = Hds.video_data.nframes;
    end
    
    % assign next exemplar in corpus
    %     next_frame = video_data.frames{Hds.video_data.current_index};
    
    % update GUI's axis with plot of next exemplar
    display_frame(Hds); % func call to display, i.e., plot
    
    set_display(Hds);
    
    
    % --- Executes previous button press.
elseif strcmp(culprit_varname, 'pb_prev')
    
    video_data = Hds.video_data;  % localize corpus vals
    
    if video_data.current_index == 1
        % check index stays within bounds, i.e. less than equal to # exemplars
        % if not, re-set GUI component states
        
        %         set_gui_components(Hds)
        
        set_buttons (Hds)
        return;
    else
        % decrease index to point at next exemplar in corpus
        Hds.video_data.current_index = video_data.current_index - 1;
    end
    % assign next exemplar in corpus
    %     previous_frame = video_data.frames{Hds.video_data.current_index};
    
    % update GUI's axis with plot of next exemplar
    display_frame(Hds); % func call to display, i.e., plot
    
    
    set_display(Hds);
    
    % --- Executes << button press.
elseif strcmp(culprit_varname, 'pb_first')
    video_data = Hds.video_data;  % localize corpus vals
    
    % set index to 1, i.e., first exemplar
    Hds.video_data.current_index = 1;
    
    % assign 1st exemplar in corpus
    %     first_frame = video_data.frames{Hds.video_data.current_index};
    
    % update GUI's axis with plot of 1st exemplar
    display_frame(Hds); % func call to display, i.e., plot
    
    set_display(Hds);
    % --- Executes >> button press.
elseif strcmp(culprit_varname, 'pb_last')
    
    video_data = Hds.video_data;  % localize corpus vals
    
    % set index to 1, i.e., first exemplar
    Hds.video_data.current_index = video_data.nframes;
    
    % assign 1st exemplar in corpus
    %     last_exemplar = video_data.frames{Hds.video_data.current_index};
    
    % update GUI's axis with plot of 1st exemplar
    display_frame(Hds); % func call to display, i.e., plot
    
    
    set_display(Hds);
    % --- Executes add button press.
elseif strcmp(culprit_varname, 'pb_add')
    
    % extract corpus vars from data handle
    if ~Hds.video_data.display
        Hds.video_data.num_exemp_flags = Hds.video_data.num_exemp_flags + 1;
        Hds.video_data.unsaved = true;
    end
    %
    % % --- Executes remove button press.
    % elseif strcmp(culprit_varname, 'pb_remove')
    %
    %
    %     % extract corpus vars from data handle
    %     if Hds.video_data.corpus.flag ~= -1
    %         Hds.video_data.flag = -1;
    %         Hds.video_data.unsaved = true;
    %     end
    %
    % % --- Executes remove button press.
    % elseif strcmp(culprit_varname, 'pb_delete')
    %
    %     % extract corpus vars from data handle
    %     current_index = Hds.video_data.current_index;
    %     frames = Hds.video_data.frames;
    %     cur_exemplar = frames{current_index};
    %
    %     % determine boundaries according to the current state of 'next'; if enabled
    %     % then check 'previous'... logic elsewhere sets button states
    %     if strcmp(get(Hds.pb_next,'Enable'), 'on')
    %         Hds.video_data.current_index = Hds.video_data.current_index + 1;
    %         %         next_exemplar = cur_corpus.exemplars ...
    %         %             (Hds.video_data.current_index + 1);
    %
    %     elseif strcmp(get(Hds.pb_prev,'Enable'), 'on')
    %         Hds.video_data.current_index = Hds.video_data.current_index - 1;
    %
    %         %         next_exemplar = cur_corpus.exemplars ...
    %         %             (Hds.video_data.current_index - 1);
    %         %         current_index = current_index - 1;
    %     else
    %         next_exemplar = [];
    %     end
    %
    %     Hds.video_data.frames = removeFromCorpus(cur_corpus,cur_exemplar);
    %     Hds.video_data.current_index = current_index;
    %     Hds.video_data.nframes = Hds.video_data.nframes - 1;
    %
    %
    %     Hds.video_data.unsaved = true;
    %     % func call to display, i.e., plot
    %     if ~isempty(next_exemplar)
    %         display_frame(Hds);
    %     end
    %
    %
end

guidata(hObject, Hds);              % Update Hds structure
set_buttons(Hds);
set_display (Hds)
% set_gui_components(Hds);            % set GUI components [state] and labels



% --- Executes on when icon from toolbar triggers an event.
% Determines the icon [culprit] that triggered event by use 'Tag' property.
% Then Hds accordingly.
function mnu_Callback(hObject, ~, Hds)   %#ok<DEFNU>
% hObject    handle to action icon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)

var_name = get (hObject,'Tag');
if strcmp('icon_',var_name(1:5))
    culprit = 'load';
else
    culprit = lower( get(hObject,'Label') );
end

switch culprit
    
    case 'new'
        %         Start a new corpus (TBD, likely aim to allow corpus merging)
        fprintf (1, '\nComing Soon!!\n');
        
    case 'load'
        % open M file; preview set to index 1
        cur_exemplar = load_video(hObject, Hds);
        
        if isempty (cur_exemplar), return;  end
        display_frame (cur_exemplar,Hds);
        %         start_session();
    case 'save'
        Hds = save_corpus( hObject, Hds );
        set_buttons (Hds);
        
    case 'save as...'
        fname = save_corpus_as(Hds.video_data.corpus);
        if ~isempty (fname)
            Hds.video_data.fpath = fname;
            Hds.video_data.unsaved = false;
            guidata(hObject, Hds);              % Update Hds structure
            set_buttons(Hds);
        end
        
    case 'save copy as...'
        save_corpus_as(Hds.video_data.corpus);
        
    case 'exit'
        if Hds.video_data.unsaved
            do_save = Quit_Program();
            if do_save, save_corpus( hObject, Hds );    end
            
        end
        
        delete(gcf);
        
    case 'about'
        figAbout();
end




% --- Executes on button press in pb_save.
function save_Callback(hObject, ~, Hds) %#ok<DEFNU>
% hObject    handle to pb_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
Hds = save_corpus( hObject, Hds );
set_buttons (Hds);

% --------------------------------------------------------------------
function mnu_help_child_Callback(~,~,~) %#ok<DEFNU>
% hObject    handle to mnu_help_child (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
open ('README.txt');


% --- Executes on button press in pb_new.
function pb_new_Callback(hObject, ~, Hds) %#ok<DEFNU>
% hObject    handle to pb_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)
% Add exemplars from shotfile or load corpus from MAT
dirname = uigetdir('~','Select Data Directory');
% in=[pname temp];
% guidata(hObject, Hds);              % Update Hds structure
new_video( hObject, Hds, dirname );


%
% % --- Executes on button press in cb_test_only.
% function cb_test_only_Callback(hObject, eventdata, Hds)
% % hObject    handle to cb_test_only (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % Hds    structure with Hds and user data (see GUIDATA)
%
% if get(Hds.cb_shock_only, 'Value')
%     on_off = 0;
% %     set(Hds.cb_test_only, 'Value', 1);
% else
%     on_off = 1;
% %     set(Hds.cb_test_only, 'Value', 0);
% end
% % Hint: get(hObject,'Value') returns toggle state of cb_test_only
% video_data = Hds.video_data;
%
%
%
% % sizer = zeros(1,numel(video_data.corpus.exemplars));
% ind= ismember([video_data.corpus.exemplars.type],'CSHOCK');
%
% sizer = find(ind == 1);
% for n = 1:length(sizer)
%     video_data.corpus.exemplars(sizer(n)).flag = 0;
% end
%
% ind=find(ismember([video_data.corpus.exemplars.flag],1));
% if isempty(ind), return;    end
%
% video_data.unsaved = false;
% video_data.num_exemp_flags = numel(ind);
%
% video_data.current_index = min(ind);
%
% Hds.video_data = video_data;
% guidata(hObject, Hds);              % Update Hds structure
% set_buttons(Hds)
%    set_display(Hds);
% next_exemplar = Hds.video_data.corpus.exemplars(Hds.video_data.current_index);
% display_frame(next_exemplar,Hds); % func call to display, i.e., plot
%



% --- Executes on button press in cb_select_all.
% function cb_select_all_Callback(hObject, ~, Hds) %#ok<DEFNU>
% % hObject    handle to cb_select_all (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%
% % Hint: get(hObject,'Value') returns toggle state of cb_select_all
% % Hint: get(hObject,'Value') returns toggle state of cb_muzzle_only
% video_data = Hds.video_data;
% ind= find(ismember([video_data.corpus.exemplars.flag],0));
% for k = 1:length(ind)
%     video_data.corpus.exemplars(ind(k)).flag = 1;
% end
%
% Hds.video_data = video_data;
% guidata(hObject, Hds);              % Update Hds structure
% set_buttons(Hds);
% set_display(Hds);

% --- Executes on selection change in popupmenu26.
function popupmenu26_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu26 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu26


% --- Executes during object creation, after setting all properties.
function popupmenu26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_missed.
function pb_missed_Callback(hObject, eventdata, Hds)
% hObject    handle to pb_missed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Hds.video_data.missed = Hds.video_data.missed + 1;
guidata(hObject, Hds);              % Update Hds structure
set_buttons(Hds);
set_display (Hds)  ;

% --- Executes on button press in pb_fp.
function pb_fp_Callback(hObject, eventdata, Hds)
% hObject    handle to pb_fp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% Hds    structure with Hds and user data (see GUIDATA)

% [temp,pname] = uigetfile('*.*','Enter data file','~');
% in=[pname temp]; % defaultDir = pname;

guidata(hObject, Hds);              % Update Hds structure
set_buttons(Hds);
set_display (Hds)  ;

% --- Executes on button press in pb_fn.
function pb_fn_Callback(hObject, eventdata, Hds)
% hObject    handle to pb_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, Hds);              % Update Hds structure
set_buttons(Hds);
set_display (Hds)  ;


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in lb_actions.
function lb_actions_Callback(hObject, eventdata, handles)
% hObject    handle to lb_actions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb_actions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_actions


% --- Executes during object creation, after setting all properties.
function lb_actions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_actions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pb_next.
function pb_next_Callback(hObject, eventdata, handles)
% hObject    handle to pb_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function icon_load_ClickedCallback(hObject, eventdata, Hds)
% hObject    handle to icon_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Hds = load_video(hObject, Hds);
set_display (Hds);
set_buttons (Hds);

% if isempty (cur_frame), return;  end
% axis(Hds.axis_preview);
display_frame (Hds);


% --- Executes on button press in b_start.
function b_start_Callback(hObject, eventdata, handles)
% hObject    handle to b_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
action_types = get(handles.lb_actions,'String');     % get selected item
ids_selected = get(handles.lb_actions,'Value');

handles.video_data.Labels = [handles.video_data.Labels;...
    Label(action_types{ids_selected}, handles.video_data.current_index)];

handles.video_data.color_palette(:,handles.video_data.current_index,:) = repmat(handles.video_data.colors{ids_selected},[150, 1]);


axes(handles.axis_color);
imshow(handles.video_data.color_palette)
axes(handles.axis_preview)
guidata(hObject, handles);              % Update Hds structure



% --- Executes on button press in b_end.
function b_end_Callback(hObject, eventdata, handles)
% hObject    handle to b_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
action_types = get(handles.lb_actions,'String');     % get selected item
ids_selected = get(handles.lb_actions,'Value');

handles.video_data.Labels(end) = handles.video_data.Labels(end).set_end(handles.video_data.current_index);
cLabel = handles.video_data.Labels(end);

for y = cLabel.start_frame:cLabel.end_frame
    handles.video_data.color_palette(:,y,:) = repmat(handles.video_data.colors{ids_selected},[150, 1]);
end
% handles.video_data.color_palette(:,,:)...
%     = handles.video_data.colors{ids_selected};
axes(handles.axis_color);
imshow(handles.video_data.color_palette)
axes(handles.axis_preview)
guidata(hObject, handles);              % Update Hds structure


% --- Executes on button press in b_remove.
function b_remove_Callback(hObject, eventdata, handles)
% hObject    handle to b_remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in tb_play.
function tb_play_Callback(hObject, eventdata, handles)
% hObject    handle to tb_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% gui_toggle;
% How to stop a while loop with a toggle button.
% S.f = figure('name','togglegui',...
%     'menubar','none',...
%     'numbert','off',...
%     'pos',[100 100 300 150]);
% S.t = uicontrol('Style','toggle',...
%     'Units','pix',...
%     'Position',[10 10 280 130],...
%     'CallBack',@callb,...
%     'String','No Loop');
% movegui('center')

% end
%         function [] = callb(varargin)
%             set(S.t,'string','Looping!')
%             drawnow
%             while 1
%                 sort(rand(1010101,1)); % Put your code here.
%                 drawnow
%                 if ~get(S.t,'value')
%                     set(S.t,'string','No Loop')
%                     break
%                 end
%             end
%         end
%
%     end
% Hint: get(hObject,'Value') returns toggle state of tb_play
