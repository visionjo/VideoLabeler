function  set_buttons (handles)      
%SET_BUTTON_STATES Sets GUI component states accordingly
%   Determines the state of GUI buttons conditionally: e.g. if current exemplar
%   is the last in the corpus the 'Next' button will be disabled; else, the
%   state will be enabled... similiar logic used on a button-by-button basis.

% cur_index = handles.video_data.cur_index;
% num_frames = numel(handles.video_data.images);


if ~handles.video_data.display
    set(handles.pb_next, 'Enable','off');
    set(handles.pb_prev, 'Enable','off');
    set(handles.pb_first, 'Enable','off');
    set(handles.pb_last, 'Enable','off');    
    set(handles.slidebar, 'Enable','off');    
else
    set(handles.slidebar, 'Enable','on');     
end



if handles.video_data.current_index < handles.video_data.nframes 
% enable 'Next' button    
    set(handles.pb_next,'Enable','on'); 
    set(handles.pb_last, 'Enable','on');
else
    set(handles.pb_next,'Enable','off');
    set(handles.pb_last, 'Enable','off');
end

if handles.video_data.current_index > 1 
% enable 'Next' button    
    set(handles.pb_prev,'Enable','on'); 
    set(handles.pb_first, 'Enable','on');
    
else
    set(handles.pb_prev,'Enable','off');
    set(handles.pb_first, 'Enable','off');
end

if handles.video_data.nframes > 0
    set(handles.lb_actions, 'Enable','on');
else    
    set(handles.lb_actions,'Enable','off');  
end          

if handles.video_data.unsaved
    set(handles.mnu_save,'Enable','on'); 
    set(handles.icon_save,'Enable','on');     
else  
    set(handles.mnu_save,'Enable','off');
    set(handles.icon_save,'Enable','off');    
end
