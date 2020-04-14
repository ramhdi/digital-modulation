% bpskmod.m
% Modulator BASK
% ramhdi 06/08/2020

function [xt,x,n] = baskmod(bit_in, fc, Rb, oversamp)
  fsamp = Rb*oversamp; % frekuensi sampling
  x = expandbit(bit_in,oversamp); % mengubah bit menjadi sinyal unipolar NRZ
  n = 0:1:length(x)-1;
  c = sqrt(2*Rb)*cos(2*pi*n*fc/fsamp);
  xt = c.*x;
endfunction
