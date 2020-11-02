img = imread('lena.png');
img = rgb2gray(img);

% 0.DFT

F = fft2(img);
S = abs(F);


F = fft2(img);
Fc=fftshift(F);
Zc_inv = ifft2(conj(Zc));
imshow(abs(Zc),[])
