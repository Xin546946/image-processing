%% Ex1 ３)
x = [1,2,3,4,3,2,1];
y = [2,0,-2];
z = conv(x,y); % parameter full,same, valid

f = [-1,0,1;-2,0,2;-1,0,1];
g = [1,3,2,0,4;1,0,3,2,3;0,4,1,0,5;2,3,2,1,4;3,1,0,4,2];
h = conv2(f,g) % parameter full, same, valid,默认为full
%　same, valid参数下,f,g的顺序会对结果产生影响

 %% 验证卷积的交换，结合,分配律
 %　继续使用x,y信号作为实验对象
 % 交换律 
 Comm  = conv(x,y) == conv(y,x);
 % 结合律 f*g*h = f*(g*h)
 m = [1,2,3];
 Asso = conv(conv(x,y),m) == conv(conv(x,m),y);
 % 分配律
 Distr = conv(x,y+m) == conv(x,y) + conv(x,m)
 