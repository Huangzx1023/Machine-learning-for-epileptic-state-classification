function [out] = GetOneDataFun(Setting) 
%% 参数初始化

tag={'Control','Preictal','Seizure'};
OverlapTag={'Seizure'}; 
NormalTag={'Control','Preictal'}; 
setname={'test','train'};
FinName={'Test','Train'};


    per=Setting.per;
    RowNumber=Setting.RowNumber;

    OverlapNumber=Setting.OverlapNumber;


if Setting.HasColumNumber
    ColumNumber=Setting.ColumNumber;  
end


    UseDataDivide=Setting.UseDataDivide;

    normalization=Setting.normalization;

name=Setting.name;
%name={'W','Cu','PD'};       
%name={'LongW'};


%% load data
fprintf('Loading data');
for i=1:length(name)
    fprintf([',',name{i}]);
    eval(['load(''',name{i},'.mat'');']);
end
fprintf('\n');

%% 重叠处理数据

for i=1:length(name)
    for j=1:length(OverlapTag)
        eval([name{i},'1024_',OverlapTag{j},'=do1024(',name{i},'_',OverlapTag{j},',RowNumber,OverlapNumber);']);
        eval(['clear ',name{i},'_',OverlapTag{j},';']);
    end
end
        
%% 逐段处理数据

for i=1:length(name)
    for j=1:length(NormalTag)
        eval([name{i},'1024_',NormalTag{j},'=StrongReshape(',name{i},'_',NormalTag{j},',RowNumber);']);
        eval(['clear ',name{i},'_',NormalTag{j},';']);
    end
end

%% 随机抽取样本

for i=1:length(NormalTag)
    for j=1:length(name)
        eval(['[~,L(j)]=size(',name{j},'1024_',NormalTag{i},');']);
    end
    NewColunm=floor(min(L)/UseDataDivide);
    for j=1:length(name)
        if exist('ColumNumber','var') == 1
            eval([name{j},'_done_',NormalTag{i},'=ds(',name{j},'1024_',NormalTag{i},',ColumNumber(i));']);
        else
            eval([name{j},'_done_',NormalTag{i},'=ds(',name{j},'1024_',NormalTag{i},',NewColunm);']);
        end
        eval(['clear ',name{j},'1024_',NormalTag{i}]);
    end
    fprintf(NormalTag{i});
    fprintf('%d\n',NewColunm);
end
  
%% 分段抽取样本
for i=1:length(OverlapTag)
    for j=1:length(name)
        eval(['[~,L(j)]=size(',name{j},'1024_',OverlapTag{i},');']);
    end
    NewColunm=floor(min(L)/UseDataDivide);
    for j=1:length(name)
        if exist('ColumNumber','var') == 1
            eval([name{j},'_done_',OverlapTag{i},'=dsS(',name{j},'1024_',OverlapTag{i},',ColumNumber(i+2));']);
        else
            eval([name{j},'_done_',OverlapTag{i},'=dsS(',name{j},'1024_',OverlapTag{i},',NewColunm);']);
        end
        eval(['clear ',name{j},'1024_',OverlapTag{i}]);
    end
    fprintf(OverlapTag{i});
    fprintf('%d\n',NewColunm);
end
%% 滤波器
% fprintf('Filter')
% for i=1:length(name)
%     fprintf([',',name{i}]);
%     for j=1:length(tag)
%         eval([name{i},'_band_',tag{j},'=bandpass(',name{i},'1024_',tag{j},',fpass,fs);'])
%         eval(['clear ',name{i},'1024_',tag{j},';']);
%     end
% end
% fprintf('\n');

%% 傅里叶

for i=1:length(name)
    for j=1:length(tag)
        eval([name{i},'_Fil_',tag{j},'=fuli1024(',name{i},'_done_',tag{j},');']);
        eval(['clear ',name{i},'_done_',tag{j},';']);
    end
end

%% 转化为数据集

for i=1:length(name)

%         eval(['[',name{i},'train, ',name{i},'test10, ',name{i},'test30, ',name{i},'test,',...
%             name{i},'_train_lable,',name{i},'_test10_lable,',name{i},'_test30_lable,',...
%             name{i},'_test_lable',']=spawnDataSet(',...
%             name{i},'_Fil_Control,',name{i},'_Fil_Preictal_10,',name{i},'_Fil_Preictal_30,',...
%             name{i},'_Fil_Seizure,per);']);
%         
%         eval(['clear ',name{i},'_Fil_Control ',name{i},'_Fil_Preictal_10 ',name{i},'_Fil_Preictal_30 ',...
%             name{i},'_Fil_Seizure;']);


        eval(['[',name{i},', lable, ]=DivideData3Kind_combine(',name{i},...
            '_Fil_Seizure, ',name{i},'_Fil_Preictal, ',...
            name{i},'_Fil_Control);']);
        eval(['clear ',name{i},'_Fil_Control ',name{i},'_Fil_Preictal ',...
             name{i},'_Fil_Seizure;']);
   
        
end

%% 特征提取与组合
fprintf('Extracting features')
for i=1:length(name)
    fprintf([',',name{i}]);
        eval([name{i},'_ch=combineCharact(',name{i},');']);
        eval(['clear ',name{i},';']);
end
fprintf('\n')

%% 进行归一化

if normalization==1
    for i=1:length(name)

            eval([name{i},'_map=(mapminmax(zscore((',name{i},'_ch)''),0,1))'';']);
            eval(['clear ',name{i},'_ch;']);

    end
else


for i=1:length(name)

        eval([name{i},'_map','_map=(mapminmax(zscore((',name{i},'_ch)),0,1));']);
        eval(['clear ',name{i},'_',setname{j},'_ch;']);
        eval(['clear ',name{i},';']);
        eval(['clear ',name{i},'_train_ch ',name{i},'_test_ch']);
end

eval(['clear tempTest tempTrain']);
end

%% 打标签
fprintf('Labeling\n')
for i=1:length(name)

        eval([name{i},'=[',name{i},'_map ;lable','];']);

end


eval(['out=',Setting.need,';'])
%% 清除多余变量
clear FinName fpass fs i j name NormalTag OverlapNumber OverlapTag per RowNumber setname tag L NewColunm...
    ColumNumber UseDataDivide normalization

end

