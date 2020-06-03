function result=distEuclidienne(QueryCase,caseCBRi)
global w;
vecteurXY=(QueryCase-caseCBRi).^2;
LaDistanceEuclidienne=sqrt(sum(vecteurXY));
result=1-LaDistanceEuclidienne;