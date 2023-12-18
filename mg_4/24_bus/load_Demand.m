function D_B=load_Demand(load_data,PD)        
T=sum(load_data(1:end,2));
for i=1:max(size(load_data))
    a(i)=load_data(i,2)/T; 
end
    
for t=1:max(size(PD))
    for i=1:length(a)
        D_B(i,t)=a(i)*PD(t);
    end
end
end    
    
    
    
    
    
    
    
    
      
        
        