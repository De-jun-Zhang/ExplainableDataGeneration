
function [obj_set,U,D,V] = SVD_X_F_OH(Data,d,n)

[num,dim] = size(Data);

Data = Data';
U = randn(dim,d);
D = randn(d,n);
V = randn(n,num);
V = V';

T = randn(num,n);

max_iter = 10;
eta = 1e-2;

a = 1; b = 0; u = 0.2; v = 0.2; o = 0.2; h = 0.2;

H = ones(num,num)*(1/num)*(-1) + eye(num);

obj_set = a*norm(Data-U*D*V','fro')^2 + u*norm(U,'fro')^2 + v*norm(V,'fro')^2 + b*norm(D,'fro')^2 + o*trace(D'*U'*Data*T) + ...
    h*trace(Data'*Data*H*V*D'*D*V'*H);

for i = 1:max_iter
    % disp(strcat('Iteration:',num2str(i)))

    [~,T] = OPW(Data',D'*U'); 

    % obj_1 = a*norm(Data-U*D*V','fro')^2 + u*norm(U,'fro')^2 + v*norm(V,'fro')^2 + b*norm(D,'fro')^2 + o*trace(D'*U'*Data*T);
    % disp(strcat('obj1:',num2str(obj_1)))
    U = (a*Data*V*D'+0.5*o*Data*T*D')*pinv(a*D*V'*V*D'+u);
    % U = U/norm(U);

    % obj_2 = a*norm(Data-U*D*V','fro')^2 + u*norm(U,'fro')^2 + v*norm(V,'fro')^2 + b*norm(D,'fro')^2 + o*trace(D'*U'*Data*T);
    % disp(strcat('obj2:',num2str(obj_2)))
    V = (a*Data'*U*D)*pinv(a*D'*U'*U*D+v);
    % V = V/norm(V);
    
    obj_3 = a*norm(Data-U*D*V','fro')^2 + u*norm(U,'fro')^2 + v*norm(V,'fro')^2 + b*norm(D,'fro')^2 + o*trace(D'*U'*Data*T) + ... 
        h*trace(Data'*Data*H*V*D'*D*V'*H);
    % disp(strcat('obj3:',num2str(obj_3)))
    D = pinv(a*U'*U)*(a*U'*Data*V+0.5*o*U'*Data*T)*pinv(a*V'*V);
    % D = D/norm(D);
    
    obj_set = [obj_set, obj_3];
    
    % if abs(obj_1-obj_3)<eta || obj_1-obj_3<0
    %      break
    % end
    
end

end

