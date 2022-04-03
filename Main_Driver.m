%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%                                                                  %%%%
%%%%    Classifier Machine Learning - Task 5 - Gabriel Gattaux        %%%%
%%%%                            LSTM Network                          %%%%
%%%%                           10/06/2021                             %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This classifier use the LSTM network algorithm
function Main_Driver(QFigure,Trainingprogres)

clearvars -except QFigure Trainingprogres
close all;clc;

% QFigure = 0; %0 for no figure, 1 for figure
% Trainingprogres = 1;

%Put the path of the differents Folder for the training and Folder to
%classify

TRpath(1) = "Data_Train\business";
TRpath(2) = "Data_Train\sport";
TRpath(3) = "Data_Train\entertainment";
TRpath(4) = "Data_Train\politics";
TRpath(5) = "Data_Train\tech";

ToClassifyPath = "Data_To_Classify";

%Import the Data
Dataset =readDataSet2(TRpath);

%convert label to categorical
Dataset.Category = categorical(Dataset.Category);

%View the distribution of the classes in the data using a histogram.
if QFigure == 1
    figure
    histogram(Dataset.Category);
    xlabel("Class")
    ylabel("Frequency")
    title("Class Distribution")
end

%partition it into set for training and validation. Holdout percentage is
%how ;uch data for training and how much for validation
cvp = cvpartition(Dataset.Category,'Holdout',0.15);
dataTrain = Dataset(training(cvp),:);
dataValidation = Dataset(test(cvp),:);

%Extract the text data and labels from the partitioned tables
textDataTrain = dataTrain.DataPress;
textDataValidation = dataValidation.DataPress;
YTrain = dataTrain.Category;
YValidation = dataValidation.Category;


if QFigure == 1
    figure
    wordcloud(textDataTrain);
    title("Training Data")
end

documentsTrain = preprocessText(textDataTrain);
documentsValidation = preprocessText(textDataValidation);


if QFigure == 1
    figure
    wordcloud(documentsTrain);
    title("Training Data cleaned")
end

%documentsTrain(1:5)

%word encoding to convert the documents into sequences of numeric indices
enc = wordEncoding(documentsTrain);

documentLengths = doclength(documentsTrain);

if QFigure == 1
    figure
    histogram(documentLengths)
    title("Document Lengths")
    xlabel("Length")
    ylabel("Number of Documents")
end

sequenceLength = 600;
XTrain = doc2sequence(enc,documentsTrain,'Length',sequenceLength);
%XTrain(1:5)

XValidation = doc2sequence(enc,documentsValidation,'Length',sequenceLength);

%Define the LSTM network architecture
inputSize = 1;
embeddingDimension = 50;
numHiddenUnits = 80;
%numHiddenUnits = 80
%numHiddenUnits = 70
numWords = enc.NumWords;
numClasses = numel(categories(YTrain));

layers = [ ...
    sequenceInputLayer(inputSize)
    wordEmbeddingLayer(embeddingDimension,numWords)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

%minibatch 16
%minibatch =8, we have accuracy 85,5% and 1 error in classifier
if Trainingprogres == 1
    options = trainingOptions('adam', ...
        'MiniBatchSize',8, ... %93 avec 8
        'GradientThreshold',2, ... %93 avec 1
        'Shuffle','every-epoch', ...
        'ValidationData',{XValidation,YValidation}, ...
        'Plots','training-progress', ...
        'ValidationPatience',3, ...
        'VerboseFrequency',200, ...
        'InitialLearnRate',0.001, ...
        'MaxEpochs',7,...
        'Verbose',true);
    
else 
    options = trainingOptions('adam', ...
        'MiniBatchSize',8, ... %93 avec 8
        'GradientThreshold',2, ... %93 avec 1
        'Shuffle','every-epoch', ...
        'ValidationData',{XValidation,YValidation}, ...
        'ValidationPatience',3, ...
        'VerboseFrequency',200, ...
        'InitialLearnRate',0.001, ...
        'MaxEpochs',6,...
        'Verbose',true);
end

disp('LSTM Network Training ...  ');
tic;
net = trainNetwork(XTrain,YTrain,layers,options);
toc;
disp(['LSTM Network Training complete ! ',toc, ' ']);

%Import the datas to classify
[reportsNew,filename] = readNewReport();

%preprocess the news datas
documentsNew = preprocessText(reportsNew);

XNew = doc2sequence(enc,documentsNew,'Length',sequenceLength);

%Put the new category t0 data classified
labelsNew = classify(net,XNew);

Classification = [string(filename) , string(labelsNew)]
writematrix(Classification,'Classified\DatatoCl_CL.txt','Delimiter','bar');

%confusion matrix
YPredicted = classify(net,XTrain);
confusionchart(YTrain,YPredicted);

end