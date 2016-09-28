#Run Argus through here to save time
program_directory<-"C:\\Users\\Matthew Scicluna\\Desktop\\Argus"
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Bypass GUI.txt",sep=''))
#Sets up training data for ML algorithms
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Extract Parameters From Trials.txt",sep=''))

#Now set up test data
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Make Test Set.txt",sep=''))

#Now we have assembled the training set, so we can choose which classifier we want to train using it
#To use a neural network with 5 way softmax output as classifier (1)
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Behavior Neural Network Classifier.txt",sep=''))

#Now predict on unseen data
#To use neural network with 5 way softmax output as classifier (1)
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Predict Behavior.txt",sep=''))

#Now compare with the actual results (1)
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Compare Prediction.txt",sep=''))
