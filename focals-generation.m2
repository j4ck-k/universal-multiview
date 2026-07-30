-- Calculating bi/tri/quadrifocals for specified n

n = 4
S = QQ[a_(1, 1, 1)..a_(n, 3, 4)]
R = S[x_(1, 1)..x_(n, 3)]

points = for i from 1 to n list(matrix{{x_(i, 1)}, {x_(i,2)}, {x_(i,3)}})
cameras = for i from 1 to n list(matrix(R, {{a_(i, 1, 1)..a_(i, 1, 4)}, {a_(i, 2, 1)..a_(i, 2, 4)}, {a_(i, 3, 1)..a_(i, 3, 4)}}))

emp = matrix(0_(R^3))

foc_mat = sigma -> matrix(for i in sigma list({cameras_i})) | directSum(for i in sigma list points_i)

maxminors = mat -> (if numrows mat == numcols mat then det mat
   else for sigma in subsets(numrows mat, numcols mat) list det submatrix(mat, sigma, ) do print sigma)

bifocals = for sigma in subsets(4, 2) list(det foc_mat sigma);

trifocals = {}
for sigma in subsets(4, 3) do(print sigma; trifocals = join(trifocals, maxminors foc_mat sigma)) ;

quadrifocals = maxminors foc_mat {0, 1, 2, 3};

focals = join(bifocals, trifocals, quadrifocals);

-- save focals to be used later

F = openOut "focals-n"|toString n|".m2"
F << toExternalString focals;
close F;
