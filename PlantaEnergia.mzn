% Parametros
int: s; %Numero de clientes
int: n; %Numero de dias

int: diasRegimen;
int: pctRegimen;

int: Cn;
int: Ch;
int: Ct;

int: Nmax;
int: Hmax;
int: Tmax;

array[1..n,1..s] of int: dsn;

%Variables
array[1..n] of var int:Pn;
array[1..n] of var int:Ph;
array[1..n] of var int:Pt;
var int: f;

%Restricciones
constraint forall(i in 1..n)(Pn[i]<=Nmax);
constraint forall(i in 1..n)(Ph[i]<=Hmax);
constraint forall(i in 1..n)(Pt[i]<=Tmax);
constraint forall(i in 1..n)(sum(j in 1..s)(dsn[i,j])<=Pn[i]+Ph[i]+Pt[i]);

%Restriccion adicional
constraint forall(i in diasRegimen..n)
                  (if forall(j in 0..diasRegimen-1)(Ph[i-j]>pctRegimen*Hmax div 100)
                   then Hmax=pctRegimen*Hmax div 100
                   else true 
                   endif);

%No negatividad
constraint forall(i in 1..n)(Pn[i]>=0);
constraint forall(i in 1..n)(Pt[i]>=0);
constraint forall(i in 1..n)(Ph[i]>=0);

%Funcion objetivo
constraint f=sum(i in 1..n)(Cn*Pn[i]+Ch*Ph[i]+Ct*Pt[i]);
solve minimize f;