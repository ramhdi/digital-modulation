% expandbit.m
% Expander bit ke sinyal NRZ unipolar
% ramhdi 06/04/2020

function y = expandbit(x,L)
  y = zeros(1,length(x)*L);
  for i=1:1:length(y)
    y(i)=x(ceil(i/L));
  endfor
endfunction
