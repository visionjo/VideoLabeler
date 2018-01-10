function DIR_ROOT =  al_setup()
%%
%     Sets up workspace for action labeling tool.
%           - adds directories to path.
%
%     AUTHOR    : Joseph Robinson
%     DATE      : January-2018
%     Revision  : 1.0
%     DEVELOPED : 2017b
%     FILENAME  : al_setup.m
%
dirnames = {'demo','views', 'include'};

fpath = which ('al_setup');

if isempty(fpath)
    fprintf(2,'ERROR: Could not determine ROOT_DIR of project');
    return;
end

if ispc,    tmp = strfind(fpath,'\');   else    tmp = strfind(fpath,'/');
end

warning('OFF', 'MATLAB:dispatcher:nameConflict') 
cur_root = pwd;
DIR_ROOT = fpath(1:tmp(end));   

addpath(DIR_ROOT);

cd (DIR_ROOT);

for indx = 1:length(dirnames)
    addpath(genpath(strcat(DIR_ROOT,dirnames{indx})));
end

cd (cur_root);

fprintf(1,'\nAction_Viewer: Done configuring workspace!\n');
if nargout == 0,    DIR_ROOT = '';  end


end