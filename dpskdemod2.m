% dpskdemod2.m
% Demodulator DPSK
% ramhdi 13/04/2020

function [bit_out, ich, qch, iiad, qiad, iad] = dpskdemod2(xr, fc, Rb, oversamp)
  % demodulator quadrature menggunakan integrate-and-dump
  n = 0:1:(length(xr)-1); % sampel ke-n
  fsamp = Rb*oversamp; % frekuensi sampling
  N = length(xr)/oversamp; % jumlah bit
  ich = xr.*(sqrt(2*Rb)*cos(2*pi*fc*n/fsamp)); % mixer in-phase
  qch = xr.*(sqrt(2*Rb)*sin(2*pi*fc*n/fsamp)); % mixer quadrature

  % integrate-and-dump
  % mencacah ich dan qch menjadi matriks, untuk diintegral satu2
  idemodd = reshape(ich,[oversamp N])'; 
  idemoddd = zeros(size(idemodd));
  qdemodd = reshape(qch,[oversamp N])';
  qdemoddd = zeros(size(qdemodd));

  % fungsi transfer integrator
  b_int = [0 1/fsamp]; a_int = [1 -1];
  for i=1:1:N
    % integrator
    idemoddd(i,:) = filter(b_int,a_int,idemodd(i,:));
    qdemoddd(i,:) = filter(b_int,a_int,qdemodd(i,:));
  endfor

  % menyusun kembali hasil integrate-and-dump
  iiad = reshape(idemoddd',[1 N*oversamp]);
  qiad = reshape(qdemoddd',[1 N*oversamp]);
  iad = iiad + qiad;
  bit_sampled = iad(oversamp:oversamp:end) > 0; % sampling bit keluaran
  bit_out = diffdecode(bit_sampled);
endfunction
