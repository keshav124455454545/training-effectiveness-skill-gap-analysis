# Project workflow and setup

## Dataset disclaimer
The 1,500-row dataset is simulated for academic demonstration. It is not confidential SkillInfyTech operational data.

## Workflow
1. **Excel:** inspect the dataset, review data types, calculate KPIs, and use pivot tables for cohort summaries.
2. **MySQL:** import the CSV into a table named `training_effectiveness` and run `sql/analysis_queries.sql`.
3. **Python:** install dependencies and run `python python/analysis.py` to create analysis summaries and charts.
4. **Power BI:** import the CSV or workbook into Power BI Desktop and build KPI cards, cohort readiness, skill averages, performance bands, and slicers.

## Run the Python script
From the repository root:

```bash
pip install -r requirements.txt
python python/analysis.py
```

Generated summaries are saved to `data/generated_*.csv`; generated charts are saved to `images/generated/`.

## Power BI file note
A `.pbix` file is not included because no saved Power BI project file was available. `images/executive_dashboard_preview.png` is a designed preview using report values, not a screenshot or editable Power BI file.

## Report
The `report/` folder includes the matching internship report files available in this workspace. Verify final signatures and institution-required details before submission or public sharing.
