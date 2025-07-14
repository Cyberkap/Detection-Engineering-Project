## Detection Capabilities Demonstrated

1. **Scanning Activity Detection**
   - Zeek logs web scans (Nikto, ZAP)
   - Elastic rules detect scanning patterns
   - Threshold-based alerting for excessive requests

2. **Payload Delivery Detection**
   - HTTP file download monitoring
   - Suspicious script execution patterns
   - Reverse shell detection

3. **Behavioral Detection**
   - Multi-stage attack sequencing
   - Environment reconnaissance before execution

## Getting Started

### Prerequisites
- Ubuntu VM with Zeek installed
- Elastic Stack (or Elastic Cloud)
- Kali Linux and Parrot OS VMs

### Lab Setup
1. Install Zeek on Ubuntu monitoring machine
2. Deploy Elastic Agent on all systems
3. Configure Zeek to send logs to Elastic
4. Import provided detection rules

## Detection Rules
- [Nikto Scan Detection](/configs/elastic-alerts/nikto-detection.json)
- [Nmap Scan Detection](/configs/elastic-alerts/nmap-detection.json)
- [High Volume Request Alert](/configs/elastic-alerts/request-threshold.json)
- [Reverse Shell Detection](/configs/elastic-alerts/reverse-shell.json)

## Example Alerts
![Nikto Detection Alert](/screenshots/nikto-alert.png)
![Reverse Shell Detection](/screenshots/reverse-shell-detected.png)


## License
[MIT License](/LICENSE)

