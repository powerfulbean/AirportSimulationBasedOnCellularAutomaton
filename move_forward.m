function space = move_forward( space,op1,op2)
global spacelength;%定义全局变量，总长度
global var;



global width
global limit_width
global preIDcheck_Num
global regularID_Num
global idcheck_Num
global Ifpre_Two
global Ifreg_Two
global Even_flag
global Even_flag2
global precheck_width
global regular_width
global midspot
global round_Num

global idcheck_Point

global lamda
global precheck_Num
global regular_Num
global checkpause_vector
global checkpause_Time

global takeoffpause_vector

global pretakeoffpause_vector%不用了，因为其不与takeoffvector相交


global xraypause_vector
global xraypause_Time

global wavepause_vector
global wavepausepre_Time
global wavepausereg_Time

global If_Two

global Plot_vector
global doublebelt_vector

global savebag_vector
global Savebagflag_vector
%======================================================
%离开策略
for i = midspot+var+1:-1:midspot+1
    for j = 2:width
        if space(i,j) == 1
            if (j>0&&j<precheck_width)
                if((Gs_disTF(takeoffpause_vector(i,j))>=rand(1))&&(space(i,j-1)==-885||space(i,j+1)==-885))   
                    if(space(i,j-1)==-885)
                    space(i,j)=space(i,j)-1;
                    takeoffpause_vector(i,j)=1;
                    space(i,j-1)=space(i,j-1)-1;
                    Plot_vector(4)=Plot_vector(4)+1;
                    else
                         space(i,j)=space(i,j)-1;
                    takeoffpause_vector(i,j)=1;
                    space(i,j+1)=space(i,j+1)-1;
                    Plot_vector(4)=Plot_vector(4)+1;
                    end
                else
                    if(space(i,j-1)==-885||space(i,j+1)==-885)
                        takeoffpause_vector(i,j)=takeoffpause_vector(i,j)+1; 
                    else
                         if(space(i,j-1)==0)
                             space(i,j-1)=space(i,j-1)+1;
                              space(i,j)=space(i,j)-1;
                              for q=i:spacelength-1
                                if (space(q+1,j-1)~=0)  
                                    break
                                else
                                    space(q+1,j-1)=1 ;
                                    space(q,j-1)=0;
                                end
                              end
                            else       
                              if(space(i,j+1)==0)
                                  space(i,j+1)=space(i,j+1)+1;
                                  space(i,j)=space(i,j)-1;
                                 for q=i:spacelength-1
                                    if (space(q+1,j+1)~=0)  
                                        break
                                    else
                                        space(q+1,j+1)=1 ;
                                        space(q,j+1)=0;
                                    end
                                 end
                              end
                         end
                      end
                end
            else
                if(Gs_disTF2(takeoffpause_vector(i,j))>=rand(1))
                    if(space(i,j-1)==-885)
                    space(i,j)=space(i,j)-1;
                    takeoffpause_vector(i,j)=1;
                    space(i,j-1)=space(i,j-1)-1;
                    Plot_vector(4)=Plot_vector(4)+1;
                    else
                        if(space(i,j+1)==-885)
                         space(i,j)=space(i,j)-1;
                        takeoffpause_vector(i,j)=1;
                        space(i,j+1)=space(i,j+1)-1;
                        Plot_vector(4)=Plot_vector(4)+1;
                        end
                    end
                else
                     if(space(i,j-1)==-885||space(i,j+1)==-885)
                    takeoffpause_vector(i,j)=takeoffpause_vector(i,j)+1; 
                     else
                         if(space(i,j-1)==0)
                             space(i,j-1)=space(i,j-1)+1;
                              space(i,j)=space(i,j)-1;
                              for q=i:spacelength-1
                                if (space(q+1,j-1)~=0)  
                                    break
                                else
                                    space(q+1,j-1)=1 ;
                                    space(q,j-1)=0;
                                end
                              end
                           else       
                              if(space(i,j+1)==0)
                                  space(i,j+1)=space(i,j+1)+1;
                                  space(i,j)=space(i,j)-1;
                                 for q=i:spacelength-1
                                    if (space(q+1,j+1)~=0)  
                                        break
                                    else
                                        space(q+1,j+1)=1 ;
                                        space(q,j+1)=0;
                                    end
                                 end
                              end
                           end
                        end
                    end
                end
            end   
        end
    end

% %=======================================================
% 
% 
% 
% %=======================================================
%穿衣服及寻找行李策略
for i = spacelength-1:-1:midspot+1
    for j = 1:width
        if space(i,j) == 1%如果有个人在space(i,j)
            for k=i:spacelength-1
              if (space(k+1,j)~=0)%他不能往前走的话
                if(doublebelt_vector(j)+doublebelt_vector(j+1)==2)%如果两侧都有行李
                    if(takeoffpause_vector(i,j)==1)
                          if(space(k,j-1)==0)
                              space(k,j-1)=space(k,j-1)+1;
                              space(k,j)=space(k,j)-1;
                              for q=k:spacelength-1
                                if (space(q+1,j-1)~=0)  
                                    break
                                else
                                    space(q+1,j-1)=1 ;
                                    space(q,j-1)=0;
                                end
                              end
                            else       
                              if(space(k,j+1)==0)
                                  space(k,j+1)=space(k,j+1)+1;
                                  space(k,j)=space(k,j)-1;
                                 for q=k:spacelength-1
                                    if (space(q+1,j+1)~=0)  
                                        break
                                    else
                                        space(q+1,j+1)=1 ;
                                        space(q,j+1)=0;
                                    end
                                 end
                              end
                          end
                    end
                else
                    break
                end
              else                 
                  space(k+1,j)=1 ;
                  space(k,j)=0;
              end
            end
        end
      
        if space(i,j) == -885
            for k=i:spacelength-1
              if (space(k+1,j)~=-886)
                  break
              else
                  space(k+1,j)=-885  ;
                  space(k,j)=-886;
              end
             
            end
        end
%         
    end
end



%=======================================================

%=======================================================
%安检处
for i = midspot+1
    for j = 1:precheck_width
        if space(i-1,j) == -887
            if((xraypause_vector(j)>=xraypause_Time)&& (space(i,j)==-886));    
                space(i,j)=space(i,j)+1;
                space(i-1,j)=space(i-1,j)-1;
                for k=i:spacelength-1
                    if (space(k+1,j)~=-886)
                         break
                     else                 
                      space(k+1,j)=-885 ;
                      space(k,j)=-886;
                    end
                end
                xraypause_vector(j)=1;
            else
            xraypause_vector(j)=xraypause_vector(j)+1; 
            end
        end
        
        if space(i-1,j) == 3
            if(doublebelt_vector(j)+doublebelt_vector(j+1)==1)
                   if((wavepause_vector(j)>=wavepausereg_Time)&& (space(i,j)==0))  
                        space(i,j)=space(i,j)+1;
                        space(i-1,j)=space(i-1,j)-1;
                         Plot_vector(3)=Plot_vector(3)+1;
                                for k=i:spacelength-1
                                      if (space(k+1,j)~=0)
                                          break
                                      else
                                          space(k+1,j)=1  ;
                                          space(k,j)=0;
                                      end
                                end
                        wavepause_vector(j)=1;
                   else
                       wavepause_vector(j)=wavepause_vector(j)+1;
                   end 
                    
            else
                if(Ifpre_Two==0)
                   if(wavepause_vector(j)>=wavepausereg_Time)  
                       if((Even_flag==0)&& (space(i,j)==0))
                           space(i,j)=space(i,j)+1;
                           space(i-1,j)=space(i-1,j)-1;
                            Plot_vector(3)=Plot_vector(3)+1;
                           Even_flag=1;
                           wavepause_vector(j)=1;
                                for k=i:spacelength-1
                                      if (space(k+1,j)~=0)
                                          if(space(k,j+1)==0)
                                              space(k,j+1)=space(k,j+1)+1;
                                              space(k,j)=space(k,j)-1;
                                          end
                                          break
                                      else
                                          space(k+1,j)=1  ;
                                          space(k,j)=0;
                                      end
                                end
                       else
                           if((Even_flag==1)&& (space(i,j+1)==0))
                               Even_flag=0; 
                               space(i,j+1)=space(i,j+1)+1;
                               space(i-1,j)=space(i-1,j)-1;
                                Plot_vector(3)=Plot_vector(3)+1;
                               wavepause_vector(j)=1;
                                    for k=i:spacelength-1
                                      if (space(k+1,j+1)~=0)
                                          break
                                      else
                                          space(k+1,j+1)=1  ;
                                          space(k,j+1)=0;
                                      end
                                    end
                           end 

                       end
                   else
                        wavepause_vector(j)= wavepause_vector(j)+1;
                   end
                else
                    if(wavepause_vector(j)>=wavepausepre_Time)  
                         if((space(i,j)==0))
                             space(i,j)=space(i,j)+1;
                               space(i-1,j)=space(i-1,j)-1;
                                Plot_vector(3)=Plot_vector(3)+1;
                               wavepause_vector(j)=1;
                                    for k=i:spacelength-1
                                          if (space(k+1,j)~=0)
                                              break
                                          else
                                              space(k+1,j)=1  ;
                                              space(k,j)=0;
                                          end
                                    end
                         end
                     else           
                              wavepause_vector(j)= wavepause_vector(j)+1;      
                    end
                    end
                end
            end
            
            
                            
    end
         for j = precheck_width:width
        if space(i-1,j) == -887
            if((xraypause_vector(j)>=xraypause_Time)&& (space(i,j)==-886));    
                space(i,j)=space(i,j)+1;
                space(i-1,j)=space(i-1,j)-1;
                for k=i:spacelength-1
                    if (space(k+1,j)~=-886)
                         break
                     else                 
                      space(k+1,j)=-885 ;
                      space(k,j)=-886;
                    end
                end
                xraypause_vector(j)=1;
            else
            xraypause_vector(j)=xraypause_vector(j)+1; 
            end
        end
        
        if space(i-1,j) == 3
            if(doublebelt_vector(j)+doublebelt_vector(j+1)==1)
                   if((wavepause_vector(j)>=wavepausereg_Time)&& (space(i,j)==0))  
                        space(i,j)=space(i,j)+1;
                        space(i-1,j)=space(i-1,j)-1;
                         Plot_vector(3)=Plot_vector(3)+1;
                                for k=i:spacelength-1
                                      if (space(k+1,j)~=0)
                                          break
                                      else
                                          space(k+1,j)=1  ;
                                          space(k,j)=0;
                                      end
                                end
                        wavepause_vector(j)=1;
                   else
                       wavepause_vector(j)=wavepause_vector(j)+1;
                   end 
                    
            else
                if(Ifreg_Two==0)
                   if(wavepause_vector(j)>=wavepausereg_Time)  
                       if((Even_flag==0)&& (space(i,j)==0))
                           space(i,j)=space(i,j)+1;
                           space(i-1,j)=space(i-1,j)-1;
                            Plot_vector(3)=Plot_vector(3)+1;
                           Even_flag=1;
                           wavepause_vector(j)=1;
                                for k=i:spacelength-1
                                      if (space(k+1,j)~=0)
                                          if(space(k,j+1)==0)
                                              space(k,j+1)=space(k,j+1)+1;
                                              space(k,j)=space(k,j)-1;
                                          end
                                          break
                                      else
                                          space(k+1,j)=1  ;
                                          space(k,j)=0;
                                      end
                                end
                       else
                           if((Even_flag==1)&& (space(i,j+1)==0))
                               Even_flag=0; 
                               space(i,j+1)=space(i,j+1)+1;
                               space(i-1,j)=space(i-1,j)-1;
                                Plot_vector(3)=Plot_vector(3)+1;
                               wavepause_vector(j)=1;
                                    for k=i:spacelength-1
                                      if (space(k+1,j+1)~=0)
                                          break
                                      else
                                          space(k+1,j+1)=1  ;
                                          space(k,j+1)=0;
                                      end
                                    end
                           end 

                       end
                   else
                        wavepause_vector(j)= wavepause_vector(j)+1;
                   end
                else
                    if(wavepause_vector(j)>=wavepausereg_Time)  
                         if((space(i,j)==0))
                             space(i,j)=space(i,j)+1;
                               space(i-1,j)=space(i-1,j)-1;
                                Plot_vector(3)=Plot_vector(3)+1;
                               wavepause_vector(j)=1;
                                    for k=i:spacelength-1
                                          if (space(k+1,j)~=0)
                                              break
                                          else
                                              space(k+1,j)=1  ;
                                              space(k,j)=0;
                                          end
                                    end
                         end
                     else           
                              wavepause_vector(j)= wavepause_vector(j)+1;      
                    end
                    end
                end
            end
            
            
                            
         end
end  


%=======================================================

%=======================================================
%即将进入安检处

for i = midspot-1
    for j = 1:width
      if(j>0&&j<precheck_width)
        if space(i,j) == 1
            if space(i+1,j)==2
                if(Ifpre_Two==0)
                    if(Even_flag2==0)
                   space(i+1,j)=space(i+1,j)+1;
                   space(i,j)=space(i,j)-1; 
                   Even_flag2=1;
                    else
                        if(space(i,j)==1&&Even_flag2==1&&space(i+1,j-1)==2)
                            space(i,j)=space(i,j)-1;
                            space(i+1,j-1)=space(i+1,j-1)+1;
                            Even_flag2=0;
                        end
                    end
                else
                   space(i+1,j)=space(i+1,j)+1;
                   space(i,j)=space(i,j)-1;
                end
            else 
                if space(i+1,j-1)==2
                    space(i,j)=space(i,j)-1;
                    space(i+1,j-1)=space(i+1,j-1)+1;
                    Even_flag2=0;
                end                  
            end
        end
      end
      if(j>precheck_width&&j<width)
        if space(i,j) == 1
            if space(i+1,j)==2
                if(Ifreg_Two==0)
                    if(Even_flag2==0)
                   space(i+1,j)=space(i+1,j)+1;
                   space(i,j)=space(i,j)-1; 
                   Even_flag2=1;
                    else
                        if(space(i,j)==1&&Even_flag2==1&&space(i+1,j-1)==2)
                            space(i,j)=space(i,j)-1;
                            space(i+1,j-1)=space(i+1,j-1)+1;
                            Even_flag2=0;
                        end
                    end
                else
                   space(i+1,j)=space(i+1,j)+1;
                   space(i,j)=space(i,j)-1;
                end
            else 
                if space(i+1,j-1)==2
                    space(i,j)=space(i,j)-1;
                    space(i+1,j-1)=space(i+1,j-1)+1;
                    Even_flag2=0;
                end                  
            end
        end
      end
        
        if space(i,j) == -885
            for k=i:midspot-1
              if ((space(k+1,j)==-886)||(space(i+1,j)==-888))
                  space(k+1,j)=space(k+1,j)+1  ;
                  space(k,j)=space(k,j)-1;
              else
                  break
              end
            end
        end
    end    
end

%=======================================================
% Even_flag
% Even_flag2；


%=======================================================
%从放行李处出来到即将安检之前
for i = midspot-1:-1:midspot-var
%     for j= 1:precheck_Num
        
    
    
    
    
    for j = 1:width
        if space(i,j) == 1
            for k=i:midspot-1
                if ((space(k+1,j)==0)||(space(k+1,j)==2)||(space(k+1,j-1)==2)||(space(k+1,j+1)==2)||(space(k+1,j-1)==0)||(space(k+1,j+1)==0))
                      if((space(k+1,j)==0)||(space(k+1,j)==2))
                        space(k+1,j)=space(k+1,j)+1  ;
                        space(k,j)=space(k,j)-1;
                      else                   
                          if(space(k+1,j-1)==2)
                             space(k+1,j-1)=space(k+1,j-1)+1  ;
                            space(k,j)=space(k,j)-1;             
                          else
                              if(space(k+1,j+1)==2)
                                space(k+1,j+1)=space(k+1,j+1)+1  ;
                                space(k,j)=space(k,j)-1;
                              else
                                  if((space(k+1,j-1)==0))
                                     space(k+1,j-1)=space(k+1,j-1)+1  ;
                                    space(k,j)=space(k,j)-1; 
                                  else
                                      if(space(k+1,j+1)==0)
                                         space(k+1,j+1)=space(k+1,j+1)+1  ;
                                        space(k,j)=space(k,j)-1;
                                      end
                                  end
                              end
                           end
                      end
                else
                  break
                end
            end
        end
        
        if space(i,j) == -885
            for k=i:midspot-1
              if ((space(k+1,j)==-886)||(space(k+1,j)==-888))
                  space(k+1,j)=space(k+1,j)+1  ;
                  space(k,j)=space(k,j)-1;
              else
                  break
              end
            end
        end
        
    end
end

for i = midspot-1:-1:midspot-var
    for j = 1:width
        if space(i,j) == -886
            if savebag_vector(j)>0
                space(i,j)=-885;
                savebag_vector(j)=savebag_vector(j)-1;
            end
        end
    end
end



%=======================================================




%=======================================================
%放行李处
for i = midspot-var-1
    for j = 1:width
        if space(i,j) == 1
            %if (space(i+1,j)==0&&((space(i+1,j-1)==-886)|| (space(i+1,j+1)==-886)))
            if ((space(i+1,j-1)==-886)|| (space(i+1,j+1)==-886)||space(i+1,j-1)==-885||space(i+1,j+1)==-885)              
                if (space(i+1,j-1)==-886&&Savebagflag_vector(j)==0)
                   space(i+1,j-1)=space(i,j-1)+1;
                   Savebagflag_vector(j)=1;
                else
                    if (space(i+1,j-1)==-885&&Savebagflag_vector(j)==0)
                        savebag_vector(j-1)=savebag_vector(j-1)+1;
                        space(i+1,j-1)=space(i,j-1)+1;
                        Savebagflag_vector(j)=1;
                    end
                end
                if (space(i+1,j+1)==-886&&Savebagflag_vector(j)==0)
                     space(i+1,j+1)=space(i+1,j+1)+1;
                     Savebagflag_vector(j)=1;
                    else
                      if (space(i+1,j+1)==-885&&Savebagflag_vector(j)==0)
                       savebag_vector(j+1)=savebag_vector(j+1)+1;
                       Savebagflag_vector(j)=1;
                      end
                 end

                if(space(i+1,j)==0)
                   space(i+1,j)=space(i+1,j)+1;
                    space(i,j)=space(i,j)-1;
                    Savebagflag_vector(j)=0;
                end
            end
        
        end
        
    end
end


%=======================================================

EW=inf;
%=======================================================
%从idcheck出来到放行李
for i = midspot-var-1-1:-1:idcheck_Point+1
    for j = 1:1:precheck_width
    %for j =precheck_width:-1:1
%         if space(i,j) == -889
%             if (precheck_Num>1)
%             EW=direct_selection(space,i,j);
%             else
%                 EW=0;
%             end
%             if(EW==1)
%                 if space(i,j+EW)==-890
%                    space(i,j+EW)=space(i,j+EW)+1;
%                    space(i,j)=space(i,j)-1;
%                    flag111=1
%                    break
%                 end
%             end
%             if(EW<0)
%                 if space(i,j+EW)==-890
%                     space(i,j+EW)=space(i,j+EW)+1;
%                     space(i,j)=space(i,j)-1;
%                     flag111=1
%                     break
%                 else if space(i-1,j+EW)==-890
%                        space(i-1,j+EW)=space(i-1,j+EW)+1;
%                        space(i,j)=space(i,j)-1;
%                        flag111=1
%                        break
%                     end
%                 end
%             end
       if  (space(i,j) == -889)   
            if (space(i+1,j)==-890)
               space(i+1,j)=space(i+1,j)+1;
               space(i,j)=space(i,j)-1;
            else

                if space(i+1,j)==0
%                     for k=2:op1(1)+1;
%                         if( j==op1(k))
                            if(space(i+1,j)==0)
                            space(i+1,j)=space(i+1,j)+1;
                            space(i,j)=space(i,j)-1;
                            end
%                         end
%                     end
%                     for k=2:op2(1)+1;
%                         if ( j==op2(k))
%                             space(i+1,j)=space(i+1,j)+1;
%                             space(i,j)=space(i,j)-1;
%                         end
%                     end
                else       
                    if space(i+1,j-1)==-890
                        space(i+1,j-1)=space(i+1,j-1)+1;
                        space(i,j)=space(i,j)-1;
                    else
                        if space(i+1,j+1)==-890
                            space(i+1,j+1)=space(i+1,j+1)+1;
                            space(i,j)=space(i,j)-1;
                        end
                    end
                end
            end
       end
 end


  

      for j = width:-1:precheck_width+1
            if space(i,j) == -889
                if(i>0&&i<precheck_Num)
                if (precheck_Num>1)
                EW=direct_selection(space,i,j);
                else
                    EW=0;
                end
                end
                if(i>precheck_Num&&i<width)
                EW=direct_selection(space,i,j);
                end
                if(EW>0)
                    if space(i,j+EW)==-890
                       space(i,j+EW)=space(i,j+EW)+1;
                       space(i,j)=space(i,j)-1;
                       flag111=1
                       break
                    end
                end
                if(EW<0)
                    if space(i,j+EW)==-890
                        space(i,j+EW)=space(i,j+EW)+1;
                        space(i,j)=space(i,j)-1;
                        flag111=1
                        break
                    else if space(i-1,j+EW)==-890
                           space(i-1,j+EW)=space(i-1,j+EW)+1;
                           space(i,j)=space(i,j)-1;
                           flag111=1
                           break
                        end
                    end
                end

                if (space(i+1,j)==-890&&space(i,j) == -889)
                   space(i+1,j)=space(i+1,j)+1;
                   space(i,j)=space(i,j)-1;
                else

                    if space(i+1,j)==0
                        for k=2:op1(1)+1;
                            if( j==op1(k))
                                space(i+1,j)=space(i+1,j)+1;
                                space(i,j)=space(i,j)-1;
                            end
                        end
                        for k=2:op2(1)+1;
                            if ( j==op2(k))
                                space(i+1,j)=space(i+1,j)+1;
                                space(i,j)=space(i,j)-1;
                            end
                        end
                    else       
                        if space(i,j-1)==-890
                            space(i,j-1)=space(i,j-1)+1;
                            space(i,j)=space(i,j)-1;
                        else
                            if space(i,j+1)==-890
                                space(i,j+1)=space(i,j+1)+1;
                                space(i,j)=space(i,j)-1;
                            end
                        end
                    end
                end   
            end
        end

    
%=======================================================

%=======================================================
%idcheck part
for i = idcheck_Point
    for j = 1:width
        if space(i,j) == 3+1
            a=Gs_dis(checkpause_vector(j));
            b=rand(1);
            if((a>=b)&& (space(i+1,j)==-890));    
                space(i+1,j)=space(i+1,j)+1;
                space(i,j)=space(i,j)-1;
                checkpause_vector(j)=1;
                 Plot_vector(2)=Plot_vector(2)+1;
            end
         checkpause_vector(j)=checkpause_vector(j)+1;        
        end        
    end
end
%=======================================================

%=======================================================
%进来到idcheck前
for i = idcheck_Point-1:-1:1
    for j = 1:width
        if space(i,j) == 1
            if space(i+1,j)==0||space(i+1,j)==3
               space(i+1,j)=space(i+1,j)+1;
               space(i,j)=space(i,j)-1;
            else
                if space(i,j-1)==0
                    space(i,j-1)=space(i,j-1)+1;
                    space(i,j)=space(i,j)-1;
                else
                    if space(i,j+1)==0
                        space(i,j+1)=space(i,j+1)+1;
                        space(i,j)=space(i,j)-1;
                    end
                end        
            end   
        end
    end
end
%=======================================================

end

