clear;
clc;

addpath(genpath(pwd));
datasetdir = 'dataset'; % dataset

% [1] load dataset
para.type   = 'cacti'; % type of dataset, cassi or cacti
para.name   = 'kobe'; % name of dataset
para.number = 32; % number of frames in the dataset

datapath = sprintf('%s/%s%d_%s.mat',datasetdir,para.name,...
    para.number,para.type);

load(datapath); % mask, meas, orig (and para)

% for i = 1:size(orig,3)
%     imagesc(orig(:,:,i))
%     colormap(gray)
%     pause(0.5)
% end

% 先只看前八帧
rho = 0;
alpha = 1;
maxItr = 1000;
normalize = max(orig(:));
orig = orig/normalize;
[width, height, frames] = size(orig);
maskFrames = size(mask,3);
sampled = zeros(width*height,1);

for i=1:maskFrames
    mask_i = mask(:,:,i);
    mask_i = diag(sparse(mask_i(:)));
    orig_i = orig(:,:,i);
    sampled = sampled + mask_i * orig_i(:);
end
% sampled也即是meas(:,:,1)(:)

orig = orig*normalize;

% imagesc(meas(:,:,1))

sampled = reshape(sampled,[256,256]);
imagesc(sampled(:,:,1))

% [X,~]   =    tensor_cpl_admm( mask , sampled , rho , alpha , ...
%                      [width, height] , maskFrames, maxItr , 0 );
% X                      =        reshape(X,[width, height, maskFrames])         ; 
%             
% X_dif                  =        orig-X                           ; %恢复得到的张量和原始数据之差，对恢复的效果做评价
% RSE                    =        norm(X_dif(:))/norm(T(:))     ;
% 
% figure;
% for i = 1:maskFrames
%     subplot(221);imagesc(orig(:,:,i));axis off;%original
%     colormap(gray);title('Original Video');
%     subplot(222);imagesc(X(:,:,i)) ;axis off;%recovered
%     colormap(gray);title('Recovered Video');
%     pause(0.5);
% end
