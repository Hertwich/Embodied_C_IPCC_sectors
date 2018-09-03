
IPCCsecName={'Energy', 'Transport', 'Industry', 'Buildings', 'Agriculture'};
%legendx={'Scope 1','Scope 2d','Scope2m','Scope 3d','Scope 3m'};
legendx={'Scope 1','Scope 2','Scope 3'};
labely='CO_2 in Tg/a';
% xiopath='C:\Users\eh555\Box Sync\MRIO\EX_v3_3_mat\';
% load([xiopath, 'IOT_1995_pxp.mat'], 'meta');

%%
c=7
figure
%%
j=0;
%legendx=IPCCsecName;
for i=[29,31,6,34,1,30]%[6,11,28:35]%[11,9,28,30,35,43]%[34,31,6,29]% %meta.NCOUNTRIES
    j=j+1; sub=[3,2,j];
    %var=T.DomF(:,(i-1)*c+1:i*c,:)+T.ImF(:,(i-1)*c+1:i*c,:);
    var=T.Scope(:,(i-1)*c+1:i*c,:)+T.hh(:,(i-1)*c+1:i*c,:);
    if max(sum(var))>9e+11
        labely='CO_2 in Pg/a';
        var=var*1e-12;
    else
        labely='CO_2 in Tg/a';
        var=var*1e-9;
    end
    Cname=meta.countrynames(i);
    fig=tssubplot(var,IPCCsecName,labely,legendx,Cname,sub);
    if i==9
     legend(legendx);
    end
end

%%
for i=1:meta.NCOUNTRIES
    %j=j+1; sub=[3,2,j];
    var=T.ScopeT(:,(i-1)*c+1:i*c,:);
    if max(sum(var))>9e+11
        labely='CO_2 in Pg/a';
        var=var*1e-12;
    else
        labely='CO_2 in Tg/a';
        var=var*1e-9;
    end
    Cname=meta.countrynames(i);
    fig=tsfig(var,IPCCsecName,labely,legendx,Cname);
    saveas(fig,[char(Cname),'.jpg']);
end
%%
SS=sum(I.Scope,1);
for i=2:size(I.Scope,1)
    SS(i,:,:)=SS(1,:,:);
end
I.NScope=I.Scope./SS;
var=I.NScope;
fig=tsfig(var,IPCCsecName,'Fraction',legendx,'');