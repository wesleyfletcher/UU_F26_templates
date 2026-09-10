# ED Visits Probability Lab Dataset

This is a simplified teaching version of the prepared NHAMCS emergency department data.

Each row is one emergency department visit record. The row includes patient characteristics for that visit, but the file should not be treated as a longitudinal patient file with unique patients tracked over time.

This dataset is for probability and data-science teaching. It is not a clinical research dataset, and `disease_group` is a simplified teaching label rather than an ICD diagnosis.

## Files

- `ed_visits_probability_lab.csv`: student-facing CSV version.
- `ed_visits_probability_lab.parquet`: same data in compact Parquet format.
- `nhamcs_ed_2018.parquet`: fuller prepared source file.
- `disease_groups.md`: notes on how the simplified `disease_group` labels were created.

## Core Columns

| column | meaning |
| --- | --- |
| `age_years` | patient age in years |
| `age_group` | simplified age group: `0-17`, `18-34`, `35-49`, `50-64`, or `65+` |
| `sex` | recorded patient sex |
| `payer` | primary expected source of payment |
| `arrival_by_ambulance` | whether the patient arrived by ambulance |
| `triage_level` | simplified triage category |
| `wait_time_minutes` | recorded waiting time before being seen; some values are missing |
| `reason_for_visit_count` | number of reasons for visit recorded |
| `chronic_condition_count` | number of listed chronic conditions; some values are missing |
| `disease_group` | broad teaching label for the visit diagnosis |

## Symptom Columns

The symptom columns are 0/1 indicators. A value of 1 means that reason for visit was recorded somewhere among the visit's reason-for-visit fields.

| column | meaning |
| --- | --- |
| `abdominal_pain` | abdominal pain, cramps, or spasms |
| `cough` | cough |
| `vomiting` | vomiting |
| `fever` | fever |
| `nausea` | nausea |
| `chest_pain` | chest pain |
| `shortness_of_breath` | shortness of breath |
| `headache` | headache or pain in head |
| `accident` | accident, not otherwise specified |
| `dizziness` | vertigo or dizziness |
| `back_pain` | back pain, ache, soreness, or discomfort |
| `anxiety` | anxiety or nervousness |
| `skin_rash` | skin rash |

## Suggested Probability Events

These columns make it easy to define events:

```python
cough = df["cough"] == 1
respiratory = df["disease_group"] == "respiratory"
urgent = df["triage_level"] == "Urgent"
ambulance = df["arrival_by_ambulance"] == "Yes"
```

Then empirical probabilities are just proportions:

```python
cough.mean()
(cough & respiratory).mean()
respiratory[cough].mean()
```

For this lab, interpret probabilities as proportions in this prepared dataset, not as national estimates.
