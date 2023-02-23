clear
close all
clc

%% Choose model
UseModel=1;%1:DT,2:SVM，4:KNN,5:Boosting

%% Training data
MaxAccuracy = 0;TotalAccuracy = 0;A = [];AccRemainder = [];
result1 = [];result2 = [];result3 = [];result4 = [];


for ite = 1:1
Setting.per=0.1;
Setting.RowNumber=1000;
Setting.OverlapNumber=500;
Setting.UseDataDivide=2;
Setting.normalization=1;
Setting.HasColumNumber=true;
Setting.ColumNumber=[2610 1305 261];
% Setting.ColumNumber=[8*r 4*r 2*r];
Setting.name={'PD0730'};
Setting.need='PD0730';
Setting.TrainorTest = 1;

[Train]=GetOneDataFun(Setting);
[~,num1]=size(Train);


%% Testing data
Setting.per=0.99;
Setting.RowNumber=1000;
Setting.OverlapNumber=500;
Setting.UseDataDivide=2;
Setting.normalization=1;
Setting.HasColumNumber=true;
Setting.ColumNumber=[2610 1305 261];
Setting.name={'LongPD0730'};
Setting.need='LongPD0730';
Setting.TrainorTest = 0;

[Test]=GetOneDataFun(Setting);
[~,num2]=size(Test);
fprintf('# Train data：%d\n',num1);
fprintf('# Test data：%d\n',num2);


%% Data preprocessing (Deep learning)
% XTrain = Train(1:1000,:);
% XTest = Test(1:1000,:);
% YTrain = Train(end,:);
% YTest = Test(end,:);
% % XTrain = tonndata(XTrain,true,false)';
% % XTest = tonndata(XTest,true,false)';
% ntrain = size(XTrain, 2);
% ntest = size(XTest, 2);
% sX = size(XTrain,1);
% XTrain=reshape(XTrain,[size(XTrain,1),1,1,ntrain]);
% XTest=reshape(XTest,[size(XTest,1),1,1,ntest]);
% YTrain = categorical(YTrain)';% categorical
% YTest = categorical(YTest)';

%% Deep learning network settings
% layers = [
%     sequenceInputLayer(66,"Name","input")
%     bilstmLayer(128,"Name","bilstm","OutputMode","last")
%     dropoutLayer(0.1,"Name","dropout")
%     fullyConnectedLayer(3,"Name","fc")
%     softmaxLayer("Name","softmax")
%     classificationLayer("Name","classification")];
% layers = [
%     imageInputLayer([sX 1 1])
%     convolution2dLayer(3,32,"Name","conv1d_1","Padding","same")
%     reluLayer("Name","relu_1")
%     maxPooling2dLayer(5,"Name","maxpool1d_1","Padding","same")
%     convolution2dLayer(3,32,"Name","conv1d_2","Padding","same")
%     reluLayer("Name","relu_2")
%     maxPooling2dLayer(5,"Name","maxpool1d_2","Padding","same")
%     fullyConnectedLayer(3,"Name","fc")
%     softmaxLayer("Name","softmax")
%     classificationLayer("Name","classification")];
% 
% options = trainingOptions('adam', ...
%     'MaxEpochs',500, ...
%     'GradientThreshold',1, ...
%     'InitialLearnRate',0.005, ...
%     'LearnRateSchedule','piecewise', ...
%     'LearnRateDropPeriod',125, ...
%     'LearnRateDropFactor',0.2, ...
%     'Verbose',0, ...
%     'MiniBatchSize',1000, ...
%     'Plots','none');
% 
% 
% net = trainNetwork(XTrain,YTrain,layers,options);

%% Train & Test
switch UseModel
    case 1
    model=DT(Train);
    case 2
    model=SVM(Train);
    case 3
    model= KNN(Train);
    case 4
    model=Boosting(Train);
end
[Predictions,score]=model.predictFcn(Test(1:end-1,:));
[Con,SenSpe,Accuracy] = Metric(Test(end,:),Predictions,score);

% YPred=classify(net,XTrain);
% Trainacc = sum(YPred == YTrain)./numel(YTrain);
% 
% YPred=classify(net,XTest);
% Testacc = sum(YPred == YTest)./numel(YTest);
% Accuracy = Testacc;
%% Record results
if Accuracy > MaxAccuracy
    MaxAccuracy = Accuracy;
end
TotalAccuracy = TotalAccuracy + Accuracy;
A = [A; Accuracy];
AccRemainder = [AccRemainder; ite Accuracy];
    end
%     result1 = [result1;R(r) MaxAccuracy];
%     result2 = [result2;R(r) TotalAccuracy/ite];
%     result3 = [result3;R(r) sqrt(var(A))];
%     result4 = [result4;R(r) TotalAccuracy/ite MaxAccuracy sqrt(var(A))];
    TotalAccuracy = 0;MaxAccuracy = 0;A = [];



