function [out] = combineCharact(in)
out(1,:)=mean(in);          % mean
temp=in.^2;
out(2,:)=mean(temp);        % mean square value
out(3,:)=sqrt(out(2,:));    % root mean square
out=[out;var(in)];           % variance
out=[out;std(in)];           % standard deviation
out=[out;kurtosis(in)];      % standard deviation
out=[out;fuli(in,30)];       %FFT
out=[out;findpsd(in,30)];   %PSD
end
