% IPCC Sector Analysis and Display - all countries
% Embodied flows calculated in IPCCSectorAnalysis_allcountries.m
% Here, figures are produced and data is saved in Excel

% Edgar Hertwich
% 12 april 2017

clear
load ipccaggC3_det.mat

%%
n=10;
ny=size(I.Scope,3);
i=1:ny-1;
deltaS(:,:,i)=(I.Scope(:,:,i+1)-I.Scope(:,:,i))/n;
PlotB=zeros(1.2*n*ny*(size(I.Scope,2)),size(I.Scope,1));
for j=1:(size(I.Scope,2))
    for k=1:ny-1
        for l=1:n
            PlotB((j-1)*(0.2*n*ny+n*ny)+l+0.1*n*ny+(k-1)*n,:)=squeeze(I.Scope(:,j,k))'+l*squeeze(deltaS(:,j,k))';
        end
    end
end

b=sum(PlotB,2);
b(b==0)=1;
B=inv(diag(b))*PlotB;
%%
labels={'Scope 1','Scope 2','Scope 3'};
%labels={' ',' ',' '};
order=[3 2 1];
figure
subplot(2,1,1)
h=area(PlotB*1e-12);
% h(1).FaceColor=[0.1 0.1 0.1];
% h(2).FaceColor=[0.6 0.1 0.1];
% h(3).FaceColor=[1 0 0];
% ylabel('Pg CO_2 per year');
u=legend(h(order),labels{order});
ax=gca;
ax.XLim=[0 size(PlotB,1)];
ax.XTick=round(0.6*n*ny):round(1.2*n*ny):(round(0.6*n*ny)+(size(I.Scope,2)-1)*round(1.2*n*ny));
ax.XTickLabel=IPCCsecName;
ylabel('Pg CO_2 eq')
legend('boxoff')
%%
subplot(2,1,2)
area(B)
ylabel('Share');
ax=gca;
ax.YLim=[0 1];
ax.XLim=[0 size(PlotB,1)];
ax.XTick=round(0.6*n*ny):round(1.2*n*ny):(round(0.6*n*ny)+(size(I.Scope,2)-1)*round(1.2*n*ny));
ax.XTickLabel=IPCCsecName;

% hold on
% plot(1:size(B,1), sum(PlotB,2)*2e-14, 'LineWidth', 1, 'Color','k')
% hold off


%%
s=size(I.Scope,1);
t=size(I.Scope,2);
Scope=zeros((s+1)*(t+1), ny);
%%
for j=1:ny
    for i=1:t
        Scope(s*(i-1)+1:s*i,j)=squeeze(I.Scope(:,i,j));
        Label(s*(i-1)+1:s*i,1)=IPCCsecName(i);
        Label(s*(i-1)+1:s*i,2)={'Scope 1';'Scope 2';'Scope 3'};
    end
end
%%
for i=1:t
    Scope(s*t+i,:)=sum(Scope(s*(i-1)+1:s*i,:),1);
    Label(s*t+i,2)={'Sum'};
end
count=1:s:t*s;
for j=1:s
    Scope((s+1)*t+j,:)=sum(Scope(count+(j-1),:),1);
    Label((s+1)*t+j,1)={'Total'};
end
Label(s*t+1:(s+1)*t,1)=IPCCsecName;
Label((s+1)*t+1:(s+1)*t+s,2)={'Scope 1';'Scope 2';'Scope 3'};
%%
DestFile='GHGc_7.xlsx';
Sheet='PlotB';
xlswrite(DestFile,[IND,datestr(clock)],Sheet, 'A1');
xlswrite(DestFile,Label,Sheet,'B2');
xlswrite(DestFile,Scope,Sheet,'D2');
xlswrite(DestFile,1995:2015,Sheet,'D1');

%%
Orig=[IPCCsecName,'Direct'];
for i=1:21
    sheet=num2str(i-1+1995);
    Scope=[I.Scope(:,:,i), sum(I.hh(:,:,i),2)+[0;0;sum(I.EF(:,t+1,i))-sum(sum(I.hh(:,:,i),2))]];
    xlswrite(DestFile,[IPCCsecName, 'Consumption'], sheet,'B1');
    xlswrite(DestFile,[Scope; sum(Scope,1)], sheet,'B2');
    xlswrite(DestFile,{'Scope 1';'Scope 2';'Scope 3';'Sum'},sheet,'A2');
    xlswrite(DestFile,[IPCCsecName,'Consumption'], sheet,'B10');
    xlswrite(DestFile,[IPCCsecName,'Consumption'], sheet,'B21');
    xlswrite(DestFile,Orig', sheet,'A11');
    xlswrite(DestFile,Orig', sheet,'A23');
    xlswrite(DestFile,I.EF(:,:,i), sheet,'B11');
    xlswrite(DestFile,squeeze(I.EF(:,:,i))/diag(sum(I.EF(:,:,i),1)),sheet,'B23');

    Scope=[ScopeM(:,1:t,i),sum(ScopeM(:,1:t,i),2),ScopeM(:,t+1:2*t,i),sum(ScopeM(:,t+1:2*t,i),2)];
    xlswrite(DestFile,[IPCCsecName,'Sum',IPCCsecName,'Sum'], sheet,'L1');
    xlswrite(DestFile,[Scope; sum(Scope,1)], sheet,'L2');
    xlswrite(DestFile,{'Scope 1';'Scope 2';'Scope 3';'Sum'},sheet,'K2');
    xlswrite(DestFile,[IPCCsecName,'Consumption'], sheet,'L10');
    xlswrite(DestFile,[IPCCsecName,'Consumption'], sheet,'T10');
    xlswrite(DestFile,[IPCCsecName,'Consumption'], sheet,'L22');
    xlswrite(DestFile,[IPCCsecName,'Consumption'], sheet,'T22');
    xlswrite(DestFile,Orig', sheet,'K11');
    xlswrite(DestFile,Orig', sheet,'K23');
    xlswrite(DestFile,EFM(:,:,i), sheet,'L11');
    xlswrite(DestFile,squeeze(EFM(:,:,i))/diag(sum(EFM(:,:,i),1)),sheet,'L23');
   
end
disp('Fin');
