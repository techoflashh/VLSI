import os
import subprocess
import time

command = "ngspice tempfile.cir"

fp3 = open("outputDelaySub.txt",'w')
fp3.close()

for j in range(0,8):
    inputPulses1 = f'''V_in_a3 node_a3 gnd DC PULSE(0 1.8 0ns 100ps 100ps 60ns 120ns)
V_in_a2 node_a2 gnd PULSE(0 1.8 0ns 100ps 100ps 60ns 120ns)
V_in_a1 node_a1 gnd PULSE(0 1.8 0ns 100ps 100ps 60ns 120ns)
V_in_a0 node_a0 gnd PULSE(0 1.8 0ns 100ps 100ps 60ns 120ns)

V_in_b3 node_b3 gnd DC 0
V_in_b2 node_b2 gnd DC 0
V_in_b1 node_b1 gnd DC 0
V_in_b0 node_b0 gnd DC 0

V_in_Sel1 Sel1 gnd DC 0
V_in_Sel0 Sel0 gnd DC 1.8
'''
    inputPulses2 = f'''
V_in_a3 node_a3 gnd DC 1.8
V_in_a2 node_a2 gnd DC 1.8
V_in_a1 node_a1 gnd DC 1.8
V_in_a0 node_a0 gnd DC 1.8

V_in_b3 node_b3 gnd PULSE(1.8 0 0ns 100ps 100ps 60ns 120ns)
V_in_b2 node_b2 gnd PULSE(1.8 0 0ns 100ps 100ps 60ns 120ns)
V_in_b1 node_b1 gnd PULSE(1.8 0 0ns 100ps 100ps 60ns 120ns)
V_in_b0 node_b0 gnd PULSE(1.8 0 0ns 100ps 100ps 60ns 120ns)

V_in_Sel1 Sel1 gnd DC 0
V_in_Sel0 Sel0 gnd DC 1.8
'''
    inputPulses = inputPulses1
    if j<4:
        s1 = "node_a"+str(j)
        inputPulses = inputPulses1
    else:
        s1 = "node_b"+str(j-4)
        inputPulses = inputPulses2

    for i in range(0,4):

        s2 = "node_out"+str(i) 
        fp1 = open("delaySub.cir",'r')
        fp2 =open("tempfile.cir",'w')
        fp3 = open("outputDelaySub.txt",'a')
        mode1 = "RISE"
        mode2 = "RISE"
        mode3 = "FALL"
        mode4 = "FALL"

        data = fp1.read()

        search_text = "*targetText"
        replace_text = f'''
.measure tran trise 
+ TRIG v({s1}) VAL = 'SUPPLY/2' {mode1} =1
+ TARG v({s2}) VAL = 'SUPPLY/2' {mode2} =1 

.measure tran tfall 
+ TRIG v({s1}) VAL = 'SUPPLY/2' {mode3} =1 
+ TARG v({s2}) VAL = 'SUPPLY/2' {mode4}=1

.measure tran tpd param = '(trise + tfall)/2' goal = 0
        '''
        data = data.replace(search_text,replace_text)
        data = data.replace("*inputPulses",inputPulses)
        fp2.write(data)
        fp1.close()
        fp2.close()

        completed_process = subprocess.run(command, shell=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if completed_process.returncode == 0:
            output = completed_process.stdout
        else:
            output = ("Command execution failed. at",str(i),str(j))

        output = output.split('\n')
        output = output[-4] 
        additional_text = f" input = {s1} output = {s2}\n"

        fp3.write(output+additional_text)
# subprocess.run(["rm","tempfile.cir"])