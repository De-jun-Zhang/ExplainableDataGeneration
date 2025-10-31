
%% Train SVM
% % Dimension Reduction
% [coeff,score,~,~,explained,mu] = pca(full(data.tr));
% idx = find(cumsum(explained)>95,1);
% % idx = 2000;
%     X_tr = score(:,1:idx);
%     X_te = (data.te-mu)*coeff(:,1:idx);
%     % X_tr = normalize(X_tr,'range');
%     % X_te = normalize(X_te,'range');
% 
%     Model_SVM = train(label.tr, sparse(double(X_tr)),'-s 0 -B 1 -c 30 -q');
%     [predicted_label, acc, smn_I.te] = predict(label.te, sparse(double(X_te)), Model_SVM,' -b 1'); 
%     Acc1 = sum(predicted_label==label.te)/length(label.te);

% % Feature Selection with Var
% dim_num = 1000;
% Var_Data = var(data.tr);
% [~,Var_ind] = sort(Var_Data,'descend');
% X_tr = data.tr(:,Var_ind(1:dim_num));
% X_te = data.te(:,Var_ind(1:dim_num));
%     Model_SVM = train(label.tr, sparse(double(X_tr)),'-s 0 -B 1 -c 30 -q');
%     [predicted_label, acc, smn_I.te] = predict(label.te, sparse(double(X_te)), Model_SVM,' -b 1'); 
%     Acc4 = sum(predicted_label==label.te)/length(label.te);

%% Generative for SVD
Cnum = max(unique(Label));
obj = cell(1,Cnum);
U = cell(1,Cnum);
D = cell(1,Cnum);
V = cell(1,Cnum);
D_set = [];
L_set = [];
d = idx;
% n = 1000;

for class = 1:Cnum

    % disp(strcat('Class:',num2str(class)))
    % [obj{class},U{class},D{class},V{class}] = SVD_X_F_norm(data.tr(label.tr==class,:),d,n);
    [obj{class},U{class},D{class},V{class}] = SVD_X_F_OH(data.tr(label.tr==class,:),d,n);
    % D{i} = SVD_All_Autoencoder(data.tr(label.tr==i,:),d,n);
    % [obj{i},U{i},D{i},V{i}] = SVD_X_F_norm_Xsvd(data.tr(label.tr==i,:),d,n);
    D_set = [D_set;(U{class}*D{class})'];
    L = ones(n,1) * class;
    L_set = [L_set;L];

end

% These are only for Data{2}rna 'center'
% data.tr = normalize(data.tr,'range');
% data.te = normalize(data.te,'center');
% D_set = normalize(D_set,'range');

Xset = [data.tr;double(D_set)];
Lset = [label.tr;L_set];
% % for Data2{1}atac 'range'
% Xset = normalize(Xset,'range');
% for Data{2}rna 'center'
Xset = normalize(Xset,'range');
% Xset = Xset./repmat(sqrt(sum(Xset.^2,1)),size(Xset,1),1);

clear U D V D_set L obj

    [coeff,score,~,~,explained,mu] = pca(full(Xset));
    X_tr = score(:,1:idx);
    X_te = (data.te-mu)*coeff(:,1:idx);
    % X_tr = normalize(X_tr,'range');
    % X_te = normalize(X_te,'range');

        Model_SVM = train(Lset, sparse(double(X_tr)),'-s 0 -B 1 -c 30 -q');
        [predicted_label, acc, smn_I.te] = predict(label.te, sparse(double(X_te)), Model_SVM,' -b 1'); 
        Acc2 = sum(predicted_label==label.te)/length(label.te);

clear coeff score explained mu X_tr X_te Model_SVM predicted_label smn_I

% % Feature Selection with Var
% Var_Data = var(Xset);
% [~,Var_ind] = sort(Var_Data,'descend');
% X_tr = Xset(:,Var_ind(1:dim_num));
% X_te = data.te(:,Var_ind(1:dim_num));
%     Model_SVM = train(Lset, sparse(double(X_tr)),'-s 0 -B 1 -c 30 -q');
%     [predicted_label, acc, smn_I.te] = predict(label.te, sparse(double(X_te)), Model_SVM,' -b 1'); 
%     Acc5 = sum(predicted_label==label.te)/length(label.te);


%% Generative for AutoencoderSVD
% Cnum = max(unique(Label));
% Deep_obj = cell(1,Cnum);
% Deep_U = cell(1,Cnum);
% Deep_D = cell(1,Cnum);
% Deep_V = cell(1,Cnum);
% Deep_D_set = [];
% Deep_L_set = [];
% d = idx;
% % n = 1000;
% 
% for i = 1:Cnum
% 
%     disp(strcat('Class:',num2str(i)))
%     % [Deep_obj{i},Deep_U{i},Deep_D{i},Deep_V{i}] = SVD_Autoencoder(full(data.tr(label.tr==i,:)),d,n);
%     [Deep_obj{i},Deep_U{i},Deep_D{i},Deep_V{i}] = SVD_Autoencoder_Simple(full(data.tr(label.tr==i,:)),d,n);
%     Deep_D_set = [Deep_D_set;(Deep_U{i}*Deep_D{i})'];
%     Deep_L = ones(n,1) * i;
%     Deep_L_set = [Deep_L_set;Deep_L];
% 
% end
% 
% Deep_Xset = [data.tr;double(D_set)];
% Deep_Lset = [label.tr;L_set];
%     Deep_Xset = normalize(Deep_Xset,'range');
%     [coeff,score,~,~,explained,mu] = pca(full(Deep_Xset));
%     X_tr = score(:,1:idx);
%     X_te = (data.te-mu)*coeff(:,1:idx);
%     % X_tr = normalize(X_tr,'range');
%     % X_te = normalize(X_te,'range');
% 
%         Model_SVM = train(Deep_Lset, sparse(double(X_tr)),'-s 0 -B 1 -c 30 -q');
%         [predicted_label, acc, smn_I.te] = predict(label.te, sparse(double(X_te)), Model_SVM,' -b 1'); 
%         Acc3 = sum(predicted_label==label.te)/length(label.te);
% 
% % Feature Selection with Var
% % Deep_Xset = normalize(Deep_Xset,'range');
% Var_Data = var(Deep_Xset);
% [~,Var_ind] = sort(Var_Data,'descend');
% X_tr = Deep_Xset(:,Var_ind(1:dim_num));
% X_te = data.te(:,Var_ind(1:dim_num));
%     Model_SVM = train(Deep_Lset, sparse(double(X_tr)),'-s 0 -B 1 -c 30 -q');
%     [predicted_label, acc, smn_I.te] = predict(label.te, sparse(double(X_te)), Model_SVM,' -b 1'); 
%     Acc6 = sum(predicted_label==label.te)/length(label.te);
