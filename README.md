# Projet CYNA - Infrastructure Informatique Hybride et Sécurisée

## 📌 Présentation du Projet
[cite_start]**CYNA** est une entreprise spécialisée dans les solutions de cybersécurité avancées (SOC, EDR, XDR) et l'édition d'une plateforme SaaS[cite: 46]. [cite_start]Dans le cadre de son expansion commerciale — avec l'établissement d'un nouveau siège social à Genève et d'une filiale opérationnelle à Paris [cite: 47] [cite_start]— ce projet propose un modèle d'infrastructure hautement sécurisé, résilient et conçu selon les principes du **"Security by Design"**[cite: 48].

[cite_start]Le défi majeur de ce Proof of Concept (PoC) a été de simuler un réseau d'entreprise multi-sites complet tout en respectant une contrainte matérielle stricte de **14 Go de RAM**[cite: 49].

---

## 🏗️ Conception de l'Architecture

Pour garantir le cloisonnement des environnements et une haute disponibilité malgré les ressources mémoire limitées, une topologie cloud hybride optimisée a été déployée :

### 1. Optimisation On-Premises (Infrastructure Locale)
* [cite_start]**Hyperviseur :** Un hôte unique **Microsoft Hyper-V** centralise la virtualisation[cite: 50].
* [cite_start]**Simulation Multi-Sites :** Les sites de Genève et Paris sont simulés logiquement sur le même hyperviseur grâce à une **segmentation par VLANs** stricte[cite: 50].
* [cite_start]**Sécurité Périmétrique :** Deux pare-feux virtuels **pfSense** gèrent le routage inter-VLAN et sécurisent l'interconnexion via un tunnel **VPN IPsec** chiffré[cite: 51].
* [cite_start]**Gestion de l'Identité :** Les contrôleurs de domaine Active Directory (Genève/Paris) sont installés sous **Windows Server Core** (sans interface graphique) afin de réduire drastiquement l'empreinte mémoire[cite: 52].
* [cite_start]**Conteneurisation :** Les services applicatifs internes lourds sont consolidés sur un hôte **Docker** unique pour économiser la RAM[cite: 53].

### 2. Extension Cloud Public (Microsoft Azure)
[cite_start]Pour délester le stockage et le calcul local, l'infrastructure s'étend vers **Microsoft Azure** à travers un tunnel VPN IPsec de site à site[cite: 58]:
* [cite_start]**Plan de Reprise d'Activité (PRA) :** Sauvegardes externalisées et automatisées gérées via **Veeam**[cite: 59].
* [cite_start]**Gestion des Mises à Jour :** Distribution centralisée des correctifs système via un serveur **WSUS** hébergé sur Azure[cite: 59].
* [cite_start]**Environnement SaaS :** Hébergement et simulation de la plateforme SaaS de CYNA vendue à ses clients[cite: 59].

---

## 🔒 Implémentation de la Sécurité & du SOC

[cite_start]En accord avec l'expertise de CYNA, la sécurité est intégrée à chaque couche de l'infrastructure[cite: 84]:

* [cite_start]**Architecture Zero Trust (ZTNA) :** Application d'une politique de blocage par défaut sur les pare-feux pfSense ; tout trafic inter-VLAN est interdit, sauf les flux explicitement autorisés (ex: réplication Active Directory)[cite: 54].
* [cite_start]**Surveillance Active (SIEM/EDR) :** La solution **Wazuh** est conteneurisée et optimisée (JVM limitée à 1 Go de RAM) pour centraliser la collecte des journaux de sécurité des machines endpoints[cite: 55, 90].
* [cite_start]**Durcissement des Endpoints (Hardening) :** Déploiement de politiques de mots de passe complexes et restrictions des périphériques USB via les **GPOs** de l'Active Directory[cite: 56].

---

## ⚙️ DevOps & Automatisation (IaC)

[cite_start]L'environnement est entièrement reproductible, standardisé et sécurisé dès sa conception, minimisant ainsi les erreurs de configuration humaines[cite: 60, 61]:

| Périmètre | Outil | Objectif |
| :--- | :--- | :--- |
| **Infrastructure Cloud** | `Terraform` | [cite_start]Provisionnement automatisé du réseau virtuel et des machines sur Azure[cite: 60]. |
| **Gestion des Configurations** | `Ansible` | [cite_start]Automatisation des configurations réseaux et systèmes locaux[cite: 60]. |
| **Déploiement de Services** | `Docker Compose` | [cite_start]Déploiement et orchestration des microservices et conteneurs locaux[cite: 60]. |

---

## 🛠️ Stack Technique

* [cite_start]**Virtualisation :** Microsoft Hyper-V [cite: 50]
* [cite_start]**Cloud :** Microsoft Azure [cite: 58]
* [cite_start]**Conteneurs :** Docker & Docker Compose [cite: 53, 60]
* [cite_start]**Systèmes d'exploitation :** Windows Server Core, Linux Ubuntu [cite: 52]
* [cite_start]**Réseau & Sécurité :** pfSense, VPN IPsec [cite: 51]
* [cite_start]**Supervision & SIEM :** Wazuh (SIEM/EDR), Zabbix [cite: 53, 55]
* [cite_start]**Sauvegarde & Conformité :** Veeam, WSUS [cite: 59]
* [cite_start]**Automatisation :** Terraform, Ansible [cite: 60]
