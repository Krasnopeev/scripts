



import os
import json
import pandas as pd


def parseBlastJSON(file):
    
    with open(file, "r") as read_file:
        data = json.load(read_file)
    
    
    q_id = data.get("BlastOutput2",[]).get("report").get("results").get("search").get("query_title")
    
    q_summary = data.get("BlastOutput2",[]).get("report").get("results").get("search").get("hits")[0].get("description")
    
    """
    print(json.dumps(data.get("BlastOutput2",[]).get("report").get("results").get("search").get("hits")[0], indent = 4, sort_keys=True))
    """
    
    idt = data.get("BlastOutput2",[]).get("report").get("results").get("search").get("hits")[0].get("hsps")[0].get("identity")
    alen = data.get("BlastOutput2",[]).get("report").get("results").get("search").get("hits")[0].get("hsps")[0].get("align_len")
    q_len = data.get("BlastOutput2",[]).get("report").get("results").get("search").get("query_len")
    
    hom = idt/alen*100
    cov = alen/q_len*100
    
    d1 = pd.DataFrame.from_dict(q_summary)
    
    d1.insert(loc=3, column='coverage', value=cov)
    d1.insert(loc=4, column='identity', value=hom)
    d1.insert(loc=0, column='querry_id', value=q_id)
    
    return d1




directory = "/home/anri/fishes_kabilov/16S/output/blast_json/"

out_df = []

for filename in os.listdir(directory):
    f = os.path.join(directory, filename)
    out_df.append(parseBlastJSON(f))



result = pd.concat(out_df)

