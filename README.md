# Bipartite left-right sided endocrine system: processing of contralateral effects of brain injury

### Abstract

The crossed descending neural tracts set a basis for contralateral effects of brain injury. In addition, the left-right
side-specific effects of the unilateral brain lesions may be mediated by neurohormones through the humoral pathway as
discovered in animals with disabled descending motor tracts. We here examined if counterparts of the endocrine system
that convey signals from the left and right brain injuries differ in neural and molecular mechanisms. In rats with
completely transected cervical spinal cords a unilateral injury of the hindlimb sensorimotor cortex produced hindlimb
postural asymmetry with contralateral hindlimb flexion, a proxy for neurological deficit. The effects of the left and
right side brain lesions were differently inhibited by antagonists of the δ-, κ- and µ-opioid receptors suggesting
differential neuroendocrine control of the left-right side-specific hormonal signaling. Bilateral deafferentation of the
lumbar spinal cord eliminated hormone-mediated effects of the left-side brain injury but not the right-side lesion
suggesting their afferent and efferent mechanisms, respectively. Analysis of gene-gene co-expression patterns identified
the left and right side-specific gene regulatory networks that were coordinated across the hypothalamus and lumbar
spinal cord through the humoral pathway. The coordination was ipsilateral and perturbed by brain injury. These findings
suggest that the neuroendocrine system that conveys left-right side-specific hormonal messages from injured brain is
bipartite, contributes to contralateral neurological deficits through asymmetric neural mechanisms, and enables
ipsilateral coordination of molecular processes across neural areas along the neuraxis.


**Submitted to the [Function journal](https://academic.oup.com/function/article/5/4/zqae013/7629141)**  
**Authors**: Hiroyuki Watanabe, Yaromir Kobikov, *et al.*


## Processing Contralateral Effects of Brain Injury

This repository contains an R-based biostatistical analysis pipeline to study how unilateral brain lesions produce side-specific endocrine responses via humoral pathways.

---

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Methods](#methods)
- [Results](#results)
- [Contributing](#contributing)
- [License](#license)
- [Citation](#citation)

---

## Features
- Data preprocessing and cleaning  
- Bayesian multilevel modeling of gene expression  
- Co-expression network analysis  
- Publication-ready visualizations  

---

## Installation
1. **Prerequisites**  
   - R  
   - C++ toolchain for Stan (for Bayesian modeling)  
2. **Clone the repository**  
   ```bash
   git clone https://github.com/YaromirKo/biostatistics-nms.git
   cd biostatistics-nms
   ```
3. **Install R packages**  
   ```r
   install.packages(c(
     "tidyverse",
     "brms",
     "rstan",
     "igraph",
     "cowplot",
     "readxl"
   ))
   ```

---

## Usage
1. Open the RStudio project file:  
   ```
   biostatistics-nms.Rproj
   ```
2. Run the main analysis script:  
   ```r
   source("nms-genes-analysis/analysis.R")
   ```
3. View outputs in the `results/` folder.

---

## Project Structure
```
├── data/                  # Raw and processed data files  
├── nms-genes-analysis/    # R scripts for gene expression analysis  
├── results/               # Figures, tables, and network outputs  
├── biostatistics-nms.Rproj # RStudio project file  
├── README.md  
└── LICENSE  
```

---

## Methods
- **Data Loading**: Read and clean expression data with `readxl` and `tidyverse`.  
- **Model Fitting**: Fit Bayesian models using `brms` and `rstan`.  
- **Network Analysis**: Construct and analyze co-expression networks with `igraph`.  

---

## Results
- **Figures**: Side-specific expression plots (`.png`, `.pdf`)  
- **Tables**: Posterior summaries and network metrics (`.csv`)  
- **Reports**: HTML or Word reports via `rmarkdown`.  

---

## Contributing
1. Fork the repo  
2. Create a branch: `git checkout -b feature/YourFeature`  
3. Commit & push: `git push origin feature/YourFeature`  
4. Open a Pull Request  

---

## License
This project is licensed under the MIT License. See `LICENSE` for details.

---

## Citation
If you use this work, please cite:  
> Watanabe H., Kobikov Y., et al. (2025). Bipartite left–right sided endocrine system: processing contralateral effects of brain injury. *Function*.

