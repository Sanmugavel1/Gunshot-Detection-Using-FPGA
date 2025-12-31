# FPGA-Based Gunshot Detection & DOA System

## Overview
This project implements a real-time gunshot detection and direction-of-arrival (DOA) system using four INMP441 digital microphones and a Basys-3 (Artix-7) FPGA.  
The system focuses on low-latency, hardware-level signal processing using Verilog, with algorithm validation done in MATLAB.

---

## Problem Statement
Fast and accurate detection of gunshots is critical for emergency response and public safety.  
Software-only or cloud-based solutions often introduce latency and dependency on connectivity.

This project explores an FPGA-based edge solution for real-time detection and localization of impulsive acoustic events.

---

## Solution Approach
• Audio is captured simultaneously from 4 digital microphones using I²S  
• Signal energy is calculated to detect gunshot-like impulses  
• Time Difference of Arrival (TDOA) is used to estimate the direction  
• Core processing is implemented fully in Verilog on FPGA  

---

## System Workflow
INMP441 Microphones (4x)  
→ I²S Receiver (FPGA)  
→ Energy Detection  
→ Gunshot Trigger  
→ TDOA Estimation  
→ DOA Angle Output  

---

## Technologies Used
Hardware:
• Basys-3 FPGA (Artix-7)
• INMP441 Digital Microphones

Software / HDL:
• Verilog HDL
• MATLAB (simulation & validation)
• Vivado

---

## Repository Structure
matlab_simulation/  - Algorithm simulation and validation  
verilog/            - FPGA implementation (I²S, detection, DOA)  
docs/               - Architecture diagrams and certificates  

---

## Gunshot Detection Logic
• Gunshots produce short-duration, high-energy acoustic impulses  
• Energy of incoming samples is continuously monitored  
• A threshold-based trigger identifies gunshot events  

---

## DOA Estimation
• Uses relative arrival time differences between microphones  
• Provides coarse direction estimation (prototype stage)  
• Designed for future extension to cross-correlation-based TDOA  

---

## Current Status
✔ I²S audio capture implemented  
✔ Energy-based gunshot detection  
✔ FPGA-level DOA estimation  
✔ MATLAB simulation completed  

---

## Future Enhancements
• Band-pass filtering for gunshot frequencies  
• Improved TDOA using cross-correlation  
• Higher angular resolution  
• UART / dashboard visualization  
• Real-world field testing  

---

## Proof of Work
Relevant participation certificates and documentation are included in the docs folder.

---

## Why This Project
This project demonstrates:
• Real-world problem solving  
• FPGA-based signal processing  
• Hardware–software co-design  
• Hackathon-ready execution mindset  
