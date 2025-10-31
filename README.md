# ExplainableDataGeneration

Data Availability

The datasets analyzed in this study are all from publicly available datasets [1], which are downloaded from https://scglue.readthedocs.io/en/latest/data.html.

In addition, we also provide a preprocessed version using MATLAB, which can be downloaded from the following website:

https://pan.baidu.com/s/1XMR_o6vPU7RVCu0sur-1yg?pwd=4quu Password: 4quu

Code Availability

This demo is the implementation of the proposed EDG model on classification task.

The toolbox file of SVM.zip need to be decompressed. 

Please run the demo_classification.m, with Number indicating the sample number of original data. 

The parameter of Number indicates assuming the availability of only Number samples in real-world scenarios. In detail, we randomly select Number samples per category for training and data generation while using the remaining samples for testing, with the value of Number being 1, 2, 5, 10, 20, 50.

The experimental results with five repeats will be reported in SingleSample_Result, with the first column indicating the results on original data and the third column and subsequent columns indicating the results on generated data.


[1]Cao, Z.J. and Gao, G., 2022. Multi-omics single-cell data integration and regulatory inference with graph-linked embedding. Nature Biotechnology, 40(10), pp.1458-1466.
