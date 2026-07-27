function [number]=PhoneNumber(signal,rate)
%PHONENUMBER converts signal into a number.
%   [NUMBER]=PHONENUMBER(SIGNAL, RATE) uses fft to convert signal
%   consisting of linear combinations of two sines and noise into a number.
%   RATE is the sampling rate.

% separates the signal into sections with length LENGTHOFCHECK
lengthOfCheck = 20;
L = length(signal) / lengthOfCheck;

% checks every such section as mentioned above
digitSignal = [];
number = [];
for i = 0:floor(L)-1
    values = signal(lengthOfCheck*i+1 : lengthOfCheck*(i+1));
    
    % if the average of values in a particular section is above 0.2, then
    % that section is connected with other neighboring sections chich are
    % also above 0.2 on average
    % these sections together form a digit
    % if the average is below 0.2, then such a section is ignored (this
    % can also mean an end of a digit)
    if mean(abs(values)) > 0.2
        digitSignal = [digitSignal; values];
    elseif ~isempty(digitSignal)
        newDigit = findDigit(digitSignal);
        number = [number, newDigit];
        digitSignal = [];
    end
end


    function [digit] = findDigit(digitSignal)
        % converts signal, corresponding to one digit, into a digit
        
        % converts the signal into Fourier transform
        % disregards the mirrored part of Fourier transforms
        N = length(digitSignal);
        y = abs(fft(digitSignal)*2/N);
        y = y(1:N/2+1);
        f = (0:N/2)*rate/N;
        
        % finds frequencies related to two greatest Fourier coefficients
        % gets rid of noise in this way
        widthOfPeak = 10;
       
        [~,idx] = max(y);
        frequency1 = f(idx);
        
        % deletes the maximal Fourier transform and neighboring values so
        % that the second highest FT becomes maximal
        y(idx-widthOfPeak : idx+widthOfPeak) = ...
            zeros([1 length(y(idx-widthOfPeak : idx+widthOfPeak))]);
        
        [~,idx] = max(y);
        frequency2 = f(idx);
        
        % determines which found frequency is greater
        if frequency1 < frequency2
            higherFrequency = frequency2;
            lowerFrequency = frequency1;
        else
            higherFrequency = frequency1;
            lowerFrequency = frequency2;
        end
        
        % relates determined frequencies with the frequencies in the table
        b=[1209 1336 1477];
        [~,idx]=min(abs(b-higherFrequency));
        highFrequency = b(idx);
        
        a=[697 770 852 941];
        [~,idx]=min(abs(a-lowerFrequency));
        lowFrequency = a(idx);
        
        % determines the digit related to the combination of frequencies
        % from the table
        if highFrequency == 1209
            if lowFrequency == 697
                digit = 1;
            elseif lowFrequency == 770
                digit = 4;
            elseif lowFrequency == 852
                digit = 7;
            else
                digit = "*";
            end
        elseif highFrequency == 1336
            if lowFrequency == 697
                digit = 2;
            elseif lowFrequency == 770
                digit = 5;
            elseif lowFrequency == 852
                digit = 8;
            else
                digit = 0;
            end
        else
            if lowFrequency == 697
                digit = 3;
            elseif lowFrequency == 770
                digit = 6;
            elseif lowFrequency == 852
                digit = 9;
            else
                digit = "#";
            end
        end
        
    end

end