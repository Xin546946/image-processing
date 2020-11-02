img = imread('lena.png');
img = rgb2gray(img);
figure(1)
imshow(img)
%图像左乘(-1)**(x+y)
[m,n] = size(img)
img_shift = ones(m,n);
for i=1:m
    for j=1:n
        img_shift(i,j) = img(i,j)*((-1)^(i+j));
    end
end
figure(2)
imshow(abs(img_shift))

F = fft2(img_shift);
S = abs(F);
figure(3)
imshow(S,[])

img_conj = conj(F)
figure(4)
imshow(abs(img_conj),[])

img_ifft = real(ifft2(img_conj));
img_ifft=uint32(img_ifft)
figure(5)
imshow(abs(img_ifft),[])
img_convert = ones(m,n);
img_real=real(img_ifft);
[m,n] = size(img_real)
for i=1:m
    for j=1:n
        img_convert(i,j) = img_real(i,j)*((-1)^(i+j));
    end
end
figure(6)
imshow(img_convert)