%% 批量生成HSK特征
%  OFF2HKS('E:\zy\医疗大数据\3D人脸\dataset\Shapes\new_McGill_benchmark\McGillDBAll\b0.off', true)

fileDir = 'G:\BOW\new_McGill_benchmark\McGillDBAll\';
files = dir(fullfile(fileDir, '*.off'));

featDir = 'G:\BOW\new_McGill_benchmark\HSK_Features\';
addpath ../HKS_release
addpath ../HKS_release/MeshLP

fileNum = length(files);

fprintf('目录下共有%d个off文件\n', fileNum);

for i=1:fileNum
    fileName = strcat(fileDir, files(i).name);
    feat = OFF2HKS(fileName, true);
    featName = strcat(featDir, files(i).name(1:end-4));
    save(featName, 'feat');
    fprintf('featuring %i\n', i);
end