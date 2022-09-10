clc;
clear all;
close all;
as_at = zeros(2,24);
I=xlsread('res4.xlsx');
d0=I(:,2);
pw=I(:,3);
sol_P0=I(:,4);
Td0=I(:,5);
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
%% parameters setting
nvar=1; % number of variable
NP=100;              % number particle
T=100;                  % max of iteration
W=1;
C1=2;
C2=2;
alpha=0.05;
%%% initialization
empty.pos=[];
empty.velocity=[];
empty.cost=[];
%load('result.mat');
particle=repmat(empty,NP,1);
for h=1:24 
     y(h)=(-Ba(h)+sol_P0(h)+ep(h))/Td0(h);
     q(h)=g*y(h)+k*y(h)*y(h);
    
for i=1:NP
particle(i).pos=rand(24,nvar);
% particle(i).pos=gparticle.pos;
 cp(h)= cp(h)+(pw(h)-cp(h))*rand(1,1); %Random Price between cp and 1.5*cp
         % setting output set for fuzzy learning
     bat=membership(soc(h),.125,.2,.375,.46);
     com=membership(cp(h),.2,.3,.38,.675);
     ret=membership(pw(h),.2,.3,.38,.675);
particle(i).velocity=0;
particle(i).cost=fitpsores4(h,pw(h),q(h),ref_price);
end
bparticle=particle;
[value,index]=min([particle.cost]);
gparticle=particle(index);
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
            if cp>pw
                particle(i).pos=1;
              
            elseif cp<pw
                particle(i).pos=-1;
            else particle(i).pos=0;
            end
            if cp(h) > c_old(h)
            particle(i).velocity=1;
         elseif cp(h) == c_old(h)
             particle(i).velocity=2;
         else
             particle(i).velocity=3;
           end
 best=zeros(T,1);
AVR=zeros(T,1);
   for t=1:T
     for i=1:NP
          particle(i).velocity=W*particle(i).velocity...
                              +(bparticle(i).pos-particle(i).pos)...
                              +(gparticle.pos-particle(i).pos);
         particle(i).pos=particle(i).pos+particle(i).velocity;
         particle(i).pos=min(particle(i).pos);
        particle(i).cost=fitpsores4(h,pw(h),q(h),ref_price);
         if particle(i).cost<bparticle(i).cost
             bparticle(i)=particle(i); 
             if bparticle(i).cost<gparticle.cost
                 gparticle=bparticle(i);
             end
         end
     end
 W=W*(1-alpha);
 best(t)=gparticle.cost;
 AVR(t)=particle.cost;
end
         if c_old>cp
             cp(h)=cp(h) + cp(h)/NP;
         else 
              cp(h)=cp(h) - cp(h)/NP;
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
 figure(1)
 
 plot(AVR(1:t),'b','LineWidth',2);
 xlabel('t');
 ylabel(' fitness ');

