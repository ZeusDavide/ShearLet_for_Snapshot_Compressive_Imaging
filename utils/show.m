nor = max(x(:));

% 
% for i=1:8
%     figure(1)
%     colormap('gray')
%     subplot(2,4,i)
%     psnr_i = psnr(x(:,:,i)/nor,vgaptv(:,:,i));
%     ssim_i = ssim(x(:,:,i)/nor,vgaptv(:,:,i));
%     imagesc(vgaptv(:,:,i)); title({['PSNR : ' num2str(psnr_i, '%.4f')], ['SSIM : ' num2str(ssim_i, '%.4f')]});
% end
% 
% psnr_gaptv = psnr(x/nor,vgaptv);
% ssim_gaptv = ssim(x/nor,vgaptv);
% for i=1:8
%     figure(2)
%     colormap('gray')
%     imagesc(vgaptv(:,:,i)); title({['PSNR : ' num2str(psnr_gaptv, '%.4f')], ['SSIM : ' num2str(ssim_gaptv, '%.4f')]});
%     pause(0.5)
% end

% for i=1:8
%     figure(3)
%     colormap('gray')
%     subplot(2,4,i)
%     psnr_i = psnr(x(:,:,i)/nor,x_ista(:,:,i)/nor);
%     ssim_i = ssim(x(:,:,i)/nor,x_ista(:,:,i)/nor);
%     imagesc(x_ista(:,:,i)); title({['PSNR : ' num2str(psnr_i, '%.4f')], ['SSIM : ' num2str(ssim_i, '%.4f')]});
% end

psnr_ista = psnr(x/nor,x_ista/nor);
ssim_ista = ssim(x/nor,x_ista/nor);
for i=1:8
    figure(4)
    colormap('gray')
    imagesc(x_ista(:,:,i)); title({['PSNR : ' num2str(psnr_ista, '%.4f')], ['SSIM : ' num2str(ssim_ista, '%.4f')]});
    %pause(0.5)
end

denoised = TV_denoising(x_ista,1,5);
% for i=1:8
%     figure(5)
%     colormap('gray')
%     subplot(2,4,i)
%     psnr_di = psnr(x(:,:,i)/nor,denoised(:,:,i)/nor);
%     ssim_di = ssim(x(:,:,i)/nor,denoised(:,:,i)/nor);
%     imagesc(denoised(:,:,i)); title({['PSNR : ' num2str(psnr_di, '%.4f')], ['SSIM : ' num2str(ssim_di, '%.4f')]});
% end

psnr_d = psnr(x/nor,denoised/nor);
ssim_d = ssim(x/nor,denoised/nor);
for i=1:8
    figure(6)
    colormap('gray')
    imagesc(x_ista(:,:,i)); title({['PSNR : ' num2str(psnr_d, '%.4f')], ['SSIM : ' num2str(ssim_d, '%.4f')]});
    %pause(0.5)
end