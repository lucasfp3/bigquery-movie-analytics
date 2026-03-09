# 🎬 MovieLens Analytics Pipeline (BigQuery)

End-to-end data analytics pipeline built using the **MovieLens Beliefs Dataset**, ingesting raw CSV data into **Google Cloud Storage**, transforming it with **BigQuery SQL**, and producing analytical tables for recommendation system exploration.

This project demonstrates how to design a modern analytics pipeline including **raw ingestion, transformation, validation, exploratory analysis, and KPI generation**.

## 📊 Dataset

This project uses the **MovieLens Beliefs Dataset**, released by the **GroupLens Research Group (University of Minnesota)**.

The dataset contains:

- user ratings
- recommendation system predictions
- belief elicitation data (expected ratings for unseen movies)

Users are anonymized and represented only by `userId`.

**Source:**  
http://grouplens.org/datasets/

**Citation:**  
Aridor, G., Goncalves, D., Kong, R., Culver, D., Konstan, J. (2024).  
*The MovieLens Beliefs Dataset: Collecting Pre-Choice Data for Online Recommender Systems.*

---

## 🏗 Architecture

The pipeline follows a **raw → analytics** transformation model.

```text
CSV Dataset
    │
    ▼
Google Cloud Storage
    │
    ▼
BigQuery RAW Layer
    │
    ▼
BigQuery Analytics Layer
    │
    ├── dim_movies
    ├── fact_ratings
    └── fact_recommendations
    │
    ▼
SQL Analysis

Raw CSV files are ingested as external tables, then transformed into typed analytical tables.

📂 Project Structure
