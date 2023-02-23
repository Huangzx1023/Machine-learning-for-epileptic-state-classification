function [trainedClassifier, validationAccuracy] = Boosting(trainingData)

inputTable = array2table(trainingData', 'VariableNames', {'row_1', 'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66', 'row_67'});

predictorNames = {'row_1', 'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66'};
predictors = inputTable(:, predictorNames);
response = inputTable.row_67;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];


template = templateTree(...
    'MaxNumSplits', 20);
classificationEnsemble = fitcensemble(...
    predictors, ...
    response, ...
    'Method', 'AdaBoostM2', ...
    'NumLearningCycles', 30, ...
    'Learners', template, ...
    'LearnRate', 0.1, ...
    'ClassNames', [0; 1; 2]);


predictorExtractionFcn = @(x) array2table(x', 'VariableNames', predictorNames);
ensemblePredictFcn = @(x) predict(classificationEnsemble, x);
trainedClassifier.predictFcn = @(x) ensemblePredictFcn(predictorExtractionFcn(x));

trainedClassifier.ClassificationEnsemble = classificationEnsemble;
trainedClassifier.About = '此结构体是从分类学习器 R2021a 导出的训练模型。';
trainedClassifier.HowToPredict = sprintf('要对新预测变量行矩阵 X 进行预测，请使用: \n yfit = c.predictFcn(X) \n将 ''c'' 替换为作为此结构体的变量的名称，例如 ''trainedModel''。\n \nX 必须包含正好 66 个行，因为此模型是使用 66 个预测变量进行训练的。\nX 必须仅包含与训练数据具有完全相同的顺序和格式的\n预测变量行。不要包含响应行或未导入 App 的任何行。\n \n有关详细信息，请参阅 <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>。');

inputTable = array2table(trainingData', 'VariableNames', {'row_1', 'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66', 'row_67'});

predictorNames = {'row_1', 'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66'};
predictors = inputTable(:, predictorNames);
response = inputTable.row_67;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];


partitionedModel = crossval(trainedClassifier.ClassificationEnsemble, 'KFold', 5);

[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
