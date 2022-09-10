function out=fit4(Pw,,sol_P0,em,sm,d,a,b)  
    for i=1:24
        y(t)=(sol_P0(t)+em(t)+sm(t))/d(t);
       q(t)=a(t)y(t)^2+b(t)y(t); 
       c(t)=Pw(t)-q(t);
    end
    out=c(t);
end
