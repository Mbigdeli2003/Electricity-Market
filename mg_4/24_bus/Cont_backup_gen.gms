$setglobal o 1
$setglobal bus_n 24
*$onempty
*$include matglobs.gms



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
G_E_b(i,kk)            table_Generating Data /1 .1 0/
G_F(i,ll)            table fule /1 .1 0/
Line(t,ll)           table Line /%o% .1 0/
Cost_gen(i,b,t)      table biding/1 .1 .%o% 0/
P_s_max(i,b,t)        P max steps/1 .1 .%o% 0/
D_B_max(i,b,t)        demand max steps/1 .1 .%o% 0/
R(i,ll)              table Reserve /1 .1 0/
RS(i)                start up ans shut down ramp rate/1 0/
S_Cost(i,t)         table start up shut down/1 .%o% 0/
PD_b(t)               table Demand for reserve/%o% 0/
PD(t)               table Demand/%o% 0/
D_B_b(i,t)            Demand buses active power/1 .%o% 0/
P_n(i,t)            real power in normal schedule/1 .%o% 0/
Xbus(i,jj)           matrix X for dc power flow/1 .1 0/
Cost_SPIN(i,b,t)      spin reserve $/1 .1 .%o% 0/
R_s_max(i,b,t)      spin reserve $/1 .1 .%o% 0/
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
delta_m             delta contingency/0/
load_f_u(i,jj,t)    line capacity/1 .1 .%o% 0/
load_f_d(i,jj,t)    line capacity/1 .1 .%o% 0/
P_ini(i)            initial P/1 0/
P_delta_ini(i)      initial P_delta/1 0/
alfa(i,b,t)         shedding cost/1 .1 .%o% 0/
delta_pd_1(i,t)     shedding amount/1 .%o% 0/
B_delta_m(t)        load imblanace
P_max(i)            max power
P_min(i)            min power
R_max(i)         max SPIN
*TMSR_max(i)         max TMSR
*TMNR_max(i)         max TMNR
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
P_max(i)=G_E_b(i,'2');
P_min(i)=G_E_b(i,'3');
R_max(i)=R(i,'2');
*TMSR_max(i)=R(i,'4');
*TMNR_max(i)=R(i,'6');
F(i)=(UT(i)-U_0(i))*I_0(i);
F(i)$(F(i)<0)=0;
L(i)=(DT(i)-D_0(i))*(1-I_0(i));
L(i)$(L(i)<0)=0;


variables
W              objective
Pl(i,jj,t)          Line
delta(i,t)     angle in time t for bus i
SPIN_d(i,t)    MW spinning reserve down
R_m(i,t)       SPINm contingency
*Pl_pr(i,jj,t)  Pl_congestion
positive variables
P(i,t)         active power
P_s(i,b,t)   active power steps
R_u_s(i,b,t)  steps upward reserve
R_d_s(i,b,t)  steps_downward reserve
Cost_p_s(i,b,t)   power steps Cost
Cost_R_u_s(i,b,t) upward reserve cost
Cost_R_d_s(i,b,t)    downward reserve Cost
Cost_delta_pd_s(i,b,t) shedding cost
delta_pd_s(i,b,t)   shed steps
R_u(i,t)    MW spinning reserve up
R_d(i,t)    MW spinning reserve down
RU_sys(t)      system ramp up rate
RD_sys(t)      system ramp down rate
delta_pd_2(i,t) load shedding
P_delta(i,t)    Resereve+p


binary variables
Y(i,t) unit startup indicator
Z(i,t) unit shutdown indicator
II(i,t) commitment state fo unit i
ZZ(i,t) extra variable;




Equations
Cost           cost function

P_D_1(t)         Load-geneartion balance
P_D_2(t)       load-generation+reserve
P_D_3(i,t)        P_delta
PP_1(i,t)     load bus gen=0
II_C(i,t)        Cons
Y_C(i,t)         Cons
Z_C(i,t)         Cons
max_P_1(i,t)     maximum generation of unit not contingency
max_P_2(i,t)     maximum generation of unit in contingency
max_p_3(i,t)     no rserve for generation
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
R_tu(i,t)      R_tmsr max
R_td(i,t)      R_tmsr max
*R_TMNR(i,t)      R_TMNR max

RR_ini_1(i,t)  initial ramp-up check
RR_ini_2(i,t)   initial ramp down check
RR_ini_3(i,t)   initial ramp down check
RR_ini_4(i,t)   initial ramp down check
RR_1(i,t)      ramp rate_1
RR_2(i,t)      ramp_rate_2
RR_3(i,t)       ramp
RR_4(i,t)           ramp
*d_pd_2(i,t)      demand saturation

RR_sys_1(t) sys ramp_1
RR_sys_2(t) sys_ramp_2
RR_sys_3(t) sys_ramp_3
RR_sys_4(t) sys_ramp_4
RR_ZZ_1(i,t) sys_ramp_5
RR_ZZ_2(i,t) sys_ramp_6


BB(i,t)      BB state

BB_3(i,t)      BB state

UT_1(i)        uptime_1
UT_2(i,k)      uptime_2
UT_3(i,k)      uptime_3

DT_1(i)        downtime_1
DT_2(i,k)      downtime_2
DT_3(i,k)      downtime_3

DCL_C_1(i,jj,t)     Load flow_1
d_pd_1(i,t)
d_pd_2(i,t)
delta_1(i,t)   delta cons
delta_2(i,t)  delta  cons

flow_C_1(i,jj,t)  check
flow_C_2(i,jj,t)  check;



Cost..     W=e=sum(i,sum(t,Cost_gen(i,'1',t)*P_min(i)*II(i,t)+Y(i,t)*SU(i,t)+Z(i,t)*SD(i,t)))+sum(i,sum(b$(ord(b)>1),sum(t,cost_gen(i,b,t)*P_s(i,b,t))))+sum(i,sum(b,sum(t,alfa(i,b,t)*delta_pd_s(i,b,t)+Cost_SPIN(i,b,t)*R_d_s(i,b,t)+Cost_SPIN(i,b,t)*R_u_s(i,b,t))));


P_D_1(t)..                     sum(i,P(i,t))=g=PD(t)-sum(i,delta_pd_2(i,t));
P_D_2(t)..                   sum(i,P_delta(i,t))=g=PD_b(t)-sum(i,delta_pd_2(i,t));
P_D_3(i,t)..                    P_delta(i,t)=e=P(i,t)+R_m(i,t);
PP_1(i,t)$(P_max(i)=0)..      P(i,t)=e=0;
II_C(i,t)$(P_max(i)=0)..      II(i,t)=e=0;
Y_C(i,t)$(P_max(i)=0)..       Y(i,t)=e=0;
Z_C(i,t)$(P_max(i)=0)..       Z(i,t) =e=0;
max_P_1(i,t)$(ord(i)<>gen_m).. P(i,t)+R_u(i,t)=l=P_max(i)*II(i,t);
max_P_2(i,t)$(ord(i)=gen_m).. P(i,t)+R_u(i,t)=l=P_n(i,t);
max_P_3(i,t)$(ord(i)=gen_m).. R_m(i,t)=e=0;
min_P(i,t).. P(i,t)-R_d(i,t)=g=P_min(i)*II(i,t);

step_bidding_1(i,t)..          P(i,t)=e=II(i,t)*P_min(i)+sum(b$(ord(b)>1),P_s(i,b,t));
step_bidding_2(i,b,t)$(ord(b)>1)..   P_s(i,b,t)=l=P_s_max(i,b,t);
R_bidding_1(i,b,t)..                 R_u_s(i,b,t)=l=R_s_max(i,b,t);
R_bidding_2(i,b,t)..                 R_d_s(i,b,t)=l=R_s_max(i,b,t);
R_bidding_3(i,t)..                 R_u(i,t)=e=sum(b,R_u_s(i,b,t));
R_bidding_4(i,t)..                 R_d(i,t)=e=sum(b,R_d_s(i,b,t));
Cost_P(i,b,t)..                 Cost_p_s(i,b,t)=e=P_s(i,b,t)*Cost_gen(i,b,t);
Cost_R_u(i,b,t)..               Cost_R_u_s(i,b,t)=e=R_u_s(i,b,t)*Cost_SPIN(i,b,t);
Cost_R_d(i,b,t)..               Cost_R_d_s(i,b,t)=e=R_d_s(i,b,t)*Cost_SPIN(i,b,t);
Cost_delta_pd(i,b,t)..         Cost_delta_pd_s(i,b,t)=e=delta_pd_s(i,b,t)*alfa(i,b,t);
step_shed_1(i,b,t)..        delta_pd_s(i,b,t)=l=D_B_max(i,b,t);
step_shed_2(i,t)..          delta_pd_2(i,t)=e=sum(b,delta_pd_s(i,b,t));

R_su(i,t)..               R_u(i,t)=l=R_max(i);
R_sd(i,t)..                R_d(i,t)=l=R_max(i);
SPIN_1(i,t)..              R_u(i,t)=l=P(i,t);
SPIN_2(i,t)..              R_d(i,t)=l=P(i,t);
SPIN_3(i,t)$(delta_m=1)..  R_m(i,t)=l=P(i,t);
R_tu(i,t)..       R_m(i,t)=l=R_u(i,t);
R_td(i,t)..       R_m(i,t)=g=-R_d(i,t);

RR_ini_1(i,t)$(ord(t)=1)..      P(i,t)-P_ini(i)=l=UR(i);
RR_ini_2(i,t)$(ord(t)=1)..      P_ini(i)-P(i,t)=l=DR(i);
RR_ini_3(i,t)$(ord(t)=1)..      P_delta(i,t)-P_delta_ini(i)=l=UR(i);
RR_ini_4(i,t)$(ord(t)=1)..      P_delta_ini(i)-P_delta(i,t)=l=DR(i);
RR_1(i,t)$(ord(t)>1)..                P(i,t)-P(i,t-1)=l=UR(i);
RR_2(i,t)$(ord(t)>1)..                P(i,t-1)-P(i,t)=l=DR(i);
RR_3(i,t)$(ord(t)>1)..                 P_delta(i,t)-P_delta(i,t-1)=l=UR(i);
RR_4(i,t)$(ord(t)>1)..                 P_delta(i,t-1)-P_delta(i,t)=l=DR(i);

RR_sys_1(t)$(ord(t)>1)..      RU_sys(t)=e=sum(i,(UR(i)+P_min(i)-RS(i))*ZZ(i,t)+RS(i)*II(i,t)-P_min(i)*II(i,t-1));
RR_sys_2(t)$(ord(t)>1)..      RU_sys(t)=g=PD_b(t)-PD_b(t-1);
RR_sys_3(t)$(ord(t)>1)..      RD_sys(t)=e=sum(i,(DR(i)+P_min(i)-RS(i))*ZZ(i,t)+RS(i)*II(i,t-1)-P_min(i)*II(i,t));
RR_sys_4(t)$(ord(t)>1)..      RD_sys(t)=g=PD_b(t-1)-PD_b(t);
RR_ZZ_1(i,t)$(ord(t)>1)..     ZZ(i,t)=l=(II(i,t-1)+II(i,t)+II(i,t+1))/3;
RR_ZZ_2(i,t)$(ord(t)>1)..     ZZ(i,t)=g=(II(i,t-1)+II(i,t)+II(i,t+1)-2)/3;
BB(i,t)$(ord(t)>1)..       Y(i,t)-Z(i,t)=e=II(i,t)-II(i,t-1);

BB_3(i,t)$(ord(t)>1)..                  Y(i,t)+Z(i,t)=l=1;

UT_1(i)..                                                    sum(k$(ord(k)<=F(i)),1-II(i,k))=e=0;
UT_2(i,k)$((ord(k)>=F(i)+1)and(ord(k)<=24-UT(i)+1))..        sum(j$((ord(j)>=ord(k))and(ord(j)<=ord(k)+UT(i)-1)),II(i,j))=g=(UT(i)*Y(i,k));
UT_3(i,k)$((ord(k)>=24-UT(i)+2)and(ord(k)<=24))..            sum(j$((ord(j)>=ord(k))and(ord(j)<=24)),II(i,j)-Y(i,k))=g=0;
DT_1(i)..                                                    sum(k$(ord(k)<=L(i)),II(i,k))=e=0;
DT_2(i,k)$((ord(k)>=L(i)+1)and(ord(k)<=24-DT(i)+1))..        sum(j$((ord(j)>=ord(k))and(ord(j)<=ord(k)+DT(i)-1)),1-II(i,j))=g=(DT(i)*Z(i,k));
DT_3(i,k)$((ord(k)>=24-DT(i)+2)and(ord(k)<=24))..            sum(j$((ord(j)>=ord(k))and(ord(j)<=24)),1-II(i,j)-Z(i,k))=g=0;


d_pd_1(i,t)..   delta_pd_2(i,t)=g=-P_delta(i,t)+D_B_b(i,t)+sum(jj$(ord(jj)<>ord(i)),(delta(i,t)-delta(jj,t))*Xbus(i,jj));
*d_pd_2(i,t)$(delta_m=1)..   delta_pd_2(i,t)=e=P_delta(i,t)-D_B(i,t)-sum(jj$(ord(jj)<>ord(i)),(delta(i,t)-delta(jj,t))*Xbus(i,jj));
d_pd_2(i,t)..     delta_pd_2(i,t)=l=D_B_b(i,t);
delta_1(i,t)..    delta(i,t)=l=1;
delta_2(i,t)..      delta(i,t)=g=-1;
DCL_C_1(i,jj,t)$((ord(i)<>ord(jj)))..        Pl(i,jj,t)=e=Xbus(i,jj)*(delta(i,t)-delta(jj,t));
flow_c_1(i,jj,t)$(ord(i)<>ord(jj))..                      Pl(i,jj,t)=l=load_f_u(i,jj,t);
flow_c_2(i,jj,t)$(ord(i)<>ord(jj))..                      Pl(i,jj,t)=g=load_f_d(i,jj,t);





model Cont_back_up /all/;
solve Cont_back_up using mip minimizing W;




$if exist matdata.gms $include matdata.gms

$libinclude matout P.l i t


$libinclude matout  W.l
$libinclude matout  II.l i t
*$libinclude matout delta.l i t
*$libinclude matout Y.l i t i
*$libinclude matout Z.l i t
*$libinclude matout pl_p.l i jj t
*$libinclude matout DR i
*$libinclude matout ZZ.l i t
*$libinclude matout UT i
*$libinclude matout DT i
*$libinclude matout PD  t
*$libinclude matout DR.l i
*$libinclude matout P_delta.l i t
$libinclude matout R_u.l i t
$libinclude matout R_d.l i t
$libinclude matout R_m.l i t
$libinclude matout delta_pd_2.l i t
$libinclude matout Pl.l i jj t
$libinclude matout P_delta.l i t
*$libinclude matout pl_pr.l i jj t
*$libinclude matout pl_prp.l i jj t
*$libinclude matout pl_prn.l i jj t
*$libinclude matout RTMNR_m.l i t
*$libinclude matout RTMSR_m.l i t
*$libinclude matout SPIN_u.l i t
*$libinclude matout SPIN_d.l i t
