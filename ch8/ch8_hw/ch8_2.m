close all;
clear all;
clc;
I = im2double(imread('lena.png'));
I = rgb2gray(I);
[hei,wid,~] = size(I);
subplot(2,2,1),imshow(I);
title('original image');
% motion blur.
LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(I, PSF, 'conv', 'circular');
subplot(2,2,2), imshow(blurred); title('blured image');
H = psf2otf(PSF,[hei,wid]);
% add gaussian noise
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian',noise_mean, noise_var);
subplot(2,2,3), imshow(blurred_noisy)
title('noisy image')
p = [0 -1 0;-1 4 -1;0 -1 0];%laplace operator
P = psf2otf(p,[hei,wid]);
gamma = 1;
If = fft2(blurred_noisy);
numerator = conj(H);%conj
denominator = H.^2 + gamma*(P.^2);
deblurred2 = ifft2( numerator.*If./ denominator );
subplot(2,2,4), imshow(deblurred2)
noise_square = hei* wid*((noise_mean+0.001)*(noise_mean+0.001)+noise_var*noise_var);
%noise_square = hei* wid*(noise_mean*noise_mean+noise_var*noise_var);
r = blurred_noisy - imfilter(deblurred2,PSF , 'conv','circular');
r_square = norm(r,2) * norm(r,2);
r_square - noise_square
title('reconstructed image after using lsq')
%% 
noise_square = hei* wid*((noise_mean)*(noise_mean)+(noise_var+0.001)*(noise_var+0.001));

%noise_square= hei* wid*((noise_mean+0.001)*(noise_mean+0.001)+(noise_var)*(noise_var));

%noise_square = hei* wid*((noise_mean)*(noise_mean)+(noise_var)*(noise_var));
gamma = 1;

a = 0.08;
iteration = 1;
while(iteration~=1000)
    iteration = iteration +1;
    
    If = fft2(blurred_noisy);
    numerator = conj(H);%conj
    denominator = H.^2 + gamma*(P.^2);
    deblurred2 = ifft2( numerator.*If./ denominator );
    r = blurred_noisy - imfilter(deblurred2,PSF , 'conv','circular');
    r_square = norm(r,2)*norm(r,2);   
    if(r_square > noise_square + a)
        gamma = gamma - 0.001;
    elseif (r_square < noise_square -a)
        gamma = gamma +0.001;
    else
        break
    end
end

figure("Name","gamma after optimization"), imshow(deblurred2)


%% choose different var and means
% choose different var
for num = 1:9
    noise_mean = 0;
    noise_var = power(10,-num);
    gamma = 0.01;
    blurred_noisy = imnoise(blurred, 'gaussian',noise_mean, noise_var);
    p = [0 -1 0;-1 4 -1;0 -1 0];%laplace operator
    P = psf2otf(p,[hei,wid]);
   
    If = fft2(blurred_noisy);
    numerator = conj(H);%conj
    denominator = H.^2 + gamma*(P.^2);
    deblurred2 = ifft2( numerator.*If./ denominator );
   
    a = norm(blurred_noisy - H * deblurred2, 2) - hei*wid*(noise_mean*noise_mean + noise_var*noise_var)
    titlename = sprintf('var = %d',noise_var);
    subplot(3,3,num), imshow(deblurred2),title(titlename)
    
end

%% choose different means
num = 1
for noise_mean = -4:4
    noise_mean = (noise_mean)*0.1;
    noise_var = 0.0001;
    gamma = 0.01;
    blurred_noisy = imnoise(blurred, 'gaussian',noise_mean, noise_var);
    p = [0 -1 0;-1 4 -1;0 -1 0];%laplace operator
    P = psf2otf(p,[hei,wid]);
    
    If = fft2(blurred_noisy);
    numerator = conj(H);%conj
    denominator = H.^2 + gamma*(P.^2);
    deblurred2 = ifft2( numerator.*If./ denominator );
   
    a = norm(blurred_noisy - H * deblurred2, 2)*norm(blurred_noisy - H * deblurred2, 2) - hei*wid*(noise_mean*noise_mean + noise_var*noise_var)
    titlename = sprintf('mean = %d',noise_mean);
    subplot(3,3,num), imshow(deblurred2),title(titlename)
    num = num +1
end

%% add some disturb



