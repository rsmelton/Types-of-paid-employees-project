/*
    Below we have multiple predicates that can output different things depending
    on what we want. 

    list - lists out all the employees that satisfied the Operator Ref condition.
    count - reports the number of employees that satisfied the Operator Ref condition.
    min - reports the minimum pay that satisfies the Operator Ref condition.
    max - reports the maximum pay that satisfies the Operator Ref condition.
    total - reports the total amount of all the employees pay that satisfies the Operator Ref condition.
    avg - reports the avg pay of all the employees that satisfies the Operator Ref condition.
*/

list(Operator, Ref, List) :- (
    Operator = ('=='), findall([First, Last, Pay], (pay(First, Last, Pay), Pay =:= Ref), List);
    Operator = ('!='), findall([First, Last, Pay], (pay(First, Last, Pay), Pay =\= Ref), List);
    Operator = ('>'), findall([First, Last, Pay], (pay(First, Last, Pay), Pay > Ref), List);
    Operator = ('>='), findall([First, Last, Pay], (pay(First, Last, Pay), Pay >= Ref), List);
    Operator = ('<'), findall([First, Last, Pay], (pay(First, Last, Pay), Pay < Ref), List);
    Operator = ('<='), findall([First, Last, Pay], (pay(First, Last, Pay), Pay =< Ref), List)
).

/* 
    third_element allows us to create a list of only the Pay of the list of employees.
    This allows us to use the list predicate in all of our other functions to make
    our lives easier.
*/

third_element([_, _, Pay], Pay).

count(Operator, Ref, Count) :- (
    list(Operator, Ref, List),
    length(List, Count)
).

min(Operator, Ref, Min) :- (
    list(Operator, Ref, List),
    maplist(third_element, List, Pay_List),
    min_list(Pay_List, Min)
).

max(Operator, Ref, Max) :- (
    list(Operator, Ref, List),
    maplist(third_element, List, Pay_List),
    max_list(Pay_List, Max)
).

total(Operator, Ref, Total) :- (
    list(Operator, Ref, List),
    maplist(third_element, List, Pay_List),
    sum_list(Pay_List, Total)
).

avg(Operator, Ref, Avg) :- (
    list(Operator, Ref, List),
    maplist(third_element, List, Pay_List),
    sum_list(Pay_List, Total),
    count(Operator, Ref, Count),
    Count > 0,
    Avg is Total / Count
).
