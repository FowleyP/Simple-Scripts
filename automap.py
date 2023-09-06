# This script runs 2 nmap scans: first a syn scan to find open top-ports and then a version scan;
# Then save it into a txt file;

import subprocess
import sys
import time
from colorama import init, Fore, Style

banner = """

░█████╗░██╗░░░██╗████████╗░█████╗░███╗░░░███╗░█████╗░██████╗░░░░██████╗░██╗░░░██╗
██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗████╗░████║██╔══██╗██╔══██╗░░░██╔══██╗╚██╗░██╔╝
███████║██║░░░██║░░░██║░░░██║░░██║██╔████╔██║███████║██████╔╝░░░██████╔╝░╚████╔╝░
██╔══██║██║░░░██║░░░██║░░░██║░░██║██║╚██╔╝██║██╔══██║██╔═══╝░░░░██╔═══╝░░░╚██╔╝░░
██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝██║░╚═╝░██║██║░░██║██║░░░░░██╗██║░░░░░░░░██║░░░
╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝░░░░░░░░╚═╝░░░
                                                                                                                                                                                                                
"""
print(f"{Style.BRIGHT}{Fore.GREEN}{banner}")

init(autoreset=True)

if len(sys.argv) != 3:
    print(f"{Fore.CYAN}Usage: python3 script.py <target> <top-ports>")
    sys.exit(1)

target = sys.argv[1]
top_ports = sys.argv[2]

time.sleep(2)

print(f"{Style.BRIGHT}{Fore.CYAN}Running Nmap...")

command1 = f"nmap -sS -Pn --top-ports={top_ports} --open -T4 {target} | grep -v 'filtered'"
output1 = subprocess.check_output(command1, shell=True, universal_newlines=True)
lines1 = output1.split('\n')[4:-2] # change this if your scan do not show correctly on screen

print(f"{Style.BRIGHT}{Fore.GREEN}Filtered Output of First Scan:")
for line in lines1:
    print(line)


print(f"{Style.BRIGHT}{Fore.CYAN}Scanning Versions...")

command2 = f"nmap -sV -sC -Pn --top-ports={top_ports} --open {target} | grep -v 'filtered'"
output2 = subprocess.check_output(command2, shell=True, universal_newlines=True)
lines2 = output2.split('\n')[4:-3] # change this if your scan do not show correctly on screen

print(f"{Style.BRIGHT}{Fore.GREEN}Filtered Output of Second Scan:")


output_filename = f"nmap_{target}.txt"

with open(output_filename, 'w') as output_file:
    for line in lines2:
        output_file.write(line + '\n')

with open(output_filename, 'r') as saved_output_file:
    saved_output = saved_output_file.read()
    print(f"{Style.BRIGHT}{Fore.BLUE}Saved Output:")
    print(saved_output)

print(f"{Style.BRIGHT}{Fore.BLUE}Output of the scan saved to {output_filename}")
