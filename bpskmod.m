% bpskmod.m
% Modulator BPSK
% ramhdi 06/08/2020

function [xt,x,n] = bpskmod(bit_in, fc, Rb, oversamp)
  fsamp = Rb*oversamp; % frekuensi sampling
  x = expandbit(bit_in,oversamp); % mengubah bit menjadi sinyal unipolar NRZ
  bpsk_sym = 2*x-1;
  n = 0:1:length(bpsk_sym)-1;
  c = sqrt(2*Rb)*cos(2*pi*n*fc/fsamp);
  xt = c.*bpsk_sym;
endfunction
