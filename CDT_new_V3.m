function [T,DS]=CDT_new_v3(ns,DatabasePath);
T=[];
DS=0;

lambda  = 8;
theta   = 0;
psi     = [0 pi/2];
gamma   = 0.5;
bw      = 1;
N       = 8;

% DatabasePath = 'Test\s';
% gaborArray = gaborFilterBank(5,8,39,39);

for td = 1:ns
    File_path = DatabasePath;
    Files = dir(DatabasePath);
    for i = 1:size(Files,1)

        if not(strcmp(Files(i).name,'.')|strcmp(Files(i).name,'..')|strcmp(Files(i).name,'Thumbs.db'))
            DS = DS + 1; % Number of all images in the training database
            img = imread(strcat(File_path,'\',Files(i).name));
            [irow icol dim] = size(img);
            if dim>1
                img=rgb2gray(img);
            end
            %
            img_out = zeros(size(img,1), size(img,2), N);
            for n=1:N
                gb = gabor_fn1(bw,gamma,psi(1),lambda,theta)...
                    + 1i * gabor_fn1(bw,gamma,psi(2),lambda,theta);
                % gb is the n-th gabor filter
                img_out(:,:,n) = imfilter(img, gb, 'symmetric');
                % filter output to the n-th channel
                theta = theta + 2*pi/N;
                % next orientation
            end

            img_out_disp = sum(abs(img_out).^2, 3).^0.5;
            % default superposition method, L2-norm
            img_out_disp = img_out_disp./max(img_out_disp(:));

            temp = reshape(img_out_disp,irow*icol,1);   % Reshaping 2D images into 1D image vectors
            T = [T temp];
        end
    end
    T=double(T);
end
