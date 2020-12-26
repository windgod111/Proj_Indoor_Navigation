clear;
rawdata_path = 'G:\Indoor Navigation\Data\������λ����\�������ģ����������\';
staticdata_path = 'G:\Indoor Navigation\Data\������λ����\��̬��λ��\';

dirOutput=dir(fullfile(rawdata_path,'*.txt')); %get all file name in rawdata_path
fileNames={dirOutput.name};
D = zeros(size(fileNames,2),1);
RSSI = zeros(size(fileNames,2),1);
RSSI_Weights = zeros(size(fileNames,2),1);
RSSI_Var = zeros(size(fileNames,2),1);

for i = 1:size(fileNames,2)
    fileNames_str = fileNames{i};
    D(i) = str2double(fileNames_str(1:end-4));
    rawdata_filepath = [rawdata_path ,fileNames_str];
    rawdata = importdata(rawdata_filepath,' ');
    rawdata_rssi = rawdata.data;
    
     rawdata_rssi_mean = mean(rawdata_rssi);%�ֲ��޳� 
     rawdata_rssi_std  = std(rawdata_rssi);
     index = find((rawdata_rssi < rawdata_rssi_mean+2*rawdata_rssi_std) & (rawdata_rssi > rawdata_rssi_mean-2*rawdata_rssi_std));%2��sigma�޳��ֲ�
     rawdata_rssi_mean  = mean(rawdata_rssi(index));
     
     RSSI(i) = rawdata_rssi_mean;
     RSSI_Var(i) = cov(rawdata_rssi(index));
end
[D,index] = sort(D);%����
RSSI = RSSI(index);
RSSI_Var = RSSI_Var(index);
RSSI_Weights = RSSI_Var/sum(RSSI_Var);%��Ȩֵ

[a,b] =BLE_Model(D,RSSI,RSSI_Weights);





