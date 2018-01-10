function handles = load_video(hObject, handles, fpath)
%LOAD_CORPUS Load MAT file containing corpus to be reviewed.
%   Default - starts off on Exemplar #1
% Display 'Open' dialog for user to select file

if nargin < 3
    [filename, pathname] = uigetfile('*.mat','File Selector');
    fpath = fullfile(pathname, filename);
else
    %     pathname = optional_fpath{1};
    %     if numel(pathname) > 1
    %         filename = optional_fpath{2};
    %     else
    %         filename = '';
    %     end
end
% if  fpath == 0
%     disp('User selected Cancel')
%     cur_exemplar = '';
%     return;
% end
disp(['Loading video ' fpath])
%     fpath = [pathname filename];

mContents = open(fpath);        % open MAT file, set as corpus struct
%     corpus = mContents.corpus;
if nargin == 3
    handles.video_data.fpath = fpath;
else
    handles.corpus_data.fpath = '';
end
% assign, then display first exemplar from corpus queue
handles.video_data = Video(mContents.image_record, ...
    mContents.time_record, mContents.meta_record, mContents.deep_record);
guidata(hObject, handles);


%
% if numel(mContents.image_record) > 0
%
%
%
%     handles.video_data.images = mContents.image_record;
%     handles.video_data.time_stamps = mContents.time_record;
%
%     %         handles.video_data.corpus_orig = corpus;
%     %         % store corpus in GUI object
%     cur_exemplar = mContents.image_record{1};
%
%     handles.video_data.cur_index = 1;
%     handles.video_data.corpus_size = numel(mContents.image_record);
%
%     handles.video_data.frame_label = cell(1, handles.video_data.corpus_size);
%     handles.video_data.flag_corpus = 1;
%     guidata(hObject, handles);
% end
% update GUI (button states, data displays)

end

