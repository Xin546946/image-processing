img = imread('Fig0316(a)(moon).tif');
imshow(img)
% soble y filter 
sobel_y = [-1,-2,-1;0,0,0;1,2,1];
laplace = [0,1,0;1,-4,1;0,1,0];
sobel_x = [-1,0,1;-2,0,2;-1,0,1];
f1 = imfilter(img,laplace);
g = zeros(size(img));
g = img - f1;


subplot(2,2,1)
imshow(img)
subplot(2,2,2)
imshow(f1)
subplot(2,2,4)
imshow(g)