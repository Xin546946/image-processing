clc;
clear;
close all;

im = imread('lena.png');
rows = size(im,1);
cols = size(im,2);
out = zeros(2*rows, 2*cols, size(im,3), class(im));
out(1:2:end,1:2:end,:) = im; %// Left
out(2:2:end,1:2:end,:) = im; %// Bottom
out(1:2:end,2:2:end,:) = im; %// Right
out(2:2:end,2:2:end,:) = im; %// Bottom-Right
imshow(out)

