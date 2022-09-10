clc;
clear all;
close all;
as_at = zeros(2,24);%storage and trade action for each hour
L=100; % learning stage
alpha=.2;% a constant in q value calculation
gama=.95; % a constant in q value calculation
I=xlsread('res4.xlsx'); % read dataset from res4 excel
d0=I(:,2); % Demand of individual smart user
pw=I(:,3); % retail price
sol_P0=I(:,4); % solar power data
Td0=I(:,5)*13.5; % Total demand for each hour
ref_price=112; % Reference retail price (highest among retail) in cents (remains in cents)
ref_battery=5; % Reference battery charge discharge rate in kW/h
ep=0.7*13.5; % remaining power in pool after trade
g=-42; %
k=130;
Ba=1.5; % Initial battery charge/discharge rate(0.3*5 kW/h)
% e=.9;
c_old=pw;
cp=c_old;
soc=1;
act=0;
sumc=0;
sumr=0;
for h=1:24
    Q=zeros(3);
    Reward = zeros(3);
    
    y(h)=(sol_P0(h)+ep(h))/Td0(h);
    %     y(h) = sol_P0(h) + ep(h) - Td0(h);
%          q(h)=g*y(h)+k*y(h)*y(h);
         
         
    %     50 is FIT
    if y(h)<=1 && y(h)>=0 % demand is high (supply by demand is less than zero)
        cp(h) = (50*pw(h))/((pw(h)-50)*y(h)+50);
%         cp(h)=pw(h)-q(h);
    else
        cp(h) = 50; % supply is high (supply by demand is higher than zero)
    end
    %      cp(h)=pw(h)-q(h);
    
    cp(h)=cp(h)/ref_price;
    c_old(h)=c_old(h)/ref_price;
    pw(h)=pw(h)/ref_price;
    
    for i=1:L % learning
        
        % setting output set for fuzzy learning
        bat=membership(soc(h),.4,.5,.7,.9);
        
        com=membership(cp(h),.5,.6,.75,.87);
        
        ret=membership(pw(h),.5,.6,.75,.87);
        %----- Set State ------
        
        [as,at] = fuzzyrules_2(com,ret,bat);
        
        % initialize Q table
        if cp(h)>pw(h)
            state=1;
            st=-1;
        elseif cp(h)<pw(h)
            state=2;
            st=1;
        else
            state=3;
            st=0;
        end
        if cp(h) > c_old(h)
            act=1;
        elseif cp(h) == c_old(h)
            act=2;
        else
            act=3;
        end
        
        Reward(state,act)=100*st+1e-3*(st+1);
        %------ Q-Learning -----
        Q(state,act)=Q(state,act) + alpha * (Reward(state,act) + gama * max(Q(:,act)) - Q(state,act));
        if c_old(h)>cp(h)
            cp(h)=cp(h) + cp(h)/L;
        else
            cp(h)=cp(h) - cp(h)/L;
        end
        
        soc(h) = soc(h) + as; % a predictive condition to check the soc limit violations
        
            if soc(h) < 0.3 
                soc(h) = 0.3;
                bat = 0;
                com=1;
                ret=membership(pw(h),.5,.6,.75,.87);
                [as,at] = fuzzyrules_2(com,ret,bat);
                soc(h+1) = soc(h) + as;
                
            elseif soc(h) > 1
                soc(h) = 1;
                bat = 1;
                com=0;
                ret=membership(pw(h),.5,.6,.75,.87);
                [as,at] = fuzzyrules_2(com,ret,bat);
                soc(h+1) = soc(h)+as;
                
            else
                soc(h+1)=soc(h)+as;
                
            end
        
        
    end
    as;
    at;
    asori=as*ref_battery;
    atori=at*ref_price;
    
    sumc=sumc+cp(h);
    sumr=sumr+pw(h);
    
    as_at(1,h) = as;
    as_at(2,h) = at;
    
    % change in battery capacity (storage - rate of C/Dis C)
    ep(h+1)=ep(h)+asori;
    c_old(h)=cp(h);
end
cost=sumc-sumr;

figure(1);
bar([as_at']);
grid();
xlabel('1.storage action 2.trade action ');

figure(2);
plot([cp,pw],'-*');
title('price comparison');
xlabel('Hour');
ylabel('Price ');

figure(3)
plot(soc,'-*');
title('soc');
xlabel('Hour');
ylabel('kwh');

figure(4);
plot(L,cp,'b','LineWidth',2);
xlabel('t');
ylabel(' fitness ');
