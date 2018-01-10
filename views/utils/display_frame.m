function display_frame(Hds)
%       input: 
%           in_corpus = exemplar to be reviewed
%     
%       output: 
%           out_corpus = exemplar, 2 flags indicating whether approved and next
% 
%      April 2015 J Robinson
% view_opts = {'LineWidth',3,'LineStyle','-','EdgeColor','r'};

fprintf (1, '\nInfo for Exemplar under review:');
% print_exemplar (exemplar);
axis(Hds.axis_preview);
imshow(Hds.video_data.frames{Hds.video_data.current_index},...
    'Parent',Hds.axis_preview)

% 
% hold on
% for i = 1:size(exemplar.BB,1)
%     rectangle('Position',exemplar.BB(i,:), view_opts{:},'Parent',Hds.axis_preview);
% end
% title('Face Detection');
% hold off;

end

    
 