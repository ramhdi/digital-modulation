% bpskdemod.m
% Demodulator BPSK
% ramhdi 08/04/2020

function [bit_out, mix, iad] = bpskdemod(xr, fc, Rb, oversamp)
  % demodulator menggunakan integrate-and-dump
  n = 0:1:(length(xr)-1); % sampel ke-n
  fsamp = Rb*oversamp; % frekuensi sampling
  N = length(xr)/oversamp; % jumlah bit
  c = sqrt(2*Rb)*cos(2*pi*fc*n/fsamp); % fungsi basis dari c(n) carrier
  mix = xr.*c; % mixer
  
  % integrate-and-dump
  recv22 = reshape(mix,[oversamp N])'; % mencacah mix menjadi matriks, untuk diintegral satu2
  recv222 = zeros(size(recv22));

  % fungsi transfer integrator
  b_int = [0 1/fsamp]; a_int = [1 -1];
  for i=1:1:N
    recv222(i,:) = filter(b_int,a_int,recv22(i,:)); % integrator
  endfor

  iad = reshape(recv222',[1 N*oversamp]); % menyusun kembali hasil integrate-and-dump
  bit_out = iad(oversamp:oversamp:end) > 0; % sampling bit keluaran
endfunction
