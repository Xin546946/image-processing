f = imread('Fig0315(a)(original_test_pattern).tif');
% f = rgb2gray(I);
PQ=paddedsize(size(f));
[U V]=dftuv(PQ(1),PQ(2));
D0=0.05*PQ(2);
F=fft2(f,PQ(1),PQ(2));
H=exp(-(U.^2+V.^2)/(2*(D0^2)));
figure,mesh(H)
g=dftfilt(f,H);
figure,imshow(g,[]);