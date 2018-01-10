# VideoLabeler
**Version 0.1**

Created:    01/03/2018

#### OVERVIEW: 
Tool provides an easy-to-use interface that facilitates labeling of actions in videos. 

ActionViewer allows the labeler to scroll through video to mark the start and end frame of each action. 

Unmarked frames are considered to not contain an action (i.e., in between actions).
    
    
In summary, this labeling tools provides the following functionality:
    - *database* package
    - *fiw* package

#### CONTENTS:
    Updates.txt             -- Track progress/develop of application
    README.md		        -- (This)
    al_setup.m	            -- script to setup workspace
    
    main/
        ActionViewer.m      -- Main program
        ActionViewer.fig    -- Main figure

    view/
        figAbout.m          -- Action function 'About'
        figAbout.fig        -- 'About' figure
       
    include/        Classes
        @Label			    -- Class for annotations
        @Video			    -- Class for action clips
    
    demo/           TO DO
    docs/           Image icons for GUI and related references
    utils/

#### Todos
- [ ] Enlarge interface
- [ ] Add scroll bar to scroll through video
- [ ] Add play button to play through video (i.e., add various speeds that are set by clicking 'Play' 2x, 3x...)
- [ ] Add play button to play through video (i.e., add various speeds that are set by clicking 'Play' 2x, 3x...)
- [ ] Create demo script


## Authors
* **Joseph Robinson** - [Github](https://github.com/visionjo) - [web](http://www.jrobsvision.com)
#
[![N|Solid](https://web.northeastern.edu/smilelab/wp-content/uploads/2015/01/small_logo_2.png)](https://web.northeastern.edu/smilelab/wp-content/uploads/2015/01/small_logo_2.png)