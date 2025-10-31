

Generation_N_List = Number*[5 10 20];
SingleSample_Result = zeros(10,length(Generation_N_List)+2);
for iteration = 1:5
    disp('Begin')
    Data_Partition_Single_Sample
    
    % Origin
    [coeff,score,~,~,explained,mu] = pca(full(data.tr));
    idx = find(cumsum(explained)>96,1);
    X_tr = score(:,1:idx);
    X_te = (data.te-mu)*coeff(:,1:idx);
    Model_SVM = train(label.tr, sparse(double(X_tr)),'-s 0 -B 1 -c 30 -q');
    [predicted_label, acc, smn_I.te] = predict(label.te, sparse(double(X_te)), Model_SVM,' -b 1'); 
    Acc1 = sum(predicted_label==label.te)/length(label.te);
    SingleSample_Result(iteration,1) = Acc1;
    clear coeff explained Model_SVM score predicted_label smn_I X_tr X_te

    % Generation
    for Generation_N = 1:length(Generation_N_List)
        disp(strcat('N=',num2str(Number)))
        disp(strcat('i=',num2str(iteration)))
        disp(strcat('j=',num2str(Generation_N)))
        n = Generation_N_List(Generation_N);
        Generation_Classification
        SingleSample_Result(iteration,Generation_N+2) = Acc2;
        disp('End')
    end
end

SingleSample_Result(end,:) = sum(SingleSample_Result)/5;
