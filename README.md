# Constraint-Aware Hybrid Water Wave and Grey Wolf Optimization for Crop Planning

## Overview

This repository contains the MATLAB implementation of the Constraint-Aware Hybrid Water Wave and Grey Wolf Optimization (CA-HWW-GWO) framework proposed for crop planning under land, water, fertilizer, and budget constraints.

The framework combines the exploration capability of Water Wave Optimization (WWO), the exploitation capability of Grey Wolf Optimization (GWO), and a repair-based feasibility preservation mechanism.

---

## Software Requirements

* MATLAB R2021a or later

---

## Dataset

The study utilizes:

* NASA POWER meteorological data
* Crop-specific economic and resource parameters
* Agricultural statistics collected from the Statistical Abstract of Haryana

Crop parameters, resource constraints, and weather inputs are provided within `loadData_V2.m`.

---

## Experimental Settings

* Population Size = 30
* Maximum Iterations = 200
* Independent Runs = 30
* Uniform Random Initialization

---

## Hardware Configuration

* Intel Core i5-1135G7
* 8 GB RAM
* Windows 10

---

## Repository Structure

```text
src/        MATLAB source code
reproduce/  Scripts used to reproduce manuscript results
result/    Output files and result tables
figures/    Figures used in the manuscript
```

---

## Reproducing Result

1. Open MATLAB.
2. Add the project folder and all subfolders to the MATLAB path.
3. Run the scripts located in the `reproduce` folder.
4. Tables and figures reported in the manuscript can be regenerated automatically.
Random seeds and parameter settings used in the manuscript experiments are provided within the reproduction scripts.
---

## Associated Manuscript

This repository accompanies the manuscript:

"Constraint-Aware Hybrid Water Wave and Grey Wolf Optimization for Crop Planning"

The citation details will be updated once the manuscript is formally published.
