clear all 
close all 

ecg = load('ecg_lfn.dat');  
fs = 1000 ;
slen = length(ecg);
t = [1:slen]/fs ;
h= 1/2*[0.5 0 -1 ]; 

%------------3 point central difference----------------
midStartPoint = ceil(3/2); % First point at which full n points can be used
midEndPoint = slen-midStartPoint+1; % Last point at which full n points can be used

y(1) = (ecg(2)-ecg(1))/1;
y(slen) = (ecg(slen)-ecg(slen-1))/1;
for i= midStartPoint:midEndPoint
    y(i) = (ecg(i+1) - ecg(i-1))/(2);
    noise(i) = ecg(i) - y(i);
    %------------------noise level ------------------
    SNR(i) = 10 *log10(mean(y(i)).^2/mean(noise(i).^2));
    %------------------------------------------------
end
%-------------------------BPM------------------------
beat_count = 0 ; 
for k = 2:slen-18
       if(y(k) < y(k-1) & y(k)< y(k+1) & y(k)<-0.4) 
           % y(k) < peak value 
           beat_count = beat_count+1 ; 
       end
end

duration_in_seconds = length(y)/fs;
duration_in_minutes = duration_in_seconds/60;
BPM_avg = beat_count/duration_in_minutes;
%---------------------------------------------------



% show it on screen 
figure(1); 
subplot(2,1,1);
plot((10:9500)/fs ,y(10:9500)); 
axis tight;
xlabel('Time in seconds');
ylabel('ECG');
title('Centeral Difference');
grid on;


subplot(2,1,2);
plot((1:9500)/fs,SNR(1:9500));
axis tight; 
xlabel('Time in seconds');
ylabel('Noise Level(dB)');
title('SNR(db) = signal / noise ');

print('1000HzCentral_Difference', '-dpng', '-r600');