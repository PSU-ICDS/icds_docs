import os
import pickle
try:
	import pandas as pd
except:
	os.popen("pip install pandas --user")
	import pandas as pd
try:
	from sklearn.ensemble import RandomForestClassifier
except:
	os.popen("pip install sklearn --user")
	from sklearn.ensemble import RandomForestClassifier

#data=pickle.load(open("input.p","rb"))
data=pd.read_csv("input.csv")
clf = RandomForestClassifier(max_depth=2, random_state=0)
X=data.values[:,:4]
y=data.values[:,-1]
clf.fit(X, y)
pickle.dump(clf,open("model.p","wb"))
