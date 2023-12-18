


P_co=P_cm{13,17}*100;
    P_G_c=[P_co(1,:);P_co(2,:);P_co(7,:);P_co(13,:);P_co(14,:);P_co(15,:);P_co(16,:);P_co(18,:);P_co(21,:);P_co(22,:);P_co(23,:)];
P_B=P_b{13,17}*100;
    P_G_b=[P_B(1,:);P_B(2,:);P_B(7,:);P_B(13,:);P_B(14,:);P_B(15,:);P_B(16,:);P_B(18,:);P_B(21,:);P_B(22,:);P_B(23,:)];

    d_pd_cm=delta_pd_cm{2,8}*100;
delta_pd_n=delta_pd_n;
summ_no=[sum(delta_pd_n(:,8)) sum(delta_pd_n(:,9)) sum(delta_pd_n(:,10)) sum(delta_pd_n(:,11)) sum(delta_pd_n(:,12))];
summ_=[sum(d_pd_cm(:,1)) sum(d_pd_cm(:,2)) sum(d_pd_cm(:,3)) sum(d_pd_cm(:,4)) sum(d_pd_cm(:,5))];
R_m_bb=R_m_b{13,17};
R_m_B=[R_m_bb(1,:);R_m_bb(2,:);R_m_bb(7,:);R_m_bb(13,:);R_m_bb(14,:);R_m_bb(15,:);R_m_bb(16,:);R_m_bb(18,:);R_m_bb(21,:);R_m_bb(22,:);R_m_bb(23,:)]*100;
R_m_N=[R_m_n(1,:);R_m_n(2,:);R_m_n(7,:);R_m_n(13,:);R_m_n(14,:);R_m_n(15,:);R_m_n(16,:);R_m_n(18,:);R_m_n(21,:);R_m_n(22,:);R_m_n(23,:)];
R_m_c=RSPIN_m_cm{13,17};
R_M_C=[R_m_c(1,:);R_m_c(2,:);R_m_c(7,:);R_m_c(13,:);R_m_c(14,:);R_m_c(15,:);R_m_c(16,:);R_m_c(18,:);R_m_c(21,:);R_m_c(22,:);R_m_c(23,:)]*100;
d_pd_cm=delta_pd_cm{13,17}*100;
d_pd_b=delta_pd_b{13,17}*100;
