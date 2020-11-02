clc;
clear;
close all;

f = rgb2gray(imread('lena.png'));
[h,w]=size(f);
subplot(2,3,1),imshow(f);
title('原始图像')
PSF = fspecial('motion',21,11);%点扩散函数，运动模糊
blurred = imfilter(f,PSF,'conv','circular');
subplot(2,3,2),imshow(blurred);
title('运动模糊的图像');
noise_mean=0;
noise_var = 0.0001;
g = imnoise(blurred, 'gaussian',noise_mean, noise_var);
subplot(2,3,3),imshow(g);
title('加了噪声的模糊图像');
H = psf2otf(PSF,[h,w]);
p = [0 -1 0;-1 4 -1;0 -1 0];%拉普拉斯模板
P = psf2otf(p,[h,w]);
G = fft2(g);
gamma=0.01;
numerator = conj(H)
denominator = H.^2+gamma*(P.^2);
deblur_f = ifft2(numerator.*G./denominator);
subplot(2,3,4);
imshow(deblur_f,[]);
title('约束最小二乘复原的图像')
%迭代计算最优的gamma
while (norm(double(g-blurred),2)*norm(double(g-blurred),2)-h*w*(noise_mean.^2+noise_var.^2))>0.00001
    
    gamma=gamma-0.001
end
numerator = conj(H)
denominator = H.^2+gamma*(P.^2);
deblur_f = ifft2(numerator.*G./denominator);
subplot(2,3,5);
imshow(deblur_f,[]);
title('约束最小二乘复原最佳gamma的图像')