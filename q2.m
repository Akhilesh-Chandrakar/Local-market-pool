clc;
clear all;
close all;
as_at = zeros(2,48);
L=100;
alpha=.2;
gama=.95;
I=xlsread('res41.xlsx');

pw=I(:,2);
sol_P0=I(:,3);
Td0=I(:,4);
ref_price=112;
ref_battery=13.5;
ep=0;
g=-42;
k=130;
Ba=.3;
e=.9;
c_old=pw;
cp=c_old;
c_old=c_old/ref_price;
soc=0.4;
act=0;
%%
for h=1:24
Qa=zeros(3);
Qb=zeros(3);
     y(h)=(-Ba(h)+sol_P0(h)+ep(h))/Td0(h);
     q(h)=g*y(h)+k*y(h)*y(h);
     cp(h)=pw(h)-q(h);
     cp(h)=cp(h)/ref_price;
     pw(h)=pw(h)/ref_price;
     for i=1:L % learning
         cp(h)= cp(h)+(pw(h)-cp(h))*rand(1,1); %Random Price between cp and 1.5*cp
         % setting output set for fuzzy learning
     bat=membership(soc(h),.125,.2,.375,.46);
    
     com=membership(cp(h),.2,.3,.38,.675);
     
     ret=membership(pw(h),.2,.3,.38,.675);
         %----- Set State ------
             
                if com==0 && ret==0 && bat==0
                    at=-(0+(.3-0)*rand(1,1));
                    as=.7+(1-.7)*rand(1,1);
                elseif com==0 && ret~=0 && ret~=1 &&bat==0
                        at=-(.7+(1-.7)*rand(1,1));
                    as=.7+(1-.7)*rand(1,1);
                    elseif com==0 && ret~=0 && ret~=1 && bat~=0 && bat~=1
                        at=-(0+(.3-0)*rand(1,1));
                    as=.4+(.6-.4)*rand(1,1);
                    elseif com==0 && ret~=0 && ret~=1 && bat==1
                        at=-(.3-0)*rand(1,1);
                    as=-(.7+(1-.7)*rand(1,1));
                    elseif com==0 && ret==0 && bat~=0 && bat~=1
                        at=.7+(1-.7)*rand(1,1);
                    as=-((.3-0)*rand(1,1));
                    elseif com==0 && ret==0 && bat==1
                        at=.4+(.6-.4)*rand(1,1);
                    as=-(.7+(1-.7)*rand(1,1));
                    elseif com==0 && ret==1 && bat~=0 && bat~=1
                        at=-(.7+(1-.7)*rand(1,1));
                    as=-((.3-0)*rand(1,1));
                    elseif com==0 && ret==1 && bat==1
                        at=-(.7+(1-.7)*rand(1,1));
                    as=-(.7+(1-.7)*rand(1,1));
                    elseif com~=0 && com~=1 && ret==0 && bat==0
                        at=.4+(.6-.4)*rand(1,1);
                    as=.7+(1-.7)*rand(1,1);
                    elseif com~=0 && com~=1 && ret==0 && bat~=0 && bat~=1
                        at=.4+(.6-.4)*rand(1,1);
                    as=(.3-0)*rand(1,1);
                    elseif com~=0 && com~=1 && ret==0 && bat==1
                        at=(.3-0)*rand(1,1);
                    as=-(.7+(1-.7)*rand(1,1));
                    elseif com~=0 && com~=1 && ret~=0 && ret~=1 && bat==0
                        at=(.3-0)*rand(1,1);
                    as=.7+(1-.7)*rand(1,1);
                    elseif com~=0 && com~=1 && ret~=0 && ret~=1 && bat~=0 && bat~=1
                        at=(.3-0)*rand(1,1);
                    as=(.3-0)*rand(1,1);
                    elseif com~=0 && com~=1 && ret~=0 && ret~=1 && bat==1
                        at=-((.3-0)*rand(1,1));
                    as=-(.3+(.6-.3)*rand(1,1));
                    elseif com~=0 && com~=1 && ret==1 && bat==0
                        at=-(.3-0)*rand(1,1);
                    as=.4+(.7-.4)*rand(1,1);
                    elseif com~=0 && com~=1 && ret==1 && bat~=0 && bat~=1
                        at=-(.7+(1-.7)*rand(1,1));
                    as=(.3-0)*rand(1,1);
                    elseif com~=0 && com~=1 && ret==1 && bat==1
                        at=-(.4+(.6-.4)*rand(1,1));
                    as=-(.4+(.6-.4)*rand(1,1));
                    elseif com==1 && ret==0 && bat==0
                        at=.7+(1-.7)*rand(1,1);
                    as=.7+(1-.7)*rand(1,1);
                     elseif com==1 && ret==0 && bat~=0 && bat~=1
                        at=.4+(.6-.4)*rand(1,1);
                    as=.4+(.6-.4)*rand(1,1);
                     elseif com==1 && ret==0 && bat==1
                        at=.4+(.6-.4)*rand(1,1);
                    as=-(.4+(.6-.4)*rand(1,1));
                     elseif com==1 && ret~=0 && ret~=1 && bat==1
                        at=(.3-0)*rand(1,1);
                    as=.7+(1-.7)*rand(1,1);
                     elseif com==1 && ret~=0 && ret~=1 && bat~=0 && bat~=1
                        at=(.3-0)*rand(1,1);
                    as=-((.3-0)*rand(1,1));
                     elseif com==1 && ret~=0 && ret~=1 && bat==1
                        at=4+(.6-.4)*rand(1,1);
                    as=.4+(.6-.4)*rand(1,1);
                     elseif com==1 && ret==1 && bat==0
                        at=-((.3-0)*rand(1,1));
                    as=.7+(1-.7)*rand(1,1);
                     elseif com==1 && ret==1 && bat~=0 && bat~=1
                        at=-((.3-0)*rand(1,1));
                    as=(.3-0)*rand(1,1);
                     elseif com==1 && ret==1 && bat==1
                        at=.7+(1-.7)*rand(1,1);
                    as=-(.4+(.6-.4)*rand(1,1));
                end
            % initialize Q table
            if cp>pw
                state=1;
                st=1;
            elseif cp<pw
                state=2;
                st=-1;
            else state=3;
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
         Qa(state,act)=Qa(state,act) + alpha * (Reward(state,act) + gama * max(Qb(:,act)) - Qa(state,act));
        
        
         
         if c_old>cp
             cp(h)=cp(h) + cp(h)/L;
         else 
              cp(h)=cp(h) - cp(h)/L;
         end
     end
      soc(h+1)=soc(h)+as;
     as;
     at;
     as_at(1,h) = as;
     as_at(2,h) = at;

      Ba(h+1)= Ba(h)-as;
             ep(h+1)=ep(h)-at-as;
     c_old(h)=cp(h);
end

       
     for h=25:48
Qa=zeros(3);
Qb=zeros(3);
     y(h)=(-Ba(h)+sol_P0(h)+ep(h))/Td0(h);
     q(h)=g*y(h)+k*y(h)*y(h);
     cp(h)=pw(h)-q(h);
     cp(h)=cp(h)/ref_price;
     pw(h)=pw(h)/ref_price;
     for i=1:L % learning
         cp(h)= cp(h)+(pw(h)-cp(h))*rand(1,1); %Random Price between cp and 1.5*cp
         % setting output set for fuzzy learning
     bat=membership(soc(h),.125,.2,.375,.46);
    
     com=membership(cp(h),.2,.3,.38,.675);
     
     ret=membership(pw(h),.2,.3,.38,.675);
         %----- Set State ------
             
                if com==0 && ret==0 && bat==0
                    at=-(0+(.3-0)*rand(1,1));
                    as=.7+(1-.7)*rand(1,1);
                elseif com==0 && ret~=0 && ret~=1 &&bat==0
                        at=-(.7+(1-.7)*rand(1,1));
                    as=.7+(1-.7)*rand(1,1);
                    elseif com==0 && ret~=0 && ret~=1 && bat~=0 && bat~=1
                        at=-(0+(.3-0)*rand(1,1));
                    as=.4+(.6-.4)*rand(1,1);
                    elseif com==0 && ret~=0 && ret~=1 && bat==1
                        at=-(.3-0)*rand(1,1);
                    as=-(.7+(1-.7)*rand(1,1));
                    elseif com==0 && ret==0 && bat~=0 && bat~=1
                        at=.7+(1-.7)*rand(1,1);
                    as=-((.3-0)*rand(1,1));
                    elseif com==0 && ret==0 && bat==1
                        at=.4+(.6-.4)*rand(1,1);
                    as=-(.7+(1-.7)*rand(1,1));
                    elseif com==0 && ret==1 && bat~=0 && bat~=1
                        at=-(.7+(1-.7)*rand(1,1));
                    as=-((.3-0)*rand(1,1));
                    elseif com==0 && ret==1 && bat==1
                        at=-(.7+(1-.7)*rand(1,1));
                    as=-(.7+(1-.7)*rand(1,1));
                    elseif com~=0 && com~=1 && ret==0 && bat==0
                        at=.4+(.6-.4)*rand(1,1);
                    as=.7+(1-.7)*rand(1,1);
                    elseif com~=0 && com~=1 && ret==0 && bat~=0 && bat~=1
                        at=.4+(.6-.4)*rand(1,1);
                    as=(.3-0)*rand(1,1);
                    elseif com~=0 && com~=1 && ret==0 && bat==1
                        at=(.3-0)*rand(1,1);
                    as=-(.7+(1-.7)*rand(1,1));
                    elseif com~=0 && com~=1 && ret~=0 && ret~=1 && bat==0
                        at=(.3-0)*rand(1,1);
                    as=.7+(1-.7)*rand(1,1);
                    elseif com~=0 && com~=1 && ret~=0 && ret~=1 && bat~=0 && bat~=1
                        at=(.3-0)*rand(1,1);
                    as=(.3-0)*rand(1,1);
                    elseif com~=0 && com~=1 && ret~=0 && ret~=1 && bat==1
                        at=-((.3-0)*rand(1,1));
                    as=-(.3+(.6-.3)*rand(1,1));
                    elseif com~=0 && com~=1 && ret==1 && bat==0
                        at=-(.3-0)*rand(1,1);
                    as=.4+(.7-.4)*rand(1,1);
                    elseif com~=0 && com~=1 && ret==1 && bat~=0 && bat~=1
                        at=-(.7+(1-.7)*rand(1,1));
                    as=(.3-0)*rand(1,1);
                    elseif com~=0 && com~=1 && ret==1 && bat==1
                        at=-(.4+(.6-.4)*rand(1,1));
                    as=-(.4+(.6-.4)*rand(1,1));
                    elseif com==1 && ret==0 && bat==0
                        at=.7+(1-.7)*rand(1,1);
                    as=.7+(1-.7)*rand(1,1);
                     elseif com==1 && ret==0 && bat~=0 && bat~=1
                        at=.4+(.6-.4)*rand(1,1);
                    as=.4+(.6-.4)*rand(1,1);
                     elseif com==1 && ret==0 && bat==1
                        at=.4+(.6-.4)*rand(1,1);
                    as=-(.4+(.6-.4)*rand(1,1));
                     elseif com==1 && ret~=0 && ret~=1 && bat==1
                        at=(.3-0)*rand(1,1);
                    as=.7+(1-.7)*rand(1,1);
                     elseif com==1 && ret~=0 && ret~=1 && bat~=0 && bat~=1
                        at=(.3-0)*rand(1,1);
                    as=-((.3-0)*rand(1,1));
                     elseif com==1 && ret~=0 && ret~=1 && bat==1
                        at=4+(.6-.4)*rand(1,1);
                    as=.4+(.6-.4)*rand(1,1);
                     elseif com==1 && ret==1 && bat==0
                        at=-((.3-0)*rand(1,1));
                    as=.7+(1-.7)*rand(1,1);
                     elseif com==1 && ret==1 && bat~=0 && bat~=1
                        at=-((.3-0)*rand(1,1));
                    as=(.3-0)*rand(1,1);
                     elseif com==1 && ret==1 && bat==1
                        at=.7+(1-.7)*rand(1,1);
                    as=-(.4+(.6-.4)*rand(1,1));
                end
            % initialize Q table
            if cp>pw
                state=1;
                st=1;
            elseif cp<pw
                state=2;
                st=-1;
            else state=3;
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
         Qb(state,act)=Qb(state,act) + alpha * (Reward(state,act) + gama * max(Qa(:,act)) - Qb(state,act));
        Q=zeros(3);
     Q=(Qa+Qb)/2;
         if c_old>cp
             cp(h)=cp(h) + cp(h)/L;
         else 
              cp(h)=cp(h) - cp(h)/L;
         end
     end
   
      soc(h+1)=soc(h)+as;
     as;
     at;
     as_at(1,h) = as;
     as_at(2,h) = at;

      Ba(h+1)= Ba(h)-as;
             ep(h+1)=ep(h)-at-as;
     c_old(h)=cp(h);
end

   figure;
bar([as_at'])
grid();
xlabel('1.storage action 2.trade action ');
figure,plot([cp,pw],'-*');

title('price comparison');
xlabel('Hour');
ylabel('Price ');
     %-----------------------------------
     
