library('neuralnet')
library('nnet')
library('caret')
library('mlbench')
windowfeatures<-cbind(trainingset,
windowfeatures[,length(windowfeatures[1,])])

windowfeatpart<-list()
length(windowfeatpart)<-length(BEHAVIORLIST)
#seperate training data based on behaviors observed.
for (i in 1:length(BEHAVIORLIST))
{windowfeatpart[[i]]<-subset(windowfeatures,
windowfeatures[,length(windowfeatures[1,])]
==BEHAVIORLIST[i])}

#Train each behavior against default behavior in seperate  neural network. 
#Default behavior is assumed to be the last behavior listed.

trainingsets<-list()
length(trainingsets)<-length(BEHAVIORLIST)-1
trainingref<-list()
length(trainingref)<-length(BEHAVIORLIST)-1

for (i in 1:(length(BEHAVIORLIST)-1))
{trainingsets[[i]]<-rbind(windowfeatpart[[i]],windowfeatpart[[length(BEHAVIORLIST)]])
ref<-factor(trainingsets[[i]][,length(trainingsets[[i]][1,])],levels=BEHAVIORLIST)
labels<-class.ind(ref)
trainingset<-cbind(labels,trainingsets[[i]]
[,1:(length(trainingsets[[i]][1,])-1)])
trainingsets[[i]]<-matrix(as.numeric(trainingset),length(trainingset[,1]),
length(trainingset[1,]))
trainingref[[i]]<-ref
}

trainingsubsets<-list()
validsubsets<-list()
refvalid<-list()
reftraining<-list()

length(trainingsubsets)<-length(BEHAVIORLIST)-1
length(validsubsets)<-length(BEHAVIORLIST)-1
length(reftraining)<-length(BEHAVIORLIST)-1
length(refvalid)<-length(BEHAVIORLIST)-1


for (i in 1:length(trainingsets))
{if (!(all(trainingsets[[i]][,length(BEHAVIORLIST)]==1)))
{trainingsubset<-createDataPartition(y=trainingsets[[i]][,i],p=0.75,list=FALSE)
trainingsubsets[[i]]<-trainingsets[[i]][trainingsubset,]
validsubsets[[i]]<-trainingsets[[i]][-trainingsubset,]
reftraining[[i]]<-trainingref[[i]][trainingsubset]
refvalid[[i]]<-trainingref[[i]][-trainingsubset]
}}


formula <- paste(paste('trainingsubsets[[i]]  [,',1:5,']',collapse='+'),'~',
paste('trainingsubsets[[i]][,',6:105,']',collapse='+'))

bNNlst<-list()
length(bNNlst)<-length(validsubsets)

for (i in 1:length(bNNlst))
{if (length(trainingsubsets[[i]])!=0)
{bNNlst[[i]]<-neuralnet(formula, trainingsubsets[[i]], 
hidden = 1, threshold = 0.01,
stepmax = 1e+05, rep = 1, startweights = NULL,
learningrate.limit = NULL,
learningrate.factor = list(minus = 0.5, plus = 1.2),
learningrate=NULL, lifesign = "none",
lifesign.step = 1000, algorithm = "rprop+",
err.fct = "ce", act.fct = "logistic",
linear.output = FALSE, exclude = NULL,
constant.weights = NULL, likelihood = FALSE)}}

predictlist<-list()
length(predictlist)<-length(validsubsets)

#Predict on validation data
for (i in 1:length(bNNlst))
{if (length(bNNlst[[i]])!=0)
{predictions<-compute(bNNlst[[i]],
validsubsets[[i]][,(length(BEHAVIORLIST)+1):length(validsubsets[[i]][1,])])
predictlist[[i]]<-predictions$net.result
}}

conmatlst<-list()
length(conmatlst)<-length(bNNlst)
conmatlst2<-list()
length(conmatlst2)<-length(bNNlst)
trainingpredlist<-list()
length(trainingpredlist)<-length(bNNlst)
validpredlist<-list()
length(validpredlist)<-length(bNNlst)



for (i in 1:length(predictlist))
{for (j in 1:length(predictlist[[i]][,1]))
{ind<-which.max(predictlist[[i]][j,])
validpredlist[[i]][j]<-BEHAVIORLIST[ind]}}

for (i in 1:length(predictlist))
{refvalid[[i]]<-factor(refvalid[[i]],levels=BEHAVIORLIST)
validpredlist[[i]]<-factor(validpredlist[[i]],levels=BEHAVIORLIST)
conmatlst[[i]]<-confusionMatrix(validpredlist[[i]],refvalid[[i]])}

#Predict on Training data ie: ground truthing
for (i in 1:length(bNNlst))
{if (length(bNNlst[[i]])!=0)
{predictions<-compute(bNNlst[[i]],
trainingsubsets[[i]][,(length(BEHAVIORLIST)+1):length(trainingsubsets[[i]][1,])])
predictlist[[i]]<-predictions$net.result
}}

for (i in 1:length(predictlist))
{for (j in 1:length(predictlist[[i]][,1]))
{ind<-which.max(predictlist[[i]][j,])
trainingpredlist[[i]][j]<-BEHAVIORLIST[ind]}}

for (i in 1:length(predictlist))
{reftraining[[i]]<-factor(reftraining[[i]],levels=BEHAVIORLIST)
trainingpredlist[[i]]<-factor(trainingpredlist[[i]],levels=BEHAVIORLIST)
conmatlst2[[i]]<-confusionMatrix(trainingpredlist[[i]],reftraining[[i]])}

