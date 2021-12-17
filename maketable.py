from collections import Counter
import pandas as pd
import os

# сначала установить и сформировать рабочий файл с taxid из ncbi
# https://github.com/zyxue/ncbitax2lin

# в 'p' указать полный путь к папке включая саму папку с файлами, где записаны taxid
p = '/home/anri/viromes_serj/IDs/'
path = os.listdir(p)

# в 'taxid' указать полный путь к файлу с taxid после выполнения ncbitax2lin
taxid = pd.read_csv("/home/anri/viromes_serj/ncbi_lineages_2021-12-17.csv", index_col="tax_id", low_memory=False)

mydicts = []
sampleIDs = []

for element in range(0,len(path)):
    handle = open(p+path[element], 'r')
    sampleIDs.append(str(path[element])[:-4])
    samDict = dict(Counter([line.rstrip() for line in handle]))
    mydicts.append(samDict)

print(sampleIDs)
df = pd.concat([pd.Series(d) for d in mydicts], axis=1).fillna(0).T
df.index = sampleIDs
df = df.T.astype(int)
#print(df)

# здесь пишется на диск таблица представленности ( типо таблицы OTU)
df.to_csv("/home/anri/viromes_serj/taxID_count_table.txt", sep='\t', encoding='utf-8')

df.index = df.index.astype(int)

taxdf = df.join(taxid)

# здесь пишется на диск таблица представленности + таксонмия
taxdf.to_csv("/home/anri/viromes_serj/taxID_count_table+taxa.txt", sep='\t', encoding='utf-8')
