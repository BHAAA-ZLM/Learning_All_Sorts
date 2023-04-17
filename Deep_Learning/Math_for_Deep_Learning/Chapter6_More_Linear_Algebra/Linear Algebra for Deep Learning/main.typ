#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Linear Algebra for Deep Learning",
  authors: (
    (name: "Lumi", email: "12112618@mail.sustech.edu.cn"),
  ),
  date: "April 11, 2023",
)

#set par(justify: true)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!


= Symmetric, Orthogonal, and Unitary Matrices

If for a square matrix, $bold(A)$, we have $ bold(A)^top = bold(A) $
then $bold(A)$ is said to be a *symmetric matrix*.

If the following is true, $ bold(A) bold(A)^top = bold(A)^top bold(A) = bold(I) $ then $bold(A)$ is an *orthogonal matrix*, and $bold(A)^(-1) = bold(A)^top$.

And as a result, $"det"(bold(A)) = plus.minus 1$.

If we count complex matrices, then if $ bold(U)^* bold(U) = bold(U) bold(U) ^ * = bold(I) $ we say that $bold(U)$ is a *unitary matrix* with $bold(U)^*$ being the conjucate transpose of $bold(U)$.

= Eigenvalues and Eigenvectors
Suppose the eigenvalue and eigenvector of matrix $bold(A)$ is $bold(v) "and " lambda$, the property $ bold(A) bold(v) = lambda bold(v) $ holds.

The code in Python `np.linalg.eig(a)` returns two values. `np.linalg.eig(a)[0]` are the eigen values, and `np.linalg.eig(a)[1]` are the eigen vectors for the corresponding eigenvalues.

`print(a)
# [[ 0  1]
  [-2 -3]]

print(np.linalg.eig(a)[0])
# [-1. -2.]

print(np.linalg.eig(a)[1])
# [[ 0.70710678 -0.4472136 ]
 [-0.70710678  0.89442719]] `

 = Vector Norms and Distance Matrix
 For an $n$-dimensional vector, $bold(x)$, we define the $p$-norm of the vector to be $ ||x||_p = (sum_i abs(x_i) ^ p)^(1/p) $ where $p$ is a real number.

 The _L2-norm_, $ abs(abs(x))_2 = sqrt(x_0^2 + x_1^2 + dots + x_(n-1)^2) = sqrt(bold(x)^top bold(x)) $ and the _L1-norm_ $ abs(abs(x))_1  = sum_i abs(x_i) $ are the most frequently used norms in deep learning.

 A funny thing is that the $ L_infinity$-_norm_ finds the maximum absolute value for all the components of $bold(x)$.

 Switching from norm to distance makes a change to the equations,
$ upright(L)_p (bold(x), bold(y)) = (sum_i abs(x_i - y_i)^p)^(1/p) $ this is called the _Euclidean distance_ between two vectors. The L1-distance is often called the _Manhattan distance_ ($upright(L)_1 = sum_i abs(x_i - y_i)$).

= Covariance Matrix
The covariance matrix $bold(Sigma)$ discribes how two columns of data vary together, that is to say $ Sigma_(i j) = 1/(n-1) sum_(k=0)^(n-1) (x_(k i) - overline(x)_i) (x_(k j) - overline(x)_j) $

Numpy function for calculating the covariance matrix is `np.cov(X, rowvar = False)`. We also need to set `rowvar = False` because our data for individual group are stored in the columns.

= Mahalanobis Distance
With the mean value vector $bold(mu)$ and the covariance matrix $bold(Sigma)$, with these values, we can define a distance metric called the _Mahalanobis distance_.
$ D_M = sqrt((bold(x) - bold(mu))^ top bold(Sigma)^(-1) (bold(x) - bold(mu))) $

We can use this _Mahalanobis distance_ as a simple classifier, called the nearest centroid classifier. $D_M$ is more accurate than the L1-distance in classifiers.

= Kullback-Leiber Divergence
The _Kullback-Leiber divergence (KL-divergence)_, or _relative entropy_, is a measure of the similarity between two probability distributions: the lower the value, the more similar the distributions.

If $P "and" Q$ are discrete probabitlity distributions, the KL-divergence is $ D_(upright(K L))(P || Q) = sum_x P(x)log_2(P(x)/Q(x)) $ The KL-divergence isn't a distance metrix in mathematical sense because the symmetry property doesn't hold, $D_(upright(K L))(P||Q) eq.not D_(upright(K L))(Q||P)$.

= Principle Component Analysis
_Principle Component Analysis (PCA)_ is the technique to learn the directions of the scatter in the dataset, starting with the direction aligned along the greatest scatter. The PCA algorithm generally involves the following steps:

#set par(justify: false)
+ Find the mean center of the data.
+ Calculate the covariance matrix, $bold(Sigma)$, of the mean-centered data. 
+ Calculate the eigenvalues and the eigenvectors of $bold(Sigma)$.
+ Sort the eigenvalues by decreasing absolute value.
+ Discard the weaker eigenvalues and eigenvectors.
+ Generate the new transformed values from the existing dataset, $bold(x)' = bold(W x)$.
#set par(justify: true)

PCA are often used in machine learning to reduce the model size, thus usually enhancing the results of the deep learning.

== Singlar Value Decomposition and Pseudoinverse
_Singular value decomposition (SVD)_ is a power technique to transform any matrix into the product of three matrices. For example, for an input matrix $bold(A)$, with real elements and shape $m times n$, where $m$ might not be equal to $n$. Then the SVD for $bold(A)$ is $ bold(A) = bold(U Sigma V^top) $ $bold(A)$ have been decomposed into three matrices. A $m times m$ orthogonal matrix $bold(U)$, a $m times n$ "diagonal" matrix $bold(Sigma)$ and a $n times n$ orthogonal matrix $bold(V)$.

The "sigular" comes from the fact that the diagonal elements of the "diagonal" matrix $bold(Sigma)$, are singular values, the square roots of the positive eigenvalues of the matrix $bold(A^top A)$.

In SciPy, the `svd` function returns three values, $bold(U), bold(Sigma) "and" bold(V)^top$.

We can use the SVD for the PCA, or calculating the pseudoinverse of a matrix.