clc;
clear;
close all;
%% task 0
I_rgb = imread('222.jpg');
figure("Name","original image"), imshow(I_rgb)
%% task 1
I_ycbcr = rgb2ycbcr(I_rgb);

[hei,wid,channel] = size(I_rgb);
I_downsample_ycbcr = zeros(hei/2,wid/2,channel);
for i = 1:hei/2
    for j = 1:wid/2
        
        I_downsample_ycbcr(i,j,:) = I_ycbcr(2*i,2*j,:);
       
        
    end
end

I_downsample_ycbcr = uint8(I_downsample_ycbcr);

figure("Name", "downsample of cb,cr"), imshow(I_downsample_ycbcr);
I_upsample_ycbcr = zeros(size(I_ycbcr));
out = zeros(hei, wid, size(I_downsample_ycbcr,3), class(I_downsample_ycbcr));
out(1:2:end,1:2:end,:) = I_downsample_ycbcr; %// Left
out(2:2:end,1:2:end,:) = I_downsample_ycbcr; %// Bottom
out(1:2:end,2:2:end,:) = I_downsample_ycbcr; %// Right
out(2:2:end,2:2:end,:) = I_downsample_ycbcr; %// Bottom-Right
out(:,:,1) = I_ycbcr(:,:,1);
I_upsample_ycbcr2rgb = ycbcr2rgb(out);
figure("Name","out (effect of cb,cr) rgb"),imshow(I_upsample_ycbcr2rgb)

%% task 2
out = zeros(hei, wid, size(I_downsample_ycbcr,3), class(I_downsample_ycbcr));
out(1:2:end,1:2:end,:) = I_downsample_ycbcr; %// Left
out(2:2:end,1:2:end,:) = I_downsample_ycbcr; %// Bottom
out(1:2:end,2:2:end,:) = I_downsample_ycbcr; %// Right
out(2:2:end,2:2:end,:) = I_downsample_ycbcr; %// Bottom-Right
out(:,:,2) = I_ycbcr(:,:,2);
out(:,:,3) = I_ycbcr(:,:,3);
I_upsample_ycbcr2rgb = ycbcr2rgb(out);
figure("Name","out (effect of y) rgb"),imshow(I_upsample_ycbcr2rgb)