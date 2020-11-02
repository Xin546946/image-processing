close all;
clear;
clc;

%% ��ȡ����
I_ori = imread('cara1.ppm');
mask = roipoly(I_ori);
imshow(mask);
%% 
red = immultiply(mask,I_ori(:,:,1));
green = immultiply(mask,I_ori(:,:,2));
blue = immultiply(mask,I_ori(:,:,3));
I_sample = cat(3,red,green,blue);
figure();
imshow(I_sample);
%% 
[m,n,k] = size(I_sample);
Isam = reshape(I_sample,m * n,3);
index = find(mask);
Isam = double(Isam(index,1:3));
[height,width] = size(Isam);

%%  �����ֵ��Э�������
avg = sum(Isam,1) / height;  % ��ֵ
M = Isam - avg(ones(height,1),:);
C = (M'*M) / (height - 1);  % Э�������
S = inv(chol(C));  % 
% d = diag(C);
% sd = sqrt(d)';

%%  ��������ͼ��
I_test = imread('cara2.ppm');
[m,n,k] = size(I_test);
Itest = double(reshape(I_test,m * n,3));
figure();
imshow(I_test);

% �������Ͼ���
dist = sqrt(sum((Itest * S).^2,2) - 2 * (Itest * S) * (avg * S)' + repmat(sum((avg * S).^2),m * n,1));

% ���
threshold = 2.50;  % ��ֵ
id = find(dist <= threshold);
Iarea = zeros(m * n,1);
Iarea(id) = 1;
Iarea = reshape(Iarea,m,n);
figure();
imshow(Iarea);

red = immultiply(Iarea,double(I_test(:,:,1)));
green = immultiply(Iarea,double(I_test(:,:,2)));
blue = immultiply(Iarea,double(I_test(:,:,3)));
I_result = uint8(cat(3,red,green,blue));
figure();
imshow(I_result);




