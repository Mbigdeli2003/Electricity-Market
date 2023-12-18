*$setglobal o 1
*$setglobal bus_n 24
$onempty
$include matglobs.gms



sets
i Gen units  /1*%bus_n%/
kk table G_E    /1*9/
ll table G_F fuel and line   /1*7/
m table R(reserve)     /1*6/
n table S_cost         /1*2/
t Time Period/%o%*%bus_n%/
b bidding steps/1*3/
alias(k,t);
alias(j,t);
alias(jj,i);
alias(jjj,i);

parameters
G_E(i,kk)            table_Generating Data /1 .1 0/
G_F(i,ll)            table fule /1 .1 0/
Line(t,ll)           table Line /%o% .1 0/
Cost_gen(i,b,t)      table biding/1 .1 .%o% 0/
P_s_max(i,b,t)        P max steps/1 .1 .%o% 0/
D_B_max(i,b,t)        demand max steps/1 .1 .%o% 0/
R(i,ll)              table Reserve /1 .1 0/
RS(i)                start up ans shut down ramp rate/1 0/
S_Cost(i,t)         table start up shut down/1 .%o% 0/
PD(t)               table Demand/%o% 0/
P_cont(t)             contingency unit/%o% 0/
D_B(i,t)            Demand buses active power/1 .%o% 0/
Xbus(i,jj)           matrix X for dc power flow/1 .1 0/
Cost_SPIN(i,b,t)      spin reserve $/1 .1 .%o% 0/
R_s_max(i,b,t)      spin reserve $/1 .1 .%o% 0/
Cost_TMSR(i,t)      TMSR $/1 .%o% 0/
Cost_TMNR(i,t)      TMNR $/1 .%o% 0/
SU(i,t)             start up Cost/1 .%o% 0/
SD(i,t)             shut down cost/1 .%o% 0/
I_0(i)              initial state for gens/1  0/
U_0(i)              inital time for on gens/1  0/
D_0(i)              inital time for off gens/1  0/
UT(i)               up time/1  0/
DT(i)               down time/1  0/
UR(i)               ramp up limit/1 0/
DR(i)               ramp down limit/1 0/
gen_m               contingency happens/0/
delta_m             delta contingency/1/
load_f_u(i,jj,t)    line capacity/1 .1 .%o% 0/
load_f_d(i,jj,t)    line capacity/1 .1 .%o% 0/
UT_new              new up time/0/
P_ini(i)            initial P/1 0/
P_delta_ini(i)      initial P_delta/1 0/
alfa(i,b,t)         shedding cost/1 .1 .%o% 0/
C_time              contingency time/0/
B_delta_m(t)        load imblanace
P_max(i)            max power
P_min(i)            min power
SPIN_max(i)         max SPIN
TMSR_max(i)         max TMSR
TMNR_max(i)         max TMNR
UR(i)               ramp up
DR(i)               ramp dow
Cost_F              fuel cost
SU_F(i,t)           start up cost
SD_F(i,t)           shut down fuel
F_max(t)            max fuel using in hour t
E_P(i,t)            emission of unit i
SU_e(i,t)           emission of start up
SD_e(i,t)           emission of shut down
E_max(t)            max emission in hour t
F(i)                F in uptime
L(i)                L in downtime ;

$if exist matdata.gms $include matdata.gms
P_max(i)=G_E(i,'2');
P_min(i)=G_E(i,'3');
SPIN_max(i)=R(i,'2');
F(i)=(UT(i)-U_0(i))*I_0(i);
F(i)$(F(i)<0)=0;
L(i)=(DT(i)-D_0(i))*(1-I_0(i));
L(i)$(L(i)<0)=0;

variables
objout              objective
Pl(i,jj,t)          Line
delta(i,t)     angle in time t for bus i
SPIN_d(i,t)    MW spinning reserve down
RSPIN_m(i,t)    SPINm contingency
objin            new OBJ;

*delta_pd_2(i,t)   diffrence P bilevel;
positive variables
P(i,t)         active power
P_s(i,b,t)   active power steps
R_u_s(i,b,t)  steps upward reserve
R_d_s(i,b,t)  steps_downward reserve
Cost_p_s(i,b,t)   power steps Cost
Cost_R_u_s(i,b,t) upward reserve cost
Cost_R_d_s(i,b,t)    downward reserve Cost
Cost_delta_pd_s(i,b,t) shedding cost
SPIN_u(i,t)    MW spinning reserve up
SPIN_d(i,t)    MW spinning reserve down
RU_sys(t)      system ramp up rate
RD_sys(t)      system ramp down rate
TMSR_u(i,t)    MW operating reserve up-10 min spiining reserve
TMSR_d(i,t)    MW operating reserve down-10 min spiining reserve
TMNR(i,t)      MW operating resrve-10 min non-spinning reserve
P_delta(i,t)    p contingency
RTMNR_m(i,t)     TMNR Contingency
RTMSR_m(i,t)    TMSRm contingency
delta_pd_s(i,b,t)   shed steps
delta_pd(i,t)   diffrence P bilevel

binary variables
Y(i,t) unit startup indicator
Z(i,t) unit shutdown indicator
II(i,t) commitment state fo unit i
ZZ(i,t) extra variable ;


Equations
defout           cost function

*P_D_1(t)         Load-geneartion balance
PP_1(i,t)     load bus gen=0
II_C(i,t)        Cons
Y_C(i,t)         Cons
Z_C(i,t)         Cons
max_P_1(i,t)     maximum generation of unit
*max_P_2(i,t)     maximum generation of unit normal
min_P(i,t)     minimum generation of unit
step_bidding_1(i,t)    steps
step_bidding_2(i,b,t)    steps_max
R_bidding_1(i,b,t)                 res allocation
R_bidding_2(i,b,t)                res allocation
R_bidding_3(i,t)                 res summation
R_bidding_4(i,t)                 res summation
step_shed_1(i,b,t)  shed_1 steps
step_shed_2(i,t)    shed_2 steps
Cost_P(i,b,t)                cost of P steps
Cost_R_u(i,b,t)               cost of upward reserve steps
Cost_R_d(i,b,t)               Cost of downward reserve steps
Cost_delta_pd(i,b,t)         Cost of shedding steps


R_su(i,t)     sPIn_up
R_sd(i,t)     SPIN_down
SPIN_1(i,t)   SPIN_u=l=p
SPIN_2(i,t)   SPIN_l=p
SPIN_3(i,t)   SPIN_m=l=p


RR_ini_1(i,t)  initial ramp-up check
RR_ini_2(i,t)   initial ramp down check
RR_ini_3(i,t)   initial ramp down check
RR_ini_4(i,t)   initial ramp down check
RR_1(i,t)      ramp rate_1
RR_2(i,t)      ramp_rate_2
RR_3(i,t)      ramp_rate_2
RR_4(i,t)      ramp_rate_2


BB(i,t)      BB state

BB_3(i,t)      BB state

UT_1(i)        uptime_1
UT_2(i,k)      uptime_2
UT_3(i,k)      uptime_3

DT_1(i)        downtime_1
DT_2(i,k)      downtime_2
DT_3(i,k)      downtime_3


Contingency_1(i,t)  contingency_1
*Contingency_2(i,t)  contingency_2
P_deltam_1(t)      outage

P_deltam_2(i,t)    outage
P_deltam_3(t)    outage
P_deltam_RR1(i,t)  outage_RR1
P_deltam_RR2(i,t)  outage_RR2
RSPIN_delta_1(i,t) SPINm_1
RSPIN_delta_2(i,t) SPINm_2



d_pd_1(i,t)   flow_cont_1

d_pd_2(i,t)   flow_cont_2

d_pd_3(i,t)   flow_cont_3
d_pd_4(i,t)     flow_cont_4
DCL_C_1(i,jj,t)  load flow cont


flow_C_1(i,jj,t)   flow_cont_1
flow_C_2(i,jj,t)   flow_cont_2;



defout..      objout=e=sum(i,sum(t,Cost_gen(i,'1',t)*P_min(i)*II(i,t)+Y(i,t)*SU(i,t)+Z(i,t)*SD(i,t)))+sum(i,sum(b$(ord(b)>1),sum(t,cost_gen(i,b,t)*P_s(i,b,t))))+sum(i,sum(b,sum(t,alfa(i,b,t)*delta_pd_s(i,b,t)+Cost_SPIN(i,b,t)*R_d_s(i,b,t)+Cost_SPIN(i,b,t)*R_u_s(i,b,t))));






PP_1(i,t)$(P_max(i)=0)..      P(i,t)=e=0;
II_C(i,t)$(P_max(i)=0)..      II(i,t)=e=0;
Y_C(i,t)$(P_max(i)=0)..       Y(i,t)=e=0;
Z_C(i,t)$(P_max(i)=0)..       Z(i,t) =e=0;

max_P_1(i,t).. P(i,t)+SPIN_u(i,t)=l=P_max(i)*II(i,t);
*max_P_2(i,t)$(ord(t)=1).. P(i,t)=l=P_n_me(i);
min_P(i,t).. P(i,t)-SPIN_d(i,t)=g=P_min(i)*II(i,t);


step_bidding_1(i,t)..          P(i,t)=e=II(i,t)*P_min(i)+sum(b$(ord(b)>1),P_s(i,b,t));
step_bidding_2(i,b,t)$(ord(b)>1)..   P_s(i,b,t)=l=P_s_max(i,b,t);
R_bidding_1(i,b,t)..                 R_u_s(i,b,t)=l=R_s_max(i,b,t);
R_bidding_2(i,b,t)..                 R_d_s(i,b,t)=l=R_s_max(i,b,t);
R_bidding_3(i,t)..                 SPIN_u(i,t)=e=sum(b,R_u_s(i,b,t));
R_bidding_4(i,t)..                 SPIN_d(i,t)=e=sum(b,R_d_s(i,b,t));
Cost_P(i,b,t)..                 Cost_p_s(i,b,t)=e=P_s(i,b,t)*Cost_gen(i,b,t);
Cost_R_u(i,b,t)..               Cost_R_u_s(i,b,t)=e=R_u_s(i,b,t)*Cost_SPIN(i,b,t);
Cost_R_d(i,b,t)..               Cost_R_d_s(i,b,t)=e=R_d_s(i,b,t)*Cost_SPIN(i,b,t);
Cost_delta_pd(i,b,t)..         Cost_delta_pd_s(i,b,t)=e=delta_pd_s(i,b,t)*alfa(i,b,t);
step_shed_1(i,b,t)..        delta_pd_s(i,b,t)=l=D_B_max(i,b,t);
step_shed_2(i,t)..          delta_pd(i,t)=e=sum(b,delta_pd_s(i,b,t));

R_su(i,t)..               SPIN_u(i,t)=l=SPIN_max(i);
R_sd(i,t)..                SPIN_d(i,t)=l=SPIN_max(i);
SPIN_1(i,t)..              SPIN_u(i,t)=l=P(i,t);
SPIN_2(i,t)..              SPIN_d(i,t)=l=P(i,t);
SPIN_3(i,t)$(delta_m=1)..  RSPIN_m(i,t)=l=P(i,t);

RR_ini_1(i,t)$((ord(t)=1) and (ord(i)<>gen_m))..      P(i,t)-P_ini(i)=l=UR(i);
RR_ini_2(i,t)$((ord(t)=1) and (ord(i)<>gen_m))..      P_ini(i)-P(i,t)=l=DR(i);
RR_ini_3(i,t)$((ord(t)=1) and (ord(i)<>gen_m))..      P_delta(i,t)-P_delta_ini(i)=l=UR(i);
RR_ini_4(i,t)$((ord(t)=1) and (ord(i)<>gen_m))..      P_delta_ini(i)-P_delta(i,t)=l=DR(i);
RR_1(i,t)$((ord(t)>1) and (ord(i)<>gen_m))..                P(i,t)-P(i,t-1)=l=UR(i);
RR_2(i,t)$((ord(t)>1) and (ord(i)<>gen_m))..                P(i,t-1)-P(i,t)=l=DR(i);
RR_3(i,t)$((ord(t)>1) and (ord(i)<>gen_m))..                 P_delta(i,t)-P_delta(i,t-1)=l=UR(i);
RR_4(i,t)$((ord(t)>1) and (ord(i)<>gen_m))..                 P_delta(i,t-1)-P_delta(i,t)=l=DR(i);



BB(i,t)$((ord(t)>1)and (ord(i)<>gen_m))..       Y(i,t)-Z(i,t)=e=II(i,t)-II(i,t-1);

BB_3(i,t)$((ord(t)>1)and (ord(i)<>gen_m))..                  Y(i,t)+Z(i,t)=l=1;

UT_1(i)$(ord(i)<>gen_m)..                                                    sum(k$(ord(k)<=F(i)),1-II(i,k))=e=0;
UT_2(i,k)$((ord(k)>=F(i)+1)and(ord(k)<=24-UT(i)+1)and (ord(i)<>gen_m))..        sum(j$((ord(j)>=ord(k))and(ord(j)<=ord(k)+UT(i)-1)),II(i,j))=g=(UT(i)*Y(i,k));
UT_3(i,k)$((ord(k)>=24-UT(i)+2)and(ord(k)<=24)and (ord(i)<>gen_m))..            sum(j$((ord(j)>=ord(k))and(ord(j)<=24)),II(i,j)-Y(i,k))=g=0;
DT_1(i)$(ord(i)<>gen_m)..                                                    sum(k$(ord(k)<=L(i)),II(i,k))=e=0;
DT_2(i,k)$((ord(k)>=L(i)+1)and(ord(k)<=24-DT(i)+1)and (ord(i)<>gen_m))..        sum(j$((ord(j)>=ord(k))and(ord(j)<=ord(k)+DT(i)-1)),1-II(i,j))=g=(DT(i)*Z(i,k));
DT_3(i,k)$((ord(k)>=24-DT(i)+2)and(ord(k)<=24)and (ord(i)<>gen_m))..            sum(j$((ord(j)>=ord(k))and(ord(j)<=24)),1-II(i,j)-Z(i,k))=g=0;



Contingency_1(i,t)$((delta_m=1) and (ord(i)=gen_m))..     P(i,t)=e=0;


P_deltam_1(t)..           sum(i,P(i,t))=g=PD(t)-sum(i,delta_pd(i,t));
P_deltam_3(t)..              sum(i,P_delta(i,t))=g=PD(t)+0.01*PD(t)-sum(i,delta_pd(i,t));

P_deltam_2(i,t)..             P_delta(i,t)=e=P(i,t)+RSPIN_m(i,t);

P_deltam_RR1(i,t)$((ord(t)>1) and (ord(i)<>gen_m))..      P_delta(i,t)-P_delta(i,t-1)=l=UR(i);

P_deltam_RR2(i,t)$((ord(t)>1) and (ord(i)<>gen_m))..      P_delta(i,t-1)-P_delta(i,t)=l=DR(i);

RSPIN_delta_1(i,t)..                     -SPIN_d(i,t)=l=RSPIN_m(i,t);
RSPIN_delta_2(i,t)..                       RSPIN_m(i,t)=l=SPIN_u(i,t);

d_pd_1(i,t)..   delta_pd(i,t)=g=-P_delta(i,t)+D_B(i,t)+sum(jj$(ord(jj)<>ord(i)),(delta(i,t)-delta(jj,t))*Xbus(i,jj));
d_pd_2(i,t)..   delta_pd(i,t)=l=D_B(i,t);
d_pd_3(i,t)..    delta(i,t)=l=1;
d_pd_4(i,t)..      delta(i,t)=g=-1;


DCL_C_1(i,jj,t)$((ord(i)<>ord(jj)))..        Pl(i,jj,t)=e=Xbus(i,jj)*(delta(i,t)-delta(jj,t));


flow_C_1(i,jj,t)$((ord(i)<>ord(jj)))..                      Pl(i,jj,t)=l=load_f_u(i,jj,t);
flow_C_2(i,jj,t)$((ord(i)<>ord(jj)))..                      Pl(i,jj,t)=g=load_f_d(i,jj,t);


model Contingency /all/;
solve Contingency using mip minimizing objout;



$if exist matdata.gms $include matdata.gms

$libinclude matout P.l i t

$libinclude matout  objout.l
$libinclude matout  II.l i t
*$libinclude matout delta.l i t
*$libinclude matout Pl.l i jj t
*$libinclude matout Y.l i t
*$libinclude matout Z.l i t
*$libinclude matout P_ini i
*$libinclude matout PD  t
*$libinclude matout DR i
*$libinclude matout P_delta.l i t
$libinclude matout RSPIN_m.l i t

*$libinclude matout RTMNR_m.l i t
*$libinclude matout RTMSR_m.l i t
$libinclude matout SPIN_u.l i t
$libinclude matout SPIN_d.l i t
$libinclude matout delta_pd.l i t
$libinclude matout pl.l i jj t
*$libinclude matout alfa i t
$libinclude matout P_delta.l i t
*$libinclude matout pl_prp.l i jj t
*$libinclude matout pl_prn.l i jj t
*$libinclude matout delta_pd_2.l i t
