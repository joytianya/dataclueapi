import json
import os
from sentence_transformers import SentenceTransformer, util

dataset_file = "cic_unlabeled.json"

sentences = []
with open(dataset_file) as fIn:
    for line in fIn:
        sentences.append(json.loads(line))


print(len(sentences), "sentences loaded")

model = SentenceTransformer("distiluse-base-multilingual-cased-v1")
print(sentences[0])
texts = [sent["sentence"] for sent in sentences]

courpus_embeddings = model.encode(texts, convert_to_tensor=True)

def search_sentences(sentence):
    query_embedding = model.encode(sentence, convert_to_tensor = True)

    search_hits = util.semantic_search(query_embedding, courpus_embeddings, top_k=10)

    search_hits = search_hits[0]

    print("\n\nSentence:", sentence)
    print("Most similar sentences")
    for hit in search_hits:
        print(hit)
        related_sent = sentences[hit["corpus_id"]]
        print("{:.2f}\t{}".format(hit["score"], related_sent["sentence"]))
    
import sys
query = sys.argv[1]
search_sentences(query)