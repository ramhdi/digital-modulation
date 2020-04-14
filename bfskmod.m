% bfskmod.m
% Modulator BFSK
% ramhdi 06/04/2020

function [xt,x,n] = bfskmod(bit_in, fc1, fc2, Rb, oversamp)
  fsamp = Rb*oversamp; % frekuensi sampling
  fc = fc1; % frekuensi carrier bit 0
  kf = fc2-fc1; % sensitivitas modulator VCO
  x = expandbit(bit_in,oversamp); % mengubah bit menjadi sinyal unipolar NRZ
  [xt,n] = vco(x,fc,kf,fsamp);
  xt = sqrt(2*Rb)*xt;
endfunction
