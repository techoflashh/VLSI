import os
import subprocess
import time
import random


command = "ngspice tempfile.cir"

fp3 = open("q5_capacitance_output.txt",'w')
fp3.close()


temperatures = []

for i in range(0,501):
    temp = (80/500)*i
    temp = round(temp,2)
    temperatures.append(temp)

temperatures = temperatures[::50]

capacitance_initial = 0.5

for _ in range(10):
    c = capacitance_initial
    capacitance_initial *= 2
    fp3 = open("q5_capacitance_output.txt",'a')
    f1 = open("q5.cir",'r') 
    f2 = open("tempfile.cir",'w')
    data = f1.read()
    search_text = "*capacitance"
    replace_text = f"C1 node_out gnd {c}f"
    data = data.replace(search_text,replace_text)
    f1.close()
    f2.write(data)
    f2.close()
    completed_process = subprocess.run(command,shell=True,text=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    if completed_process.returncode == 0:
        output = completed_process.stdout
    else:
        output = ("Command execution failed. at capcitance =",c)

    output = output.split('\n')
    output = output[-4]
    additional_text = f" for capacitance = {c}\n"
    fp3.write(output+additional_text)
    # time.sleep(0.5)
    fp3.close()
subprocess.run(["rm","tempfile.cir"])