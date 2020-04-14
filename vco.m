% vco.m
% Modulator VCO
% ramhdi 06/04/2020

function [y,n] = vco(x,fc,kf,fsamp)
  b = [0 1/fsamp]; % pembilang fungsi transfer fasa VCO domain z
  a = [1 -1]; % penyebut fungsi transfer fasa VCO domain z
  int_x = filter(b,a,x); % integrator frekuensi -> fasa
  n = 0:1:(length(int_x)-1); % sampel ke-n
  theta = 2*pi*(fc/fsamp)*n + 2*pi*kf*int_x; % fasa VCO
  y = cos(theta);
endfunction
