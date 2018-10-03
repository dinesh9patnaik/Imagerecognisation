clear all
close all
clc;
% dirr = dir('D:\project\PCA_gowda_v1\PCA_gowda_v1\');
File_path = 'D:\project\TestImageset\test2\';
  Files = dir(File_path);
    for i = 1:size(Files,1)

        if not(strcmp(Files(i).name,'.')|strcmp(Files(i).name,'..')|strcmp(Files(i).name,'Thumbs.db'))
%             DS = DS + 1; % Number of all images in the training database
            img = imread(strcat(File_path,'\',Files(i).name));
            [irow icol dim] = size(img);
            if dim>1
                img=rgb2gray(img);
            end
            B = imresize(img, [112 92]);
           [path,name,ext,ver]= fileparts(strcat(File_path,'\',Files(i).name));
           name = [name '.' 'pgm'];
            name1 = [name '.' 'jpg'];
            imwrite(B',strcat(File_path,name),'pgm')
             imwrite(B',strcat(File_path,name1),'jpg')
        end
    end