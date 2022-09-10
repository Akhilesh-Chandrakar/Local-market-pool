function [as,at] = fuzzyrules(com,ret,bat)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if com==0 && ret==0 && bat==0
    at=-(0+(.3-0)*rand(1,1));
    as=.7+(1-.7)*rand(1,1);
elseif com==0 && ret~=0 && ret~=1 &&bat==0
    at=-(0+(.3-0)*rand(1,1));
    as=.7+(1-.7)*rand(1,1);
elseif com==0 && ret~=0 && ret~=1 && bat~=0 && bat~=1
    at=(0+(.3-0)*rand(1,1));
    as=-(0+(.3-0)*rand(1,1));
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
else
    at = 0;
    as = 0;
end
end

