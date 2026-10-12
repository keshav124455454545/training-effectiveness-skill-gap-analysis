from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "training_effectiveness_1500_records.csv"
OUT = ROOT / "images" / "generated"
OUT.mkdir(parents=True, exist_ok=True)

df = pd.read_csv(DATA)
print(f"Records: {len(df):,}")
print(f"Variables: {len(df.columns)}")

kpi_cols = [
    "Attendance_Percentage", "Assignment_Completion_Percentage",
    "Final_Assessment", "Project_Score", "Technical_Skill_Average",
    "Readiness_Score"
]
kpis = df[kpi_cols].mean().round(2).rename_axis("KPI").reset_index(name="Average")
kpis.to_csv(ROOT / "data" / "generated_kpi_summary.csv", index=False)
print("\nKPI averages:\n", kpis.to_string(index=False))

if "Cohort" in df.columns:
    cohort = df.groupby("Cohort").agg(
        Learners=("Intern_ID", "count"),
        Average_Readiness=("Readiness_Score", "mean")
    ).round(2)
    cohort.to_csv(ROOT / "data" / "generated_cohort_summary.csv")
    print("\nCohort summary:\n", cohort)

skill_cols = [
    "Excel_Score", "SQL_Score", "Python_Score", "PowerBI_Score",
    "Statistics_Score", "Data_Cleaning_Score", "Data_Visualization_Score"
]
skills = df[skill_cols].mean().sort_values()
skills.rename_axis("Skill").rename("Average_Score").to_csv(ROOT / "data" / "generated_skill_summary.csv")
fig, ax = plt.subplots(figsize=(9, 5))
skills.plot(kind="barh", ax=ax)
ax.set_title("Average Technical Skill Scores")
ax.set_xlabel("Average score")
ax.set_ylabel("Skill")
fig.tight_layout()
fig.savefig(OUT / "technical_skill_averages.png", dpi=160)
plt.close(fig)

bands = df["Performance_Band"].value_counts().rename_axis("Performance_Band").rename("Learners")
bands.to_csv(ROOT / "data" / "generated_performance_bands.csv")
fig, ax = plt.subplots(figsize=(8, 5))
bands.plot(kind="bar", ax=ax)
ax.set_title("Learners by Performance Band")
ax.set_ylabel("Learners")
ax.set_xlabel("Performance band")
fig.tight_layout()
fig.savefig(OUT / "performance_bands.png", dpi=160)
plt.close(fig)

corr_cols = ["Attendance_Percentage", "Final_Assessment", "Project_Score",
             "Technical_Skill_Average", "Readiness_Score"]
corr = df[corr_cols].corr(numeric_only=True)
corr.to_csv(ROOT / "data" / "generated_correlation_matrix.csv")
print("\nCorrelation matrix:\n", corr.round(2))

print("\nNote: the dataset is simulated for academic demonstration. Correlation does not establish causation.")
