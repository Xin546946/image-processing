% dip ch08

clc;
clear;
close all;

I=imread('lenna.png');
% I_ycbcr=rgb2ycbcr(I);
% Y=im2double(I_ycbcr(:,:,1));
I_ycbcr = zeros(size(I), 'like',I);
T = [ ...
    65.481 128.553 24.966;...
    -37.797 -74.203 112; ...
    112 -93.786 -18.214]/255;
offset = [16; 128; 128];
for p = 1:3
    I_ycbcr(:,:,p) = imlincomb(T(p,1),I(:,:,1),T(p,2),I(:,:,2),T(p,3),I(:,:,3),offset(p));
end
Y=im2double(I_ycbcr(:,:,1));

[M,N]=size(Y);
PSF=fspecial('motion',10,45);
Yb=imfilter(Y,PSF,'circular');
noise=imnoise2('Gaussian', size(Y,1), size(Y,2), 0, sqrt(0.004));
Yn=Y+noise;
Ybn=Yb+noise;

% 1.1
Sn=abs(fft2(noise)).^2;
nA=sum(Sn(:))/numel(noise);
Sf=abs(fft2(Y)).^2;
fA=sum(Sf(:))/numel(Y);
% R=nA/fA; % 0.0161
R=0.004/var(Y(:));% 0.1578
NCORR=fftshift(real(ifft2(Sn)));
ICORR=fftshift(real(ifft2(Sf)));
Ybn_inv0=deconvwnr(Ybn,PSF);
Ybn_inv1=deconvwnr(Ybn,PSF,0.9);
Ybn_inv2=deconvwnr(Ybn,PSF,NCORR,ICORR);

% imshow(Y0,[]); title('Y0'); figure;
% imshow(Y); title('Y'); figure;
% imshow(I_ycbcr(:,:,2)); title('Cb'); figure;
% imshow(I_ycbcr(:,:,3)); title('Cr');
% imshow(Yb); title('Yb'); figure;
% imshow(Yn); title('Yn'); 
% imshow(Ybn); title('Ybn'); figure;
% imshow(noise); title('noise');figure;
imshow(Ybn_inv0); title('Ybn\_inv0');figure
imshow(Ybn_inv1); title('Ybn\_inv1'); figure;
imshow(Ybn_inv2,[]); title('Ybn\_inv2'); figure;

% 1.2
NP=0.90*numel(Y)*(0.004*(1+1) + 0);
Ybn_inv3=deconv_reg(Ybn,PSF,NP,[1e-9,1e9]);
imshow(Ybn_inv3,[]); title('Ybn\_inv3'); figure;

% % 1.3
Cb=im2double(I_ycbcr(:,:,2));
Cr=im2double(I_ycbcr(:,:,3));
Y_d=dyaddown(Y,0,'m');
Cb_d=dyaddown(Cb,0,'m');
Cr_d=dyaddown(Cr,0,'m');
Y_u=zeros(M,N);
Cb_u=zeros(M,N);
Cr_u=zeros(M,N);
for r=1:M/2
    for c=1:N/2
        Cb_u(2*r-1:2*r, 2*c-1:2*c)=Cb_d(r,c);
        Cr_u(2*r-1:2*r, 2*c-1:2*c)=Cr_d(r,c);
        Y_u(2*r-1:2*r, 2*c-1:2*c)=Y_d(r,c);
    end
end
ycbcr0=cat(3,Y,Cb_u,Cr_u);
ycbcr1=cat(3,Y_u,Cb,Cr);
Inew0=ycbcr2rgb(ycbcr0);
Inew1=ycbcr2rgb(ycbcr1);

hsv=rgb2hsv(I);
hsv0=rgb2hsv(Inew0);
hsv1=rgb2hsv(Inew1);
h=hsv(:,:,1);
s=hsv(:,:,2);
v=hsv(:,:,3);
h0=hsv0(:,:,1);
s0=hsv0(:,:,2);
v0=hsv0(:,:,3);
h1=hsv1(:,:,1);
s1=hsv1(:,:,2);
v1=hsv1(:,:,3);
imshow(I);title('I');figure;
imshow(Inew0);title('Inew0');figure;
imshow(Inew1);title('Inew1');








