f = imread('lena.png');
imshow(f);
figure,imhist(f);
ylim('auto');
g = histeq(f,256);
figure, imshow(g);
figure, imhist(g);
ylim('auto');