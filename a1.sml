fun is_older (d1 : (int*int*int), d2 : (int*int*int)) = 
    (#1 d1 * 365) + (#2 d1 * 30) + #3 d1 < (#1 d2 * 365) + (#2 d2 * 30) + #3 d2


fun number_in_month (dates : (int*int*int) list, month : int) =
    if null dates
    then 0
    else
        if #2 (hd dates) = month
        then 1 + number_in_month(tl dates, month)
        else number_in_month(tl dates, month)

fun number_in_months (dates : (int*int*int) list, months : int list) = 
    if null months
    then 0 
    else number_in_month(dates, (hd months)) + number_in_months(dates, (tl months))

fun dates_in_month (dates : (int*int*int) list, month : int) = 
    if null dates
    then []
    else if (#2 (hd dates)) = month
    then hd dates  :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

fun dates_in_months (dates : (int*int*int) list, months : int list) = 
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth (strings : string list, n : int) =
    if n = 1
    then hd strings
    else get_nth(tl strings, n - 1)

fun month_name (index : int) = 
    let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"] 
    in
        get_nth(months, index)
    end


fun date_to_string (date : (int*int*int)) = 
    let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"] in
        month_name(#2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

fun number_before_reaching_sum (sum : int, l : int list) = 
    let fun helper (acc : int, n : int, l : int list) = 
            if acc + hd l >= sum
            then n
            else helper (acc + hd l, n + 1, tl l) 
    in
        helper(0, 0, l)
    end

fun what_month (day : int) = 
    let val days_of_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum(day, days_of_months) + 1
    end
    

fun month_range (d1 : int, d2 : int) = 
    if d1 > d2
    then []
    else what_month(d1) :: month_range(d1 + 1, d2)

fun oldest (dates : (int*int*int) list) = 
    let fun helper (dates : (int*int*int) list) = 
            if null (tl dates)
            then hd dates
            else let val older = helper (tl dates) 
                 in
                     if is_older (hd dates, older)
                     then hd dates
                     else older
                 end
    in
        if null dates
        then NONE
        else SOME (helper dates)
    end

fun in_list(n : int, l : int list) = 
    if null l
    then false
    else if (hd l) = n
    then true
    else in_list(n, tl l)

fun unique(l : int list) = 
    if null l
    then []
    else if in_list (hd l, tl l)
    then unique(tl l)
    else (hd l) :: unique(tl l)

fun number_in_months_challenge (dates : (int*int*int) list, months : int list) = 
   number_in_months (dates, unique(months))

fun dates_in_months_challenge (dates : (int*int*int) list, months : int list) = 
    dates_in_months (dates, unique(months))

fun reasonable_date(date : (int*int*int)) = 
    let val y = #1 date 
        val m = #2 date 
        val d = #3 date
        val days_of_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        fun is_leap (year : int) =
            (year mod 400 = 0) orelse (year mod 4 = 0 andalso year mod 100 <> 0)
        fun val_of_index (n : int, l : int list) = 
            if n = 0 
            then hd l
            else val_of_index(n - 1, tl l)
    in
        y >= 1 andalso
        m >= 1 andalso
        m <= 12 andalso 
        d >= 1 andalso
        if m <> 2
        then d <= val_of_index (m, days_of_months)
        else if is_leap(y)
        then d <= 29
        else d <= 28 
    end

fun index(n : int, l : int list) = 
    if null l
    then ~1
    else if hd l = n 
    then 0 
    else let val res = index(n, tl l) 
	 in
	     if res = ~1
	     then res
	     else 1 + res
	 end
