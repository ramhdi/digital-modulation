% modulasi_bpsk.m
% Modulasi BPSK melalui GNU Octave
% ramhdi 08/04/2020
pkg load communications

fc = 3e2; % carrier
Rb = 1e2; % bitrate
oversamp=100;
N = 10;
bit_in = randn(1,N)>0;
fsamp = Rb*oversamp;
Ts = 1/fsamp;
%SNR = 10; % dB

[y,bit_expand,n] = bpskmod(bit_in, fc, Rb, oversamp);

t = n/(Rb*oversamp);
figure(1);
hold on;
plot(t,bit_expand);
plot(t,y);
hold off;
legend(['Input signal';'Modulated signal']);
xlabel('time (s)');
ylabel('voltage (V)');
title('Binary PSK Modulation');

xr=y;
[bit_out,mix,iad] = bpskdemod(xr, fc, Rb, oversamp);
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