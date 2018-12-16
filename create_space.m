function space = create_space(precheck_Num,regular_Num,midspot)
%生成二维数组，表示元胞空间的状态矩阵
global spacelength
global var
global width
global limit_width
global precheck_width
global regular_width

global preIDcheck_Num
global regularID_Num
global Ifpre_Two
global Ifreg_Two
global idcheck_Point
global If_Two
space = zeros(spacelength,width);
idcheck_Point=midspot-var-1-4;


%==========================================================================
%precheck区


for i=1:preIDcheck_Num
    space(idcheck_Point,i+1) = 3;  
end
%画出precheck绝对禁止区以及IDcheck与scan间的空地

    space(1:midspot-var-1-1,1) = -900;
    space(idcheck_Point+1:midspot-var-1-1,2:precheck_width-1)=-890;
    space(1:midspot-var-1-1,preIDcheck_Num+2:max(precheck_width,precheck_Num*4))=-900;
    if(precheck_width>precheck_Num*4)
    space(1:spacelength,max(precheck_width,precheck_Num*4:precheck_width))=-900;
    end
    space(idcheck_Point+1:midspot-var-1-1,1+1:precheck_width-1)=-890;%空地
    
    
for i=0:precheck_Num-1%行李安检区
    space(midspot,[1+i*4,1+i*4+3]) = -888;
end


for i=0:precheck_Num-1%安检区 
    if(1+i*4+1>0&&1+i*4+1<precheck_width)
    space(midspot,1+i*4+1) = 2;
    space(midspot,1+i*4+2) = 2*Ifpre_Two+(~Ifpre_Two)*(-900);
    end
end
for i=0:precheck_Num-1%放行李区
    space([midspot+1:midspot+var+1],[1+i*4,1+i*4+3]) = -886;
    space([midspot-var-1:midspot-1],[1+i*4,1+i*4+3]) = -886;   
    if(precheck_width>4*precheck_Num)
    space([midspot-var-1:midspot+var+1],4*precheck_Num:precheck_width) = -900;
end
% for i=0:precheck_Num+regular_Num-1%人群队列间过道区
%     space(1:spacelength,[1+i*4,1+i*4+3]) = -887;
% end

%==========================================================================

%==========================================================================
%regularcheck区

for i=precheck_width+1:precheck_width+1+regularID_Num
    space(idcheck_Point,i+1) = 3;  
end

%%%%%%%%%%%%%%
%画出precheck和regular间绝对禁止区以及IDcheck与scan间的空地

    space(1:midspot-var-1-1,precheck_width+1) =-900;
    space(1:midspot-var-2,precheck_width+1+regularID_Num+1:precheck_width+4*regular_Num) = -900;
     space(1:spacelength,limit_width:width)=-900;
    space(idcheck_Point+1:midspot-var-1-1,precheck_width+1+1:width-1)=-890;%空地
  



for i=0:regular_Num-1%行李安检区
    space(midspot,[precheck_width+1+i*4,precheck_width+1+i*4+3]) = -888;
end


for i=0:regular_Num-1%安检区 
    space(midspot,precheck_width+1+i*4+1) = 2;
    space(midspot,precheck_width+1+i*4+2) = 2*Ifreg_Two+(~Ifreg_Two)*(-900);
    space(midspot,7)=2;
end
for i=0:regular_Num-1%放行李区
    space([midspot+1:midspot+var+1],[precheck_width+1+i*4,precheck_width+1+i*4+3]) = -886;
    space([midspot-var-1:midspot-1],[precheck_width+1+i*4,precheck_width+1+i*4+3]) = -886;    
end

%     space(1:midspot-var-1-1,1+i*4) = -890;
%     space(idcheck_Point+1:midspot-var-1-1,precheck_width+1+1:width)=-890;%空地
%     space(1:midspot-var-1-1,1+(i+regular_Num-1)*4+3)=-890;

%%%%%%%%%%%%%%%%
%==========================================================================


% for i=0:precheck_Num+regular_Num-1%行李安检区
%     space(midspot-var:midspot+var,[1+i*4,1+i*4+3]) = -888;
% end
% 
% 
% for i=0:precheck_Num+regular_Num-1%安检区 
%     space(midspot,1+i*4+1) = 2;
%     space(midspot,1+i*4+2) = -890;
% end
% for i=0:precheck_Num+regular_Num-1%放行李区
%     space([midspot+1:midspot+var+1],[1+i*4,1+i*4+3]) = -886;
%     space([midspot-var-1:midspot-1],[1+i*4,1+i*4+3]) = -886;    
% end




end

