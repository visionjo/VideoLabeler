classdef Video
    %% Container class video object to label via action_labeler
    %
    %   AUTHOR    : J. Robinson
    %   DATE      : 3-January-2018
    %   Revision  : 1.0
    %   DEVELOPED : MATLAB R2017a
    %   FILENAME  : video.m
    %
    %   See @Label
    
    properties
        do_skullaton;
        fpath;
        frames;
        nframes;
        tima_stamps;
        metadata;
        deep_record;
        current_index;     % index of current frame being displayed
        Labels;
        Palette;
        display;
        unsaved;           % true if labels modified but not saved
    end
    
    methods (Access = public)
        
        
        
        function this = Video(image_record, fpath, Labels)
            %             , time_record, metadata,deep_record, Labels)
            % Constructor
            
            this.frames = image_record;
            this.nframes = length(this.frames);
            this.tima_stamps = [];
            %             this.tima_stamps = time_record;
            this.metadata = [];
            %             this.metadata = metadata;
            %             this.deep_record = deep_record;
            this.deep_record = [];
            this.current_index = 1;
            %             if nargin == 3
            % if labels are not passed in to constructor as argument
            this.Labels = [];
            %             else
            %                 this.Labels = Labels;
            %             end
            if this.nframes > 0
                % only display if images exist
                this.display = true;
            else
                this.display = false;
            end
            
            this.fpath = fpath;
            this.unsaved = false;
            
            this.do_skullaton = false;
            
            
            %             this.color_palette = ones(150, 10000, 3)*250;
            %
            %             this.colors = cell(1, 10);
            %             this.colors{1} = [1 1 0];
            %             this.colors{2} = [1 0 1];
            %             this.colors{3} = [0 1 1];
            %             this.colors{4} = [1 0 0];
            %             this.colors{5} = [0 1 0];
            %             this.colors{6} = [0 0 1];
            %             this.colors{7} = [1 1 1];
            %             this.colors{8} = [0.5 0.5 0.5];
            %             this.colors{9} = [0.7 .2 0.2];
            %             this.colors{10} = [0.1 .7 .5];
        end
    end
end

