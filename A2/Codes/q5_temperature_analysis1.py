import os
import subprocess
import time
import random


command = "ngspice tempfile.cir"

fp3 = open("q5_temperature_output.txt",'w')
fp3.close()


temperatures = []

with open('temperatureValues.txt') as f:
    temperatures = f.readlines()
    temperatures = [float(i[:-1]) for i in temperatures]



for i in range(500):
    f1 = open("q5.cir",'r') 
    f2 = open("tempfile.cir",'w')
    fp3 = open("q5_temperature_output.txt",'a')

    temp = temperatures[i]

    data = f1.read()

    search_text = "*temperature"
    replace_text = f".option temp={temp}\n"
    data = data.replace(search_text,replace_text)
    f1.close()

    f2.write(data)
    f2.close()

    completed_process = subprocess.run(command,shell=True,text=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    if completed_process.returncode == 0:
        output = completed_process.stdout
    else:
        output = ("Command execution failed. at temp =",temp)

    output = output.split('\n')
    output = output[-4]
    additional_text = f" for temperature = {temp}\n"
    fp3.write(output+additional_text)
    fp3.close()
    # time.sleep(0.5)
subprocess.run(["rm","tempfile.cir"])