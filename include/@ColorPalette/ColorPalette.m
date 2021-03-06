classdef ColorPalette
    %@COLORPALETTE controls the color display depicting labeling process.
    % The matrix (i.e., ColorPalette.panel) is an image that is displayed
    % below the video and is colored according to class labels assigned to
    % sequence of frames (i.e., chunk of video)
    
    properties
        colors;
        panel;
        factor; % how many columns per frames (to keep same size)
        H;
        W;
    end
    
    methods (Access = public)
        
        function this = ColorPalette(nframe)
            %@COLORPALETTE Construct an instance of this class
            this.panel = ColorPalette.clear();
            this.colors = ColorPalette.get_colors();
            this.H = 150;
            this.W = 10000;
            if exist('nframe')
                this.factor = round(this.W/ nframe);
            else
                this.factor = this.W;
            end
        end
        
        function this = refresh(this)
            this.panel = ColorPalette.clear();
        end
        
        
        function this = add(this, ids, cLabel)
            fr1 = round(cLabel.start_frame*this.factor);
            fr2 = round(cLabel.end_frame*this.factor);
            for y = fr1:fr2
                try
                    this.panel(:,y,:) = repmat(this.colors{ids},[this.H, 1]);
                catch
                    % catch if out of bounce
                end
            end
        end
    end
    
    methods(Static)
        function pan = clear()
            pan = ones(150, 10000, 3)*250;
        end
        
        
        function colors = get_colors()
            colors = cell(1, 10);
            colors{2} = [1 0 1];
            colors{3} = [0 1 1];
            colors{4} = [1 0 0];
            colors{5} = [0 1 0];
            colors{6} = [0 0 1];
            colors{7} = [1 1 1];
            colors{1} = [1 1 0];
            colors{8} = [0.5 0.5 0.5];
            colors{9} = [0.7 .2 0.2];
            colors{10} = [0.1 .7 .5];
        end
        
    end
end

