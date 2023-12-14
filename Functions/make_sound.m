function [output] = make_sound(y, Fs, interval, count)
%  
    period = Fs/interval;
    peaks = zeros(1, count);

    tag = 1;
    for i = 1 : count
        peaks(1, i) = find(abs(y(tag:end, 1)) > 0.1, 1);
        if i > 1
            peaks(1, i) = peaks(1, i) + tag;
        end
        tag = peaks(1, i) + 11025;
    end
    
    clap_sounds = zeros(period*12, 2);

    for i = 1:count
        if i == 1
            clap_sounds(1:2*period, :) = y(peaks(1, i)-period: peaks(1, i) + period-1, :);
        else
            clap_sounds(period * i:period * (i+1)-1, :) = y(peaks(1, i): peaks(1, i) + period-1, :);
        end
    end
    
    output = clap_sounds;

end

