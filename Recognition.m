function [recp,rectime] = Recognition(ProjectedTestImages,ProjectedImages,TDS,DS,TrNum,TsNum)
%%%%%%%%%%%%%%%%%%%%%%%% Calculating Euclidean distances 
% Euclidean distances between the projected test image and the projection
% of all centered training images are calculated. Test image is
% supposed to have minimum distance with its corresponding image in the
% training database.
rec=[];
tic
%% finding Euclidean distance of Projected test image with all Projected trained images
for j=1:TDS
Euc_dist = [];
for i = 1 : DS
    temp = ( norm( ProjectedTestImages(:,j) - ProjectedImages(:,i) ) )^2;
    Euc_dist = [Euc_dist temp];
end
%finding the Recognized image number ' image whose euclidean distance is minimum'
[Euc_dist_min , Recognized_index] = min(Euc_dist);
rec=[rec Recognized_index];
end
rectime=toc; % total time elapsed in finding the closest image
recd=ceil(rec/TrNum); % dividing recognition index with total trained images to get recognized class 'person'

%% generating the desired result
 outd=[];
 for i = 1:DS/TrNum
     for j=1:TsNum
         outd=[outd i];
     end
 end
%% finding recognition percentage
recp=1-(size(find((recd-outd)>0),2)/TDS);
display(sprintf('\nRecognition Percentage %1.2f%%  and recognition time is %1.3f sec for %d out of %d number of images',recp*100,rectime,TDS,DS));

end