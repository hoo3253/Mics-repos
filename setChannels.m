function setChannels(mics,value)
    global channels         
    if value==1
        if ~isempty(channels) 
            channels{size(channels,1)+1,1}=mics;            
        else
            channels{1,1}=mics;
        end         
    else
         if ~isempty(channels)
             for i=1:length(channels)
                if isequal(channels{i},mics)                    
                    channels{i}=[];
                    channels=channels(~cellfun('isempty',channels));
                    break
                end                 
             end             
         end
    end
end