# 🛠️ WSL DNS Fix Script

Fix the frustrating `Temporary failure resolving 'archive.ubuntu.com'` error when running `sudo apt update` in Ubuntu on Windows Subsystem for Linux (WSL).

---

## ❗ The Problem

When you run:

```bash
sudo apt update
```

You may encounter this error:

```
Err:1 http://archive.ubuntu.com/ubuntu focal InRelease
  Temporary failure resolving 'archive.ubuntu.com'
Reading package lists... Done
W: Failed to fetch http://archive.ubuntu.com/ubuntu/dists/focal/InRelease  Temporary failure resolving 'archive.ubuntu.com'
W: Some index files failed to download. They have been ignored, or old ones used instead.
```

### 💥 What It Means

This error means WSL can't resolve domain names — it can't convert `archive.ubuntu.com` into an IP address. This is a **DNS (Domain Name System)** issue.

### 🔍 Why It Happens

WSL generally uses Windows' DNS settings, but several factors can disrupt this:

- VPN or proxy usage  
- Misconfigured Windows DNS settings  
- WSL auto-generating a broken `resolv.conf` file  
- Network issues after sleep or reboot  

If `/etc/resolv.conf` is misconfigured, you won't be able to access the internet inside Ubuntu.

---

## ✅ Quick Fix: Use the Script

This script automates the following tasks:

- Prevents WSL from auto-overwriting DNS settings  
- Configures reliable DNS servers (`8.8.8.8` and `1.1.1.1`)  
- Restarts WSL to apply the changes  

### 🧰 Steps to Use

1. **Download the `fix_wsl_dns.sh` file**:

   You can directly download the script using `curl` or `wget`:

   - With `curl`:

     ```bash
     curl -O https://raw.githubusercontent.com/dha-aa/wsl-dns-fix/main/fix_wsl_dns.sh
     ```

   - With `wget`:

     ```bash
     wget https://raw.githubusercontent.com/dha-aa/wsl-dns-fix/main/fix_wsl_dns.sh
     ```

2. Make the script executable:

   ```bash
   chmod +x fix_wsl_dns.sh
   ```

3. Run the script:

   ```bash
   ./fix_wsl_dns.sh
   ```

This will fix the DNS issue automatically.

---

## 🧭 Manual Fix (Two Options)

### ⚡ Temporary Fix (Until Reboot)

If you need a quick fix until WSL restarts:

1. Open the DNS configuration file:

   ```bash
   sudo nano /etc/resolv.conf
   ```

2. Replace its contents with:

   ```
   nameserver 8.8.8.8
   ```

3. Save and exit.  
   > ⚠️ **Note**: This fix is temporary and will be lost after a WSL restart.

---

### 🔐 Permanent Fix (Manual)

To apply the fix permanently:

1. Prevent WSL from auto-generating DNS settings by editing `/etc/wsl.conf`:

   ```bash
   sudo nano /etc/wsl.conf
   ```

2. Add the following lines:

   ```ini
   [network]
   generateResolvConf = false
   ```

3. Backup and remove the existing DNS config:

   ```bash
   sudo mv /etc/resolv.conf /etc/resolv.conf.backup
   ```

4. Create a new `resolv.conf` file with the correct DNS servers:

   ```bash
   echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
   ```

5. Restart WSL:

   ```powershell
   wsl --shutdown
   ```

After reopening Ubuntu, DNS resolution should now work permanently.

---

## 🧪 Check If It Works

After restarting WSL, test by running:

```bash
ping google.com
sudo apt update
```

If both commands work, your DNS issue is resolved!

---

## 🧹 Still Not Working?

### 🔒 VPN or Firewall Issues

VPNs or firewalls may block WSL's network traffic.

1. Disconnect your VPN.
2. Restart WSL:

   ```powershell
   wsl --shutdown
   ```

3. Try running `sudo apt update` again.

If it works, adjust your VPN or firewall settings to allow WSL traffic.

---

### 🔄 Update WSL and Ubuntu

Outdated versions of WSL or Ubuntu might cause issues.

- To update WSL:

  ```powershell
  wsl --update
  ```

- To check your Ubuntu version:

  ```bash
  lsb_release -a
  ```

If you're using an outdated version, consider upgrading Ubuntu.

---

## 📄 License

MIT License  
---
Made with 💻 to improve WSL and make it smoother to use. By [@Dhananajy](https://github.com/dha-aa/)
