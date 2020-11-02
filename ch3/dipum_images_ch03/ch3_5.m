clc;
clear all;
close all;

image=imread('lena.png');
image=rgb2gray(image);
image=double(image);
[ih,iw]=size(image);

%中值滤波器尺寸
fw=5;
fh=5;
hfw=floor(fw/2);
hfh=floor(fh/2);

%1.image pad,边界拓展
src=zeros(ih+fh-1,iw+fw-1);
for i=1-hfh:1:ih+hfh
    row=i;
    if(i<1)
        row=1;
    elseif(i>ih)
        row=ih;
    end
    for j=1-hfw:1:iw+hfw
        col=j;
        if(j<1)
            col=1;
        elseif(j>iw)
            col=iw;
        end
        src(i+hfh,j+hfw)=image(row,col);
    end
end

%2.滤波操作
th=(fw*fh)/2+1;%中值位置
dst=zeros(ih,iw);%输出
for row=1:ih
    
    %2.1当前行先初始化直方图
    imHist=zeros(256,1);
    num=0;
    for i=row:fh+row-1
        for j=1:fw
            imHist(src(i,j)+1)=imHist(src(i,j)+1)+1;%图像取值范围0~255
        end
    end
    for i=0:255
        num=imHist(i+1)+num;
        if(num>th)
            index=i;
            break;
        end
    end
    
    %2.2当前行第1个元素赋值
    dst(row,1)=index;
    
    %2.3当前行其他元素计算
    for col=2:iw
        
        %2.3.1更新直方图
        for i=row:fh+row-1
            imHist(src(i,col-1)+1)=imHist(src(i,col-1)+1)-1;%待输出统计元素
            imHist(src(i,fw+col-1)+1)=imHist(src(i,fw+col-1)+1)+1;%待增加统计的元素
            if(src(i,col-1)<=index)
                num=num-1;
            end
            if(src(i,fw+col-1)<=index)
                num=num+1;
            end
        end
        
        %2.3.2寻找中值滤波结果
        while(num>th)
            num=num-imHist(index+1);
            index=index-1;
        end
        while(num<th)
            index=index+1;
            num=num+imHist(index+1);
        end
        
         dst(row,col)=index;
    end
end

figure,imshow(image,[]),title('src image');
figure,imshow(src,[]),title('pad image');
figure,imshow(dst,[]),title('filter image');