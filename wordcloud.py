corpus_thebigshort = ' '.join([l['text'] for l in thebigshort])#[l[text] for l in thebigshort]thebigshort[2]['text']
delete_list = ['big','short']
for word in delete_list:
    corpus_thebigshort = corpus_thebigshort.replace(word, "")
print corpus_thebigshort

from wordcloud import WordCloud

import matplotlib.pyplot as plt
%matplotlib inline
wordcloud = WordCloud(background_color='white').generate(corpus_thebigshort)
plt.figure(figsize=(8,4))
plt.imshow(wordcloud)
plt.savefig('wordcloud_bigshort1')
plt.axis("off")


# take relative word frequencies into account, lower max_font_size
wordcloud = WordCloud(background_color='white',max_font_size=40, relative_scaling=.5).generate(corpus_thebigshort)
plt.figure(figsize=(8,4))
plt.imshow(wordcloud)
plt.savefig('wordcloud_bigshort2')
plt.axis("off")
plt.show()