# MFM Full Project — Multi-Sheet Result Workbook Final

## Current result workflow

1. Keep one workbook per Exam + Year, for example `MFM_Annual_Result_2026.xlsx`.
2. The workbook may contain `01_Class_One` through `16_Fazil_4th_Year` plus `README`.
3. Fill only the class sheets whose results are ready; empty class sheets are skipped.
4. Admin -> Student results -> **Import result workbook**.
5. One upload imports every non-empty class sheet into Exam, Student, StudentResult and SubjectMark.
6. Re-uploading the same Exam + Year + Class + Group updates existing results and replaces marks.
7. The old single-sheet `Class Result` format is still accepted.

**No sheet named `Class Result` is required for the new multi-sheet workbooks.**

Corrected 2026 workbooks are in:
`EXCEL_TEMPLATES_REFERENCE/Results/2026/`

---

# MFM Full Project - Final Excel-to-Database Result Integration

This package starts from the previously corrected MFM Django project and preserves the accepted homepage, BN/EN system, dynamic 3-level menu, footer, slideshow, and right-aligned header/menu actions.

## Result architecture

Excel is the input/master backup. The live website reads results from the Django database.

Workflow:
1. Prepare one Excel workbook for one Exam + Academic Year + Class + Group.
2. Admin -> Student results -> Import class result Excel.
3. Import automatically creates/updates Exam, Student, StudentResult and SubjectMark records.
4. Public Results search reads the imported database records.
5. Correct the Excel and re-upload it when marks need to change.

## Workbook layout

Sheet name: `Class Result`

- B2: Exam Type
- D2: Academic Year
- F2: Class
- H2: Group
- B3: Exam Title BN
- F3: Exam Title EN
- B4: Optional / 4th Subject exact name, or blank if none
- Row 5, F onward: Subject names
- Row 6, F onward: Full marks
- Row 7 onward: Student ID, Name BN, Name EN, Roll, Section, then subject marks

The supplied master has 20 subject slots. Fill only the subject headers used by a class; blank subject columns are ignored.

## Result rules

Subject grade is based on percentage:
- 80-100 = A+ / 5.00
- 70-79 = A / 4.00
- 60-69 = A- / 3.50
- 50-59 = B / 3.00
- 40-49 = C / 2.00
- 33-39 = D / 1.00
- Below 33 = F / 0.00

Overall rules:
- Any compulsory subject below 33% => FAILED.
- FAILED => GPA 0.00 and merit is hidden.
- Optional subject failure does not fail the overall result.
- Custom optional bonus = min(optional subject GP, 3.00).
  Therefore GP 5/4/3.5/3 contributes 3.00; GP 2 contributes 2.00; GP 1 contributes 1.00; GP 0 contributes 0.
- GPA = (sum of compulsory GP + optional bonus) / number of compulsory subjects, capped at 5.00.
- Merit is calculated among published passed students in the same Exam, ordered by GPA, then Percentage, then Total Marks. Equal keys share the same rank.

## Result sheet

The public result sheet includes institution logo/name/address/EIIN, exam details, student information, subject marks, percentage, letter grade, grade point, total, GPA, PASS/FAILED, merit for passed students, grading scale, and print/PDF styling.

## Important files added/changed

- `portal/models.py`
- `portal/forms.py`
- `portal/views.py`
- `portal/admin.py`
- `portal/result_import.py` (new)
- `templates/portal/results.html`
- `templates/portal/result_sheet.html`
- `templates/admin/portal/studentresult/change_list.html` (new)
- `templates/admin/portal/studentresult/import_excel.html` (new)
- `static/css/result-system.css` (new)
- `requirements-result.txt` (new)

Existing `static/css/site.css`, `static/css/dynamic-menu.css`, main JS, base layout, and dynamic menu are preserved from the accepted right-aligned corrected version.

## Excel template storage

The `EXCEL_TEMPLATES_REFERENCE` folder is for reference/backup only. On your own PC, keep working Excel files outside the Django project, for example:

`C:\MFM-Result-Excel\2026\Annual\`

Do not delete the Excel files after import; keep them as the institution's offline/master result record.
