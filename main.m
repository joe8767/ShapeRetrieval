feat0 = load('b0');
feat1 = load('b1');

feat80 = load('b80');
feat81 = load('b81');

feat149 = load('b149');
feat153 = load('b153');

% feat271 = load('b271');
% feat275 = load('b275');
% 
% feat325 = load('b325');
% feat326 = load('b326');

% feat = [feat0.feat; feat1.feat; feat80.feat; feat81.feat; feat149.feat; feat153.feat; feat271.feat; feat275.feat; feat325.feat; feat326.feat];
feat = [feat0.feat; feat1.feat; feat80.feat; feat81.feat; feat149.feat; feat153.feat];
options = statset('Display', 'iter',  'MaxIter', 200);
[IDX, C] = kmeans(feat, 128, 'Options', options);

% 根据聚类中心构造直方图
featArr = [feat0; feat1; feat80; feat81; feat149; feat153];
hist = zeros( numel(featArr), size(C, 1) );

for i=1:numel(featArr)
    % 遍历一个feat
    featTemp = featArr(i).feat;
    % 遍历feat中的row
    for j=1:size(featTemp, 1)
        featRow = featTemp(j, :);
        % 构建直方图
        nearestFeat = zeros(1, size(C, 2));
        nearestDist = inf;
        histIdx = -1;
        for k=1:size(C, 1)
            dist = norm(featRow-C(k,:));
            if  dist < nearestDist
                nearestDist = dist;
                nearestFeat = featRow;
                histIdx = k;
            end
        end
        hist(i, histIdx) = hist(i, histIdx) + 1;
    end 
end

% 画出直方图
figure
for i=1:size(hist, 1)
    subplot(5, 2, i);
    bar(hist(i, :));
    title(i);
end

% 计算相似度, 欧氏距离
for i=1:size(hist, 1)
    for j=1:size(hist, 1)
        sim = norm(hist(i, :)-hist(j, :));
        fprintf('%d <-> %d : sim: %f\n', i, j, sim);
    end
    fprintf('------------------\n');
end

% using cos distance
for i=1:size(hist, 1)
    for j=1:size(hist, 1)
        sim = hist(i, :) * hist(j, :)' / (norm(hist(i, :))*norm(hist(j, :)));
        fprintf('%d <-> %d : sim: %f\n', i, j, sim);
    end
    fprintf('------------------\n');
end



