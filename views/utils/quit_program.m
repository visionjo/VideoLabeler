% quit_program()
%   This function confirms that the user wishes to exit the program.
%   
%   Input arguments:
%       MSG - the message string
%
%   Output arguments;
%       none

function do_save = quit_program()

% Verify that the user wishes to exist
sInput=questdlg('Are you sure you wish to exit before saving?','Verify exit',...
    'Exit','Save','Save');
if strcmpi(sInput,'exit')
    delete(gcf);
    do_save = 0;
else
    do_save = 1;
end