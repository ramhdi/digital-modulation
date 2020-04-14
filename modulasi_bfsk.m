% modulasi_bfsk.m
% Modulasi BFSK melalui GNU Octave
% ramhdi 06/04/2020
pkg load communications
% syarat ortogonal: fc2-fc1 = Rb
fc1 = 1e2; % carrier bit 0
fc2 = 3e2; % carrier bit 1
Rb = 1e2; % bitrate
oversamp=1000;
N = 10;
bit_in = randn(1,N)>0;
fsamp = Rb*oversamp;
Ts = 1/fsamp;
SNR = 10; % dB

[y,bit_expand,n]=bfskmod(bit_in,fc1,fc2,Rb,oversamp);
t = n/(Rb*oversamp);
figure(1);
hold on;
plot(t,bit_expand);
plot(t,y);
hold off;
legend(['Input signal';'Modulated signal']);
xlabel('time (s)');
ylabel('voltage (V)');
title('Binary FSK Modulation');

xr=y;
[bit_out,mix,iad] = bfskdemod(xr, fc1, fc2, Rb, oversamp);
figure(3);
stem(bit_out);
title('Received bits');
xlabel('samples');
%figure(4);
%plot(iad);
%figure(5);
%plot(mix);
ber = sum(bit_in ~= bit_out)/N;
disp(ber);