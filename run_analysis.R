xtest<-read.table("X_test.txt")
ytest<-read.table("Y_test.txt")
subtest<-read.table("subject_test.txt")
features<-read.table("features.txt")
activitylabels<-read.table("activity_labels.txt")

features<-as.character(features$V2)
features<-gsub("\\()","",features)
features<-tolower(gsub("-","",features))
colnames(xtest)<-features
xtest<-xtest[,grepl("mean[x-z]|std[x-z]|mean$|std$",features)]
ytest<-as.factor(ytest$V1)
activitylabels<-as.character(activitylabels$V2)
levels(ytest)<-activitylabels
dtest<-cbind(subtest,ytest,xtest)
names(dtest)[1]<-"subject"
names(dtest)[2]<-"activity"

xtrain<-read.table("X_train.txt")
ytrain<-read.table("Y_train.txt")
subtrain<-read.table("subject_train.txt")
colnames(xtrain)<-features
xtrain<-xtrain[,grepl("mean[x-z]|std[x-z]|mean$|std$",features)]
ytrain<-as.factor(ytrain$V1)
levels(ytrain)<-activitylabels
dtrain<-cbind(subtrain,ytrain,xtrain)
names(dtrain)[1]<-"subject"
names(dtrain)[2]<-"activity"

dfinal<-arrange(rbind(dtest,dtrain),subject)
dmelt<-melt(dfinal,id.vars=c("subject","activity"),measure.vars = colnames(dfinal[,3:50]))
subjectaverage<-dcast(dmelt,subject+activity~variable,mean)
rm(subtest,subtrain,xtest,ytest,ytest,ytrain,dmelt,dtest,dtrain,features,activitylabels,xtrain)