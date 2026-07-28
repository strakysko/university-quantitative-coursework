# University Quantitative Coursework

A curated collection of quantitative coursework completed during my studies in **Mathematics, Data Science, Stochastics, and Financial Mathematics** at Vrije Universiteit Amsterdam and the University of Amsterdam.

The repository contains implementations, reports, and exploratory analyses covering computational finance, statistics, optimization, numerical methods, data wrangling, and programming. It is intended both as an academic archive and as a practical overview of my quantitative problem-solving experience.

## Selected coursework

| Area | Topics and methods | Main tools |
|---|---|---|
| [Computational Finance](./computational-finance) | Option pricing, volatility smiles, the COS method, Riccati equations, and exotic derivatives | Python, NumPy, SciPy, Matplotlib |
| [Data-Driven Decision Making in Operations Research](./data-driven-decision-making-in-OR) | Multi-armed bandits, dynamic pricing, demand learning, upper-confidence-bound methods, simulation, and regret analysis | Python, NumPy, Matplotlib |
| [Statistical Data Analysis](./statistical-data-analaysis) | Exploratory analysis, normality testing, kernel density estimation, bootstrapping, Wilcoxon tests, independence tests, and regression models | R |
| [Data Wrangling](./data-wrangling) | Data loading, cleaning, preprocessing, feature engineering, aggregation, and an applied Netflix content/subscriber analysis | Python, pandas, NumPy, Matplotlib, seaborn |
| [Numerical Methods](./numerical-methods) | Numerical root-finding and convergence analysis, including Newton and secant methods | MATLAB |
| [Java Programming](./java-course) | Object-oriented programming and foundational programming exercises | Java |

## Highlighted projects

### Computational finance

The computational-finance assignments apply numerical techniques to derivative-pricing problems. They include implementations related to option valuation, implied-volatility behaviour, Fourier-based pricing through the COS method, Riccati equations, and exotic options.

### Dynamic pricing and sequential decision-making

The operations-research coursework studies decisions made under uncertainty. The simulations explore demand estimation, adaptive pricing, multi-armed bandit policies, confidence-bound methods, and cumulative regret across different parameter settings.

### Statistical modelling in R

The statistical-data-analysis work covers a progression from exploratory visualization and distributional diagnostics to resampling, non-parametric hypothesis testing, contingency-table analysis, and regression modelling.

### Data wrangling and applied analysis

The data-wrangling notebooks demonstrate practical data preparation with pandas, including ingestion, cleaning, transformation, feature construction, and exploratory analysis. The larger applied notebook investigates whether Netflix subscriber growth is associated with the amount of new content added over time.

## Technical coverage

- **Languages:** Python, R, MATLAB, Java
- **Quantitative methods:** simulation, optimization, regression, hypothesis testing, bootstrapping, numerical approximation, sequential learning, and regret analysis
- **Python ecosystem:** NumPy, pandas, SciPy, Matplotlib, seaborn, and Jupyter
- **Application areas:** financial mathematics, operations research, statistics, data science, and numerical computing

## Repository structure

Each top-level directory corresponds to a university course or subject area. Within a directory, numbered folders or files generally follow the original assignment sequence. Where available, source code is accompanied by the corresponding report, assignment document, or generated figures.

```text
university-quantitative-coursework/
├── computational-finance/
├── data-driven-decision-making-in-OR/
├── data-wrangling/
├── statistical-data-analaysis/
├── numerical-methods/
└── java-course/
```

## Reproducibility

Some notebooks depend on datasets supplied during the course or downloaded from external sources. A notebook may therefore require the relevant data files to be placed in its working directory before it can be executed. Package versions were those available when the coursework was completed and may need minor updates in newer environments.

## Notes

- This repository contains academic coursework rather than production software.
- Some assignments were completed within a prescribed notebook or report structure.
- The code is presented to demonstrate the methods used and my development across different quantitative subjects.
- Assignment briefs and reports remain included where they provide useful mathematical or methodological context.
