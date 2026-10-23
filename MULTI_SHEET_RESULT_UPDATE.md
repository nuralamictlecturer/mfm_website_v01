# Multi-sheet Result Workbook Update

- Fixed the old importer requirement that every workbook must contain a sheet named `Class Result`.
- Supports all-class exam workbooks with sheets `01_Class_One` through `16_Fazil_4th_Year`.
- Keeps backward compatibility with the old `Class Result` workbook.
- Empty class sheets are skipped.
- All non-empty sheets import in one atomic transaction.
- Re-upload updates existing Exam/Student/StudentResult/SubjectMark data.
- Known standard sheet names are cross-checked against F2 Class metadata.
- Subject placeholders with blank Full Marks are ignored; active placeholders raise a clear error until renamed.
- Admin UI text/download template updated for multi-sheet workflow.
- No new database fields; no migration is required for this specific update.
