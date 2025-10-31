
class_Number = max(Label);
Data_All= cell(class_Number,1);
Label_All= cell(class_Number,1);
Ind_All = cell(class_Number,1);
data.tr = [];
data.te = [];
label.tr = [];
label.te = [];

for c = 1:class_Number

    Data_All{c} = Data(Label==c,:);
    Label_All{c} = Label(Label==c,:);

    if Number>length(Label_All{c})
        Number_temp=round(length(Label_All{c})/2);
    else
        Number_temp = Number;
    end

    Ind_All{c} = randperm(length(Label_All{c}),Number_temp);
    data.tr = [data.tr;Data_All{c}(Ind_All{c},:)];
    label.tr = [label.tr;Label_All{c}(Ind_All{c},:)];
    Data_All{c}(Ind_All{c},:) = [];
    Label_All{c}(Ind_All{c},:) = [];
    data.te = [data.te;Data_All{c}];
    label.te = [label.te;Label_All{c}];
end

clear Data_All Label_All Ind_All