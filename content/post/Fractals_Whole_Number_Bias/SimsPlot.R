#NOTE: the distributions are obtained in python (Balls_pandas.py)

library(reshape2)
library(xtable)
library(plotrix)
library(purrr)

rm(list=ls())



# Fractals ####
# Case of independent ratio and denominator
# Sierpinsky triangle
p = c(0, 500, 1000)
q = c(0, 1000, 0)

#par(mar=rep(0,4))
par(mfrow = c(1,1))
plot(p, q, col = 'red', pch = 15, cex = 1, axes = F,
     xlab ='', ylab = '')
#random starting point
x = sample(0:1000, 1)
y = sample(0:1000, 1)
for (i in 1:10000){
  #print(i)
  #Sys.sleep(.1)
  n = sample(1:3, 1)
  x = floor(x + (p[n]-x)/2)
  y = floor(y + (q[n]-y)/2)
  
  points(x, y, pch = 15, cex = 0.5)
}


par(mfrow = c(2,2))
nsamples = 2000
n = 1:20 #n number of iterations
shaded = 3^n #number of shaded triangles
unshaded = 3^(n-1) #number of unshaded triangles
total = 4*(3^(n-1)) #total number of triangles (sort of, it never counts the center one)
area_init = 100*100/2 #area
area_unshaded = area_init/4*(3/4)^n #https://math.stackexchange.com/questions/2047664/representing-the-areas-of-sierpinski-triangles-as-a-partial-sum-of-a-geometric-s
area_shaded = area_init-area_unshaded

n1 = rep(NA, nsamples)
d1 = rep(NA, nsamples)
r1 = rep(NA, nsamples)
n2 = rep(NA, nsamples)
d2 = rep(NA, nsamples)
r2 = rep(NA, nsamples)
triangle_base_height_range = c(10, 1000)
for (i in 1:nsamples){
  iter = n[sample.int(length(n), 1)] #random iteration
  sh = 3^iter #number of shaded triangles
  unsh = 3^(iter-1) #number of unshaded triangels
  totalT =  4*(3^(iter-1)) #total number of triangles (sort of, it never counts the center one)
  base = runif(1, triangle_base_height_range[1], triangle_base_height_range[2])
  height = runif(1, triangle_base_height_range[1], triangle_base_height_range[2])
  area_init = base*height/2 #area
  area_unshaded = area_init/4*(3/4)^iter #https://math.stackexchange.com/questions/2047664/representing-the-areas-of-sierpinski-triangles-as-a-partial-sum-of-a-geometric-s
  area_shaded = area_init#-area_unshaded
  n1[i] = area_unshaded
  d1[i] = area_shaded
  r1[i] = area_unshaded/area_shaded
  
  
  iter = n[sample.int(length(n), 1)] #random iteration
  sh = 3^iter #number of shaded triangles
  unsh = 3^(iter-1) #number of unshaded triangels
  totalT =  4*(3^(iter-1)) #total number of triangles (sort of, it never counts the center one)
  base = runif(1, triangle_base_height_range[1], triangle_base_height_range[2])
  height = runif(1, triangle_base_height_range[1], triangle_base_height_range[2])
  area_init = base*height/2 #area
  area_unshaded = area_init/4*(3/4)^iter #https://math.stackexchange.com/questions/2047664/representing-the-areas-of-sierpinski-triangles-as-a-partial-sum-of-a-geometric-s
  area_shaded = area_init#-area_unshaded
  n2[i] = area_unshaded
  d2[i] = area_shaded
  r2[i] = area_unshaded/area_shaded
  
}

plot(r1, d1,
     main = sprintf('r: %s',round(cor.test(r1,d1)$estimate,2)),
     xlab = 'Ratio', ylab = 'Den', bty = 'n',
     cex.lab = 1.5, cex.axis = 1.5, cex = 0.1)

plot(r2, d2,
     main = sprintf('r: %s',round(cor.test(r2,d2)$estimate,2)),
     xlab = 'Ratio', ylab = 'Den', bty = 'n',
     cex.lab = 1.5, cex.axis = 1.5, cex = 0.1)


ns_dl = 0  # larger fraction has smaller numerator and larger denominator (not possible, should be zero!)
nl_dl = 0  # larger fraction has larger numerator and denominator
ns_ds = 0  # larger fraction has smaller numerator and denominator
nl_ds = 0  # larger fraction has larger numerator and smaller denominator
ne_dl = 0  # larger fraction has equal numerator and larger denominator (not possible, should be zero!)
ne_ds = 0  # larger fraction has equal numerator and smaller denominator
ns_de = 0  # larger fraction has smaller numerator and equal denominator (not possible, should be zero!)
nl_de = 0  # larger fraction has larger numerator and equal denominator
ne_de = 0  # larger fraction has equal numerator and equal denominator (not applicable, the counts reflect how many)
for (i in 1:nsamples) { 
  # This loop calculates p(*|RL). *: NL, DL, NS, or DS/
  # For p(RL|*) code see Alonso-Diaz & Penagos (2021, Acta Psychologica)
  # Still, by Bayes rule, p(RL|*) = p(*|RL)p(RL)/p(*).
  # If distributions p(RL), p(*) are continuous or approximately continuous,
  # p(RL) is approx equal  to p(*) i.e. in any continuous distribution the
  # probability of observing that one value is larger than another is 0.5.
  # Therefore, p(RL|*) = p(*|RL) in such cases.
  
  print(i)
  rA = rep(r1[i], nsamples)
  nA = rep(n1[i], nsamples)
  dA = rep(d1[i], nsamples)
  
  idx1 = rA>r2
  n1_L = nA[idx1]
  d1_L = dA[idx1]
  n2_S = n2[idx1]
  d2_S = d2[idx1]
  
  ns_dl = ns_dl + sum((n1_L < n2_S & d1_L > d2_S))
  nl_dl = nl_dl + sum((n1_L > n2_S & d1_L > d2_S))
  ns_ds = ns_ds + sum((n1_L < n2_S & d1_L < d2_S))
  nl_ds = nl_ds + sum((n1_L > n2_S & d1_L < d2_S))
  ne_dl = ne_dl + sum((n1_L == n2_S & d1_L > d2_S))
  ne_ds = ne_ds + sum((n1_L == n2_S & d1_L < d2_S))
  ns_de = ns_de + sum((n1_L < n2_S & d1_L == d2_S))
  nl_de = nl_de + sum((n1_L > n2_S & d1_L == d2_S))
  ne_de = ne_de + sum((n1_L == n2_S & d1_L == d2_S))
  
  
  rA = rep(r2[i], nsamples)
  nA = rep(n2[i], nsamples)
  dA = rep(d2[i], nsamples)
  
  idx1 = rA>r1
  n1_L = nA[idx1]
  d1_L = dA[idx1]
  n2_S = n1[idx1]
  d2_S = d1[idx1]
  
  ns_dl = ns_dl + sum((n1_L < n2_S & d1_L > d2_S))
  nl_dl = nl_dl + sum((n1_L > n2_S & d1_L > d2_S))
  ns_ds = ns_ds + sum((n1_L < n2_S & d1_L < d2_S))
  nl_ds = nl_ds + sum((n1_L > n2_S & d1_L < d2_S))
  ne_dl = ne_dl + sum((n1_L == n2_S & d1_L > d2_S))
  ne_ds = ne_ds + sum((n1_L == n2_S & d1_L < d2_S))
  ns_de = ns_de + sum((n1_L < n2_S & d1_L == d2_S))
  nl_de = nl_de + sum((n1_L > n2_S & d1_L == d2_S))
  ne_de = ne_de + sum((n1_L == n2_S & d1_L == d2_S))
}

bp = c(ns_dl, nl_dl, ns_ds, nl_ds, ne_dl, ne_ds, ns_de, nl_de, ne_de)
nl_dl/sum(bp)
ns_ds/sum(bp)
nl_ds/sum(bp)
ratio = c(r1,r2)
distrA = data.frame(c('NS_DL','NL_DL','NS_DS','NL_DS',
                      'NE_DL','NE_DS','NS_DE','NL_DE',
                      'NE_DE'), bp)
colnames(distrA) = c('Type','Frequency')
cl = distrA[,'Type'] == 'NL_DL' | distrA[,'Type'] == 'NS_DS' | distrA[,'Type'] == 'NL_DS' 
barplot(distrA[cl, 'Frequency']/sum(distrA[,'Frequency']),
        main = 'Fractal fractions',
        ylim = c(0,1),
        ylab = 'Prob.',
        xlab = 'Larger fraction has ... ',
        names.arg = distrA[cl,'Type'],
        cex.names = 1.25,
        cex.lab = 1.5, cex.axis = 1.5, cex.main = 1.5)
lines(seq(0,100, length.out = 200), rep(0.5, 200), lty = 2)
S = distrA[,'Frequency']








