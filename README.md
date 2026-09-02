# Grant Intelligence Pipeline — Literature Data Availability

Companion repo to the Grant Success literature table. Tracks which underlying
datasets from the literature review are actually accessible, and includes the
open ones directly.

## ✅ Open — included in this repo (CC-BY licensed)

| Source | File | Original link |
|---|---|---|
| Recio-Saucedo et al. 2022 | `data/recio-saucedo-2022-tables.docx` | https://doi.org/10.1186/s41073-022-00120-2 |
| Rusu et al. 2022 | `data/rusu-2022-romania-survey.xlsx` | https://doi.org/10.1371/journal.pone.0272292 |
| Pina et al. 2021 (Marie Curie) | `data/pina-2021-marie-curie-scores.xlsx`, `data/pina-2021-tables-a1-a2.docx`, `data/pina-2021-reporting-form.pdf` | https://elifesciences.org/articles/59338 |
| Heinze et al. 2025 (Excellence Initiative) | `data/heinze-2025-excellence-replication/` — full replication package: 6 Stata `.do` scripts, 12 `.dta` files, 12 `.csv` files, master do-file | https://osf.io/qf6z2/ |

**Note on Pina et al.:** contains evaluation scores per proposal, not a direct
funded/rejected column. Success would need to be derived from per-call score
thresholds, unlike the Rusu dataset which has an explicit binary outcome.

## ⚠️ On request — no file, but a real access path exists

| Source | Path |
|---|---|
| Urquhart-Cronish & Otto 2019 | Data via NSERC, summary form only |
| Hashiguchi et al. 2024 | Corresponding author, reasonable request |

## 💰 Paywalled — not included, requires institutional login or purchase

| Source | Access note |
|---|---|
| Enger & Castellacci 2016 | Springer, €39.95 or via institutional library login |
| Bornmann, Mutz & Daniel 2007 | ScienceDirect, €39.95 or via institutional library login |

## ❌ Not public — confirmed confidential, no access path

CIHR bias study (Row 9), CIHR resubmission study (Row 14), Oberschelp DFG
org-structure (Row 18), Wanzenböck H2020 consortium study (Row 19),
Twinning/Widening study (Row 21), SNSF/Heyard & Hottenrott (Row 25),
ERC/Veugelers et al. (Row 29) — all built on confidential agency records
(eCORDA, CIHR, SNSF, ERC internal data) with no public access path.

## 🔍 Not yet checked

Rows 3, 4, 5, 6, 7, 10, 11, 13, 15, 17, 20, 22, 27 from the master literature
table have not had their data-availability status individually verified.

## CORDIS funded-proposal corpus

`data/horizon_funded_corpus.xlsx` — 23,258 funded Horizon projects containing
title, abstract, participants, funding, coordinator, and topic code. Bulk export
from CORDIS, CC-BY. This is the **"what winning proposals looked like"** dataset.

## EC R&I Proposals Dashboard exports

Source: [EC R&I Proposals Dashboard](https://dashboard.tech.ec.europa.eu/qs_digit_dashboard_mt/public/sense/app/28b39a3a-4d62-4180-9dfa-551489b06928/sheet/9ccb6c45-f749-4b6a-aecd-eeb2868d5916/state/analysis) — official European Commission dashboard containing proposal, funding, and success-rate statistics.

Dashboard snapshot/data refresh: **31 July 2026**.

### H2020

| Folder | Scope |
|---|---|
| `data/ec-dashboard/h2020-germany/` | H2020, Germany only |
| `data/ec-dashboard/h2020-all-countries/` | H2020, all countries |

Each folder contains 7 exported tables:

- `EligibleProposals-KPI`
- `EligibleApplications-KPI`
- `EligibleEUContribution-KPI`
- `EUContribution-byOrgType`
- `NUTS1-RegionalBreakdown`
- `ProposalStats-byCallID`
- `SuccessRate-byThematicPriority`

### Horizon Europe

| Folder | Scope |
|---|---|
| `data/ec-dashboard/he-germany/` | Horizon Europe, Germany only |
| `data/ec-dashboard/he-all-countries/` | Horizon Europe, all countries |

Each folder contains the same 7 exported tables as the H2020 exports above.

### All Programmes (H2020 + FP7 + Horizon Europe combined)

Unlike the H2020 and Horizon Europe exports above (each scoped to a single
programme), these folders combine all three programmes — H2020, FP7, and
Horizon Europe — in a single view, filtered only by geography.

| Folder | Scope |
|---|---|
| `data/ec-dashboard/allprogrammes-germany/` | All Programmes, Germany only |
| `data/ec-dashboard/allprogrammes-all-countries/` | All Programmes, all countries |

Each folder contains 7 exported tables:

- `EligibleProposals-KPI`
- `EligibleApplications-KPI`
- `EligibleEUContribution-KPI`
- `EUContribution-byOrgType`
- `SuccessRate-byProgramme` — retained proposals, non-successful eligible
  proposals, and success rate broken out per programme (H2020 / FP7 /
  Horizon Europe), rather than by thematic priority
- `ProposalStats-byCallID`
- `CountryBreakdown` (all-countries export) or `NUTS1Breakdown`
  (Germany export) — regional/geographic split at the level appropriate
  to the scope of the export

File naming pattern: `<Scope>-AllProgrammes-<TableName>-AlirezaEftekhar-<DDMMYY>.xlsx`,
e.g. `Germany-AllProgrammes-ProposalStats-byCallID-AlirezaEftekhar-020926.xlsx`.

### Methodological note

The EC dashboard reports success rates primarily at **Call ID level**, not
necessarily at individual **Topic ID level**. For multi-topic calls, the
reported rate can therefore be a blended call-level rate.

Where official topic-level results are available through European Commission
or agency **Flash Call Info / call-results** publications, those should be
preferred over the dashboard call-level rate.

For Horizon Europe 2025–2027, the **all-countries** exports are the primary
source because they provide larger sample sizes. Germany-only exports are
retained for German-specific analysis and regional context. The same applies
to the All Programmes exports.

The H2020 exports are historical predecessor evidence and may be used as a
proxy for unclosed Horizon Europe topics when a comparable completed call
exists. They should not be treated as direct Horizon Europe success rates.
The All Programmes exports, since they blend H2020, FP7, and Horizon Europe
figures together, should likewise not be treated as a direct Horizon Europe
success rate on their own — use `SuccessRate-byProgramme` to isolate the
Horizon Europe-only figures within that export where needed.

## Evidence hierarchy for success rates

When determining the success rate for a target call/topic, use the following
order:

1. **Official topic-level Flash Call Info / call-results**
2. **EC R&I Proposals Dashboard — Call ID level**
3. **Historical H2020 comparable call**
4. **Unavailable — leave blank**

Do not backfill missing values with estimates when no defensible evidence
exists.

## Dataset structure

```text
grant-intelligence-datasets/
├── README.md
└── data/
    ├── ec-dashboard/
    │   ├── h2020-germany/
    │   ├── h2020-all-countries/
    │   ├── he-germany/
    │   ├── he-all-countries/
    │   ├── allprogrammes-germany/
    │   └── allprogrammes-all-countries/
    ├── horizon_funded_corpus.xlsx
    ├── heinze-2025-excellence-replication/
    ├── pina-2021-marie-curie-scores.xlsx
    ├── pina-2021-reporting-form.pdf
    ├── pina-2021-tables-a1-a2.docx
    ├── recio-saucedo-2022-tables.docx
    └── rusu-2022-romania-survey.xlsx
```
