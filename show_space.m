function p = show_space(plaza,total_Num,p,midspot)
%用图像显示元胞空间
global var
global spacelength

global width
global limit_width
global precheck_width
global regular_width

global idcheck_Point
global idcheck_Num
global preIDcheck_Num
global regularID_Num
global total_Num
global midspot
[L, W] = size(plaza); %获取车道长度，车道数
temp = plaza;
temp(temp==1)=0 ;%一开始先把车道中的车清空

PLAZA(:,:,1) = plaza;
PLAZA(:,:,2) = plaza;
PLAZA(:,:,3) = temp;%3维矩阵，用于生成RGB图像
% 010为绿 001 为蓝 100 为红
% 

PLAZA = 1-PLAZA;

PLAZA(PLAZA==901)=0.2;%forbidden part
PLAZA(PLAZA==889)=0.4;%bag check part
PLAZA(PLAZA==887)=0.8;%bag storage part
PLAZA(PLAZA==891)=1;%blank-part between IDcheck and entrance of bag storage part
%===============================================================
%check point part color-strategy
for i = midspot
    for t = 0:total_Num-1
        for j=1:width
            if plaza(i,j) == 0;
                PLAZA(i,j,1) =0;
                PLAZA(i,j,2) =1;
                PLAZA(i,j,3) =0;
            else
                
                if plaza(i,j) == 3
                PLAZA(i,j,1) =0;
                PLAZA(i,j,2) =0;
                PLAZA(i,j,3) =1;
                else
                    if (plaza(i,j) == 2)
                    PLAZA(i,j,1) =1;
                    PLAZA(i,j,2) =0;
                    PLAZA(i,j,3) =0;

                    end
                end   
%                 if plaza(i,j) == 3
%                 PLAZA(i,j,1) =1;
%                 PLAZA(i,j,2) =1;
%                 PLAZA(i,j,3) =0;
%                 end 
            end
       end
    end
end
%===============================================================

%===============================================================
%IDcheck区颜色策略
for i = midspot-var-1-4
        for j=1:width
            if(plaza(i,j)>0)
            if plaza(i,j) == 3
                PLAZA(i,j,1) =1;
                PLAZA(i,j,2) =1;
                PLAZA(i,j,3) =0;
            end 
            if plaza(i,j) == 4
                PLAZA(i,j,1) =0;
                PLAZA(i,j,2) =0;
                PLAZA(i,j,3) =1;
            end 
            end
        end
   
end


%===============================================================
%行李区颜色策略
for i=midspot-var-1:midspot+var+1
    for j=1:width
        if plaza(i,j) == (-888+1)
            PLAZA(i,j,1) =0;
            PLAZA(i,j,2) =1;
            PLAZA(i,j,3) =0;
        else
            if plaza(i,j) ==(-886+1)
            PLAZA(i,j,1) =1;
            PLAZA(i,j,2) =0;
            PLAZA(i,j,3) =1;
            else if plaza(i,j) ==1
                PLAZA(i,j,1) =0;
                PLAZA(i,j,2) =0;
                PLAZA(i,j,3) =1; 
                end
            end 
        end
    end
end
%=================================================================




%=================================================================
%空白区颜色策略
for  i=idcheck_Point+1:midspot-var-1-1
    for j=2:width
        if plaza(i,j)==-889
            PLAZA(i,j,1) =0;
            PLAZA(i,j,2) =0;
            PLAZA(i,j,3) =1;
        end
    end
end

%=================================================================




if ishandle(p)
    set(p,'CData',PLAZA)
else
    %figure('position',[20,100,200,700])
    figure('Position',[20,100,400,700])
    p = imagesc(PLAZA);    
    hold on
    plot([[0:W]',[0:W]']+0.5,[0,L]+0.5,'k')%画纵线k代表黑色
    plot([0,W]+0.5,[[0:L]',[0:L]']+0.5,'k')%画横线
    axis image
     set(gca,'xtick',[]);%去掉下面x轴的标签
     set(gca,'ytick',[]);%去掉左边y轴的标签
end

end

