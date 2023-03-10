function [trainedClassifier, validationAccuracy] = SVM(trainingData)

inputTable = array2table(trainingData', 'VariableNames', {'row_1', 'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66', 'row_67'});

predictorNames = {'row_1', 'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66'};
predictors = inputTable(:, predictorNames);
response = inputTable.row_67;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

template = templateSVM(...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder', 3, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true);
classificationSVM = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone', ...
    'ClassNames', [0; 1; 2]);

predictorExtractionFcn = @(x) array2table(x', 'VariableNames', predictorNames);
svmPredictFcn = @(x) predict(classificationSVM, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(predictorExtractionFcn(x));

trainedClassifier.ClassificationSVM = classificationSVM;
trainedClassifier.About = '????????????????????????????????? R2021a ????????????????????????';
trainedClassifier.HowToPredict = sprintf('?????????????????????????????? X ????????????????????????: \n yfit = c.predictFcn(X) \n??? ''c'' ?????????????????????????????????????????????????????? ''trainedModel''???\n \nX ?????????????????? 66 ????????????????????????????????? 66 ?????????????????????????????????\nX ?????????????????????????????????????????????????????????????????????\n??????????????????????????????????????????????????? App ???????????????\n \n?????????????????????????????? <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>???');

inputTable = array2table(trainingData', 'VariableNames', {'row_1', 'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66', 'row_67'});

predictorNames = {'row_1', 'row_2', 'row_3', 'row_4', 'row_5', 'row_6', 'row_7', 'row_8', 'row_9', 'row_10', 'row_11', 'row_12', 'row_13', 'row_14', 'row_15', 'row_16', 'row_17', 'row_18', 'row_19', 'row_20', 'row_21', 'row_22', 'row_23', 'row_24', 'row_25', 'row_26', 'row_27', 'row_28', 'row_29', 'row_30', 'row_31', 'row_32', 'row_33', 'row_34', 'row_35', 'row_36', 'row_37', 'row_38', 'row_39', 'row_40', 'row_41', 'row_42', 'row_43', 'row_44', 'row_45', 'row_46', 'row_47', 'row_48', 'row_49', 'row_50', 'row_51', 'row_52', 'row_53', 'row_54', 'row_55', 'row_56', 'row_57', 'row_58', 'row_59', 'row_60', 'row_61', 'row_62', 'row_63', 'row_64', 'row_65', 'row_66'};
predictors = inputTable(:, predictorNames);
response = inputTable.row_67;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

partitionedModel = crossval(trainedClassifier.ClassificationSVM, 'KFold', 5);

[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
