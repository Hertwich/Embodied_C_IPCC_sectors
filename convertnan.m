function[y]=convertnan(x)
[m,n]=size(x);
for i=1:m
    for j=1:n
        if isnan(x(i,j))
            y(i,j)=0; 
        else
            y(i,j)=x(i,j);
        end
    end
end