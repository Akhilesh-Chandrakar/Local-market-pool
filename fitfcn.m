function out=fitfcn(p,Pw,p0,d0,E)  
    for i=1:24
        d(i)=0;
        for j=1:24
            d(i)=d(i) + 0.109*log((p(j)/p0(j))^E(i,j))+.881*E(i,j)*(p(j)-p0(j))/p0(j);
        end
        B(i)= d(i)*(p(i)-Pw(i));
    end
    out=-sum(B);
end