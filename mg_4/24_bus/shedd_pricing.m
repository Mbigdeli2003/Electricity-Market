function [alfa D_B_max]=shedd_pricing(D_B,ALFA)
a=size(D_B);
for t=1:a(1)
    for b=1:3
    for i=1:a(2)
        if b==1
        D_B_max(i,b,t)=D_B(i,t)/3;
        alfa(i,b,t)=ALFA(i,t)/3;
        end
        if b==2
        D_B_max(i,b,t)=2*D_B(i,t)/3;
        alfa(i,b,t)=2*ALFA(i,t)/3;
        end
        if b==3
        D_B_max(i,b,t)=D_B(i,t);
        alfa(i,b,t)=ALFA(i,t);
        end
    end
    end
end
        
        