# Final integration changelog

## Preserved
- Existing homepage/slideshow visual design.
- Dynamic 3-level bilingual navigation.
- Header action/menu right alignment.
- BN/EN language switching and query preservation.
- Existing notices/resources/people/result archive filters.
- Existing footer alignment and developer credit.

## Result system added
- Class-wise Excel upload from Django Admin.
- 20-subject flexible workbook format; blank subject columns ignored.
- Student/Exam/StudentResult/SubjectMark automatic create/update.
- Re-upload update behavior; subject marks become the workbook source of truth for that result.
- Duplicate roll/Student ID validation within a workbook.
- Full-mark and obtained-mark validation.
- Subject grade/GP calculation from percentage.
- 33% compulsory pass threshold.
- Custom optional/4th-subject bonus capped at 3.00 GP.
- Optional subject failure does not fail overall result.
- GPA, total, percentage, PASS/FAILED and merit calculation.
- Failed result shown in red and merit hidden.
- Board-style institution-branded printable result sheet.
- Result admin list shows status, GPA and percentage.
- Import/download buttons on Student Results admin.

## Database change
`SubjectMark.is_optional = BooleanField(default=False)`

Run `makemigrations portal` and `migrate` after copying the package.


## Multi-sheet workbook update
- Removed the new-workbook dependency on a sheet named `Class Result`.
- Added one-upload import for Class One through Fazil 4th Year sheets.
- Empty class sheets are skipped; non-empty sheets import atomically.
- Old `Class Result` workbook remains supported.
- Fixed Class One metadata in all four 2026 workbooks.
- Added validation that standard sheet names match the Class value in F2.
- Fixed `IMPORTANT:` footer rows being mistaken for student rows.

## Placeholder subject columns
- `Subject 1` ... `Subject 20` are now treated as inactive template placeholders until renamed to real subjects.
- Placeholder columns are skipped even when a Full Marks value remains in row 6.
- If student marks exist under a placeholder column, the importer raises a clear error instead of silently discarding marks.
