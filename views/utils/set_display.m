function  set_display (handles)
%SET_DISPLAY_INFO Displays info on GUI for current exemplar under review.
%

% if nargin == 1
%     cframe = handles.video_data.images{cur_index};
% end
% cur_index = handles.video_data.current_index;

if handles.video_data.display
    
    %     set(handles.text_shotname,'String',exemplar.vid,'FontSize',8);
    %     set(handles.text_chann_id,'String',exemplar.pid(11:28),'FontSize',8);
    %     set(handles.text_type,'String',exemplar.type{:},'FontSize',8);
    
    %     if length(str_toa) > 10, str_toa =[str_toa(1:6) str_toa((end - 3):end)]; end
    %     set(handles.text_toa,'String',num2str(exemplar.index),'FontSize',8);
    
    
    %     if exemplar.flag == 1
    %         tmp_color = get(handles.pb_add,'BackgroundColor');
    %         set(handles.text_status,'String', 'Added', 'BackgroundColor', tmp_color);
    %     elseif exemplar.flag == -1
    %         tmp_color = get(handles.pb_remove,'BackgroundColor');
    %         set(handles.text_status,'String', 'Removed', 'BackgroundColor', tmp_color);
    %     else
    %         tmp_color = get(handles.pb_go,'BackgroundColor');
    %         set(handles.text_status,'String', '----', 'BackgroundColor', tmp_color);
    %     end
    
    % display index over total
    %     frame_count{1} = get(handles.t_cur_exemplar, 'String');
    t_cur_index = num2str(handles.video_data.current_index);
    t_count_total = num2str(handles.video_data.nframes);
    
    t_frame_count = [t_cur_index '/' t_count_total];
    set(handles.t_cur_exemplar, 'String',t_frame_count);
end