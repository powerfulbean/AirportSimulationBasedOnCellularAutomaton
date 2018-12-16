function EW= direct_selection( space,y,x )
%====================================
%calculate the number of people in every lane
global precheck_Num
global regular_Num
global precheck_width
global regular_width
global midspot
global var
global doublebelt_vector
global Ifpre_Two
global Ifreg_Two

total_Num=precheck_Num+regular_Num;
queue_vector=zeros(total_Num,2);%column 1 stores the number of people in everylane, column 2 stores the left-most position of every lane

minx=0;

for i=1:precheck_Num
    for j=midspot-var-1:midspot
        for k=1+1+(i-1)*4:1+(i-1)*4+2
            queue_vector(i,2)=1+(i-1)*4+1;
            if(space(j,k)==1||space(j,k)==3)
                queue_vector(i,1)=queue_vector(i,1)+1;
            end
        end
    end
    if((doublebelt_vector(queue_vector(i,2))+doublebelt_vector(queue_vector(i,2)+1)==2)&&(Ifpre_Two==1))
        queue_vector(i,1)=queue_vector(i,1)/2;
    end
end
for i=1:regular_Num
    for j=midspot-var-1:midspot
        for k=precheck_width+1+1+(i-1)*4:precheck_width+1+1+(i-1)*4+2
            queue_vector(i+precheck_Num,2)=1+1+(i+precheck_Num-1)*4;
            if(space(j,k)==1||space(j,k)==3)
                queue_vector(i+precheck_Num,1)=queue_vector(i+precheck_Num,1)+1;
            end
        end
    end
    if((doublebelt_vector(queue_vector(i+precheck_Num,2))+doublebelt_vector(queue_vector(i+precheck_Num,2)+1)==2)&&(Ifreg_Two==1))
        queue_vector(i+precheck_Num,1)=queue_vector(i+precheck_Num,1)/2;
    end
end


if(x>0&&x<precheck_width)
    flag=0;
    min=queue_vector(1,1);
    minx=queue_vector(1,2);
    for i=1:precheck_Num
        if( queue_vector(i,1)<min)
            minx=queue_vector(i,2);
            if(queue_vector(i,1)==min)
                flag=flag+1;
            end
        end        
    end
    if(flag==precheck_Num-1)
        minx=0;
    end
    
    if(minx>x)
        if(space(y,x+1)==-890)
            EW=1;
        else
            EW=0;
        end
    else
        if(minx<x)
            EW=-1;
        else
            if(minx==x||minx==0)
                EW=0;
            end
        end
    end
end

if(x>precheck_width&&x<precheck_width+regular_width)
    flag=0;
    min=queue_vector(precheck_Num+1,1);
    minx=queue_vector(precheck_Num+1,2);
    for i=precheck_Num:precheck_Num+regular_Num
        if( queue_vector(i,1)<min)
            minx=queue_vector(i,2);
            if(queue_vector(i,1)==min)
                flag=flag+1;
            end
        end
    end
    
    if(flag==regular_Num-1)
        minx=0;
    end
    
    if(minx>x)
        if(space(y,x+1)==-890)
            EW=1;
        else
            EW=0;
        end
    else
        if(minx<x)
            EW=-1;
        else
            if(minx==x||minx==0)
                EW=0;
            end
        end
    end
end


end

