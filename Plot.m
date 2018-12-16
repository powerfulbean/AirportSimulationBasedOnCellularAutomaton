function  Plot( i )
global Plot_vector
global round_Num
global Show_vector
global Create_vector
global Create_vector1

Show_vector(1,i)=Plot_vector(1)-Plot_vector(4);
Show_vector(2,i)=Plot_vector(1)-Plot_vector(2);
Show_vector(3,i)=Plot_vector(2)-Plot_vector(3);
Show_vector(4,i)=Plot_vector(3)-Plot_vector(4);
Create_vector=[Create_vector,Plot_vector(1)];
Plot_vector(4)
Create_vector1=[Create_vector1,Plot_vector(4)];
Create_vector1
end

