function p = show_space(plaza,total_Num,p,midspot)
%��ͼ����ʾԪ���ռ�
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
[L, W] = size(plaza); %��ȡ�������ȣ�������
temp = plaza;
temp(temp==1)=0 ;%һ��ʼ�Ȱѳ����еĳ����

PLAZA(:,:,1) = plaza;
PLAZA(:,:,2) = plaza;
PLAZA(:,:,3) = temp;%3ά������������RGBͼ��
% 010Ϊ�� 001 Ϊ�� 100 Ϊ��
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
%IDcheck����ɫ����
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
%��������ɫ����
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
%�հ�����ɫ����
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
    plot([[0:W]',[0:W]']+0.5,[0,L]+0.5,'k')%������k�����ɫ
    plot([0,W]+0.5,[[0:L]',[0:L]']+0.5,'k')%������
    axis image
     set(gca,'xtick',[]);%ȥ������x��ı�ǩ
     set(gca,'ytick',[]);%ȥ�����y��ı�ǩ
end

end

