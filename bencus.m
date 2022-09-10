function  cutomer_ben  = bencus( p,Pw,p0,d0,E )
for i=1:24
        d(i)=0;
        for j=1:24
            d(i)=d(i)+0.109*d0(i)*(1+log((p(j)/p0(j))^E(i,j)))+.881*d0(i)*(1 +E(i,j)* (p(j)-p0(j))/p0(j));
            b_c(i)=p0(i)*(d(i)-d0(i))+1+(d(i)-d0(i))/E(i,j);
        end
end
cutomer_ben=sum( b_c(i))
end