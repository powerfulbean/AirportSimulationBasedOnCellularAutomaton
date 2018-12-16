function P= Gs_disTF( t)
global takeoffpausepre_TimeE
global takeoffpause_TimeD2
E=takeoffpausepre_TimeE;
D2=takeoffpause_TimeD2;
P=normcdf(t,E,D2);
end

