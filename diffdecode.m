% diffdecode.m
% Differential decoding untuk bit DPSK
% ramhdi 08/04/2020

function bit_decoded = diffdecode(bit_encoded)
  N = length(bit_encoded)-1;
  bit_encoded_de = [0 bit_encoded(1:N)];
  bit_subtract = abs(bit_encoded .- bit_encoded_de);
  bit_decoded = bit_subtract(2:end);
endfunction
