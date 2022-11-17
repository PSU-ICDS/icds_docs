import datetime
import sys
import re
import subprocess

import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

def queue_usage():
	try:
		allocation = sys.argv[1]
	except IndexError:
		print('usage: python queueRenewal $allocation_name')
		exit()
	today = datetime.date.today()
	periodLength = 90	#days in allocation hours calculating period
	windowStart = today - datetime.timedelta(days=90)
	print(windowStart)
	subprocess.call(['sudo','/opt/mam/bin/mam-list-usagerecords', '--show', 'Id,Instance,Charge,User,Account,Nodes,Processors,StartTime,EndTime' ,'-a',allocation, '-s',windowStart.strftime('%Y-%m-%d'),'-h'], stdout=open(allocation+'_jobs.txt', 'w'))

	jobs = open(allocation+'_jobs.txt','r')
	header = jobs.readline()
	header = re.sub(' +', ' ', header.strip())
	header = header.split(' ')
	print(header)
	endTimeIndex = header.index('EndTime')
	chargeIndex = header.index('Charge')	
	jobs.readline()  #line of dashes
	chargesByDay = np.zeros(periodLength+1)
	for line in jobs:
		#print(line)
		l = re.sub(' +', ' ', line.strip())
		l = l.split(' ')
		print(l)		
		print(l[endTimeIndex], len(l))
		print(endTimeIndex)
		if len(l) == 21:
			#if no memory is specified, the location in shifted by one, once all the spaces are deleted 
			#this should be fixed now, since I'm specifying the columns to be included, but it also shouldn't hit ever, so I'm going to leave it. 
			endTime = l[endTimeIndex+1]
		else:
			try:
				endTime = l[endTimeIndex]
				datetime.datetime.strptime(endTime, '%Y-%m-%d').date()
			except ValueError:
				endTime = l[endTimeIndex+1]
		#print(endTimeIndex)
		charge = l[chargeIndex]
		#print(endTime, charge)
		endDate = datetime.datetime.strptime(endTime, '%Y-%m-%d').date()
		#print(endDate)
		daysAgo = (today-endDate).days
		#print(daysAgo)
		chargesByDay[daysAgo] += float(charge)

	subprocess.call(['sudo', '/opt/mam/bin/mam-list-funds','-a',allocation,'-h'],stdout=open(allocation+'_funds.txt','w'))
	funds=open(allocation+'_funds.txt','r')
	funds_header = re.sub(' +', ' ',funds.readline().strip()).split(' ')
	funds.readline() #dashes
	print(funds_header)
	max_funds_index = funds_header.index('Allocated')	
	maxQueueHours = re.sub(' +', ' ',funds.readline().strip()).split(' ')[max_funds_index]
	#plt.plot(range(0,91),np.cumsum(chargesByDay))
	charges = np.cumsum(chargesByDay[::-1])
	plt.plot(range(0,91), [float(maxQueueHours)-charges[i] for i in range(91)])
	plt.plot(range(0,91), [float(maxQueueHours) for i in range(91)], 'k')
	plt.ylim([0,float(maxQueueHours)*1.05])
	plt.xlim([0,90])
	plt.ylabel('Queue Hours')
	date=datetime.datetime.today().strftime('%Y-%m-%d')
	plt.title('Allocation Useage for '+allocation+ ', generated: ' +date)
	plt.savefig(allocation+'_usage.png')
	#plt.show()
	

	for i in range(len(chargesByDay)):
		print(i, chargesByDay[i], sum(chargesByDay[:i]))







if __name__ == '__main__':
	queue_usage()
