import os
import subprocess
import time
import random


command = "ngspice tempfile.cir"

fp3 = open("q5_capacitance_output.txt",'w')
fp3.close()


temperatures = []

with open('temperatureValues.txt') as f:
    temperatures = f.readlines()
    temperatures = [float(i[:-1]) for i in temperatures]

temperatures = temperatures[::10]

capacitance_initial = 0.5

for _ in range(10):
    c = capacitance_initial
    capacitance_initial += 2
    replace_textc = f"C1 node_out gnd {c}f"
    fp3 = open("q5_capacitance_output.txt",'a')
    fp3.write(f"\n\nCapacitance = {c}fF\n\n")
    for i in range(50):
        f1 = open("q5.cir",'r') 
        f2 = open("tempfile.cir",'w')
        temp = temperatures[i]
        data = f1.read()
        search_text = "*temperature"
        search_textc = "*capacitance"
        replace_text = f".option temp={temp}\n"
        data = data.replace(search_text,replace_text)
        data = data.replace(search_textc,replace_textc)
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
        # time.sleep(0.5)
    fp3.close()
subprocess.run(["rm","tempfile.cir"])