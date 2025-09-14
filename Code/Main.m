clear;
rawdata_path = 'G:\Indoor Navigation\Data_UPINLBS2019\���ģ������\';

dirOutput=dir(fullfile(rawdata_path,'*.txt')); %get all file name in rawdata_path
fileNames={dirOutput.name};
D = zeros(size(fileNames,2),1);
RSSI = zeros(size(fileNames,2),1);
RSSI_Weights = zeros(size(fileNames,2),1);
RSSI_Var = zeros(size(fileNames,2),1);

for i = 1:size(fileNames,2)
    fileNames_str = fileNames{i};
    D(i) = str2double(fileNames_str(2:end-5));
    rawdata_filepath = [rawdata_path ,fileNames_str];
    rawdata = importdata(rawdata_filepath,' ');
    rawdata_lenth = rawdata.data;
    
     rawdata_rssi_mean = mean(rawdata_lenth);%�ֲ��޳� 
     rawdata_rssi_std  = std(rawdata_lenth);
     index = find((rawdata_lenth < rawdata_rssi_mean+2*rawdata_rssi_std) & (rawdata_lenth > rawdata_rssi_mean-2*rawdata_rssi_std));%2��sigma�޳��ֲ�
     rawdata_rssi_mean  = mean(rawdata_lenth(index));
     
     RSSI(i) = rawdata_rssi_mean;
     RSSI_Var(i) = cov(rawdata_lenth(index));
end
[D,index] = sort(D);%����
RSSI = RSSI(index);
RSSI_Var = RSSI_Var(index);
RSSI_Weights = RSSI_Var/sum(RSSI_Var);%��Ȩֵ

[a,b] =BLE_Model(D,RSSI,RSSI_Weights);

%display
RSSI_Model = a*log10(D)+b;
figure;
plot(D,RSSI,'b-*');
hold on
plot(D,RSSI_Model,'r-*');
hold off
box on;
grid on;

clearvars -except a b;
clc

%��̬�������ڶ�λ
baseposition_path = 'G:\Indoor Navigation\Data_UPINLBS2019\BasePosition.txt';
staticdata_path = 'G:\Indoor Navigation\Data_UPINLBS2019\��̬��λ��\';

basedata = importdata(baseposition_path,' ');


dirOutput=dir(fullfile(staticdata_path,'*.txt')); %get all file name in rawdata_path
fileNames={dirOutput.name};

i = 1;
% for i = 1:size(fileNames,2)
    fileNames_str = fileNames{i};
    rawdata_filepath = [staticdata_path ,fileNames_str];
    rawdata = importdata(rawdata_filepath,' ');
    rawdata_ID = rawdata.textdata(:,3);
    rawdata_lenth = 10.^((rawdata.data - b)./a);%��RSSIͨ��ģ�ͻ���ɾ���
    base_ID = basedata.textdata(:,2);
    base_pos = basedata.data;
    
    %��ԭʼ���ݵ�����ID��ȡ�����ͻ�վ��IDƥ�䲢���λ��
    [IDuse,ia,ic]= unique(rawdata_ID); 
    base_pos_use = zeros(size(IDuse,1),3);
    
    for j = 1: size(IDuse,1)
        idx = find(strcmp(base_ID, IDuse{j}));
        if ~isempty(idx) 
            base_pos_use(j,:) = base_pos(idx,:);   
        end
    end
    
    Base_pos_use = base_pos_use(ic);
    
    for j = 1:size(rawdata_lenth,1)
        
    end
    
    

    
    
    
    
    
    
    
    
    
    
    
    
% end






