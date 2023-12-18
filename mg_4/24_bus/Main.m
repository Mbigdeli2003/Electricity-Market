%% 24 bus data Contingency-costrained
clc
clear all
close all
Sb=100

%% Generator Energy Biding Data
%    Bus.No  Pmax     Pmin    Qmax     Qmin     Ini   Min.on   Minoff   Ramp
G_E=[1       200      50     80       -60       -2     2        -4        55;
     2       200      20      80       -60       2     4        -3       20;
     3        0       0       0         0        1     1         -1        0;
     4        0       0       0         0        1     1         -1        0;
     5        0       0       0         0        1     1         -1        0;
     6        0       0       0         0        1     1         -1        0;
     7       250      30      180       0       -4     2        -3         30;
     8       0        0       0         0        1     1         -1        0;
     9       0        0       0         0        1     1         -1        0;
     10      0        0       0         0        1     1         -1        0;
     11      0        0       0         0        1     1         -1        0;
     12      0        0       0         0        1     1         -1        0;
     13      280      70     240       0        3     4        -2         80;
     14      10       5       200      -50       2     1        -1       5;
     15      230      40     110      -50      -3     3        -2       45;
     16      180      30      80       -50       5     2        -4       35;
     17      0        0       0         0        1     1         -1        0;
     18      250      80     200      -50       2     5        -4       95;
     19      0        0       0         0        1     1         0        0;
     20      0        0       0         0        1     1         0        0;
     21      250      50     200      -50       3     5        -6       70;
     22      300      80       90      -60      -2    3        -5       90;
     23      200      70      310     -125      -2     2        -2       80;
     24      0        0         0       0        1     1         -1        0];
 clear init D_0 U_0 I_0
  for i=1:max(size(G_E))
     if G_E(i,3)-G_E(i,end)>0
         G_E(i,3)=G_E(i,end);
     end
 end
 
 init=G_E(:,6);
 % start up and shut down  ramp rate 1.5*Pmin 
  RS=3*(G_E(:,end));
%  for i=1:max(size(G_E))
%      UR(i)=min((G_E(i,2)-G_E(i,3)),G_E(i,end));
%      DR(i)=UR(i);
%  end
UR=G_E(:,end);
DR=G_E(:,end);
 for k=1:max(size(init))
 if init(k)<0    
 I_0(k)=0;
 end
 if init(k)>0
  I_0(k)=1;
 end
 end
 %% 
 for p=1:max(size(init))
  if init(p)>0    
 U_0(p)=init(p);
  else
      U_0(p)=0;
  end
  if init(p)<0
      D_0(p)=init(p);
  else 
      D_0(p)=0;
  end
 end
 D_0=abs(D_0);
 UT=G_E(:,7);
 DT=abs(G_E(:,8));
 
 for i=1:max(size(G_E))
     if init(i)>0
         P_ini(i)=G_E(i,3);
     else
         P_ini(i)=0;
     end
 end
RS=RS/Sb;
 
 
%  Cost_gen=[13 12 14 13 11 13 12 13 14 11 11;
%            12 10 11 12 12 11 10 13 12 10 11;
%            12 11 11 10 10 13 12 11 10 12 10;
%            10 12 11 10 11 12 11 10 11 13 12;
%            13 14 12 12 14 15 12 13 11 12 13;
%            14 11 12 13 14 13 13 12 14 14 15;
%            13 14 11 13 14 12 13 15 14 13 11;
%            15 14 16 14 11 13 15 12 16 14 15;
%            12 13 12 11 14 12 11 13 14 12 13;
%            14 16 15 13 17 14 13 12 12 11 12;
%            15 13 16 16 14 13 14 15 14 14 13;
%            17 15 16 14 14 15 14 16 13 17 16;
%            11 12 13 12 14 13 12 12 11 15 11;
%            14 13 12 14 15 13 14 15 13 12 13;
%            14 13 15 14 13 14 15 13 14 11 12;
%            16 17 16 18 19 17 18 18 19 17 16;
%            22 21 20 23 20 21 21 22 23 22 20;
%            20 23 24 25 24 22 23 23 21 24 23;
%            24 26 25 27 22 24 23 25 26 24 24;
%            27 26 25 24 26 27 25 24 23 26 25;
%            28 29 27 26 27 25 28 21 20 24 25;
%            22 23 21 20 22 21 20 20 20 22 19;
%            21 20 19 16 28 21 16 18 19 15 17;
%            14 15 13 12 14 16 12 16 15 12 16;]';
%       


%          1   2  3    4    5   6    7  8    9    10  11   12    13 14 15
%          
% ruye bus hayi ke gen nabud gheimate 1e8 gozashte shodde ast          
%           
% Cost_gen=[ 13 12  1e8  1e8 1e8 1e8   15 1e8  1e8  1e8 1e8  1e8   13 11 13 12 1e8  13  1e8  1e8  14 11 11  1e8 ;
%            12 12  1e8  1e8 1e8 1e8   13 1e8  1e8  1e8 1e8  1e8   12 12 11 10 1e8  13  1e8  1e8  12 10 10  1e8 ;
%            12 13  1e8  1e8 1e8 1e8   7 1e8  1e8  1e8 1e8  1e8   10 10 13 12 1e8  11  1e8  1e8   9  12 8  1e8 ;
%            8 14  1e8  1e8 1e8 1e8   5 1e8  1e8  1e8 1e8  1e8   10 11 12 11 1e8  10  1e8  1e8   11 13 4  1e8 ;
%            7 17  1e8  1e8 1e8 1e8   4 1e8  1e8  1e8 1e8  1e8   12 14 15 8 1e8  13  1e8  1e8    5  12 13  1e8 ;
%            14 15  1e8  1e8 1e8 1e8   6 1e8  1e8  1e8 1e8  1e8   13 14 13 1 1e8  12  1e8  1e8  14 14 15  1e8 ;
%            13 14  1e8  1e8 1e8 1e8   7 1e8  1e8  1e8 1e8  1e8   13 14 12 1 1e8  15  1e8  1e8  14 13 11  1e8 ;
%            15 14  1e8  1e8 1e8 1e8   2 1e8  1e8  1e8 1e8  1e8   14 11 13 1 1e8  12  1e8  1e8  16 14 15  1e8 ;
%            12 16  1e8  1e8 1e8 1e8   5 1e8  1e8  1e8 1e8  1e8   11 14 12 1 1e8  13  1e8  1e8  14 12 13  1e8 ;
%            14 13  1e8  1e8 1e8 1e8   3 1e8  1e8  1e8 1e8  1e8   13 17 14 1 1e8  12  1e8  1e8  12 11 12  1e8 ;
%            15 12  1e8  1e8 1e8 1e8   2 1e8  1e8  1e8 1e8  1e8   16 14 13 1 1e8  15  1e8  1e8  14 14 13  1e8 ;
%            17 17  1e8  1e8 1e8 1e8   6 1e8  1e8  1e8 1e8  1e8   14 14 15 1 1e8  16  1e8  1e8  13 17 16  1e8 ;
%            11 11  1e8  1e8 1e8 1e8   4 1e8  1e8  1e8 1e8  1e8   12 14 13 1 1e8  12  1e8  1e8  11 15 11  1e8 ;
%            14 10  1e8  1e8 1e8 1e8   5 1e8  1e8  1e8 1e8  1e8   14 15 13 14 1e8  15  1e8  1e8  13 12 13  1e8 ;
%            14 13  1e8  1e8 1e8 1e8   1 1e8  1e8  1e8 1e8  1e8   14 13 4 15 1e8  13  1e8  1e8  14 11 12  1e8 ;
%            16 11  1e8  1e8 1e8 1e8   3 1e8  1e8  1e8 1e8  1e8   18 19  7 18 1e8  18  1e8  1e8  19 17 16  1e8 ;
%            22 12  1e8  1e8 1e8 1e8   2  1e8 1e8  1e8  1e8  1e8  23 20 1 21 1e8 22 1e8  1e8  23 22 20  1e8 ;
%            20 12  1e8  1e8 1e8 1e8   4 1e8  1e8  1e8 1e8  1e8   25 24 2 23 1e8  23  1e8  1e8  21 24 23  1e8 ;
%            24 12  1e8  1e8 1e8 1e8   1 1e8  1e8  1e8 1e8  1e8   27 22 4 23 1e8  25  1e8  1e8  26 24 24  1e8 ;
%            27 12  1e8  1e8 1e8 1e8   1 1e8  1e8  1e8 1e8  1e8   24 26 7 25 1e8  24  1e8  1e8  23 26 25  1e8 ;
%            28 12  1e8  1e8 1e8 1e8   1 1e8  1e8  1e8 1e8  1e8   26 27 5 28 1e8  21  1e8  1e8  20 24 25  1e8 ;
%            22 12  1e8  1e8 1e8 1e8   1 1e8  1e8  1e8 1e8  1e8   20 22 1 20 1e8  20  1e8  1e8  20 22 19  1e8 ;
%            21 12  1e8  1e8 1e8 1e8   1 1e8  1e8  1e8 1e8  1e8   16 28 1 16 1e8  18  1e8  1e8  19 15 17  1e8 ;
%            14 11  1e8  1e8 1e8 1e8   1 1e8  1e8  1e8 1e8  1e8   12 14 6 12 1e8  16  1e8  1e8  15 12 16  1e8 ;]';
% 






A1=xlsread('bidding_24.xlsx',1);A2=xlsread('bidding_24.xlsx',2);A3=xlsread('bidding_24.xlsx',3);A4=xlsread('bidding_24.xlsx',4);
A5=xlsread('bidding_24.xlsx',5);A6=xlsread('bidding_24.xlsx',6);A7=xlsread('bidding_24.xlsx',7);A8=xlsread('bidding_24.xlsx',8);
A9=xlsread('bidding_24.xlsx',9);A10=xlsread('bidding_24.xlsx',10);A11=xlsread('bidding_24.xlsx',11);A12=xlsread('bidding_24.xlsx',12);
A13=xlsread('bidding_24.xlsx',13);A14=xlsread('bidding_24.xlsx',14);A15=xlsread('bidding_24.xlsx',15);A16=xlsread('bidding_24.xlsx',16);
A17=xlsread('bidding_24.xlsx',17);A18=xlsread('bidding_24.xlsx',18);A19=xlsread('bidding_24.xlsx',19);A20=xlsread('bidding_24.xlsx',20);
A21=xlsread('bidding_24.xlsx',21);A22=xlsread('bidding_24.xlsx',22);A23=xlsread('bidding_24.xlsx',23);A24=xlsread('bidding_24.xlsx',24);
%% genretor biddnig data clustering in 3 steps
Cost_gen(:,:,1)=[A1(:,3) A1(:,5) A1(:,7)];Cost_gen(:,:,2)=[A2(:,3) A2(:,5) A2(:,7)];Cost_gen(:,:,3)=[A3(:,3) A3(:,5) A3(:,7)];
Cost_gen(:,:,4)=[A4(:,3) A4(:,5) A4(:,7)];Cost_gen(:,:,5)=[A5(:,3) A5(:,5) A5(:,7)];Cost_gen(:,:,6)=[A6(:,3) A6(:,5) A6(:,7)];
Cost_gen(:,:,7)=[A7(:,3) A7(:,5) A7(:,7)];Cost_gen(:,:,8)=[A8(:,3) A8(:,5) A8(:,7)];Cost_gen(:,:,9)=[A9(:,3) A9(:,5) A9(:,7)];
Cost_gen(:,:,10)=[A10(:,3) A10(:,5) A10(:,7)];Cost_gen(:,:,11)=[A11(:,3) A11(:,5) A11(:,7)];Cost_gen(:,:,12)=[A12(:,3) A12(:,5) A12(:,7)];
Cost_gen(:,:,13)=[A13(:,3) A13(:,5) A13(:,7)];Cost_gen(:,:,14)=[A14(:,3) A14(:,5) A14(:,7)];Cost_gen(:,:,15)=[A15(:,3) A15(:,5) A15(:,7)];
Cost_gen(:,:,16)=[A16(:,3) A16(:,5) A16(:,7)];Cost_gen(:,:,17)=[A17(:,3) A17(:,5) A17(:,7)];Cost_gen(:,:,18)=[A18(:,3) A18(:,5) A18(:,7)];
Cost_gen(:,:,19)=[A19(:,3) A19(:,5) A19(:,7)];Cost_gen(:,:,20)=[A20(:,3) A20(:,5) A20(:,7)];Cost_gen(:,:,21)=[A21(:,3) A21(:,5) A21(:,7)];
Cost_gen(:,:,22)=[A22(:,3) A22(:,5) A22(:,7)];Cost_gen(:,:,23)=[A23(:,3) A23(:,5) A23(:,7)];Cost_gen(:,:,24)=[A24(:,3) A24(:,5) A24(:,7)]; 
%% P_max for each bid b (3 steps)
P_s_max(:,:,1)=[A1(:,4) A1(:,6) A1(:,8)];P_s_max(:,:,2)=[A2(:,4) A2(:,6) A2(:,8)];P_s_max(:,:,3)=[A3(:,4) A3(:,6) A3(:,8)];
P_s_max(:,:,4)=[A4(:,4) A4(:,6) A4(:,8)];P_s_max(:,:,5)=[A5(:,4) A5(:,6) A5(:,8)];P_s_max(:,:,6)=[A6(:,4) A6(:,6) A6(:,8)];
P_s_max(:,:,7)=[A7(:,4) A7(:,6) A7(:,8)];P_s_max(:,:,8)=[A8(:,4) A8(:,6) A8(:,8)];P_s_max(:,:,9)=[A9(:,4) A9(:,6) A9(:,8)];
P_s_max(:,:,10)=[A10(:,4) A10(:,6) A10(:,8)];P_s_max(:,:,11)=[A11(:,4) A11(:,6) A11(:,8)];P_s_max(:,:,12)=[A12(:,4) A12(:,6) A12(:,8)];
P_s_max(:,:,13)=[A13(:,4) A13(:,6) A13(:,8)];P_s_max(:,:,14)=[A14(:,4) A14(:,6) A14(:,8)];P_s_max(:,:,15)=[A15(:,4) A15(:,6) A15(:,8)];
P_s_max(:,:,16)=[A16(:,4) A16(:,6) A16(:,8)];P_s_max(:,:,17)=[A17(:,4) A17(:,6) A17(:,8)];P_s_max(:,:,18)=[A18(:,4) A18(:,6) A18(:,8)];
P_s_max(:,:,19)=[A19(:,4) A19(:,6) A19(:,8)];P_s_max(:,:,20)=[A20(:,4) A20(:,6) A20(:,8)];P_s_max(:,:,21)=[A21(:,4) A21(:,6) A21(:,8)];
P_s_max(:,:,22)=[A22(:,4) A22(:,6) A22(:,8)];P_s_max(:,:,23)=[A23(:,4) A23(:,6) A23(:,8)];P_s_max(:,:,24)=[A24(:,4) A24(:,6) A24(:,8)];
%% Generator Energy Biding Data Fuel
 % a=MBtu b=Mbtu/MWh c=Mbtu/Mw^2h SUf=Mbtu Fuel price=$/MBtu
 %% reserve bidding
 B1=xlsread('bidding_24_reserve.xlsx',1);B2=xlsread('bidding_24_reserve.xlsx',2);B3=xlsread('bidding_24_reserve.xlsx',3);
 B4=xlsread('bidding_24_reserve.xlsx',4);B5=xlsread('bidding_24_reserve.xlsx',5);B6=xlsread('bidding_24_reserve.xlsx',6);
 B7=xlsread('bidding_24_reserve.xlsx',7);B8=xlsread('bidding_24_reserve.xlsx',8);B9=xlsread('bidding_24_reserve.xlsx',9);
 B10=xlsread('bidding_24_reserve.xlsx',10);B11=xlsread('bidding_24_reserve.xlsx',11);B12=xlsread('bidding_24_reserve.xlsx',12);
B13=xlsread('bidding_24_reserve.xlsx',13);B14=xlsread('bidding_24_reserve.xlsx',14);B15=xlsread('bidding_24_reserve.xlsx',15);
B16=xlsread('bidding_24_reserve.xlsx',16);B17=xlsread('bidding_24_reserve.xlsx',17);B18=xlsread('bidding_24_reserve.xlsx',18);
B19=xlsread('bidding_24_reserve.xlsx',19);B20=xlsread('bidding_24_reserve.xlsx',20);B21=xlsread('bidding_24_reserve.xlsx',21);
B22=xlsread('bidding_24_reserve.xlsx',22);B23=xlsread('bidding_24_reserve.xlsx',23);B24=xlsread('bidding_24_reserve.xlsx',24);
%% Reserve biddnig in 3 steps
 Cost_SPIN(:,:,1)=[B1(:,2) B1(:,4) B1(:,6)];Cost_SPIN(:,:,2)=[B2(:,2) B2(:,4) B2(:,6)];Cost_SPIN(:,:,3)=[B3(:,2) B3(:,4) B3(:,6)];
 Cost_SPIN(:,:,4)=[B4(:,2) B4(:,4) B4(:,6)];Cost_SPIN(:,:,5)=[B5(:,2) B5(:,4) B5(:,6)];Cost_SPIN(:,:,6)=[B6(:,2) B6(:,4) B6(:,6)];
 Cost_SPIN(:,:,7)=[B7(:,2) B7(:,4) B7(:,6)];Cost_SPIN(:,:,8)=[B8(:,2) B8(:,4) B8(:,6)];Cost_SPIN(:,:,9)=[B9(:,2) B9(:,4) B9(:,6)];
 Cost_SPIN(:,:,10)=[B10(:,2) B10(:,4) B10(:,6)];Cost_SPIN(:,:,11)=[B11(:,2) B11(:,4) B11(:,6)];Cost_SPIN(:,:,12)=[B12(:,2) B12(:,4) B12(:,6)];
Cost_SPIN(:,:,13)=[B13(:,2) B13(:,4) B13(:,6)];Cost_SPIN(:,:,14)=[B14(:,2) B14(:,4) B14(:,6)];Cost_SPIN(:,:,15)=[B15(:,2) B15(:,4) B15(:,6)]; 
Cost_SPIN(:,:,16)=[B16(:,2) B16(:,4) B16(:,6)];Cost_SPIN(:,:,17)=[B17(:,2) B17(:,4) B17(:,6)];Cost_SPIN(:,:,18)=[B18(:,2) B18(:,4) B18(:,6)]; 
Cost_SPIN(:,:,19)=[B19(:,2) B19(:,4) B19(:,6)];Cost_SPIN(:,:,20)=[B20(:,2) B20(:,4) B20(:,6)];Cost_SPIN(:,:,21)=[B21(:,2) B21(:,4) B21(:,6)]; 
Cost_SPIN(:,:,22)=[B22(:,2) B22(:,4) B22(:,6)];Cost_SPIN(:,:,23)=[B23(:,2) B23(:,4) B23(:,6)];Cost_SPIN(:,:,24)=[B24(:,2) B24(:,4) B24(:,6)];
%% R_max for each reserve steps (3 steps)
R_s_max(:,:,1)=[B1(:,3) B1(:,5) B1(:,7)];R_s_max(:,:,2)=[B2(:,3) B2(:,5) B2(:,7)];R_s_max(:,:,3)=[B3(:,3) B3(:,5) B3(:,7)];
R_s_max(:,:,4)=[B4(:,3) B4(:,5) B4(:,7)];R_s_max(:,:,5)=[B5(:,3) B5(:,5) B5(:,7)];R_s_max(:,:,6)=[B6(:,3) B6(:,5) B6(:,7)];
R_s_max(:,:,7)=[B7(:,3) B7(:,5) B7(:,7)];R_s_max(:,:,8)=[B8(:,3) B8(:,5) B8(:,7)];R_s_max(:,:,9)=[B9(:,3) B9(:,5) B9(:,7)];
R_s_max(:,:,10)=[B10(:,3) B10(:,5) B10(:,7)];R_s_max(:,:,11)=[B11(:,3) B11(:,5) B11(:,7)];R_s_max(:,:,12)=[B12(:,3) B12(:,5) B12(:,7)];
R_s_max(:,:,13)=[B13(:,3) B13(:,5) B13(:,7)];R_s_max(:,:,14)=[B14(:,3) B14(:,5) B14(:,7)];R_s_max(:,:,15)=[B15(:,3) B15(:,5) B15(:,7)];
R_s_max(:,:,16)=[B16(:,3) B16(:,5) B16(:,7)];R_s_max(:,:,17)=[B17(:,3) B17(:,5) B17(:,7)];R_s_max(:,:,18)=[B18(:,3) B18(:,5) B18(:,7)];
R_s_max(:,:,19)=[B19(:,3) B19(:,5) B19(:,7)];R_s_max(:,:,20)=[B20(:,3) B20(:,5) B20(:,7)];R_s_max(:,:,21)=[B21(:,3) B21(:,5) B21(:,7)];
R_s_max(:,:,22)=[B22(:,3) B22(:,5) B22(:,7)];R_s_max(:,:,23)=[B23(:,3) B23(:,5) B23(:,7)];R_s_max(:,:,24)=[B24(:,3) B24(:,5) B24(:,7)];


%    a        b        c          SUf     SUD        fuel price       Ems
%  G_F=[176.9    13.5     0.0004     100     100              1.2469       0.2;
%       129.9    40.6     0.001      300     300              1.2461       0.2;
%       137.4    17.6     0.005      0       0              1.2462       0.2;
%       138      15       0.0003     50      50              1.3         0.2; 
%       120.1    52.3     0.0004     50      50               1.4        0.2;
%       113.7    17.1     0.002      120     120              1.1        0.2;
%       170.1    18.9     0.005      300     300              1.24       0.2;
%       180.3    17.8     0.007      250     250              1.23       0.2;
%       120.5    19.7     0.009      150     150              1.3        0.2;
%       130.4    20.1     0.008      130     130              1.247      0.2;
%       125.7    22.3     0.0008     140     140              2.1        0.2;];
%       
      
      %% Transmisssion Line Data
      
      


 
       %            From	to	      R	          X	            B     Flow_1_raft  flow_2 
linedata=[  	    1	    2	     0.003        0.014        0.461        200    120    ;
        	        1	    3        0.055        0.211        0.057        100    70 ; 
        	        1       5        0.022        0.085        0.023        90    200    ;
        	        2	    4	     0.033        0.127        0.034        150    220    ;
        	        2	    6        0.05        0.192        0.052         200    150    ;
        	        3	    9        0.031        0.119        0.032        100    120    ;
        	        3       24       0.002        0.084        0            170    140   ;
        	        4	    9        0.027        0.104        0.028        180    170    ;   
                    5       10       0.023        0.088        0.024        220    200    ;
                    6       10       0.014        0.061        2.459        130    160    ;
                    7       8        0.016        0.061        0.017        140    180    ;        
                    8       9        0.043        0.165        0.045        150    190    ;
                    8       10       0.043        0.165  	   0.045        230    250     ;
                    9       11       0.002        0.084        0            170    200     ;
                    9       12       0.002        0.084        0            180    210     ;
                    10      11       0.002        0.084        0            220    100     ;
                    10      12       0.002        0.084        0            130    170     ;
                    11      13       0.006        0.048        0.1          100    120     ;
                    11      14       0.005        0.042        0.088        150    115     ;
                    12      13       0.006        0.048        0.1          130    110     ;
                    12      23       0.012        0.097        0.203        350    300     ;
                    13      23       0.011        0.087        0.182        180    100      ;
                    14      16       0.005        0.059       0.082         300    270     ;
                    15      16       0.002        0.17        0.036         260    300     ;   
                    15      21       0.006        0.049       0.103         250    280        ;
                    15      21       0.006        0.049       0.103         300    270        ;
                    15      24       0.007        0.052       0.109         270    300        ;
                    16      17       0.003        0.026       0.055         180    150        ;
                    16      19       0.003        0.023       0.049         100    50         ;
                    17      18       0.002        0.014       0.03          220    200        ;
                    17      22       0.014        0.105       0.221         350    300        ;
                    18      21       0.003        0.026       0.055         200    250          ;
                    18      21       0.003        0.026       0.055         150    250           ;
                    19      20       0.005        0.04        0.083         30    50         ;
                    19      20       0.005        0.04        0.083         20    30            ;
                    20      23       0.003        0.022       0.046         180    150           ;
                    20      23       0.003        0.022       0.046         80    170           ;
                    21      22       0.009        0.068       0.142         200    250          ;];
     
%    for i=1:max(max(linedata(:,1)),max(linedata(:,2)))
%        for j=i+1:max(max(linedata(:,1)),max(linedata(:,2)))
%        if linedata(i,1)==linedata(j,1)
%            
%         load_f(i,linedata(j,2))=linedata(j,end);
%        else
%            load_f()
%        end
%        end
%    end
nl = linedata(:,1); nr = linedata(:,2); 
L = linedata(:,6); 
a = ones(length(linedata(:,4)));
nbr=length(linedata(:,1)); nbus = max(max(nl), max(nr));
        %branch admittance
for n = 1:nbr
if a(n) <= 0  a(n) = 1; else 
end
load_f=zeros(nbus,nbus);     % initialize Ybus to zero
               % formation of the off diagonal elements
for k=1:nbr;
       load_f(nl(k),nr(k))=load_f(nl(k),nr(k))+L(k)/a(k);
       load_f(nr(k),nl(k))=load_f(nl(k),nr(k));
    end
end

for i=1:max(size(load_f))
    for j=1:max (size(load_f))
        for t=1:24
        load_f_u(i,j,t)=load_f(i,j);
        end
    end
end



nl = linedata(:,1); nr = linedata(:,2); 
L = linedata(:,7); 
a = ones(length(linedata(:,4)));
nbr=length(linedata(:,1)); nbus = max(max(nl), max(nr));
        %branch admittance
for n = 1:nbr
if a(n) <= 0  a(n) = 1; else 
end
load_f=zeros(nbus,nbus);     % initialize Ybus to zero
               % formation of the off diagonal elements
for k=1:nbr;
       load_f(nl(k),nr(k))=load_f(nl(k),nr(k))+L(k)/a(k);
       load_f(nr(k),nl(k))=load_f(nl(k),nr(k));
    end
end

for i=1:max(size(load_f))
    for j=1:max (size(load_f))
        for t=1:24
        load_f_d(i,j,t)=-load_f(i,j);
        end
    end
end








%% Y bus 
    j=sqrt(-1); i = sqrt(-1);
nl = linedata(:,1); nr = linedata(:,2); R = 0*linedata(:,3);
X = linedata(:,4);
Bc = 0*j*linedata(:,5); 
a = ones(length(linedata(:,4)));
nbr=length(linedata(:,1)); nbus = max(max(nl), max(nr));
Z =R+ j*X; y= ones(nbr,1)./Z;        %branch admittance
for n = 1:nbr
if a(n) <= 0  a(n) = 1; else 
end
Ybus=zeros(nbus,nbus);     % initialize Ybus to zero
               % formation of the off diagonal elements
for k=1:nbr;
       Ybus(nl(k),nr(k))=Ybus(nl(k),nr(k))-y(k)/a(k);
       Ybus(nr(k),nl(k))=Ybus(nl(k),nr(k));
    end
end
              % formation of the diagonal elements
for  n=1:nbus
     for k=1:nbr
         if nl(k)==n
         Ybus(n,n) = Ybus(n,n)+y(k)/(a(k)^2) + Bc(k);
         elseif nr(k)==n
         Ybus(n,n) = Ybus(n,n)+y(k) +Bc(k);
         else, end
     end
end
% [Ybus_angle Ybus_abs]=cart2pol(real(Ybus),imag(Ybus));
Xbus=-Ybus/j;    
        
    
%   %     Line.No    From    to   R        X        Flow Limit
%   Line=[1          1       2    0.003    0.170    200;
%         2          1       4    0.0030   0.258    150;
%         3          2       4    0.007    0.197    150;
%         4          5       6    0.002    0.140    100];

    
%   %% TAP Changing Transformer and Phase Shift Data
%   %  From     to      X         Max      Min
%   Tr=[2        3       0.037     0.98     0.95;
%      4        5       0.037     0.98     0.95;
%      3        6       0.018     30       -30;];
 
 %% Generaotor Reserve Biding data
 %  Rspin$     Rspin,Max    Rtmsr$      Rtmsr,max   Rtmnr$          RTmnr,max
 R=[ 1.2          20.2           1.7         18.3          1.1            50;
      1.4         30.1            2          30            1.2            50;
      1e8           0           1e8          0            1e8             0;
      1e8           0           1e8          0            1e8             0;
      1e8           0           1e8          0            1e8             0;
      1e8           0           1e8          0            1e8             0;
      3.05          33          1.8         6.6           1.1             10;
      1e8           0           1e8           0           1e8             0;
      1e8           0           1e8           0           1e8             0;
     1e8            0           1e8           0           1e8             0;
     1e8            0           1e8           0           1e8             0;
     1e8            0           1e8           0           1e8             0;
     5.2            20          1.9           17.8        0.9            75;
     1.7            2.1          2.1           18.8         0.8            60;
     3.2            25           3.2          20           1.3             55;
     6.8           35          3.1         21.2         1.5             45;
     1e8           0            1e8          0           1e8              0;
     1.9           16          2.7           23         1.4              85;
     1e8           0           1e8           0          1e8               0;
     1e8           0           1e8           0          1e8                0;
     5.5           40           2.8         24           1.01              30;
     3.2           60           2.3         15           0.7               35;
     1.4          50            1.8         17           0.8               40;
     1e8           0             1e8         0                1e8          0]; 
 
 
%  R=[3.2          9.2         1.7         18.3          1.1            50;
%     3            15           2          30            1.2            50;
%     2.5          3.3         1.8         6.6           1.1            10;
%     3.2          20          1.9         17.8          0.9            75;
%     2.7          17          2.1         18.8          0.8            60;
%     3.2          4           3.2         20            1.3            55;
%     2.8          3.5         3.1         21.2          1.5            45;
%     2.9          16          2.7         23            1.4            85;
%     3.5          17          2.8         24            1.01           30;
%     3.2          20          2.3         15            0.7            35;
%     2.4          18          1.8         17            0.8            40;];


%% start up and shut down cost
 %      SU       SD
S_Cost=[ 45      42;
         42      40;
         1e8       1e8;
         1e8       1e8;
         1e8       1e8;
         1e8       1e8;
         35          30;
         1e8       1e8;
         1e8       1e8;
        1e8       1e8;
        1e8       1e8;
        1e8       1e8;
        42         48; 
        49         41;
        47         43;
        42         45;
        52         50;
        33         43;
        1e8       1e8;
        1e8       1e8;
        34          35;
         40         32;
         45       55;
         1e8       1e8];
 
 
 
 % S_Cost=[0.5      0.7;
%        0.78      0.75;
%        0.8       0.9;
%        1.2       0.8;
%        0.9       1.1;
%        0.7       0.6;
%        0.82      0.5;
%        0.93      0.72;
%        0.94      0.55;
%        1         0.7;
%        1.5       0.6;];

   
   
   %% Demand
   %demand in each hour(24)
   PD=[450;600;700;900;1100;1250;1800;1900;2000;1700;1600;1550;1400;1300;1200;1150;1500;1400;1900;2000;2100;1600;1100;1000]';
  
         %Bus Number	Active Load (MW)	Reactive Load (MVar)  v0  teta
load_data=[ 1            108                 22;
            2            97                  20;
            3            180                 37;
            4            74                  15;
            5            71                  14;
            6            136                 28;
            7            125                 25;
            8            171                 35;
            9            175                 36;
            10           195                 40;
            11           0                   0;
            12           0                   0;
            13           265                 54;
            14           194                 39;
            15           317                 64;
            16           100                 20;
            17           0                   0;
            18           333                 68;
            19           181                 37;
            20           128                 26;
            21           0                   0;
            22           0                   0;
            23           0                   0;
            24           0                   0;];
%% function MW active load for each bus(24) in each hour(24)
%satr=11 Gen   sutun=saaat n om;
 D_B=load_Demand(load_data,PD);
 
 % motegheyer khuruji az gamz ba hurufe kuchak
%   [g_E,II,P]=gams('Cont'); 

%% Pu and sorting input data to GAMS

 G_E=[G_E(:,1) G_E(:,2)/Sb G_E(:,3)/Sb G_E(:,4)/Sb G_E(:,5)/Sb G_E(:,6) G_E(:,7) G_E(:,8) G_E(:,9)/Sb ];
 Cost_gen=Cost_gen*Sb;
load_f_d=load_f_d/Sb;
load_f_u=load_f_u/Sb;
PD=PD/Sb;
load_data= [load_data(:,1) load_data(:,2)/Sb load_data(:,3)/Sb];
D_B=D_B/Sb;
  
S_Cost=S_Cost*Sb;

   
R=[R(:,1)*Sb (R(:,2)/Sb) R(:,3)*Sb R(:,4)/Sb R(:,5)*Sb R(:,6)/Sb ];  
P_ini=P_ini/Sb;
P_delta_ini=P_ini+0.01*P_ini;


 SU=repmat(S_Cost(1:end,1),1,24);
 SD=repmat(S_Cost(1:end,2),1,24);
%  Cost_SPIN=repmat(R(1:end,1),1,24);
Cost_SPIN=Cost_SPIN*Sb;
 Cost_TMSR=repmat(R(1:end,3),1,24);
 Cost_TMNR=repmat(R(1:end,5),1,24);

P_s_max=P_s_max/Sb;
delta_m=0;
o=num2str(1);
  ALFA=1e9*[25 13 10 16 20 21 30 39 30 26 29 22 24 23 26 29 29 25 50 25 26 27 29 25]'*1e3;
ALFA=repmat(ALFA(1:end,1),1,24);
 [alfa D_B_max]=shedd_pricing(D_B,ALFA);
 alfa=alfa*Sb;
   

UR=UR/Sb;
DR=DR/Sb;
bus_n=max(size(G_E));
b_n=3;
bus_n=num2str(bus_n);
b_n=num2str(b_n);
[P,W,II,delta,Y,Z,P_delta,R_u,R_d,R_m,delta_pd,P_s,Costgen,R_u_s,R_d_s,Cost_P_s,Cost_R_u_s,Cost_R_d_s,Cost_delta_pd_s]=gams('Cont_rr_1','Cost_gen','P_s_max','o','bus_n','b_n','G_E','Cost_SPIN','R_s_max','I_0','U_0','D_0','UT','DT','Xbus','R','S_Cost','SU','SD','PD','D_B','delta_m','load_f_u','load_f_d','UR','DR','RS','P_ini','P_delta_ini','alfa','D_B_max'); 

% 
% %   g_E=gams('Cont','G_E'); 
% %  
  P_n=P.val;
  W_n=W.val
  II_n=II.val
 DELTA=  delta.val;
%     Pl=Pl.val;
   P_delta_n=P_delta.val;
    Y_n=Y.val;
     Z_n=Z.val;
    Y=Y.val;
    P_G_n=[P_n(1,:);P_n(2,:);P_n(7,:);P_n(13,:);P_n(14,:);P_n(15,:);P_n(16,:);P_n(18,:);P_n(21,:);P_n(22,:);P_n(23,:)]
res_n=R_m.val;
R_u_n=R_u.val;
R_d_n=R_d.val;
R_m_n=R_m.val;
delta_pd_n=delta_pd.val*100;
%  C_time=9;
%    gen_m=7;
   
        for C_time=1:24
           for gen_m=1:24
 %%contingency delta=1
 %%%generators in buses: 1,2,7,13,14,15,16,18,21,22,23
 if G_E(gen_m,2)>0
  delta_m=1;
  clear init D_0 U_0 I_0 o P_ini P_delta_ini
 %%%o is the time that contingency kth happening
 %%%n is the bus that its generator outage happens
 %%%contingency time that generator outage happens
  
 n=gen_m;
 o=C_time;
 P_cont=P_n(gen_m,1:end);
%  
%  
%  %%%initial P for ramp up
%    
  for i=1:max(size(P_n))
       if o-1>0  
          P_ini(i)=P_n(i,o-1);
          P_delta_ini(i)=P_delta_n(i,o-1);
      else
          P_ini(i)=0;
          P_delta_ini=0;
       end
  end
%            

%  
% %%%out gen is min power=2 and maxpower=0
% %G_E(n,2)=0;
% %G_E(n,3)=0;
 if o-1>0
 for i=1:max(size(P_n))
     k=0;
     d=0;
%     
     for j=1:o-1
     if II_n(i,j)==1 
       k=k+1;  
      count_on(i,j)=k;   
     elseif Y_n(i,j)==1 
       k=0;
       count_on(i,j)=0;
     else
         count_on(i,j)=0;
     end
     if II_n(i,j)==0
         d=d-1;
         count_off(i,j)=d;
     elseif Z_n(i,j)==1
         d=0;
         count_off(i,j)=0;
     else
         count_off(i,j)=0;
     end
     end
     if (G_E(i,2)==0 & G_E(i,3)==0)
      count_on(i,j)=1;
      count_off(i,j)=0;
     end
 end
% 
% 
% %%recalculating inital state
 init=count_on(:,end)+count_off(:,end);
% 
 for k=1:max(size(init))
  if init(k)<0    
  I_0(k)=0;
  end
  if init(k)>0
   I_0(k)=1;
  end
  end
%  
  for p=1:max(size(init))
   if init(p)>0    
  U_0(p)=init(p);
   else
       U_0(p)=0;
   end
   if init(p)<0
       D_0(p)=init(p);
   else 
       D_0(p)=0;
   end
  end
  D_0=abs(D_0);
  UT=G_E(:,7);
  DT=abs(G_E(:,8));
  for i=1:length(UT)
      if n==i
          UT(i)=1;
          DT(i)=0;
      end
  end
 end
 if o-1==0
     init=G_E(:,6);
     for k=1:max(size(init))
  if init(k)<0    
  I_0(k)=0;
  end
  if init(k)>0
   I_0(k)=1;
  end
  end
%  %% 
  for p=1:max(size(init))
   if init(p)>0    
  U_0(p)=init(p);
   else
       U_0(p)=0;
   end
   if init(p)<0
       D_0(p)=init(p);
   else 
       D_0(p)=0;
   end
  end
  D_0=abs(D_0);
  UT=G_E(:,7);
  DT=abs(G_E(:,8));
    for i=1:max(size(G_E))
       if o-1==0  
      if init(i)>0
          P_ini(i)=G_E(i,3);
      else
          P_ini(i)=0;
      end
     end
 
%     P_ini=P_ini/Sb;
    P_delta_ini=P_ini+0.01*P_ini
    end
 end
  o=num2str(C_time);
% % UT_new=4;
%  
% %  shed cost
%  %alfa=100*[20 22 23 20 27 23 25 29 21 26 29 22 24 23 26 29 28 25 21 25 21 27 29 25]'*Sb;
%  %alfa=repmat(alfa(1:end,1),1,24);
% 
%  Z_ini=Z_n(:,C_time);
%  P_n_1=P_n(:,C_time);
%  P_n_me=P_n(:,C_time);
[P,objout,II,RSPIN_m,SPIN_u,SPIN_d,delta,Pl,Pl_prp,Pl_prn,P_delta]=gams('Cont_1','o','bus_n','P_s_max','R_s_max','Cost_SPIN','G_E','I_0','U_0','D_0','UT','DT','Cost_gen','Xbus','R','S_Cost','SU','SD','PD','D_B','delta_m','gen_m','load_f_u','load_f_d','UR','DR','P_ini','P_delta_ini');  
 
clc
 P_c{gen_m,C_time}=P.val;
  W_c{gen_m,C_time}=objout.val;
  II_c{gen_m,C_time}=II.val;
  RSPIN_m_c{gen_m,C_time}=RSPIN_m.val;
  SPIN_u_c{gen_m,C_time}=SPIN_u.val;
  SPIN_d_c{gen_m,C_time}=SPIN_d.val;
  delta_c{gen_m,C_time}=delta.val;
  Pl_c{gen_m,C_time}=Pl.val;
  Pl_prp_c{gen_m,C_time}=Pl_prp.val;
Pl_prn_c{gen_m,C_time}=Pl_prn.val;
P_delta_c{gen_m,C_time}=P_delta.val;
% gaining the shedding amount for next step which is the back-up plan
  [P,objout,II,RSPIN_m,SPIN_u,SPIN_d,delta_pd,Pl,P_delta]=gams('Cont_me','bus_n','P_s_max','R_s_max','P_cont','o','Cost_SPIN','G_E','I_0','U_0','D_0','UT','DT','Cost_gen','Xbus','R','S_Cost','SU','SD','PD','D_B','delta_m','gen_m','load_f_u','load_f_d','UR','DR','P_ini','P_delta_ini','alfa','C_time','D_B_max'); 
 P_cm{gen_m,C_time}=P.val;
  W_cm{gen_m,C_time}=objout.val;
  II_cm{gen_m,C_time}=II.val;
  RSPIN_m_cm{gen_m,C_time}=RSPIN_m.val;
  SPIN_u_cm{gen_m,C_time}=SPIN_u.val;
  SPIN_d_cm{gen_m,C_time}=SPIN_d.val;
  delta_pd_cm{gen_m,C_time}=delta_pd.val;
   Pl_cm{gen_m,C_time}=Pl.val;
P_delta_cm{gen_m,C_time}=P_delta.val;
 
 end
           end
        end
% running for contingency with backup to cover ramp rate problems  
%% njbk

  clear init D_0 U_0 I_0 P_ini P_delta_ini
  for i=1:max(size(G_E))
     if G_E(i,3)-G_E(i,end)>0
         G_E(i,3)=G_E(i,end);
     end
 end
 
 init=G_E(:,6);
 % start up and shut down  ramp rate 1.5*Pmin 
  RS=5*(G_E(:,end));
 for i=1:max(size(G_E))
     UR(i)=min((G_E(i,2)-G_E(i,3)),G_E(i,end));
     DR(i)=UR(i);
 end
UR=G_E(:,end);
DR=G_E(:,end);
 for k=1:max(size(init))
 if init(k)<0    
 I_0(k)=0;
 end
 if init(k)>0
  I_0(k)=1;
 end
 end

 for p=1:max(size(init))
  if init(p)>0    
 U_0(p)=init(p);
  else
      U_0(p)=0;
  end
  if init(p)<0
      D_0(p)=init(p);
  else 
      D_0(p)=0;
  end
 end
 D_0=abs(D_0);
 UT=G_E(:,7);
 DT=abs(G_E(:,8));
 
 for i=1:max(size(G_E))
     if init(i)>0
         P_ini(i)=G_E(i,3);
     else
         P_ini(i)=0;
     end
 end
% RS=RS/Sb;
% P_ini=P_ini/Sb;
 P_delta_ini=P_ini+0.01*P_ini;
kk=0;
 tt=0;
    
     for C_time=1:24
         for gen_m=1:24
          if G_E(gen_m,2)>0
         if (sum(sum(P_c{gen_m,C_time}))==0) 
             kk=kk+1;
             tt=tt+1;
             imp_gen_k(kk)=gen_m;
             imp_gen_t(tt)=C_time;
             clear p_cmp G_E_b delta_pd_1 delta_pd clear PD_b D_B_b
             PD_b=PD;
             G_E_b=G_E;
             %P_cmp=P_n(gen_m,C_time);
             %G_E_b(gen_m,2)=P_cmp;
             delta_pd=delta_pd_cm{gen_m,C_time};
             delta_pd_1=[zeros(24,C_time-1) delta_pd];
             D_B_b=D_B+delta_pd_1;
             for i=1:24
             PD_b(i)=PD_b(i)+sum(delta_pd_1(:,i));
             end
 %%%contingency delta=1
 %%%generators in buses: 1,2,7,13,14,15,16,18,21,22,23
 Cost_R=Cost_SPIN;
[P,W,II,R_u,R_d,R_m,delta_pd_2,Pl,P_delta]=gams('Cont_backup_gen','bus_n','P_s_max','D_B_max','R_s_max','PD','gen_m','Cost_SPIN','G_E_b','I_0','U_0','D_0','UT','DT','Cost_gen','Xbus','R','S_Cost','SU','SD','PD_b','D_B_b','load_f_u','load_f_d','UR','DR','RS','P_ini','P_delta_ini','alfa','delta_pd_1','P_n'); 
 P_b{gen_m,C_time}=P.val;
  W_b{gen_m,C_time}=W.val;
  II_b{gen_m,C_time}=II.val;
  R_u_b{gen_m,C_time}=R_u.val;
  R_d_b{gen_m,C_time}=R_d.val;
  R_m_b{gen_m,C_time}=R_m.val;
  delta_pd_b{gen_m,C_time}=delta_pd_2.val;
  Pl_b{gen_m,C_time}=Pl.val;
  P_delta_b{gen_m,C_time}=P_delta.val;
         end
         end
         
   end
       end
%     Pl_prp_cm{gen_m,C_time}=Pl_prp.val*100;
% Pl_prn_cm{gen_m,C_time}=Pl_prn.val*100;
%   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
% %   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
%   
% % %    
% % %  P_cell_p{gen_m,C_time}=P.val*100;
% % %  W_cell_p{gen_m,C_time}=objout.val;
% % %  II_cell_p{gen_m,C_time}=II.val;
% % %  P_delta_cell_p{gen_m,C_time}=P_delta.val*100;
% % %  RSPIN_m_cell_p{gen_m,C_time}=RSPIN_m.val*100;
% % %  SPIN_u_cell_p{gen_m,C_time}=SPIN_u.val*100;
% %  SPIN_d_cell_p{gen_m,C_time}=SPIN_d.val*100;
% % % % % %   delta_pd_1_cell{gen_m,C_time}=delta_pd_1.val*100;
% % % % % 
% % % % % %   delta.val
% % % % % %   Pl=Pl.val*100;
% % % % % %      
% % % % % %     Y=Y.val;
% % % % % %     Z=Z.val;
% % % % % %     
% % % % % %   P_delta=P_delta.val;
% % % % % %   
% % % % % %  delta.val
% % % % % %    Pl=Pl.val*100
% % % % % %  SPIN_u=SPIN_u.val
% % % % % %  SPIN_d=SPIN_d.val
% % % % % % % %  Y=Y.val
% % % % % % % %  plot(II); 
% % % % % % % %  
% % % % %  
% % %  [P,objout,II,delta,Pl,Y,Z,P_ini,DR,P_delta,RSPIN_m,SPIN_u,SPIN_d,delta_pd_1]=gams('cont_me','o','G_E','I_0','U_0','D_0','UT','DT','Cost_gen','Xbus','R','S_Cost','SU','SD','PD','D_B','delta_m','gen_m','load_f_u','load_f_d','UR','DR','UT_new','P_ini','alfa','C_time','Z_ini'); 
% % %  clc
% % %  P_cm=P.val*100
% % %  W_cm=objout.val
% % %  II_cm=II.val
% % %  P_delta_cm=P_delta.val*100;
% % %  RSPIN_m=RSPIN_m.val*100;
% % %  D_P=delta_pd_1.val*100;
% % %  P_G_cm=[P_cm(1,:);P_cm(2,:);P_cm(7,:);P_cm(13,:);P_cm(14,:);P_cm(15,:);P_cm(16,:);P_cm(18,:);P_cm(21,:);P_cm(22,:);P_cm(23,:)];
% % %  o=str2num(o);
% % %  P_G_nn=[P_n(1,1:o-1);P_n(2,1:o-1);P_n(7,1:o-1);P_n(13,1:o-1);P_n(14,1:o-1);P_n(15,1:o-1);P_n(16,1:o-1);P_n(18,1:o-1);P_n(21,1:o-1);P_n(22,1:o-1);P_n(23,1:o-1)];
% % % P_G_F=[P_G_nn P_G_cm];
% % %  R_M_n=[R_m(1,:);R_m(2,:);R_m(7,:);R_m(13,:);R_m(14,:);R_m(15,:);R_m(16,:);R_m(18,:);R_m(21,:);R_m(22,:);R_m(23,:)];
% % %  R_M_nn=[R_m(1,1:o-1);R_m(2,1:o-1);R_m(7,1:o-1);R_m(13,1:o-1);R_m(14,1:o-1);R_m(15,1:o-1);R_m(16,1:o-1);R_m(18,1:o-1);R_m(21,1:o-1);R_m(22,1:o-1);R_m(23,1:o-1)];
% % %  RSPIN_cm=[RSPIN_m(1,:);RSPIN_m(2,:);RSPIN_m(7,:);RSPIN_m(13,:);RSPIN_m(14,:);RSPIN_m(15,:);RSPIN_m(16,:);RSPIN_m(18,:);RSPIN_m(21,:);RSPIN_m(22,:);RSPIN_m(23,:)];
% % % R_M_f=[R_M_nn RSPIN_cm];
% % % 
% % % % % %  
% % % % % %   P_cell_m{gen_m,C_time}=P.val*100;
% % % % % %  W_cell_m{gen_m,C_time}=objout.val;
% % % % % %  II_cell_m{gen_m,C_time}=II.val;
% % % % % %  P_delta_cell_m{gen_m,C_time}=P_delta.val*100;
% % % % % %  RSPIN_m_cell_m{gen_m,C_time}=RSPIN_m.val*100;
% % % % % %  SPIN_u_cell_m{gen_m,C_time}=SPIN_u.val*100;
% % % % % %  SPIN_d_cell_m{gen_m,C_time}=SPIN_d.val*100;
% % % % % %   delta_pd_1_cell_m{gen_m,C_time}=delta_pd_1.val*100;
% % % % %     %   end
% % % % %  %end
% % % %  
% % %  
% %  
% %  
%  
%  
%  
%  
%  
%  