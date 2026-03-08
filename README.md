# logwatch-lite

> Lightweight Linux log analysis tool for auth, system, and application troubleshooting.

![Linux](https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge)
![Logs](https://img.shields.io/badge/Focus-Log%20Analysis-orange?style=for-the-badge)
![Shell](https://img.shields.io/badge/Bash-Script-green?style=for-the-badge)

---

## Overview

`logwatch-lite` is a simple Bash-based log inspection tool for Linux administrators.

It helps quickly review logs for errors, warnings, authentication failures, SSH activity, and raw log tails without needing complex tooling.

---

## Features

- Log summary mode
- Error filtering
- Warning filtering
- Authentication failure detection
- SSH activity review
- Raw tail mode
- Fast troubleshooting workflow

---

## Use Cases

- Incident troubleshooting
- SSH attack review
- Authentication failure analysis
- Quick system log inspection
- Lightweight operational diagnostics

---

## Requirements

- Linux server
- Bash shell
- `grep`
- `tail`
- `wc`

---

## Installation

Clone the repository:

```bash
git clone https://github.com/I-MONDY-I/logwatch-lite.git
cd logwatch-lite
```
## Make the script executable:

```bash
chmod +x logwatch_lite.sh
```

## Usage
Show summary:

```bash
./logwatch_lite.sh summary /var/log/syslog 100
```
Supported Modes

-summary
-errors
-warnings
-auth-fail
-ssh
-tail

Example Output
```
======================================================================
AUTHENTICATION FAILURES
======================================================================
Mar  8 17:21:10 prod-server sshd[12345]: Failed password for invalid user test from 192.168.1.50 port 51234 ssh2
Mar  8 17:21:14 prod-server sshd[12345]: Failed password for root from 192.168.1.50 port 51235 ssh2
```
