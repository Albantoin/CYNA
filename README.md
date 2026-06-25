# Projet CYNA - Infrastructure Informatique Hybride et Sécurisée

## 📌 Présentation du Projet
**CYNA** est une entreprise spécialisée dans les solutions de cybersécurité avancées (SOC, EDR, XDR) et l'édition d'une plateforme SaaS. Dans le cadre de son expansion commerciale — avec l'établissement d'un nouveau siège social à Genève et d'une filiale opérationnelle à Paris — ce projet propose un modèle d'infrastructure hautement sécurisé, résilient et conçu selon les principes du **"Security by Design"**.

Le défi majeur de ce Proof of Concept (PoC) a été de simuler un réseau d'entreprise multi-sites complet tout en respectant une contrainte matérielle stricte de **14 Go de RAM**.

---

## 🏗️ Conception de l'Architecture

Pour garantir le cloisonnement des environnements et une haute disponibilité malgré les ressources mémoire limitées, une topologie cloud hybride optimisée a été déployée :

### 1. Optimisation On-Premises (Infrastructure Locale)
* **Hyperviseur :** Un hôte unique **Microsoft Hyper-V** centralise la virtualisation.
* **Simulation Multi-Sites :** Les sites de Genève et Paris sont simulés logiquement sur le même hyperviseur grâce à une **segmentation par VLANs** stricte.
* **Sécurité Périmétrique :** Deux pare-feux virtuels **pfSense** gèrent le routage inter-VLAN et sécurisent l'interconnexion via un tunnel **VPN IPsec** chiffré.
* **Gestion de l'Identité :** Les contrôleurs de domaine Active Directory (Genève/Paris) sont installés sous **Windows Server Core** (sans interface graphique) afin de réduire drastiquement l'empreinte mémoire.
* **Conteneurisation :** Les services applicatifs internes lourds sont consolidés sur un hôte **Docker** unique pour économiser la RAM.

### 2. Extension Cloud Public (Microsoft Azure)
Pour délester le stockage et le calcul local, l'infrastructure s'étend vers **Microsoft Azure** à travers un tunnel VPN IPsec de site à site :
* **Plan de Reprise d'Activité (PRA) :** Sauvegardes externalisées et automatisées gérées via **Veeam**.
* **Gestion des Mises à Jour :** Distribution centralisée des correctifs système via un serveur **WSUS** hébergé sur Azure.
* **Environnement SaaS :** Hébergement et simulation de la plateforme SaaS de CYNA vendue à ses clients.

---

## 🔒 Implémentation de la Sécurité & du SOC

En accord avec l'expertise de CYNA, la sécurité est intégrée à chaque couche de l'infrastructure :

* **Architecture Zero Trust (ZTNA) :** Application d'une politique de blocage par défaut sur les pare-feux pfSense ; tout trafic inter-VLAN est interdit, sauf les flux explicitement autorisés (ex: réplication Active Directory).
* **Surveillance Active (SIEM/EDR) :** La solution **Wazuh** est conteneurisée et optimisée (JVM limitée à 1 Go de RAM) pour centraliser la collecte des journaux de sécurité des machines endpoints.
* **Durcissement des Endpoints (Hardening) :** Déploiement de politiques de mots de passe complexes et restrictions des périphériques USB via les **GPOs** de l'Active Directory.

---

## ⚙️ DevOps & Automatisation (IaC)

L'environnement est entièrement reproductible, standardisé et sécurisé dès sa conception, minimisant ainsi les erreurs de configuration humaines :

| Périmètre | Outil | Objectif |
| :--- | :--- | :--- |
| **Infrastructure Cloud** | `Terraform` | Provisionnement automatisé du réseau virtuel et des machines sur Azure. |
| **Gestion des Configurations** | `Ansible` | Automatisation des configurations réseaux et systèmes locaux. |
| **Déploiement de Services** | `Docker Compose` | Déploiement et orchestration des microservices et conteneurs locaux. |

---

## 🛠️ Stack Technique

* **Virtualisation :** Microsoft Hyper-V
* **Cloud :** Microsoft Azure
* **Conteneurs :** Docker & Docker Compose
* **Systèmes d'exploitation :** Windows Server Core, Linux Ubuntu
* **Réseau & Sécurité :** pfSense, VPN IPsec
* **Supervision & SIEM :** Wazuh (SIEM/EDR), Zabbix
* **Sauvegarde & Conformité :** Veeam, WSUS
* **Automatisation :** Terraform, Ansible
