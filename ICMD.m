function ICMD (space,h)

global round_Tim
global entry_precheck
global entry_regular
global midspot
global entry_1
global entry_2
global total_Num
space=create_entry(space,entry_precheck,entry_regular);    
space
space=move_forward(space,entry_1,entry_2);
h = show_space(space,h); 
drawnow
%space = clear_boundary(space);
pause(round_Tim);    
end





