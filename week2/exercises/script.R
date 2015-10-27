A <- matrix( c(3,2,1,2,4,1,1,1,5) , 3 , 3 )

L <- matrix(0, nrow(A), ncol(A))

L[1,1] <- sqrt( A[1,1] )
L[2,1] <- 1/(L[1,1]) * A[2,1]
L[2,2] <- sqrt( A[2,2] - L[2,1]**2 )
L[3,1] <- 1/(L[1,1]) * ( A[3,1] )
L[3,2] <- 1/(L[2,2]) * ( A[3,2] - L[3,1]*L[2,1] )
L[3,3] <- sqrt( A[3,3] - L[3,1]**2 - L[3,2]**2 )

round(L,2)
round(t(chol(A)),2)

choleski <- function(A) {
  for (j in 1:ncol(A)) {  
    for (i in 1:nrow(A)) {
      
      ii_sum <- function(i,j) {
        result = 0
        for (e in 1:(i-1)) {
          result = result + L[i,e]**2
        }  
      } 
      
      ij_sum <- function(i,j) {
        result2 = 0
        for (r in 1:(i-2)) {
          result2 = result2 + (L[r,1])*(L[r-1,1])
        }
      }
      
      if (i==j) {
        L[i,j] = sqrt( A[i,j] - ii_sum(i,j))
      } 
      if (i < j) {
        L[i,j] = 1/(L[j,j])*(A[i,j] - ij_sum(i,j))
      } else {
        L[i,j] = 0
      }
  return(L)
  }
 }
}


ii_sum <- function(i,j) {
  result = 0
  for (e in 1:(i-1) {
    result = result + L[i,e]**2
  }  
} 

ij_sum <- function(i,j) {
  result2 = 0
  for (r in 1:i) {
    result2 = result2 +(L[i,e+1])*(L[i,e])
  }
}



