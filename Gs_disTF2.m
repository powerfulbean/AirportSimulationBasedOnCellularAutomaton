function P= Gs_disTF2( t)
global takeoffpausereg_TimeE
global takeoffpause_TimeD2
E=takeoffpausereg_TimeE;
D2=takeoffpause_TimeD2;
P=normcdf(t,E,D2);
end

