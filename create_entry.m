function space=create_entry( space,loc1,loc2 )



global precheck_width

global  Plot_vector
global lamda1
global lamda2
global count1
global count2 
 

 [~,W1]=size(loc1);
 [~,W2]=size(loc2);

  rand_Num1=rand(1);
  rand_Num2=rand(1);
  P1=MinusE_dis(lamda1,count1);
  P2=MinusE_dis(lamda2,count2);
  rand_Num1
  rand_Num2
  count1
  P1
  count2
  P2
  if(rand_Num1<P1)       
       i=randint(1,1,[2,1+W1]);
       space(1,i)=1; 
        Plot_vector(1)=Plot_vector(1)+1;
       count1=1; 
  else
       count1=count1+1;
  end
  
  if(rand_Num2<P2)     
        j=randint(1,1,[precheck_width+2,precheck_width+1+W2]);
        space(1,j)=1;
         Plot_vector(1)=Plot_vector(1)+1;
        count2=1;  
  else
       count2=count2+1;
  end


 
 
%factorial 阶乘 自然指数函数exp(n)




