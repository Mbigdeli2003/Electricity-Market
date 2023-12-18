
clear P_gg P_cc P_cr P_gr res_cm res_b
P_G_n=P_G_n*100;
P_gg=P_b{7,7}*100;
 P_G_b=[P_gg(1,:);P_gg(2,:);P_gg(7,:);P_gg(13,:);P_gg(14,:);P_gg(15,:);P_gg(16,:);P_gg(18,:);P_gg(21,:);P_gg(22,:);P_gg(23,:)];
P_cc=P_cm{7,7}*100;
 P_G_c=[P_cc(1,:);P_cc(2,:);P_cc(7,:);P_cc(13,:);P_cc(14,:);P_cc(15,:);P_cc(16,:);P_cc(18,:);P_cc(21,:);P_cc(22,:);P_cc(23,:)];
P_G_c=P_G_c*100;
 P_R=P_G_b-P_G_n;
shed_c=delta_pd_cm{7,7};
shed_b=delta_pd_b{7,7};
P_gr=P_delta_b{7,7}*100;
 P_delta_g_b=[P_gr(1,:);P_gr(2,:);P_gr(7,:);P_gr(13,:);P_gr(14,:);P_gr(15,:);P_gr(16,:);P_gr(18,:);P_gr(21,:);P_gr(22,:);P_gr(23,:)];
P_cr=P_cm{7,7}*100; 
 P_delta_g_cm=[P_cr(1,:);P_cr(2,:);P_cr(7,:);P_cr(13,:);P_cr(14,:);P_cr(15,:);P_cr(16,:);P_cr(18,:);P_cr(21,:);P_cr(22,:);P_cr(23,:)];
res_cm=RSPIN_m_cm{7,7};
 res_G_cm=[res_cm(1,:);res_cm(2,:);res_cm(7,:);res_cm(13,:);res_cm(14,:);res_cm(15,:);res_cm(16,:);res_cm(18,:);res_cm(21,:);res_cm(22,:);res_cm(23,:)];
res_b=R_m_b{7,7};
 res_G_b=[res_b(1,:);res_b(2,:);res_b(7,:);res_b(13,:);res_b(14,:);res_b(15,:);res_b(16,:);res_b(18,:);res_b(21,:);res_b(22,:);res_b(23,:)];
 res_G_n=[res_n(1,:);res_n(2,:);res_n(7,:);res_n(13,:);res_n(14,:);res_n(15,:);res_n(16,:);res_n(18,:);res_n(21,:);res_n(22,:);res_n(23,:)];
 res_G_n=res_G_n*100;
 res_G_b=res_G_b*100;
 res_G_cm=res_G_cm*100;
 
 
 