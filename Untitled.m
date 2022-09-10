disp('###### SUMMER: ######');
I=xlsread('data2.xlsx');
d0=I(:,2);
Pw=I(:,3);
min_P0=I(:,4);
max_P0=I(:,5);
p0=I(:,6);
E=zeros(24);
Df=diff(d0)./diff(p0);
Df(24)=Df(23);
for i=1:24
    for j=1:24
        E(i,j)= p0(j)/d0(i) * Df(i);
    end
end

%%
p_old=Pw;
p=p_old;
for h=1:24 
     B_old=-fitfcn(p,Pw,p0,d0,E);
     Q=zeros(3);
     act=0;
     Reward=zeros(3);
     for i=1:L % learning
         p(h)= Pw(h)+(max_P0(h)-Pw(h))*rand(1,1); %Random Price
         B= -fitfcn(p,Pw,p0,d0,E);
         %----- Set State ------
         if B>B_old 
             state=1;
             st=1;
         elseif B==B_old
             state=2;
             st=0;
         else
             state=3;
             st=-1;
         end
         %-----------------------
         %------ Set Action -----
         if p(h) > p_old(h)
             act=1;
         elseif p(h) == p_old(h)
             act=2;
         else
             act=3;
         end
         %-----------------------
         %------ Reward ---------
         Reward(state,act)=100*st+1e-3*(st+1);
         %------ Q-Learning -----
           
    
      
       Q(state,act)=Q(state,act) + alpha * (Reward(state,act) + gama * max(Q(:,act)) - Q(state,act));
         
         B_old=B;
         p_old=p;
     end
     %-----------------------------------
     p(h)=Pw(h);
     B_old=-fitfcn(p,Pw,p0,d0,E);
     state=1;
     mx=0;
     mx_ind=1;
     for i=1:L
         for j=1:3
             if Q(state,j)>mx
                 mx=Q(state,j);
                 mx_ind=j;
             end
         end
         if mx_ind==1
             p(h)= p(h) + p(h)/L;
         elseif mx_ind==3
             p(h)= p(h) - p(h)/L;
         end
         if p(h)> max_P0(h)
             p(h)=max_P0(h);
         elseif p(h)<Pw(h)
             p(h)=Pw(h);
         end
         B=-fitfcn(p,Pw,p0,d0,E);
         if B > B_old
             state=1;
         elseif B == B_old
             state=2;
         else
             state=3;
         end
         B_old=B;
     end
    
end
RTP_QL_Benefit=abs(fitfcn(p,Pw,p0,d0,E))

figure, plot(p,'-*');
grid()
xlabel('hour');
ylabel('price (Rial/MWh)');
title('RTP by QLearning Algorithm/ Summer');
p_rtp_summer=p;
%%
% tou
range=(max(d0)-min(d0))/3;
p_k=0;
c_k=0;
p_m=0;
p_p=0;
c_m=0;
c_p=0;
for i=1:24
    if d0(i)<= (min(d0) + range)
        p_k=p_k + p(i);
        c_k=c_k + 1;
    elseif d0(i) <= (max(d0)-range) && d0(i)> (min(d0) + range)
        p_m=p_m + p(i);
        c_m=c_m + 1;
    else
        p_p=p_p + p(i);
        c_p=c_p + 1;
    end
end
kambari=p_k / c_k;
mianbari=p_m / c_m;
porbari = p_p / c_p;
p_tou=p;
for i=1:24
    if d0(i)<= (min(d0) + range)
        p_tou(i)=kambari;
    elseif d0(i) <= (max(d0)-range) && d0(i)> (min(d0) + range)
        p_tou(i)=mianbari;
    else
        p_tou(i)=porbari;
    end
end
TOU_QL_Benefit=abs(fitfcn(p_tou,Pw,p0,d0,E))

figure, plot(p_tou,'-*')
grid()
xlabel('hour');
ylabel('price (Rial/MWh)');
title('TOU by QLearning Algorithm/ Summer');
p_tou_summer=p_tou;
%%
% cpp
[~,ind]=max(d0);
p_cpp=p_tou;
p_cpp(ind)=max_P0(ind);
figure, plot(p_cpp,'-*');
grid()
xlabel('hour');
ylabel('price (Rial/MWh)');
title('CPP by QLearning Algorithm / Summer');
CPP_QL_Benefit=abs(fitfcn(p_cpp,Pw,p0,d0,E))
p_cpp_summer=p_cpp;

figure;
bar([RTP_QL_Benefit,TOU_QL_Benefit,CPP_QL_Benefit]);
grid();
xlabel('1.RTP-QL-Benefit 2.TOU-QL-Benefit 3.CPP-QL-Benefit');
ylabel('Benefit (Rial)');
title('Total Benefit Comparison/ Summer');
disp('Prices:');
disp('Summer');
disp('-----rtp-------tou-------cpp---');
disp([p,p_tou,p_cpp]);

%%
figure,plot([p_rtp_winter,p_rtp_summer],'-*');
legend('Winter','Summer');
title('RTP');
xlabel('Hour');
ylabel('Price (Rial/MWh)');

figure,plot([p_tou_winter,p_tou_summer],'-*');
legend('Winter','Summer');
title('TOU');
xlabel('Hour');
ylabel('Price (Rial/MWh)');

figure,plot([p_cpp_winter,p_cpp_summer],'-*');
legend('Winter','Summer');
title('CPP');
xlabel('Hour');
ylabel('Price (Rial/MWh)');