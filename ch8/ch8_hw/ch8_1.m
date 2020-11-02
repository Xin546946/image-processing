clc;
clear;
close all;

img_rgb= imread("lena.png");
figure("Name","rgb image"), imshow(img_rgb);
imwrite(img_rgb,"img_rgb.png");
% rgb to ycbcr
img_ycbcr = rgb2ycbcr(img_rgb);
figure("Name","ycbcr2gray image"), imshow(img_ycbcr(:,:,1));
imwrite(img_ycbcr,"img_ycbcr2gray.png");
% rgb to gray
img_gray = rgb2gray(img_rgb);
figure("Name","gray image"), imshow(img_gray);
imwrite(img_gray,"img_gray.png");
%% add motion blur
f = img_gray;
PSF = fspecial('motion',27,45);
gb = imfilter(f,PSF,'circular');

noise = imnoise(zeros(size(f)), 'gaussian',0,4);
g = gb + uint8(noise);
figure("Name","original image."),imshow(f,[]);
figure("Name","motion blured image."), imshow(gb), imwrite(gb,"motion_blured_image.png");
figure("Name","noise"), imshow(noise,[]), imwrite(noise,"noise.png")
figure("Name","noised image (motion blur + gaussian)"), imshow(g), imwrite(g, "noised_image(motion blured and gaussian).png")

%% using wiener filter to denoise
figure("Name","noised image (motion blur + gaussian)"), imshow(g, [])

Sn = abs(fft2(noise)).^2;
nA = sum(Sn(:))/prod(size(noise));
Sf = abs(fft2(f)).^2;
fA = sum(Sf(:))/prod(size(f));
R = nA / fA;
%% tune the parameter of R
for R = 1:9
    NSPR = power(10,-R);
    fr2 = deconvwnr(g,PSF,NSPR);
    subplot(3,3,R), imshow(fr2,[]);
end
%% 10e-3 - 10e-4 has best value
for R = 1:9
    NSPR = power(10,-4)*R
    fr2 = deconvwnr(g,PSF,NSPR);
    subplot(3,3,R), imshow(fr2,[]);
end

%% another wiener filter 
fr = deconvwnr(g,PSF);
figure("Name","wiener filter using only two parameters"), imshow(fr,[]),imwrite(fr,"two parameter.png");

NCORR = fftshift(real(ifft2(Sn)));
ICORR = fftshift(real(ifft2(Sf)));
fr3 = deconvwnr(g,PSF,NCORR,ICORR);
figure("Name","Wiener filter using four parameters"), imshow(fr3,[]), imwrite(fr3,"four parameter.png");

