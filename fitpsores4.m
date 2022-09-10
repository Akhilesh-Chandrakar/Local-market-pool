function [ out ] = fitpsores4( h,a,b,c)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 cp(h)=a-b;
     cp(h)=cp(h)/c;
    a=a/c;
out=cp(h);
end

