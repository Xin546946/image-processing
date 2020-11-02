clc;
clear
close all

I = imread('lena.png');
f = rgb2gray(I);


% get size
[m n] = size(f);
% DFT transformation and shift the original point in the center
F = fft2(f);
F_shift = fftshift(F);
margin = log(1+abs(F_shift));
phase = log(angle(F_shift)*180/pi);
recons = ifft2(abs(F).*exp(j*(angle(F))));

figure(1)
subplot(2,2,1),imshow(f),title('original image')
subplot(2,2,2),imshow(abs(margin),[]),title('amplitude')
subplot(2,2,3),imshow(abs(phase),[]),title('phase')
subplot(2,2,4),imshow(abs(recons),[]),title('reconstructed image')

% reconstruct the image using margin or phase
margin_recon = real(ifft2(abs(F)));
phase_recon =  real(ifft2(exp(j*angle(F))));

figure(2)
subplot(1,2,1),imshow(margin_recon,[]),title('reconstruction using amplitude')
subplot(1,2,2),imshow(phase_recon,[]),title('reconstruction using phase')
