---
layout: post
title: How to SSH into Your Mac
date: '2026-06-27 00:00:00 +0000'
slug: remote-login-mac-ssh
permalink: "/remote-login-mac-ssh/"
tags: [macos, ssh, homelab]
visibility: public
---

Whether you want to control a headless Mac mini or reach your laptop from another room, macOS has built-in SSH support. Here's how to set it up end-to-end.

---

## 1. Enable Remote Login

Open **System Settings → General → Sharing** and flip on **Remote Login**.

You'll see a line like:

```
To log in to this computer remotely, type "ssh username@Your-MacBook.local"
```

That's your address. By default it allows access to all users; you can restrict it to specific ones if needed.

---

## 2. Prevent the Mac from Sleeping

SSH connections drop the moment the Mac goes to sleep. To keep it awake when plugged in:

**System Settings → Battery → Options**

- Turn on **"Prevent automatic sleeping when the display is off"**

Alternatively, from the terminal:

```bash
sudo pmset -c sleep 0 disksleep 0
```

The `-c` flag applies only when connected to AC power.

---

## 3. Generate an SSH Key

Password login works out of the box, but key-based auth is more secure and skips the password prompt.

Generate a new Ed25519 key with an explicit filename:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_macbook -C "macbook"
```

Using `-f` avoids accidentally overwriting an existing `id_ed25519`. This creates two files:
- `~/.ssh/id_ed25519_macbook` — your **private key** (never share this)
- `~/.ssh/id_ed25519_macbook.pub` — your **public key** (safe to copy anywhere)

---

## 4. Authorize the Key on Your Mac

On the Mac you want to SSH **into**, add the public key to its authorized list:

```bash
mkdir -p ~/.ssh
cat ~/.ssh/id_ed25519_macbook.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

If you're adding a key **from another machine**, copy it over first:

```bash
ssh-copy-id -i ~/.ssh/id_ed25519_macbook.pub username@your-mac.local
```

---

## 5. Connect

From any machine on the same network:

```bash
ssh username@your-mac.local
```

From outside your network, you'll need your Mac's public IP and port forwarding set up on your router — or use a tunnel like Tailscale to avoid that entirely.

---

That's it. Remote Login + sleep prevention + a key pair is the minimal setup for a reliably reachable Mac.
