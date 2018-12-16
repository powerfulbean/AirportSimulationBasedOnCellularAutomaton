function P = Gs_dis(t)
global IDcheckE
global IDcheckd2
E=IDcheckE;
D2=IDcheckd2;
P=normcdf(t,E,D2);

end

