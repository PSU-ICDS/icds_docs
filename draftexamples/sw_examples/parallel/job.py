import os
import pickle
import sys
feature_id=int(sys.argv[1])
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
clf = RandomForestClassifier(max_depth=190,n_estimators=100, random_state=0,n_jobs=1)
X=data.values[:,feature_id].reshape(-1,1)
y=data.values[:,-1]
clf.fit(X, y)
pickle.dump(clf,open("model_"+str(feature_id)+".p","wb"))
