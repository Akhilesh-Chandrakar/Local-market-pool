function dem  = newdem( p,Pw,p0,d0,E )
f=diff(d0)./diff(p0);
f(24)=f(23);
 for i=1:24
        d(i)=0;
        
h(i)= f(i)*p0(i)/d0(i);
        
            d(i)= d0(i)*( 1+h(i)*log(p(i)/p0(i)));
            
 end
 dem=d(i)+d0(i);
end


