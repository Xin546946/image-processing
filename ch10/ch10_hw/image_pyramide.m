%% generate gaussian pyramide
clc
clear
I=im2double(rgb2gray(imread('lenna.png')));
num=4;
Gau=cell(num,1);
N=1; 
% The first layer of pyramide is original images
Gau{N}=I;
h=fspecial('gaussian',[5,5],64);
for N=2:num
    temp=imfilter(Gau{N-1},h,'conv','same','replicate');
    Gau{N}=temp(1:2:end,1:2:end,:);
end
%%
temp=Gau{size(Gau,1)};
for N=1:num
    figure;
    imshow(Gau{N});
end
%% 将残差放入拉普拉斯金字塔当中
laplas=cell(num-1,1);
for index=num-1:-1:1
    temp=imresize(Gau{index+1},[size(Gau{index},1),size(Gau{index},2)],'bilinear');%上采样构造拉普拉斯金字塔
    temp=imfilter(temp,h,'conv','same','replicate');
    laplas{index}=Gau{index}-temp;
end

%% show laplace pyramide
for M=1:num-1
    figure;
    imshow(laplas{M});
end
%% 利用拉普拉斯金字塔重构
img=Gau{N};
for index2=N:-1:2
    temp=imresize(Gau{index2},[size(Gau{index2-1},1),size(Gau{index2-1},2)],'bilinear');
    temp=imfilter(temp,h,'conv','same','replicate');
    img=temp+laplas{index2-1};
end
imshow([I img]);