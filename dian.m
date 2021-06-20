%===========================================================
clc;        %清除命令窗口代码
clear all;  %清除系统所用变量
close all;  %关掉系统所用临时窗口


%==========================================================
%系统变量的定义部分
%==========================================================
%   w: 极化频率
%   t: 时间
%   k: 波数 即在2π空间距离内包含的波长个数
%   z: 沿传播方向的位置坐标
%   faix：x方向上的初始相位
%   faiy：y方向上的初始相位
%   Exm：x方向上的电场振幅
%   Eym：y方向上的电场振幅
%   Ex：电场在x方向上的瞬时分量
%   Ey：电场在y方向上的瞬时分量


%   epsilon:介电常数ε
%   mu:磁导率μ
%   sigma:电导率σ
%   gamma:传播常数γ
%   eta:本征阻抗η
syms w t    %波特征
w=300e6;
t=[0:1e-9:1e-7];
z=[0:0.00001:0.002];


%=======================================================
%介质1中的电参数
syms gamma1 mu1 epsilon1 sigma1 eta1%介质1中的电参数的定义
mu1=1.0000004;%介质1磁导率
epsilon1=56;%介质1的相对介电常数
sigma1=100;%空气的电导率为
%介质2中的电参数
syms gamma2 mu2 epsilon2 sigma2 eta2%介质2中的电参数的定义
mu2=0.99999;%介质2磁导率
epsilon2=100;%介质2的相对介电常数
sigma2=5.8e10;%介质2的电导率为
%=======================================================
Eim=0.5;


gamma1=j*w*sqrt(mu1*epsilon1*(1-j*sigma1/(w*epsilon1)))
gamma2=j*w*sqrt(mu2*epsilon2*(1-j*sigma2/(w*epsilon2)))


% real(gamma1);    %求虚数的实部
% real(gamma2);    %求虚数的实部


eta1=sqrt((mu1/epsilon1))*(1/sqrt(1-j*sigma1/(w*epsilon1)))
eta2=sqrt((mu2/epsilon2))*(1/sqrt(1-j*sigma2/(w*epsilon2)))


xx = [-5:0.5:5];
yy = [-1:0.1:1];
[XX,YY] = meshgrid(xx,yy);


ZZ = ones(size(XX))*2e-3;
figure(1);


Erm=((eta2-eta1)/(eta1+eta2))*Eim;
Etm=((2*eta2)/(eta1+eta2))*Eim;




%=================================================================
%开始分别作图
%=================================================================
axis([0 1 -8 8]);         %设置坐标参数
pic_num = 1;
%入射
for i=0:300
    cla    %清除
    mesh(ZZ,YY,XX)         %画分界面   
    title('入射波形');     %写标题
    xlabel('Z轴入射波传播方向');
    ylabel('X轴');
    zlabel('Y轴');
    t=ones(1,length(z))*i*5e-10;  
    Ei=Eim*exp(-gamma1*z+j*w*t);%x分量上
    Hi=(1/eta1)*Eim*exp(-gamma1*z+j*w*t);
    zero=zeros(1,length(z));
    plot3(z,Ei,zero);
    hold on
    plot3(z,zero,Hi,'r');
    hold on
    plot3(z,zero,zero);     %输入电场，磁场电磁波
    hold on
    pause(0.1)
    
     drawnow;
     F=getframe(gcf);
     I=frame2im(F);
    [I,map]=rgb2ind(I,256);
 
     if pic_num == 1
         imwrite(I,map,'入射.gif','gif','Loopcount',inf,'DelayTime',0.1);
     else
         imwrite(I,map,'入射.gif','gif','WriteMode','append','DelayTime',0.1);
     end
 
     pic_num = pic_num + 1;
end




ZZ = ones(size(XX))*2e-3;
figure(2);
title('反射波形');
pic_num = 1;
%反射
axis([0 1 -8 8]); %设置坐标参数
for i=0:300
    cla    %清除
    mesh(ZZ,YY,XX)         %画分界面   
    title('反射波形');     %写标题
    xlabel('Z轴');
    ylabel('X轴');
    zlabel('Y轴');
    t=ones(1,length(z))*i*5e-10;  
    Er=Erm*exp(gamma1*z+j*w*t);%x分量上
    Hr=(1/eta1)*Erm*exp(gamma1*z+j*w*t);
    zero=zeros(1,length(z));     
    plot3(z,Er,zero);
    hold on
    plot3(z,zero,Hr,'r');
    hold on
    plot3(z,zero,zero);     %输入电场，磁场电磁波
    hold on
    pause(0.1)

     drawnow;
     F=getframe(gcf);
     I=frame2im(F);
     [I,map]=rgb2ind(I,256);
 
     if pic_num == 1
         imwrite(I,map,'反射.gif','gif','Loopcount',inf,'DelayTime',0.1);
     else
         imwrite(I,map,'反射.gif','gif','WriteMode','append','DelayTime',0.1);
     end
 
     pic_num = pic_num + 1;
end


ZZ = ones(size(XX))*0;
figure(3);
title('透射波形');
pic_num = 1;
%透射
axis([0 1 -8 8]); %设置坐标参数
for i=0:300
    
    cla    %清除
    mesh(ZZ,YY,XX)         %画分界面   
    title('透射波形');     %写标题
    xlabel('Z轴透射波传播方向');
    ylabel('X轴');
    zlabel('Y轴');
    t=ones(1,length(z))*i*5e-10;  
    Et=Etm*exp(-gamma1*z+j*w*t);%x分量上
    Ht=(1/eta1)*Etm*exp(-gamma1*z+j*w*t);
    zero=zeros(1,length(z));
    plot3(z,Et,zero);
    hold on
    plot3(z,zero,Ht,'r');
    hold on
    plot3(z,zero,zero);     %输入电场，磁场电磁波
    hold on
    pause(0.1)
    
     drawnow;
     F=getframe(gcf);
     I=frame2im(F);
    [I,map]=rgb2ind(I,256);
 
     if pic_num == 1
         imwrite(I,map,'透射.gif','gif','Loopcount',inf,'DelayTime',0.1);
     else
         imwrite(I,map,'透射.gif','gif','WriteMode','append','DelayTime',0.1);
     end
 
     pic_num = pic_num + 1;


end


ZZ = 4*ones(size(XX))*0;
pic_num = 1;
%view([-10,-10,10]);
for i=0:300
    %入射部分
    hold on
    axis([-2e-3 2e-3 -1 1 -10 10])
    cla    %清除
    mesh(ZZ,YY,XX)         %画分界面   
    title('介质1中的合成波');     %写标题
    xlabel('Z轴');
    ylabel('x轴');
    zlabel('y轴');
    z=[-0.002:0.00001:0];
    t=ones(1,length(z))*i*5e-10;  
    E1=Eim*exp(-gamma1*z+j*w*t)+Erm*exp(gamma1*z+j*w*t);%x分量上
    H1=(1/eta1)*Eim*exp(-gamma1*z+j*w*t)+(1/eta1)*Erm*exp(gamma1*z+j*w*t);
    zero=zeros(1,length(z));
    plot3(z,E1,zero);
    hold on
    plot3(z,zero,H1,'r');
    hold on
    plot3(z,zero,zero);     %输入电场，磁场电磁波
    hold on
 
    %透射部分
    z=[0:0.00001:0.002];
    t=ones(1,length(z))*i*5e-10;  
    Et=Etm*exp(-gamma1*z+j*w*t);%x分量上
    Ht=(1/eta1)*Etm*exp(-gamma1*z+j*w*t);
    zero=zeros(1,length(z));
    plot3(z,Et,zero);
    hold on
    plot3(z,zero,Ht,'r');
    hold on
    plot3(z,zero,zero);     %输入电场，磁场电磁波
    hold on
    pause(0.1)
    
     drawnow;
     F=getframe(gcf);
     I=frame2im(F);
    [I,map]=rgb2ind(I,256);
 
     if pic_num == 1
         imwrite(I,map,'合成.gif','gif','Loopcount',inf,'DelayTime',0.1);
     else
         imwrite(I,map,'合成.gif','gif','WriteMode','append','DelayTime',0.1);
     end
 
     pic_num = pic_num + 1;
end


clear all