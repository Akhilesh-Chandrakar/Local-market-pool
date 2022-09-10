function [out] = membership(input_value,a,b,c,d)
if input_value >= d
            mvalue = 1.0;
elseif input_value <= a 
            mvalue = 0.0;
elseif input_value < b
            mvalue = (input_value -a) / (b - a);
elseif input_value > c
            mvalue = (input_value - d) / (c - d);
else
            mvalue = 0.0;
%         tot=membership_value;

end
out=mvalue;
end

