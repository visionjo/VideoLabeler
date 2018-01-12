al_setup();
if ~exist('video_data','var')
    video_data = load('data/sample_video.mat');
end
ActionViewer({'Metadata',video_data.meta_record,...
    'Times',video_data.time_record,...
    'Images',video_data.image_record,...
    'Depth',video_data.deep_record});