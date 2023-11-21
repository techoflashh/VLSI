import os
import subprocess
import time

command = "ngspice tempfile.cir"

Lin1 = ["delayAdd1.cir", "delaySub1.cir", "delayComp1.cir", "delayAnd1.cir"]
Lin2 = ["delayAdd2.cir", "delaySub2.cir", "delayComp2.cir", "delayAnd2.cir"]
Lout = ["outputDelayAdd.txt" , "outputDelaySub.txt" , "outputDelayComp.txt" , "outputDelayAnd.txt"]

for k in range(4):
    fp3 = open(Lout[k],'w')
    fp3.close()
    for j in range(0,8):
        if j<4:
            s1 = "node_a"+str(j)
        else:
            s1 = "node_b"+str(j-4)

        for i in range(0,4):

            s2 = "node_out"+str(i) 

            if(j<4):
                fp1 = open(Lin1[k],'r')
            else:
                fp1 = open(Lin2[k],'r')

            fp2 =open("tempfile.cir",'w')
            fp3 = open(Lout[k],'a')
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
subprocess.run(["rm","tempfile.cir"])