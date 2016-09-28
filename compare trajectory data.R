program_directory<-"C:\\Users\\Matthew Scicluna\\Desktop\\Argus"
source(paste(program_directory,"\\scripts\\Load GUI.txt",sep=''))


data1 #total dist travelled
data16 #dist from bottom

tdt.5<-totaldisttravelled
dfm.5<-distfrombottom

totaldisttravelled<-data1
distfrombottom<-data16

totaldisttravelledetho<-read.xlsx("C:\\Users\\Matthew Scicluna\\Desktop\\fish tracker test\\Chronic - Total Distance.xlsx",1)
totaldisttravelledetho<-totaldisttravelledetho[-21,8:67]

distfrombottometho<-read.xlsx("C:\\Users\\Matthew Scicluna\\Desktop\\fish tracker test\\Chronic - Distance from Bottom.xlsx",1)
distfrombottometho<-distfrombottometho[-21,8:67]

res1<-distfrombottometho-distfrombottom
boxplot(t(res1),las=2, names=1:20,main='Distance From Bottom Residuals', xlab='Trial', ylab='Residual')
tmat<-colMeans(t(res1))
tmat<-unlist(tmat)
t.test(tmat)

res2<-totaldisttravelledetho-totaldisttravelled
boxplot(t(res2),las=2, names=1:20,main='Total Distance Travelled Residuals', xlab='Trial', ylab='Residual')
tmat<-colMeans(t(res2))
tmat<-unlist(tmat)
t.test(tmat)
