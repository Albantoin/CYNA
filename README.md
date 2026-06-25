# CYNA Project - Secure Hybrid IT Infrastructure

## 📌 Project Overview
**CYNA** is a leading cybersecurity company specializing in advanced protection solutions (SOC, EDR, XDR) and multi-tenant SaaS platform hosting. As part of its corporate expansion—establishing a new headquarters in Geneva and an operational branch in Paris—this project delivers a highly secure, resilient, and **"Security by Design"** infrastructure blueprint.

The core challenge of this Proof of Concept (PoC) was to simulate a robust, multi-site enterprise network while constrained by a strict hardware limitation of **14 GB of RAM**.

---

## 🏗️ Architecture Design

To achieve enterprise-grade separation and high availability within a limited memory footprint, the project implements an optimized hybrid cloud topology:

### 1. On-Premises Optimization (Local Infrastructure)
* **Hypervisor:** A single **Microsoft Hyper-V** host manages the virtual environment.
* **Multi-Site Simulation:** Geneva and Paris offices are logically simulated on the same host using strict **VLAN segmentation**.
* **Perimeter Security:** Two virtual **pfSense** firewalls enforce inter-VLAN routing and secure site-to-site communication via an encrypted **IPsec VPN tunnel**.
* **Identity Management:** Dual Active Directory Domain Controllers (Geneva/Paris) are deployed using **Windows Server Core** (CLI only) to drastically reduce memory overhead.
* **Containerization:** Resource-heavy internal applications are consolidated onto a single Linux **Docker Host** to save RAM.

### 2. Public Cloud Extension (Microsoft Azure)
To offload local compute and storage, critical services are extended into **Microsoft Azure** through a Site-to-Site IPsec VPN:
* **Disaster Recovery Plan (DRP):** Automated off-site backups managed via **Veeam**.
* **Update Management:** Centralized patch delivery using an Azure-hosted **WSUS** server.
* **SaaS Environment:** Hosting and simulation of CYNA's production SaaS platform.

---

## 🔒 Security & SOC Implementation

Aligned with CYNA's expertise, security is embedded into every layer of the infrastructure:

* **Zero Trust Architecture (ZTNA):** Implementation of a default-deny posture on pfSense firewalls; all inter-VLAN traffic is blocked except explicitly authorized flows (e.g., Active Directory replication).
* **Active Surveillance (SIEM/EDR):** **Wazuh** is containerized and optimized with a tuned Java Virtual Machine (JVM capped at 1 GB RAM) to collect security logs centrally from endpoints.
* **Endpoint Hardening:** Centralized enforcement of strict password policies and peripheral (USB) restrictions via Active Directory **Group Policy Objects (GPOs)**.

---

## ⚙️ DevOps & Automation (IaC)

The environment is designed to be fully reproducible, standardized, and secure from the ground up, minimizing human configuration errors:

| Scope | Tool | Purpose |
| :--- | :--- | :--- |
| **Cloud Infrastructure** | `Terraform` | Automated provisioning of Azure Virtual Networks and VMs. |
| **Configuration Management** | `Ansible` | Local system and network automated configurations. |
| **Service Deployment** | `Docker Compose` | Streamlined deployment of local containerized microservices. |

---

## 🛠️ Tech Stack

* **Virtualization:** Microsoft Hyper-V
* **Cloud:** Microsoft Azure
* **Containers:** Docker & Docker Compose
