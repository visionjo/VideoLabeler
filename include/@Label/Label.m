classdef Label
    %% Container class video object to label via action_labeler
    %
    %   AUTHOR    : J. Robinson
    %   DATE      : 3-January-2018
    %   Revision  : 1.0
    %   DEVELOPED : MATLAB R2017a
    %   FILENAME  : video.m
    %
    %   See @Video
    
    properties
        action_type;
        start_frame;
        end_frame;
        nframes;
    end
    
    methods (Access = public)
        function this = Label(action_type, start_frame, end_frame)
            % Constructor, end_frame is optional
            
            this.action_type = action_type;
            if nargin < 4
                this.start_frame = start_frame;
                
                this.end_frame =  this.start_frame + 1;
                this.nframes = 1;
                
                return;
            end
            this.start_frame = start_frame;
            this.end_frame = end_frame;
            this.nframes = end_frame - start_frame;
        end
        
        function this = set_end(this, end_frame)
            this.end_frame = end_frame;
            this.nframes = end_frame - this.start_frame;

        end
    end
end