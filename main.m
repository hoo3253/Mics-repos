clc
clear all
devices = daq.getDevices;%%Shows the available devices
channels=devices.Subsystems(1,1).ChannelNames(1:8);%Create a vector with the name of the channels that are going to be used
s = daq.createSession('ni');
s.Rate = 44100;
s.IsContinuous = true; %To get the signals until stop the sesion and monitor the name of the channels
ch=addAnalogInputChannel(s,'Dev1', channels, 'Voltage');

%For each channel change the configuration and create the vector for the
%plot
for i=1:length(ch)
    ch(i).InputType='SingleEnded'; %Configures every input channel to measure the signal compared to the reference
    m(i,:)=ones(1,1000)*i;
    i
end

hf = figure;
%hp = plot(m');
hp=mesh(1:1000,1:length(ch),m) %Generating a mesh to watch all channels
T = title('Discrete FFT Plot');
xlabel('Frequency (Hz)')
zlabel('|FFT|')
ylabel('Channel')
% axis([100 600 1 8 0 600])
grid on;

plotFFT = @(src, event) continuous_fft(event.Data, src.Rate, hp);
lh = addlistener(s,'DataAvailable', plotFFT); 


global i
i=1;
global data2;

startBackground(s);
%%
stop(s);
s.IsContinuous = false;
delete(lh);

