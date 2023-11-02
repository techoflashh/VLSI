import os
import subprocess
import time

fp3 = open("output_delayAND5IN.txt",'w')
fp3.close()

command = "ngspice tempfile.cir"

for j in range(1,6):
    s1 = "vin"+str(j)
    s2 = "vout"
    fp1 = open("delayAND5IN.cir",'r')
    fp2 =open("tempfile.cir",'w')
    fp3 = open("output_delayAND5IN.txt",'a')
    mode1 = "RISE"
    mode2 = "RISE"
    mode3 = "FALL"
    mode4 = "FALL"

    data = fp1.read()
    L = [1,2,3,4,5]
    L.remove(j)
    inputPulses = f'''
V_in_5 vin{L[3]} gnd PULSE(0 1.8 0ns 100ps 100ps 320ns 640ns)
V_in_4 vin{L[2]} gnd PULSE(0 1.8 0ns 100ps 100ps 160ns 320ns)
V_in_3 vin{L[1]} gnd PULSE(0 1.8 0ns 100ps 100ps 80ns 160ns)
V_in_2 vin{L[0]} gnd PULSE(0 1.8 0ns 100ps 100ps 40ns 80ns)
V_in_1 vin{j} gnd PULSE(0 1.8 0ns 100ps 100ps 20ns 40ns)
'''
    search_text = "*delayAnalysis"
    replace_text = f'''
.measure tran trise 
+ TRIG v({s1}) VAL = 'SUPPLY/2' {mode1} =1
+ TARG v({s2}) VAL = 'SUPPLY/2' {mode2} =1 

.measure tran tfall 
+ TRIG v({s1}) VAL = 'SUPPLY/2' {mode3} =1 
+ TARG v({s2}) VAL = 'SUPPLY/2' {mode4}=1

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
subprocess.run(["rm","tempfile.cir"])