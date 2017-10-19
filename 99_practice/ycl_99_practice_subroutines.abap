REPORT YCL_99_PRACTICE_SUBROUTINES.

data num type i value 12.

perform sum_num using num 23.

write: / num.

form sum_num using num sumando.

  num = num + sumando.

endform.
