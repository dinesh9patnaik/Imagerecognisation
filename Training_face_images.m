%********************************** FACE RECOGNITION USING PCA ***********************************************
%STUDENT NAMES:
%USN NUMBER:
%
%Ref:
%**************************************************************************************************************
clear;clc;
%**************************************************************************
%***************
ns = 40; % Number of subjects considered for database training
DatabasePath = uigetdir; % selecting image data path for training
tic
[Data,DS]=CDT_new_v2(ns,DatabasePath); % gives the vectored matrix output of all images in database 
toc

dim=9; % Number of desired dimensions to reduce the data set (1<dim<P) i.e 1<9<40 in this example

Mn=mean(Data,2); % 2)compute the mean of the data set = 10304x1

%% Find the mean centered data 'A'
A=Data-repmat(Mn,1,size(Data,2)); % 3) Mean centered data 'A' of Size 10304x400 (NxP)

%% Find Covariance Matrix's
L=cov(A); % 4) Covariance Matrix's of size 400x400 if data size 40 subjects with 10 faces each 
[U D]=eig(L);% 5) Eigen Vectors with size 400x400

%% 6) Sorting Eigenvectors to select the most dominent eigenvectors
L_eig_vec = [];
eigValue=diag(D); % 400x1 matrix
[eigValue,IX]=sort(eigValue,'descend'); % 400x1 matrix sorted value
 L_eig_vec=U(:,IX);


%% dimensionality reduction
Eigenfaces = A * L_eig_vec(:,1:dim); % 7) eigen faces of size 10304x9 (Nxdim)

[ProjectedImages] = Image_Projection(Data,Mn,Eigenfaces); % 8) Projecting given image on given eigenvectors using mean n eigen vectors 
%%%%%%%%%%%%%%%%%% Neural network training of projected images of PCA algorithm%%%%%%%%%                                                          % of size i.e dim x P, in our example 9x400 = PCA ouptput
[ProjectedImages_NN] = Neuraltraining(ProjectedImages);
save('training.mat','ProjectedImages','Mn','Eigenfaces','DatabasePath','DS','ProjectedImages_NN');

