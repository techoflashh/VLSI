import random 

L = []

for i in range(500):
    temp = random.uniform(0,80)
    L.append(temp)

    
L.sort()

fp = open("temperatureValues.txt","w")

L = [str(i)+'\n' for i in L]

fp.writelines(L)

fp.close()