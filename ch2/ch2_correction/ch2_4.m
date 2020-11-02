clc;
clear;
close all;

I=rgb2gray(imread('lena.png'));
subplot(3,2,1),imshow(I),title('原始图像'),hold on;
subplot(3,2,2),imhist(I),title('原始图像直方图'),hold on;
I1=histeq(I);
subplot(3,2,3),imshow(I1),title('一次均衡化'),hold on;
subplot(3,2,4),imhist(I1),title('一次均衡化直方图'),hold on;
I2=histeq(I1);
subplot(3,2,5),imshow(I2),title('二次均衡化'),hold on;
subplot(3,2,6),imhist(I2),title('二次均衡化直方图'),hold on;

% 无明显变化