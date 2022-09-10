clc;
clear all;
close all;
L=100;
alpha=.2;
gama=.95;
I=xlsread('24 hours.xlsx');
d0=I(:,2);
Pw=I(:,5);
max_P0=I(:,4);
p0=I(:,3);
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
         p(h)= Pw(h)+(max_P0(h)-Pw(h))*rand(1,1); %Random Price between Pw and 1.5*Pw
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
RTP_QL_1Bene_uti_alp_con=abs(fitfcn(p,Pw,p0,d0,E))
rtp_ql_1_cus_ben_aplp_con=abs(bencus(p,Pw,p0,d0,E))

p_rtp=p;

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
TOU_QL1_alp_uti_Benefit=abs(fitfcn(p_tou,Pw,p0,d0,E))
TOU_QL1_alp_cus_Benefit=abs(bencus(p_tou,Pw,p0,d0,E))

p_tou_=p_tou;

%%
% cpp
[~,ind]=max(d0);
p_cpp=p_tou;
p_cpp(ind)=max_P0(ind);

CPP_QL1_alp_con_uti_Benefit=abs(fitfcn(p_cpp,Pw,p0,d0,E))
CPP_QL1_alp_con_cus_Benefit=abs(bencus(p_cpp,Pw,p0,d0,E))


disp('Prices:');

disp('-----rtp-------tou-------cpp---');
disp([p,p_tou,p_cpp]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%alpha variable
L=100;
I=xlsread('24 hours.xlsx');
d0=I(:,2);
Pw=I(:,5);
max_P0=I(:,4);
p0=I(:,3);
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
         p(h)= Pw(h)+(max_P0(h)-Pw(h))*rand(1,1); %Random Price between Pw and 1.5*Pw
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
         alpha=1/i;
         gama=.95;
         Q(state,act)=Q(state,act) + alpha * (Reward(state,act) + gama * max(Q(:,act)) - Q(state,act));
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
RTP_QL1alpvar_uti_Benefit=abs(fitfcn(p,Pw,p0,d0,E))
RTP_QL1alpvar_cus_Benefit=abs(bencus(p,Pw,p0,d0,E))


p_rtp_alp_var=p;
x=[1:24];
figure, plot(x,p_rtp);
hold on
grid()
xlabel('hour');
ylabel('price (Rs)');
title('RTP by QLearning Algorithm');
plot(x,p_rtp_alp_var,'r');
hold off
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
p_tou_alp_var=p;
for i=1:24
    if d0(i)<= (min(d0) + range)
       p_tou_alp_var(i)=kambari;
    elseif d0(i) <= (max(d0)-range) && d0(i)> (min(d0) + range)
        p_tou_alp_var(i)=mianbari;
    else
       p_tou_alp_var(i)=porbari;
    end
end

TOU_QL1_alp_var_uti_Benefit=abs(fitfcn( p_tou_alp_var,Pw,p0,d0,E))
TOU_QL1_alp_var_cus_Benefit=abs(bencus( p_tou_alp_var,Pw,p0,d0,E))


figure, plot(x,p_tou)
hold on
grid()
xlabel('hour');
ylabel('price (RS');
title('TOU by QLearning Algorithm');
plot(x,p_tou_alp_var,'r')
hold off

%%
% cpp
[~,ind]=max(d0);
p_cpp_alp_vaqr=p_tou_alp_var;
p_cpp_alp_vaqr(ind)=max_P0(ind);

CPP_QL1_alp_var_uti_Benefit=abs(fitfcn(p_cpp_alp_vaqr,Pw,p0,d0,E))
CPP_QL1_alp_var_cus_Benefit=abs(bencus(p_cpp_alp_vaqr,Pw,p0,d0,E))
figure;
yy=[RTP_QL_1Bene_uti_alp_con,RTP_QL1alpvar_uti_Benefit;TOU_QL1_alp_uti_Benefit,TOU_QL1_alp_var_uti_Benefit;CPP_QL1_alp_con_uti_Benefit,CPP_QL1_alp_var_uti_Benefit];
bar(yy);
grid()
xlabel('1.RTP 2.TOU 3.CPP');
ylabel('Benefit (RS)');
title('Total utility Benefit Comparison');
figure;
zz=[rtp_ql_1_cus_ben_aplp_con,RTP_QL1alpvar_cus_Benefit;TOU_QL1_alp_cus_Benefit,TOU_QL1_alp_var_cus_Benefit;CPP_QL1_alp_con_cus_Benefit,CPP_QL1_alp_var_cus_Benefit];
bar(zz);
grid()
xlabel('1.1.RTP 2.TOU 3.CPP');
ylabel('Benefit (RS)');
title('Total customer Benefit Comparison');
figure, plot(x,p_cpp);
hold on
grid()
xlabel('hour');
ylabel('price (RS)');
title('CPP by QLearning Algorithm');
plot(x,p_cpp_alp_vaqr,'r');
hold off
figure,plot(x,d0);
grid()
xlabel('hour');
ylabel('demand (MWh)');
title('original demand ');
figure,plot(x,p0);
grid()
xlabel('hour');
ylabel('price (RS/MWh)');
title('original pricing');
disp('Prices:');
disp('-----rtp-------tou-------cpp---');
disp([p_rtp_alp_var,p_tou_alp_var,p_cpp_alp_vaqr]);
