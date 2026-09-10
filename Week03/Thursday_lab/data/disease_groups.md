# Disease Group Mapping for Students

This dataset compresses detailed ICD diagnosis codes into a smaller teaching label called `disease_group`.

The goal is not to perfectly reproduce clinical diagnosis. The goal is to create a believable, learnable target for machine-learning exercises while keeping the original NHAMCS data mostly intact.

## How the compression works

- The source data contains up to 5 diagnosis fields: `DIAG1` through `DIAG5`.
- The builder looks across those diagnosis codes and assigns one primary `disease_group`.
- If an early diagnosis is very general, a later more specific diagnosis may be used instead.
- Injury visits are treated specially: NHAMCS has its own injury field, so the target uses that field to distinguish:
  - `injury_trauma`
  - `injury_poisoning`
  - `injury_adverse_care`

## Main disease groups

| disease_group | Rough ICD rule |
| --- | --- |
| `cardiovascular` | Most `I*` codes |
| `respiratory` | Most `J*` codes except upper-airway/ENT subgroups |
| `neurological` | `G*` codes |
| `gastrointestinal` | Most `K*` codes except liver/biliary/pancreatic subgroups |
| `hepatobiliary_pancreatic` | `K70-K87` |
| `genitourinary_renal` | `N*` codes |
| `endocrine_metabolic` | `E*` codes |
| `musculoskeletal` | `M*` codes |
| `dermatologic` | `L*` codes |
| `psychiatric_behavioral` | `F*` codes |
| `infectious_disease` | `A*`, `B*`, and `U*` codes |
| `injury_trauma` | Injury/trauma visits, including many `S*`, `V*`, `W*`, `X*`, `Y*` patterns |
| `injury_poisoning` | Poisoning/overdose visits |
| `injury_adverse_care` | Adverse effects of medical or surgical care |
| `pregnancy_related` | `O*` codes |
| `ear_nose_throat_eye` | `H*` codes and upper-airway/ENT `J00-J06`, `J30-J39` |
| `general_constitutional` | `R*` symptom codes |
| `other` | Residual categories that do not fit the teaching taxonomy cleanly |

## Important caveats

- `disease_group` is a lossy simplification of ICD codes.
- Some groups are broad by design. For example, `gastrointestinal` and `hepatobiliary_pancreatic` are still much coarser than real diagnosis coding.
- `general_constitutional` often means the visit was coded mainly as symptoms rather than a clearly localized disease.
- `other` is expected to be large. That is part of the realism of the exercise.

## Secondary labels

The dataset also includes `secondary_disease_groups`, which is a simple mechanical summary of additional diagnosis groups seen in the remaining diagnosis fields.

This is meant to help students explore comorbidity and overlap without forcing an interpretation.
