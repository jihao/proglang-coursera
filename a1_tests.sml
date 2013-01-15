fun assert (b : bool) = 
    if b 
    then "PASS"
    else "FAIL"


val tests = [ 
    assert (is_older ((2011, 1, 1), (2012, 1, 1))),
    assert (not (is_older ((2010, 1, 1), (2010, 1, 1)))),
    assert (not (is_older ((2010, 1, 2), (2010, 1, 1)))),
    assert (number_in_month ([(2012, 1, 1), (2013, 1, 1)], 1) = 2),
    assert (number_in_month ([(2012, 4, 1), (2013, 5, 1)], 1) = 0),
    assert (number_in_months ([(2012, 4, 1), (2013, 5, 1)], [4, 5]) = 2),
    assert (number_in_months ([(2012, 4, 1), (2013, 2, 1)], [5, 6]) = 0),
    assert (dates_in_month ([(2012, 4, 1), (2013, 2, 1)], 1) = []),
    assert (dates_in_month ([(2012, 4, 1), (2013, 2, 1)], 2) = [(2013, 2, 1)]),
    assert (dates_in_months ([(2012, 4, 1), (2013, 2, 1)], [6, 7]) = []),
    assert (dates_in_months ([(2012, 4, 1), (2013, 2, 1)], [4, 2]) = [(2012, 4, 1), (2013, 2, 1)]),
    assert (get_nth(["1","2","3"], 1) = "1"),
    assert (get_nth(["1","2","3"], 3) = "3"),
    assert (date_to_string (2013, 1, 20) = "January 20, 2013"),
    assert (date_to_string (2011, 12, 31) = "December 31, 2011"),
    assert (number_before_reaching_sum (12, [14]) = 0),
    assert (number_before_reaching_sum (12, [5, 6, 9]) = 2),
    assert (what_month(365) = 12),
    assert (what_month(32) = 2),
    assert (month_range (30, 33) = [1, 1, 2, 2]),
    assert (month_range(2, 1) = []),
    assert (isSome (oldest([(2011, 1, 1)]))),
    assert (in_list (1, [1])),
    assert (not(in_list (1, [2, 3]))),
    assert (unique ([1,1,2,2,3]) = [1,2,3]),
    assert (reasonable_date ((2011, 1, 1))),
    assert (not(reasonable_date ((2011, 1, 32)))),
    assert (not(reasonable_date (2011, 2, 29)))
];

fun do_tests(tests : string list) = 
    if null tests
    then "TESTS PASS"
    else if hd tests = "PASS"
    then do_tests(tl tests)
    else "TESTS FAIL"

val test_result = do_tests(tests) 
