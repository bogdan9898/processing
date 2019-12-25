#person = raw_input('Enter your name: ')
#print type(person)
#print 'Hello', person
import os
try:
	os.mkdir("./testdadniow", 777)
except Exception as e:
	print e
	exit(1)
exit(0)