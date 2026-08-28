# 🌿 Prakriti — Nature-First Civic Waste Management & Live Dispatch

[![License: MIT](https://img.shields.io/badge/License-MIT-emerald.svg)](https://opensource.org/licenses/MIT)
[![Single-File Architecture](https://img.shields.io/badge/Architecture-Single--File%20HTML5-teal.svg)](index.html)
[![Swachh Bharat](https://img.shields.io/badge/Initiative-Swachh%20Bharat%20Mission%202.0-blue.svg)](https://swachhbharatmission.ddws.gov.in/)
[![SWM 2016 Compliant](https://img.shields.io/badge/SWM%20Rules-2016%20Compliant-green.svg)](https://cpcb.nic.in/)

> **A citizen-driven, real-time dispatch and governance ecosystem designed for Indian Urban Local Bodies (ULBs) such as Vijayawada Municipal Corporation (VMC) to eliminate urban solid waste leakage.**

---

## 📌 Problem Statement: India's 22% Solid Waste Leakage Gap

Indian cities generate approximately **150,000 tonnes of municipal solid waste per day**. While municipal collection vehicles collect ~78%, **22% (~33,000 tonnes/day) leaks into vacant plots, open storm-water drains, and neighborhood street corners**.

**Prakriti** bridges this gap through a 3-tier real-time communication ecosystem between **Citizens**, **Field Sanitation Officers**, and **Municipal Administrators**.

---

## 👥 3-Tier Multi-Role Ecosystem

`mermaid
flowchart TD
    A["👤 Citizen Reports Waste (+10 Pts)"] -->|Live Geotagged Broadcast| B["⚡ Municipal Dispatch Pool"]
    B -->|First Officer to Accept| C["🛡️ Field Officer Locks Task"]
    C -->|Shares Direct Phone Number| A
    C -->|Uploads Cleaned Site Photo| D["⏳ In Review Queue"]
    D -->|1-Click Verification| E["👑 Municipal Admin Command Center"]
    E -->|Awards +25 Pts & +50 Credits| F["✔ Cleared & Resolved"]
`

### 1. 👤 Citizen Portal (KYC Verified)
- **One-Tap Geotagging**: Auto-captures GPS coordinates and attaches camera photo evidence.
- **SWM 2016 Categorization**: Classifies waste into **Dry** (plastics/cartons), **Wet** (organic/food), and **Hazardous** (batteries/mercury).
- **Live Dispatch Broadcast**: Instantly notifies active field officers (+10 Eco-Points).
- **Direct Officer Tracking**: Once locked, the citizen sees the officer's name, badge number, and a direct [📞 Call Officer] button.

### 2. 🛡️ Sanitation Field Officer Portal (Live Dispatch & Duty Lock)
- **Real-Time Dispatch Pool**: Streams open waste spots across the ward in real time.
- **First-Come Duty Locking**: Accepting a duty locks the task to the officer and removes it from other officers' feeds.
- **Strict Photographic Proof**: Requires a real photographic proof of the cleared & bleached site.
- **Duty Incentives**: Earns **+50 Duty Credits** per verified clearance.

### 3. 👑 Municipal Admin Command Center (Governance & Dual Credits)
- **Side-by-Side Photo Review**: Inspects **Before (Citizen)** vs. **After (Officer)** evidence side-by-side.
- **1-Click Approvals**: Authorizes clearances in 1 click (+25 Pts to Citizen / +50 Credits to Officer).
- **Anti-Fraud Controls**: Ban/suspend accounts submitting fraudulent reports.
- **Audit Export**: Generates Swachh Survekshan-compliant CSV logs.

---

## ⚡ Technical Highlights

- **Single-File Standalone App (index.html)**: Fully self-contained SPA with zero build tools or Node.js required.
- **Multi-Device Real-Time Sync**: Shared REST API (/api/data, /api/sync) for instant cross-device updates across smartphones and PCs worldwide.
- **Interactive GIS Radar**: Leaflet.js mapping with custom SVG markers and pulsing status indicators.
- **Tactile UI/UX**: Micro-animations (ctive:scale-95), responsive Tailwind CSS layout, and celebratory confetti particles.

---

## 🚀 Getting Started

### Option 1: Direct File Open
Simply double-click [index.html](index.html) in any web browser.

### Option 2: Live Multi-Device Local Server
Run the included PowerShell server script:
`powershell
powershell -ExecutionPolicy Bypass -File .\start_server.ps1
`
Open **http://localhost:8080** in your browser.

---

## 🔐 Demo Credentials

| Role | Username / ID | Security Passkey |
| :--- | :--- | :--- |
| **👤 Citizen** | lakshmi_v | 1234 |
| **🛡️ Field Officer** | VMC-OFF-104 | 1234 |
| **👑 Municipal Admin** | dmin_vmc | GITAM |

---

## 📜 License
This project is open-source under the [MIT License](LICENSE).
