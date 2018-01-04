function continuous_fft(data, Fs)
% Calculate FFT(data) and update plot with it. 
global i
global data2
global data3
data3(i:i+length(data)-1,:)=data;
i=i+length(data);

lengthOfData = length(data);
data2=data;
% data=data(40:end,:);
data=data-mean(data);
w=hamming(size(data,1));
data=w.*data;

nextPowerOfTwo = 2 ^ nextpow2(lengthOfData); % next closest power of 2 to the length

plotScaleFactor = 1;
plotRange = nextPowerOfTwo / 2; % Plot is symmetric about n/2
plotRange = floor(plotRange / plotScaleFactor);

yDFT = fft(data, nextPowerOfTwo); % Discrete Fourier Transform of data

h = yDFT(1:plotRange,1:size(data,2));
abs_h = abs(h);
% abs_h=20*log10(abs_h/size(data,1));

freqRange = (0:nextPowerOfTwo-1) * (Fs / nextPowerOfTwo);  % Frequency range
gfreq = freqRange(1:plotRange);  % Only plotting upto n/2 (as other half is the mirror image)


subplot(2,1,1)
plot(data2)
% axis([0 4500 -4 4])
grid on;

subplot(2,1,2)
plot(gfreq,abs_h)
axis([200 1500 0 300])
ylabel('|FT|')
grid on;
% 
% subplot(2,2,3)
% plot(data2(:,2))
% 
% % axis([0 4096 -1 1])
% grid on;
% 
% subplot(2,2,4)
% plot(gfreq,abs_h(:,2))
% axis([0 1500 -40 -80])
% ylabel('|FT|')
% grid on;

% % set(plotHandle, 'ydata', abs_h(:,1), 'xdata', gfreq); % Updating the plot
% subplot(2,1,2)
% plot(data2)
% xlabel('Frequency (Hz)')
% ylabel('|Y(f)|')
% grid on;
% set(plotHandle, 'ydata', abs_h(:,2), 'xdata', gfreq); % Updating the plot

%set(plotHandle, 'ydata', 1:size(data,2), 'xdata', gfreq,'zdata',abs_h'); % Updating the mesh
drawnow; % Update the plot

end


