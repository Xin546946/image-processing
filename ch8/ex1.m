%% C = checkerboard(NP,M,N);
f = checkerboard(64,4,4);
figure("Name","Checkerboard"), imshow(f);
%% 
PSF = fspecial('motion',40,45);
gb = imfilter(f,PSF,'circular');
noise = imnoise(zeros(size(f)), 'gaussian',0,0.001);
g = gb + noise;
figure("Name", "image"), imshow(f,[]);
figure("Name","motion blured image"), imshow(gb,[]);
figure("Name", "Noise"), imshow(noise,[]);