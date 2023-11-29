import os
import subprocess
import time

command = "ngspice tempfile.cir"

fp3 = open("outputDelayComp.txt",'w')
fp3.close()
for j in range(0,8):

    L1 = [0,1,2,3]
    if (j<4):
        L1.remove(j)
    else:
        L1.remove(j-4)
    inputPulses1 = f'''V_in_a3 vina{j} gnd PULSE(0 1.8 0ns 100ps 100ps 20ns 40ns)
V_in_a2 vina{L1[2]} gnd PULSE(0 1.8 0ns 100ps 100ps 60ns 120ns)
V_in_a1 vina{L1[1]} gnd PULSE(0 1.8 0ns 100ps 100ps 60ns 120ns)
V_in_a0 vina{L1[0]} gnd PULSE(0 1.8 0ns 100ps 100ps 60ns 120ns)

V_in_b3 vinb{j} gnd DC 1.8
V_in_b2 vinb{L1[2]} gnd DC 0
V_in_b1 vinb{L1[1]} gnd DC 0
V_in_b0 vinb{L1[0]} gnd DC 0

V_in_Sel1 vinSel1 gnd DC 1.8
V_in_Sel0 vinSel0 gnd DC 0
'''
    inputPulses2 = f'''V_in_a3 vina{j-4} gnd DC 1.8
V_in_a2 vina{L1[2]} gnd DC 0
V_in_a1 vina{L1[1]} gnd DC 0
V_in_a0 vina{L1[0]} gnd DC 0

V_in_b3 vinb{j-4} gnd PULSE(0 1.8 0ns 100ps 100ps 20ns 40ns)
V_in_b2 vinb{L1[2]} gnd PULSE(0 1.8 0ns 100ps 100ps 60ns 120ns)
V_in_b1 vinb{L1[1]} gnd PULSE(0 1.8 0ns 100ps 100ps 60ns 120ns)
V_in_b0 vinb{L1[0]} gnd PULSE(0 1.8 0ns 100ps 100ps 60ns 120ns)

V_in_Sel1 vinSel1 gnd DC 1.8
V_in_Sel0 vinSel0 gnd DC 0
'''
    inputPulses = inputPulses1
    if j<4:
        s1 = "vina"+str(j)
        inputPulses = inputPulses1
    else:
        s1 = "vinb"+str(j-4)
        inputPulses = inputPulses2

    for i in range(0,3):
        s2 = "vout"+str(i)     
        fp1 = open("delay.cir",'r')
        fp2 =open("tempfile.cir",'w')
        fp3 = open("outputDelayComp.txt",'a')
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