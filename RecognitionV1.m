function [rec,dist] = RecognitionV1(ProjectedTestImages,ProjectedImages,TDS,DS)
%%%%%%%%%%%%%%%%%%%%%%%% Calculating Euclidean distances
% Euclidean distances between the projected test image and the projection
% of all centered training images are calculated. Test image is
% supposed to have minimum distance with its corresponding image in the
% training database.
rec=[];
dist = [];
tic
%% finding Euclidean distance of Projected test image with all Projected trained images
%% subject class separation 

for j=1:TDS
    Euc_dist = [];
    for i = 1 : DS
        temp = ( norm( ProjectedTestImages(:,j) - ProjectedImages(:,i) ) )^2;
        Euc_dist = [Euc_dist temp];
    end
    %finding the Recognized image number ' image whose euclidean distance is minimum'
    [Euc_dist_min , Recognized_index] = min(Euc_dist);
    rec=[rec Recognized_index];
    dist = [dist Euc_dist_min];
end

end