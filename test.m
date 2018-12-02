% % decompose: construct a shearlet sytem and call the SLsheardec method
% % a 2D example
% tic
% sizeX = 500;
% sizeY = 600;
% useGPU = 0;
% 
% data2D = randn(sizeX,sizeY);
% system = SLgetShearletSystem2D(useGPU,sizeX,sizeY,4);%这个4会使用默认的shearLevel = ceil((1:4)/2)，即[1,1,2,2]
% shearletCoefficients2D = SLsheardec2D(data2D,system);
% toc
% 
% % reconstruction
% reconstruction2D = SLshearrec2D(shearletCoefficients2D,system);
% RSE = norm(data2D-reconstruction2D)/norm(data2D);
% sprintf("RSE is %f",RSE)
% 
% 
% % serial decompose: only the coefficients associated to the translates of
% % one single shearlet are available at one point in time
% % a 3D example
% tic
% sizeX = 192;
% sizeY = 192;
% sizeZ = 192;
% data3D = randn(sizeX,sizeY,sizeZ);
% [Xfreq,Xrec,preparedFilters,dualFrameWeightsCurr,shearletIdxs] = SLprepareSerial3D(useGPU,data3D,2);
% for j = 1:size(shearletIdxs,1)
%     shearletIdx = shearletIdxs(j,:);
%     [coefficients3D,shearlet,dualFrameWeightsCurr,RMS] = ...
%         SLsheardecSerial3D(Xfreq,shearletIdx,preparedFilters,dualFrameWeightsCurr);
%     %reconstruction
%     Xrec = SLshearrecSerial3D(coefficients3D,shearlet,Xrec);
% end
% toc
% reconstruction = SLfinishSerial3D(Xrec,dualFrameWeightsCurr);
% RSE = norm(data2D-reconstruction2D)/norm(data2D);
% sprintf("RSE is %f",RSE)

% image denosing

sigma = 30;
scales = 4;
thresholdingFactors = [0 3 3 4 4];
load("kobe32_cacti.mat")
X = orig(:,:,1);
Xnoise = X +sigma*randn(size(X));
shearletSystem = SLgetShearletSystem2D(0,size(X,1),size(X,2),scales);
coeffs = SLsheardec2D(Xnoise,shearletSystem);
for j = 1:shearletSystem.nShearlets
    shearletIdx = shearletSystem.shearletIdxs(j,:);
    coeffs(:,:,j) = coeffs(:,:,j).*(abs(coeffs(:,:,j))>...
        thresholdingFactors(shearletIdx(2)+1)*shearletSystem.RMS(j)*sigma);
end
Xrec = SLshearrec2D(coeffs,shearletSystem);
figure(1)
%imshow(X);
imshow(X,[]);
title("初始");
figure(2)
imshow(Xnoise,[]);
title("噪声");
figure(3)
imshow(Xrec,[]);
title("降噪");
PSNR = SLcomputePSNR(X,Xrec);
