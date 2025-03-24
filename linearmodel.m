tab=table;
tab.Time=[6 7 8 6 7 8 6 7 8 6 7 8]';
tab.Knock=([0 0 0 0 0 0 1 1 1 1 1 1])';
tab.Prop=[0.1 0.2 0.3 0.2 0.3 0.4 0.7 0.8 0.9 .6 .7 .7]';
tab.Batch=[1,1,1]

model=fitlm(tab,'Prop~Time+Knock+Time*Knock+Batch')

model1=fitlm(tab,'Prop~Time+Knock')