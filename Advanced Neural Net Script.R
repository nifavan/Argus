#Run Argus through here to save time
program_directory<-"C:\\Users\\Matthew Scicluna\\Desktop\\Argus"
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Bypass GUI.txt",sep=''))
#Sets up training data for ML algorithms
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Extract Parameters From Trials2.txt",sep=''))

#Now set up test data
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Make Test Set2.txt",sep=''))

#Now we have assembled the training set, so we can choose which classifier we want to train using it
#To use a neural network with 5 way softmax output as classifier (1)
#source(paste(program_directory,"\\scripts\\Classifier Scripts\\Behavior NN Classifier 2.txt",sep=''))
#To use 4 neural networks with 2 way softmax output as classifier (2)
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Behavior NN Classifier multi trees.txt",sep=''))


#Now predict on unseen data
#To use neural network with 5 way softmax output as classifier (1)
#source(paste(program_directory,"\\scripts\\Classifier Scripts\\Predict Behavior2.txt",sep=''))
#To use 4 neural networks with 2 way softmax output as classifier (2)
source(paste(program_directory,"\\scripts\\Classifier Scripts\\Predict Behavior3.txt",sep=''))

#To get results
#write.csv(conmat3[4],file='testresults1')
#write.csv(conmat3[2],file='testresults2')
#write.csv(conmat3[3],file='testresults3')
