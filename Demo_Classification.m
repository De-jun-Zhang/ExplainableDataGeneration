
%% Single Sample Classification

clc
clear
load BioData2.mat
Data = Data{1};
Number = 5;
Main_Generation_Classification
save(strcat(strcat('Classification_',num2str(Number)),'.mat'), 'SingleSample_Result');

clc
clear
load BioData2.mat
Data = Data{1};
Number = 10;
Main_Generation_Classification
save(strcat(strcat('Classification_',num2str(Number)),'.mat'), 'SingleSample_Result');

clc
clear
load BioData2.mat
Data = Data{1};
Number = 20;
Main_Generation_Classification
save(strcat(strcat('Classification_',num2str(Number)),'.mat'), 'SingleSample_Result');

clc
clear
load BioData2.mat
Data = Data{1};
Number = 2;
Main_Generation_Classification
save(strcat(strcat('Classification_',num2str(Number)),'.mat'), 'SingleSample_Result');

clc
clear
load BioData2.mat
Data = Data{1};
Number = 1;
Main_Generation_Classification
save(strcat(strcat('Classification_',num2str(Number)),'.mat'), 'SingleSample_Result');

clc
clear
load BioData2.mat
Data = Data{1};
Number = 50;
Main_Generation_Classification
save(strcat(strcat('Classification_',num2str(Number)),'.mat'), 'SingleSample_Result');

