clear all
%% check the relation of Hlp + Hhp = 1


I = imread('lena.png');
f = rgb2gray(I);
figure(1)
imshow(f)
% get size
[m n] = size(f);
% DFT transformation and shift the original point in the center
F = fft2(f);
F_shift = fftshift(F)
Fc = log(1+abs(F_shift));
phase = log(angle(F_shift)*180/pi);

figure(2)

subplot(1,2,1),imshow(abs(Fc),[]),title('amplitude')
subplot(1,2,2),imshow(phase,[]),title('phase')




%% ideal low pass filter

Hlp = lpfilter('ideal',220,220,50,10);

H = freqz2(Hlp);
figure(3)
mesh(abs(Hlp))


G = F.*Hlp;
g = real(ifft2(G));
figure(4)
imshow(g,[])