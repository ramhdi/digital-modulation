% modulasi_dpsk.m
% Modulasi DPSK melalui GNU Octave
% ramhdi 08/04/2020
pkg load communications

fc = 3e2; % carrier
Rb = 1e2; % bitrate
oversamp=1000;
N = 10;
bit_in = randn(1,N)>0;
fsamp = Rb*oversamp;
Ts = 1/fsamp;
%SNR = 10; % dB

[y,bit_expand,bit_encoded,n] = dpskmod(bit_in, fc, Rb, oversamp);

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

%c = [zeros(1,oversamp/2) 1];
%xr = fftconv(y,c);

% demodulasi: pakai skema non-koheren
[bit_out, ich, qch, iiad, qiad, iad] = dpskdemod2(y, fc, Rb, oversamp);

figure;
stem(bit_out);
title('Received bits');
xlabel('samples');
%figure(4);
%plot(iad);
%figure(5);
%plot(mix);
ber = sum(bit_in ~= bit_out)/N;
disp(ber);