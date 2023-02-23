function [Con,SenSpe,Accuracy,ROCfigure] = Metric(RealData,Predictions,score)
%% confusion matrix
Con=confusionmat(RealData,Predictions); %confusion matrix
SenSpe= SensitivitySpecificity(Con,length(Con));%Sensitivity & Specificity

%% Acc
S=0;
for i=1:length(RealData)
    if RealData(i)==Predictions(i)
        S=S+1;
    end
end
Accuracy=S/length(RealData);
fprintf('Accuracy：%.4f\n',Accuracy);

%% ROC
ROCfigure=cell(1,length(Con));
AUC=zeros(1,length(Con));
for i=1:length(Con) 
    ClassNames=unique(RealData); 
    kk=i; 
    posclass=ClassNames(kk);
    group=RealData;
    %eval(['[x_roc',num2str(i),',y_roc',num2str(i),',~,auc',num2str(i),']=perfcurve(group,validationScores(:,kk),posclass);']);
    [x_roc,y_roc,~,auc]=perfcurve(group,score(:,kk),posclass);
    AUC(i)=auc;
    
    plot(x_roc,y_roc,'linewidth',1.5);
    hold on
    figureDetile.x_roc=x_roc;
    figureDetile.y_roc=y_roc;
    figureDetile.auc=auc;
    ROCfigure{i}=figureDetile;
end


%% plot
xlabel('False Positive Rate')
ylabel('True Positive Rate')

TEXT=cell(1,length(Con));
for i=1:length(Con)
    eval(['TEXT{',num2str(i),'}=[''Positive：',num2str(i-1),',auc=',num2str(AUC(i)),'''];'])
    %eval(['legend(''Positive：',num2str(i),',auc=',num2str(AUC(i)),''')'])
    %legend('0','1','2');
end
legend(TEXT,'Location','SouthEast');
title('ROC')
end

