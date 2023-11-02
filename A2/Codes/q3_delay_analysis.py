import os
import subprocess
import time

fp3 = open("q3_delay_output.txt",'w')
fp3.close()

command = "ngspice tempfile.cir"

temperatures = []

with open('temperatureValues.txt') as f:
    temperatures = f.readlines()
    temperatures = [float(i[:-1]) for i in temperatures]

temperatures = temperatures[::10]

for t in temperatures:
    search_text_temp = "*temperature"
    fp3 = open("q3_delay_output.txt",'a')
    replace_text_temp = f".option temp={t}\n"
    fp3.write(f"\nTemperature = {t}\n")
    for j in range(0,3):
        s1 = "node_a"+str(j)
        s2 = "node_out"
        fp1 = open("q3_delay.cir","r")
        fp2 = open("tempfile.cir",'w')
        mode1 = "RISE"
        mode2 = "RISE"
        mode3 = "FALL"
        mode4 = "FALL"
        L = [0,1,2]
        L.remove(j)
        inputPulses = f'''
V_in_3 node_a{L[1]} gnd PULSE(0 1.8 0ns 100ps 100ps 40ns 80ns)
V_in_2 node_a{L[0]} gnd PULSE(0 1.8 0ns 100ps 100ps 40ns 80ns)
V_in_1 node_a{j} gnd PULSE(0 1.8 0ns 100ps 100ps 40ns 80ns)
'''
        data = fp1.read()

        search_text = "*delay"
        replace_text = f'''
.measure tran trise 
+ TRIG v({s1}) VAL = 'SUPPLY/2' {mode1} = 1
+ TARG v({s2}) VAL = 'SUPPLY/2' {mode2} = 1 

.measure tran tfall 
+ TRIG v({s1}) VAL = 'SUPPLY/2' {mode3} = 1 
+ TARG v({s2}) VAL = 'SUPPLY/2' {mode4} = 1

.measure tran tpd param = '(trise + tfall)/2' goal = 0
        '''
        search_text2 = "*inputPulses"
        data = data.replace(search_text,replace_text)
        data = data.replace(search_text2,inputPulses)
        fp2.write(data)
        fp1.close()
        fp2.close()

        completed_process = subprocess.run(command, shell=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if completed_process.returncode == 0:
            output = completed_process.stdout
        else:
            output = ("Command execution failed. at",str(j))

        output = output.split('\n')
        output = output[-4] 
        additional_text = f" input = {s1} output = {s2}\n"

        fp3.write(output+additional_text)
        # time.sleep(0.4)
    fp3.close()
subprocess.run(["rm","tempfile.cir"])