reigns(rhodri,844,878).
reigns(anarawd,878,916).
reigns(hywel_dda,916,950).
reigns(lago_ad_idwal,950,979).
reigns(hywel_ab_ieuaf,979,985).
reigns(cadwallon,985,986).
reigns(maredudd,986,999).
prince(X,Y) :- reigns(X,A,B), Y >= A, Y =< B.