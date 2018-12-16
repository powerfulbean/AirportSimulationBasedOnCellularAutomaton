 function space=Init(  )
%======================================
%数学参数
global lamda1
global lamda2
lamda1=1/9.1554;
lamda2=1/11.6978;
global IDcheckE
global IDcheckd2
IDcheckE=11.2125;
IDcheckd2=3.9169;
global takeoffpause_TimeE
takeoffpause_TimeE=23.6207;
global takeoffpause_TimeD2
takeoffpause_TimeD2=14.09;
%======================================
%时间参数
global round_Tim
round_Tim=0.1;
global checkpause_Time
global pretakeoffpause_Time
global xraypause_Time
global wavepause_Time
xraypause_Time=5;
wavepause_Time=3.5;
%======================================
%数目参数
global round_Num%循环次数
global preIDcheck_Num
global regularID_Num
global precheck_Num
global regular_Num
global If_Two
If_Two=0;
round_Num=50;
precheck_Closedbelt_Num=1;
regular_Closedbelt_Num=1;
preIDcheck_temp_Num=2;
regularID_Num=4;
precheck_Num=1;
regular_Num=2;
%======================================
global spacelength %定义全局变量，总长度
global var
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
global entry_precheck
global entry_regular
global entry_1
global entry_2
global total_Num
Even_flag2=0
Even_flag=0;

count1=1;
count2=1;



var =6;%传送带区长度-1的1/2
length=22;
spacelength=length+4;
midspot=spacelength-var-1;

%每个格子的状态有5种：
% 用3表示IDcheck用2表示Wave
% Scan,用+1表示人来了，-1表示人走了，0表示空位，-888代表行李安检区,(-887代表人瞬间通过区域)，
%-886行李存放区,-900代表绝对禁止，
%-890表示空地

%旅客的标记 1.wave完成标记 2.是否排队标记 3.

idcheck_Num=preIDcheck_temp_Num+regularID_Num;

total_Num=precheck_Num+regular_Num;



preIDcheck_Num=preIDcheck_temp_Num;%max(preIDcheck_temp_Num,precheck_Num*2);

limit_width=max(precheck_width+regular_Num*4,precheck_width+regularID_Num+2);

precheck_width=max(precheck_Num*4,preIDcheck_Num+2);
regular_width=max(regular_Num*4,regularID_Num);
width=precheck_width+regular_width;

doublebelt_vector=zeros(width);

%====================================================
space=create_space(precheck_Num,regular_Num,midspot);              %创建元胞空间
%====================================================

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

%====================================================

%=========================================================
%初始化 checkpause_vector矩阵

checkpause_vector=ones(1,width);
takeoffpause_vector=ones(spacelength,width);
pretakeoffpause_vector=ones(spacelength,width);
xraypause_vector=ones(1,width);
wavepause_vector=ones(1,width);

%=========================================================
%==========================================================
%用于进行随机生成的向量
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
%=============================================================
end

