%sobel
% f=imread('Fig0310(a)(Moon Phobos).tif');
f=imread('Fig0316(a)(moon).tif');
% f=im2double(f);
w_sobel_lat=[-1,-2,-1;0,0,0;1,2,1];
w_sobel_lon=[-1,0,1;-2,0,2;-1,0,1];
fw_lat=imfilter(f,w_sobel_lat,'conv','replicate');
fw_lon=imfilter(f,w_sobel_lon,'conv','replicate');
%
a0 = 1;
a1 = 1;
enhance=f+a0*fw_lat+a1*fw_lon;
subplot(2,2,1),imshow(f),title("original image")
subplot(2,2,2),imshow(fw_lat),title("lateral edge")
subplot(2,2,3),imshow(fw_lon),title("longitudinal edge")
subplot(2,2,4),imshow(enhance),title("enhanced filter")