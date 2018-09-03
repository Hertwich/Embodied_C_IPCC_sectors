function fig=tssubplot(var,labelx,labely,legendx,name,sub)

n=10;
nx=size(var,1);
ny=size(var,2);
nt=size(var,3);

i=1:nt-1;
delta(:,:,i)=(var(:,:,i+1)-var(:,:,i))/n;
p=zeros(1.2*n*nt*ny,nx);
for j=1:ny
    for k=1:nt-1
        for l=1:n
            p((j-1)*(0.2*n*nt+n*nt)+l+0.1*n*nt+(k-1)*n,:)=squeeze(var(:,j,k))'+l*squeeze(delta(:,j,k))';
        end
    end
end

%%
subplot(sub(1),sub(2),sub(3));
fig=area(p);
ylabel(labely);
%legend(legendx);
title(name);
ax=gca;
ax.XLim=[0 size(p,1)];
ax.XTick=round(0.6*n*nt):round(1.2*n*nt):(round(0.6*n*nt)+(size(var,2)-1)*round(1.2*n*nt));
if sub(3)/sub(2)+1>sub(1)
    ax.XTickLabel=labelx;
else
    ax.XTickLabel={'','','','',''};
end
if round(sum(var,1),1)==1.0
    ax.YLim=[0 1];
    disp('one');
end


end %tsfig