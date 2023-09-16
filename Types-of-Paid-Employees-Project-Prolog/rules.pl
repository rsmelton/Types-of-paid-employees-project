% Rules for Salaried Employees.
pay(First, Last, Pay) :- salaried(First, Last, Salary),
          Pay is Salary.

% Rules for Commission Employees.
pay(First, Last, Pay) :- commission(First, Last, Min, Sales, Commission_rate),
          (Sales * Commission_rate > Min -> Pay is Sales * Commission_rate;
          Sales * Commission_rate =< Min -> Pay is Min).

% Rules for Hourly Employees.
pay(First, Last, Pay) :- hourly(First, Last, Hours, Rate),
          (Hours =< 40 -> Pay is Hours * Rate;
          Hours =< 50 -> Pay is ((40 * Rate) + ((Hours - 40) * (Rate * 1.5)));
          Hours > 50 -> Pay is ((40 * Rate) + (10 * (Rate * 1.5)) + ((Hours - 50) * (Rate * 2.0)))).