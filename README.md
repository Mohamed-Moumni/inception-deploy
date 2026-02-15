# Inception-Deploy

> Automated infrastructure deployment using Ansible and Docker Compose

## Overview

Automates the complete deployment of containerized applications to cloud servers. Uses Ansible for server configuration and Docker Compose for container orchestration.

---

## Architecture

```
┌─────────────────────────────────────────┐
│       Developer Workstation             │
│                                         │
│  ┌─────────────────────────────┐        │
│  │   Ansible Control Node      │        │
│  │                             │        │
│  │  - main.yml (playbook)      │        │
│  │  - inventory.ini (targets)  │        │
│  │  - roles/ (tasks)           │        │
│  └──────────┬──────────────────┘        │
└─────────────┼───────────────────────────┘
              │
              │ SSH
              ▼
┌─────────────────────────────────────────┐
│        Cloud Server (AWS EC2)           │
│                                         │
│  ┌────────────────────────────────┐    │
│  │    Ansible Configures:         │    │
│  │  ✓ Install Docker              │    │
│  │  ✓ Install dependencies        │    │
│  │  ✓ Copy docker-compose.yml     │    │
│  │  ✓ Start containers            │    │
│  └────────────────────────────────┘    │
│                                         │
│  ┌────────────────────────────────┐    │
│  │      Docker Compose            │    │
│  │                                │    │
│  │  [App Container]               │    │
│  │  [Database Container]          │    │
│  │  [Nginx Container]             │    │
│  └────────────────────────────────┘    │
└─────────────────────────────────────────┘
```

---

## How It Works

### 1. Inventory Setup
Define target servers in `inventory.ini`:
```ini
[webservers]
production ansible_host=54.XXX.XXX.XXX ansible_user=ubuntu
```

### 2. Ansible Playbook
`main.yml` orchestrates the deployment:
```yaml
- hosts: webservers
  roles:
    - dependencies    # Install system packages
    - docker         # Install Docker & Docker Compose
    - deployment     # Deploy containers
```

### 3. Deployment Flow
```
Run playbook → Connect to servers → Execute roles → Deploy containers
```

**What happens on each server:**
1. Install system dependencies
2. Install Docker and Docker Compose
3. Copy `docker-compose.yml` to server
4. Pull container images
5. Start application stack

### 4. Docker Compose
Defines the multi-container application:
```yaml
services:
  app:
    image: myapp:latest
    ports:
      - "8080:8080"
  database:
    image: postgres:14
```

---

## Usage

### Deploy to all servers
```bash
ansible-playbook -i inventory.ini main.yml
```

### Test connectivity
```bash
ansible all -i inventory.ini -m ping
```

### Deploy to specific environment
```bash
ansible-playbook -i inventory.ini main.yml --limit production
```

---

## Project Structure

```
inception-deploy/
├── main.yml              # Main playbook
├── inventory.ini         # Server inventory
├── docker-compose.yml    # Container definitions
├── script.sh            # Helper script
└── roles/               # Ansible roles
    ├── dependencies/    # System packages
    ├── docker/         # Docker installation
    └── deployment/     # App deployment
```

---

## Technologies

- **Ansible** - Configuration management & automation
- **Docker Compose** - Multi-container orchestration
- **AWS EC2** - Cloud infrastructure
- **Shell** - Deployment automation

---

## Key Features

✅ **Automated deployment** - One command deploys entire stack
✅ **Idempotent** - Safe to run multiple times
✅ **Multi-environment** - Deploy to dev/staging/production
✅ **Infrastructure as Code** - Version-controlled configuration
✅ **Reproducible** - Same setup every time

---

## Related Project

[Inception-of-Things](https://github.com/Mohamed-Moumni/Inception-of-things) - Kubernetes orchestration with GitOps
