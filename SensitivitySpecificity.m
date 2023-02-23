function [out] = SensitivitySpecificity(A,tagNum)

ALL=sum(A(:));
for i=1:tagNum
    TP=A(i,i);
    FP=sum(A(:,i))-TP;
    FN=sum(A(i,:))-TP;
    TN = ALL - TP - FP - FN;
    Sen(i)=TP/(TP+FN);
    Spe(i)=TN/(TN+FP);
end
out=[Sen' Spe'];

end

