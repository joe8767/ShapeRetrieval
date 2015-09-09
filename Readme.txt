使用HSK来计算off文件的描述子，并对这些描述子使用Bag of words来构建统一长度的直方图特征向量，通过这些向量的余弦相似度来进行shape retrieval

genHSK_Feat.m		%% 调用HSK计算descriptor

main.m			%% 基于BOW model的shape retrieval