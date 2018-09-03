% IPCC Sector Analysis and Display - OECD, non-OECD and selected countries
% Embodied flows calculated in IPCCSectorAnalysis_allcountries.m
% Based on IPCCSectorAnalysis_allcountries.m, 
% Edgar Hertwich
% 12 nov 2017
clear
path(path,'..\IPCCSectorAnalysis')
%load ipccaggC3_det.mat
load ipccaggC3.mat
%%
% Sc1=squeeze(I.Scope(:,:,1)+I.hh(:,:,1))';
% Sc2=squeeze(I.Scope(:,:,21)+I.hh(:,:,21))';
% %%
%IPCCsecName={'Energy', 'Transport', 'Industry', 'Buildings', 'Agriculture'};
% IPCCsecName={'Energy', 'Transport', 'Materials','Manfact.','Services', 'Buildings', 'AFOLU+'};path(path,'C:\Users\eh555\Box Sync\MATLAB\IPCCSectorAnalysis');
%members=readtable('OECDmembers.xlsx');
member=xlsread('OECDmembers.xlsx');
%%
ny=size(I.Scope,3);
n=meta.NCOUNTRIES;
CBA=zeros(5,n,ny);
for i=1:n
    CBA=CBA+T.CBA((i-1)*5+1:i*5,:,:);
end
%%
ScopeM=zeros(3,10,ny);
EFM=zeros(6,12,ny);
for i=1:meta.NCOUNTRIES
    if member(i,1)
        ScopeM(:,1:5,:)=ScopeM(:,1:5,:)+T.Scope(:,(i-1)*5+1:i*5,:);
        EFM(1:5,1:5,:)=EFM(1:5,1:5,:)+T.PF(:,(i-1)*5+1:i*5,:);
        EFM(6,1:5,:)=EFM(6,1:5,:)+T.DE(1,(i-1)*5+1:i*5,:);
        EFM(1:5,6,:)=EFM(1:5,6,:)+CBA(:,i,:);
    else
        ScopeM(:,6:10,:)=ScopeM(:,6:10,:)+T.Scope(:,(i-1)*5+1:i*5,:);
        EFM(1:5,7:11,:)=EFM(1:5,7:11,:)+T.PF(:,(i-1)*5+1:i*5,:);
        EFM(6,7:11,:)=EFM(6,7:11,:)+T.DE(1,(i-1)*5+1:i*5,:);
        EFM(1:5,12,:)=EFM(1:5,12,:)+CBA(:,i,:);
    end
end
%%
figure
j=0;
Cname={'OECD','Non-OECD'};
%Cname={'Annex B','Non Annex B'};
%%
legendx={'Scope 1','Scope 2','Scope 3'};
%IPCCsecName={'Energy', 'Transport', 'Industry', 'Buildings', 'Agriculture'};
for i=1:2
    j=j+1; sub=[3,2,j];
    var=ScopeM(:,(i-1)*5+1:i*5,:)*1e-12;
    labely='CO_2 in Pg/a';
    fig=tssubplot(var,IPCCsecName,labely,legendx,Cname(i),sub);
end
%%
c=5;
path(path,'C:\Users\eh555\Box Sync\MATLAB\IPCCSectorAnalysis');
IPCCsecName={'Energy', 'Transport', 'Industry', 'Buildings', 'Agriculture'};
%legendx={'Scope 1','Scope 2d','Scope2m','Scope 3d','Scope 3m'};
legendx={'Scope 1','Scope 2','Scope 3'};
labely='CO_2 in Tg/a';
% xiopath='C:\Users\eh555\Box Sync\MRIO\EX_v3_3_mat\';
% load([xiopath, 'IOT_1995_pxp.mat'], 'meta');

%%
j=2;
%legendx=IPCCsecName;
for i=[29,31,6,34]%[6,11,28:35]%[11,9,28,30,35,43]%[34,31,6,29]% %meta.NCOUNTRIES
    j=j+1; sub=[3,2,j];
    %var=T.DomF(:,(i-1)*c+1:i*c,:)+T.ImF(:,(i-1)*c+1:i*c,:);
    var=T.Scope(:,(i-1)*c+1:i*c,:);
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

disp('Fin');