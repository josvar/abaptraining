* TODO: Audit YCL_CH03_KNVK View
* Check:
* https://stackoverflow.com/questions/4076098/how-to-select-rows-with-no-matching-entry-in-another-table
* 
* SELECT t1.ID
* FROM Table1 t1
*     LEFT JOIN Table2 t2 ON t1.ID = t2.ID
* WHERE t2.ID IS NULL
*
