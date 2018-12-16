clc
clear all 
%======================================
%数学参数
global lamda1
global lamda2
%lamda1=1/9.1554;
lamda1=1/7.5;
%lamda2=1/11.6978;
lamda2=1/16.29;
global IDcheckE
global IDcheckd2
IDcheckE=11.2125;
IDcheckd2=3.9169;
global takeoffpausepre_TimeE
takeoffpausepre_TimeE=(23.6207-8)/2;
global takeoffpausereg_TimeE
takeoffpausereg_TimeE=(23.6207+8)/2;
global takeoffpause_TimeD2
takeoffpause_TimeD2=14.09/2;
%====================================
% %集体效率2级 time-2
% takeoffpausepre_TimeE=(23.6207-8)/2-2;
% takeoffpausereg_TimeE=(23.6207+8)/2-2;
% %====================================
% % %集体效率1级 time-1
% takeoffpausepre_TimeE=(23.6207-8)/2-1;
% takeoffpausereg_TimeE=(23.6207+8)/2-1;
% % %====================================
% %个人效率1级 time+1
% takeoffpausepre_TimeE=(23.6207-8)/2+1;
% takeoffpausereg_TimeE=(23.6207+8)/2+1;
% % ====================================
% %个人效率2级 time+2
% takeoffpausepre_TimeE=(23.6207-8)/2+2;
% takeoffpausereg_TimeE=(23.6207+8)/2+2;
% %====================================
% %个人效率3级 time+3
% takeoffpausepre_TimeE=(23.6207-8)/2+3;
% takeoffpausereg_TimeE=(23.6207+8)/2+3;
% %====================================
% %======================================
% 
% %个人效率40级 time+40
% takeoffpausepre_TimeE=(23.6207-8)/2+40;
% takeoffpausereg_TimeE=(23.6207+8)/2+40;
%时间参数
global round_Tim

global checkpause_Time
global pretakeoffpause_Time
global xraypause_Time
global wavepausepre_Time
global wavepausereg_Time
xraypause_Time=5;

wavepausepre_Time=3.5+7.5-2-3-1;
wavepausereg_Time=3.5+15.5-2;




%======================================
%数目参数
global round_Num%循环次数
round_Num=1000;
round_Tim=0.0001;


global preIDcheck_Num
global regularID_Num
global precheck_Num
global regular_Num
global Ifpre_Two
global Ifreg_Two
Ifpre_Two=1;
Ifreg_Two=0;

precheck_Closedbelt_Num=0;
regular_Closedbelt_Num=1;
preIDcheck_temp_Num=2;
regularID_Num=3;
precheck_Num=1;
regular_Num=2;
%======================================

pretakeoffpause_Time=10;%biyong
checkpause_Time=9;%buyong





global Create_vector
global Create_vector1
Create_vector=[];
Create_vector1=[];

global Savebagflag_vector


global Show_vector
global Plot_vector
Plot_vector=zeros(1,4);%1jin 2ID 3SCAN 4Leave
Show_vector=zeros(4,round_Num);

global spacelength;%定义全局变量，总长度
global var;
global midspot
global width
global limit_width
global precheck_width
global regular_width
global idcheck_Point
global idcheck_Num
global count1
global count2
global checkpause_vector
global takeoffpause_vector
global pretakeoffpause_vector
global xraypause_vector
global wavepause_vector
global doublebelt_vector
global Even_flag
global Even_flag2



Even_flag2=0
Even_flag=0;

count1=1;
count2=1;
checkpause_count=1;




var =6;%传送带区长度-1的1/2
length=22;
spacelength=length+4;
midspot=spacelength-var-1;



idcheck_Num=preIDcheck_temp_Num+regularID_Num;

total_Num=precheck_Num+regular_Num;



preIDcheck_Num=preIDcheck_temp_Num;%max(preIDcheck_temp_Num,precheck_Num*2);

limit_width=max(precheck_width+regular_Num*4,precheck_width+regularID_Num+2);

precheck_width=max(precheck_Num*4,preIDcheck_Num+2);
regular_width=max(regular_Num*4,regularID_Num);
width=precheck_width+regular_width;

doublebelt_vector=zeros(width);

global savebag_vector
savebag_vector=zeros(1,width);%用于暂存溢出的行李
%==========================================================
%安检开放数
entry_1=[];
entry_2=[];
precheck_Flag=1;%!!!!!!
regular_Flag=1;%!!!!!!
entry_Loc=[entry_1,entry_2];
k=0;
for i=0:precheck_Num-1
    if(precheck_Flag<=precheck_Num*2-precheck_Closedbelt_Num)
        entry_1=[entry_1,1+i*4+1];
        precheck_Flag=precheck_Flag+1;
        doublebelt_vector(1+i*4+1)=1;%向量用于判断某个安检口是否两边都能取行李
        k=k+1;
    end
    if(precheck_Flag<=precheck_Num*2-precheck_Closedbelt_Num)
        entry_1=[entry_1,1+i*4+2];
        precheck_Flag=precheck_Flag+1;
        doublebelt_vector(1+i*4+2)=1;
        k=k+1;
    end
    
end
entry_1=[k,entry_1];
% entry_1
k=0;
for i=0:regular_Num-1
    if(regular_Flag<=regular_Num*2-regular_Closedbelt_Num)
        entry_2=[entry_2,precheck_width+1+i*4+1];
        doublebelt_vector(precheck_width+1+i*4+1)=1;
        regular_Flag=regular_Flag+1;
        k=k+1;
    end
    
    if(regular_Flag<=regular_Num*2-regular_Closedbelt_Num)
        entry_2=[entry_2,precheck_width+1+i*4+2];
        doublebelt_vector(precheck_width+1+i*4+2)=1;
        regular_Flag=regular_Flag+1;
        k=k+1;
    end
    
end
entry_2=[k,entry_2];
%======================
%临时 用于非连续关belt
entry_2=zeros(1,3);
entry_2=[2,6,10];

%====================================================

%====================================================
space=create_space(precheck_Num,regular_Num,midspot);              %创建元胞空间
%====================================================
space

%==========================================================
entry_precheck=[];
for i=1:precheck_width
    if(space(1,i)>=0)
        entry_precheck=[entry_precheck,i];
    end    
end
entry_regular=[];
for i=precheck_width+1:width
    if(space(1,i)>=0)
        entry_regular=[entry_regular,i];
    end    
end
% entry_precheck
% entry_regular
%=========================================================
%初始化 checkpause_vector矩阵

checkpause_vector=ones(1,width);
takeoffpause_vector=ones(spacelength,width);
pretakeoffpause_vector=ones(spacelength,width);
xraypause_vector=ones(1,width);
wavepause_vector=ones(1,width);
Savebagflag_vector=zeros(width);
%=========================================================




%==========================================================


%====================================================

h = show_space(space,total_Num,NaN,midspot);      %用图像显示元胞空间
%====================================================
% t1=[];
% m1=[];
% h2=plot(t1,m1,'*','EraseMode','background','MarkerSize',5);
% x=1;
% axis([x x+1 0 2*round_Num]);
% 
% grid on;
% %space(1,2)=1;

% %=========================================================
%主循环
global time
global Show_vector

for(time=1:round_Num)
    
    
    space=create_entry(space,entry_precheck,entry_regular);    
    
    space=move_forward(space,entry_1,entry_2);
    space
    h = show_space(space,total_Num,h,midspot); 
    drawnow
    saveas(h,['D:\tempsave\',int2str(time),'.jpg']);
    %space = clear_boundary(space);
    pause(round_Tim);
    Plot(time)
    %Show_vector
    %h2=Dy_Chart(h2,time,t1,m1,x);
    drawnow
end
figure(3)
plot(1:round_Num,Show_vector(1,:),1:round_Num,Show_vector(2,:),1:round_Num,Show_vector(3,:),1:round_Num,Show_vector(4,:));
grid on
legend('TotalPeople Num','areaA Num','areaB Num','areaC Num');
xlabel('Time/s');
ylabel('Number of people');
title('People who stay at those areas');
figure(4)
plot(1:round_Num,Create_vector);
xlabel('Time/s');
ylabel('Number of people');
title('People who come to the airport');
grid on
figure(5)
plot(1:round_Num,Create_vector1);
xlabel('Time/s');
ylabel('Number of people');
title('People who pass the checkpoint');
grid on
Create_vector1
Plot_vector(1)
Plot_vector(4)

PASSTIME=(Plot_vector(1)-Plot_vector(4))/Plot_vector(4)




