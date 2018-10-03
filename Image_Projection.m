function [ ProjectedImages ] = Image_Projection(T,M,Eigenfaces )
%IMAGE_PROJECTION Program for projecting given image on given eigenvectors
%   Using Mean and Eigenvectors finds the Projected Image
ProjectedImages=[];
for i=1:size(T,2)
Difference = T(:,i)-M; % Centered test image
ProjectedImages = [ProjectedImages Eigenfaces'*Difference]; % image feature vector
end
end

