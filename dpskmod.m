% dpskmod.m
% Modulator DPSK
% ramhdi 06/08/2020

function [xt,bit_expand,bit_encoded,n] = dpskmod(bit_in, fc, Rb, oversamp)
  bit_encoded = diffencode(bit_in); % differential encoding
  [xt,bit_expand,n] = bpskmod(bit_encoded, fc, Rb, oversamp); % modulasi bpsk biasa
endfunction
