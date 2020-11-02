img = imread('Fig0316(a)(moon).tif');
imshow(img)
% soble y filter 
sobel_y = [-1,-2,-1;0,0,0;1,2,1];
laplace = [0,1,0;1,-4,1;0,1,0];

f1 = imfilter(img,sobel_y);

f2 = imfilter(img,laplace);
img_lap = img - f2;

subplot(3,1,1)
imshow(img)
subplot(3,1,2)
imshow(f1)
subplot(3,1,3)
imshow(img_lap)