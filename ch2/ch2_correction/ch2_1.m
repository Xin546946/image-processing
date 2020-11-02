clc;
clear;
close all;
%%
L = 256;
m = L/2; 
f = rgb2gray(imread('lena.png'));

i = 1;
j = 1;
x = 0:255;
figure
for E = [-1000,0,10,40,80,100,200,300,400]
    h{j} = (1./(1 + (m./(double(x) + eps)).^E));
    plot(x,h{j},'DisplayName', ['E = ' num2str(E) '.']);
    xlim([0,255])
    ylim([0,1])
    j = j+1;
    hold on
end
legend('show');
%%
for E = [1,5,7,9,10,15,20,35,40]
    h{j} = (1./(1 + (m./(double(x) + eps)).^E));
    plot(x,h{j},'DisplayName', ['E = ' num2str(E) '.']);
    xlim([0,255])
    ylim([0,1])
    j = j+1;
    hold on
end
legend('show');

%%
for E = [7,9,10,15,20]
    h{j} = (1./(1 + (m./(double(x) + eps)).^E));
    plot(x,h{j},'DisplayName', ['E = ' num2str(E) '.']);
    xlim([0,255])
    ylim([0,1])
    j = j+1;
    hold on
end
legend('show');
%%
f = rgb2gray(imread('lena.png'));
for E = [7,9,10,15,20]
    g{i} = uint8((1./(1 + (m./(double(f) + eps)).^E)).*255);
    i = i+1;
end
figure

subplot(3,2,1)
imhist(f)
for i = 1:7
    subplot(4,2,i+1)
    imhist(g{i})
end
figure
subplot(3,2,1)
imshow(f)
title('original image.')
subplot(4,2,2)
imshow(g{1})
title('E = 7.0')
subplot(3,2,3)
imshow(g{2})
title('E = 9.0')
subplot(3,2,4)
imshow(g{3})
title('E = 10.0.')
subplot(3,2,5)
imshow(g{4})
title('E = 15.0.')
subplot(3,2,6)
imshow(g{5})
title('E = 20.0.')


