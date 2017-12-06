function continuous_fft(data, Fs, plotHandle)
% Calculate FFT(data) and update plot with it. 
global i
global data2
data2(i:i+length(data)-1,:)=data;
i=i+length(data);

lengthOfData = length(data);
data=data(40:end,:);
data=data-mean(data);
w=hamming(size(data,1));
data=w.*data;

nextPowerOfTwo = 2 ^ nextpow2(lengthOfData); % next closest power of 2 to the length

plotScaleFactor = 4;
plotRange = nextPowerOfTwo / 2; % Plot is symmetric about n/2
plotRange = floor(plotRange / plotScaleFactor);

yDFT = fft(data, nextPowerOfTwo); % Discrete Fourier Transform of data

h = yDFT(1:plotRange,1:size(data,2));
abs_h = abs(h);
abs_h=20*log10(abs_h/size(data,2));

freqRange = (0:nextPowerOfTwo-1) * (Fs / nextPowerOfTwo);  % Frequency range
gfreq = freqRange(1:plotRange);  % Only plotting upto n/2 (as other half is the mirror image)


set(plotHandle, 'ydata', 1:8, 'xdata', gfreq,'zdata',abs_h'); % Updating the mesh
drawnow; % Update the plot

end


