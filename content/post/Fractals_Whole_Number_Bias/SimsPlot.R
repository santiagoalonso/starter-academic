#NOTE: the distributions are obtained in python (Balls_pandas.py)

library(reshape2)
library(xtable)
library(plotrix)
library(purrr)

rm(list=ls())

my.barplot = function(ratio, main1, xlab1, qL, qH,
                      distr, main2, xlab2){
  # hist(ratio[!is.na(ratio)], col = 'blue', 
  #      main = main1,
  #      xlab = xlab1, xlim = xlim1)
  q = quantile(ratio,c(qL,qH))
  # plot(density(ratio[ratio<q[2] & ratio>q[1]]),
  #      main = main1,
  #      xlab = xlab1,
  #      bty = 'n')
  cl = distr[,'Type'] == 'NL_DL' |
    distr[,'Type'] == 'NS_DS' |
    distr[,'Type'] == 'NL_DS' 
  barplot(distr[cl,
                'Frequency']/sum(distr[,'Frequency']),
          main = main2,
          ylim = c(0,1),
          ylab = '', #'Probability',
          xlab = '',#xlab2,
          names.arg = distr[cl,'Type'],
          cex.names = 1.25,
          cex.lab = 1.5, cex.axis = 1.5, cex.main = 1.5)
  lines(seq(0,100, length.out = 200), rep(0.5, 200), lty = 2)
  # barplot(distr[,'Frequency']/sum(distr[,'Frequency']),
  #         main = main2,
  #         ylim = c(0,0.8),
  #         ylab = 'Probability',
  #         xlab = xlab2,
  #         names.arg = distr[,'Type'],
  #         cex.names = 0.75)
}

my.barplot_life = function(ratio, distr, ratiotext, maintext,qL,qH){
  my.barplot(ratio, 
             maintext, 
             ratiotext, 
             qL, qH,
             distr, 
             maintext,
             paste ('Larger',
                    ratiotext,
                    'has ...'))
}

my.radialplot = function(lengths, circles = 5, maxr = 1, col.circ='gray', 
                         col.axis = 'gray', col.poly = 'black',
                         cex.text=1, extlab, cex.etext =1, lty.poly = 1, add = F){
  #lengths: lengths of segments
  #circles: number of concentric circles
  #maxr: max. radius
  #col.circ: color concentric circles
  #col.axis: color of central axis of concentric circles
  #cex.text: size text internal labels
  #add: new plot or not
  #extlab: external labels
  #cex.etext: size text external labels
  #col.poly: color of polygon
  #lty.poly: line type polygon
  
  radius = seq(maxr/circles, maxr, length.out = circles)
  if (!add) {
    par(mai = c(0,0,0.5,0))
    plot(rep(0, 200), seq(-1.2*maxr, 1.2*maxr,length.out = 200), 
         type='l',bty='n',xaxt = 'n', yaxt = 'n', 
         col.lab = 'white', col = col.axis,
         xlim = c(-1.2*maxr, 1.2*maxr),
         ylim = c(-1.2*maxr, 1.2*maxr))
    lines(seq(-1.2*maxr, 1.2*maxr,length.out = 200),rep(0, 200),
          col = col.axis)
    text(c(1.1*maxr,0,-1.1*maxr,0),c(0,1.1*maxr,0,-1.1*maxr), 
         labels = extlab, cex = cex.etext)
    text(-radius, rep(0,circles), 
         labels = radius, cex = cex.text)
    text(-0.5,0, 
         labels = 0.5, cex = cex.text)
    theta = seq(0,2*pi,length.out = 500)
    x = maxr*cos(theta)
    y = maxr*sin(theta)
    polygon(x,y, border = col.circ)
    
    radius = seq(maxr/circles, maxr, length.out = circles)
    for (i in 1:circles) {
      x = radius[i]*cos(theta)
      y = radius[i]*sin(theta)
      polygon(x,y, border = col.circ)
    }
    x = 0.5*cos(theta)
    y = 0.5*sin(theta)
    polygon(x,y, border = col.circ, lty = 2)
    
    x = c(lengths[1],0, -lengths[3],0)
    y = c(0, lengths[2], 0, -lengths[4])
    polygon(x,y, border = col.poly, lty = lty.poly, lwd=2)
  } else {
    x = c(lengths[1],0, -lengths[3],0)
    y = c(0, lengths[2], 0, -lengths[4])
    polygon(x,y, border = col.poly, lty = lty.poly, lwd=2)
  }
  
}



my.distr = function(num, den, title){
  n1 = num
  d1 = den
  n2 = n1
  d2 = d1
  r1 = n1 / d1
  #r1 = r1.values
  r2 = n2 / d2
  #r2 = r2.values
  n_ratio_pairs = length(r1)
  ns_dl = 0  # larger fraction has smaller numerator and larger denominator (not possible, should be zero!)
  nl_dl = 0  # larger fraction has larger numerator and denominator
  ns_ds = 0  # larger fraction has smaller numerator and denominator
  nl_ds = 0  # larger fraction has larger numerator and smaller denominator
  ne_dl = 0  # larger fraction has equal numerator and larger denominator (not possible, should be zero!)
  ne_ds = 0  # larger fraction has equal numerator and smaller denominator
  ns_de = 0  # larger fraction has smaller numerator and equal denominator (not possible, should be zero!)
  nl_de = 0  # larger fraction has larger numerator and equal denominator
  ne_de = 0  # larger fraction has equal numerator and equal denominator (not applicable, the counts reflect how many)
  for (rp in 1:n_ratio_pairs) {
    #print(rp)
    rA = rep(r1[rp], n_ratio_pairs)
    nA = rep(n1[rp], n_ratio_pairs)
    dA = rep(d1[rp], n_ratio_pairs)
    
    idx1 = rA > r2
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
    
  }
  
  
  bp = c(ns_dl, nl_dl, ns_ds, nl_ds, ne_dl, ne_ds, ns_de, nl_de, ne_de)
  
  ratio = c(r1,r2)
  distrA = data.frame(c('NS_DL','NL_DL','NS_DS','NL_DS',
                        'NE_DL','NE_DS','NS_DE','NL_DE',
                        'NE_DE'), bp)
  colnames(distrA) = c('Type','Frequency')
  # my.barplot(ratio, 
  #            'Fractions', 
  #            'Fractions', 
  #            0.0, 0.975,
  #            distrA, 
  #            title,
  #            'Larger fraction has ...')
  distrA[,'Frequency']/sum(distrA[,'Frequency'])
  distrA
}

my.int = function(x, pars) {
  dweibull(x, pars[1], pars[2])*
    pweibull(x,pars[1], pars[2])
}
integrate(my.int,-Inf, Inf, c(5,2))

my.misc = function(n1,d1,n2,d2,nsamples){
  #n1 = d1*rbeta(nsamples, 100, 100) #1,1 for uniform ratios, other ratios are for higher correlations
  r1 = n1/d1
  #n2 = d2*rbeta(nsamples, 1, 1)
  r2 = n2/d2
  
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
  
  bp
}

my.misc2 = function(n1,d1,n2,d2,nsamples){
  #this is the same to misc, use at will ... 
  # ... but at the end it has comments showing that posterior and likelihood nl_rl = rl_nl ...
  # ... because the prior rl and marginal nl are 0.5
  
  
  
  r1 = n1 / d1
  r2 = n2 / d2
  rl_nsdl = 0  # larger fraction has smaller numerator and larger denominator (not possible, should be zero!)
  rl_nldl = 0  # larger fraction has larger numerator and denominator
  rl_nsds = 0  # larger fraction has smaller numerator and denominator
  rl_nlds = 0  # larger fraction has larger numerator and smaller denominator
  rl_nedl = 0  # larger fraction has equal numerator and larger denominator (not possible, should be zero!)
  rl_neds = 0  # larger fraction has equal numerator and smaller denominator
  rl_nsde = 0  # larger fraction has smaller numerator and equal denominator (not possible, should be zero!)
  rl_nlde = 0  # larger fraction has larger numerator and equal denominator
  rl_nede = 0  # not possible 
  nsdl = 0  # larger fraction has smaller numerator and larger denominator (not possible, should be zero!)
  nldl = 0  # larger fraction has larger numerator and denominator
  nsds = 0  # larger fraction has smaller numerator and denominator
  nlds = 0  # larger fraction has larger numerator and smaller denominator
  nedl = 0  # larger fraction has equal numerator and larger denominator (not possible, should be zero!)
  neds = 0  # larger fraction has equal numerator and smaller denominator
  nsde = 0  # larger fraction has smaller numerator and equal denominator (not possible, should be zero!)
  nlde = 0  # larger fraction has larger numerator and equal denominator
  nede = 0  # not possible 
  for (i in 1:nsamples) { 
    print(i)
    rA = rep(r1[i], nsamples)
    nA = rep(n1[i], nsamples)
    dA = rep(d1[i], nsamples)
    
    rB = rep(r2[i], nsamples)
    nB = rep(n2[i], nsamples)
    dB = rep(d2[i], nsamples)
    
    
    idx1 = (nA<n2 & dA>d2 & rA>r2)   
    idx2 = (nB<n1 & dB>d1 & rB>r1)
    rl_nsdl = rl_nsdl + sum(idx1) + sum(idx2)
    nsdl = nsdl + sum(nA<n2 & dA>d2) + sum(nB<n1 & dB>d1)
    
    idx1 = (nA>n2 & dA>d2 & rA>r2)
    idx2 = (nB>n1 & dB>d1 & rB>r1) 
    rl_nldl = rl_nldl + sum(idx1) + sum(idx2)
    nldl = nldl + sum(nA>n2 & dA>d2)  + sum(nB>n1 & dB>d1)
    
    idx1 = (nA<n2 & dA<d2 & rA>r2)
    idx2 = (nB<n1 & dB<d1 & rB>r1)  
    rl_nsds = rl_nsds + sum(idx1) + sum(idx2)
    nsds = nsds + sum(nA<n2 & dA<d2)  + sum(nB<n1 & dB<d1)
    
    idx1 = (nA>n2 & dA<d2 & rA>r2) 
    idx2 = (nB>n1 & dB<d1 & rB>r1)  
    rl_nlds = rl_nlds + sum(idx1) + sum(idx2)
    nlds = nlds + sum(nA>n2 & dA<d2) + sum(nB>n1 & dB<d1)
    
    idx1 = (nA==n2 & dA>d2 & rA>r2)
    idx2 = (nB==n1 & dB>d1 & rB>r1)  
    rl_nedl = rl_nedl + sum(idx1) + sum(idx2)
    nedl = nedl + sum(nA==n2 & dA>d2) + sum(nB==n1 & dB>d1)
    
    idx1 = (nA==n2 & dA<d2 & rA>r2)
    idx2 =  (nB==n1 & dB<d1 & rB>r1)  
    rl_neds = rl_neds + sum(idx1) + sum(idx2)
    neds = neds + sum(nA==n2 & dA<d2) + sum(nB==n1 & dB<d1)
    
    idx1 = (nA<n2 & dA==d2 & rA>r2)
    idx2 =  (nB<n1 & dB==d1 & rB>r1)  
    rl_nsde = rl_nsde + sum(idx1) + sum(idx2)
    nsde = nsde + sum(nA<n2 & dA==d2) + sum(nB<n1 & dB==d1)
    
    idx1 = (nA>n2 & dA==d2 & rA>r2) 
    idx2 = (nB>n1 & dB==d1 & rB>r1)  
    rl_nlde = rl_nlde + sum(idx1) + sum(idx2)
    nlde = nlde + sum(nA>n2 & dA==d2) + sum(nB>n1 & dB==d1)
    
    idx1 = (nA==n2 & dA==d2 & rA>r2) 
    idx2 =  (nB==n1 & dB==d1 & rB>r1)  
    rl_nede = rl_nede + sum(idx1) + sum(idx2)
    nede = nede + sum(nA==n2 & dA==d2) + sum(nB==n1 & dB==d1)
  
  }
  
  bp = c(rl_nsdl, rl_nldl, rl_nsds, rl_nlds, rl_nedl, rl_neds, rl_nsde, rl_nlde, rl_nede)
  np = c(nsdl, nldl, nsds, nlds, nedl, neds, nsde, nlde, nede)
  nl_rl = (bp[2]+bp[4]+bp[8])/sum(bp) #p(NL|RL)
  rl = sum(bp)/sum(np) #p(RL)
  nl = (np[2]+np[4]+np[8])/sum(np) #p(NL)
  rl_nl = (nl_rl*rl)/(nl) #posterior p(RL|NL)
  rl_nl #p(RL|NL)
  bp/sum(bp)
  bp
}


#Independent sims####
#par(mfrow=c(3,3), mai = c(0.6,0.6,0.4,0.1))
#par(mai = c(0.6,0.6,0.4,0.1))
#layout(matrix(c(1:3,10,11,4:6,12,13,7:9,14,15), 3, 5, byrow = TRUE))
nsamples = 2500
distr = 'Normal'
if (1==1) {
  n1 = rnorm(5*nsamples,300,20)
  n1 = n1[-n1<=0]  #truncate values no larger than this
  n1 = n1[1:nsamples]
  d1 = rnorm(5*nsamples,300,20) 
  d1 = d1[-d1<=0] 
  d1 = d1[1:nsamples]
  
  n2 = rnorm(5*nsamples,300,20)
  n2 = n2[-n2<=0]  #truncate values no larger than this
  n2 = n2[1:nsamples]
  d2 = rnorm(5*nsamples,300,20)
  d2 = d2[-d2<=0]
  d2 = d2[1:nsamples]
  
  r1 = n1 / d1
  r2 = n2 / d2
  
  bp = my.misc(n1,d1,n2,d2,nsamples)
  ratio = c(r1,r2)
  distrA = data.frame(c('NS_DL','NL_DL','NS_DS','NL_DS',
                        'NE_DL','NE_DS','NS_DE','NL_DE',
                        'NE_DE'), bp)
  colnames(distrA) = c('Type','Frequency')
  # my.barplot(ratio, 
  #            'Fractions', 'Fractions', 
  #            0.0, 0.975, distrA, 
  #            #sprintf('Numerator and Denominator are \n%s',distr),
  #            sprintf('%s (0,1)',distr), 'Larger fraction has ...')
}
normal = distrA

distr = 'Unif.'
if (1==1) {
  n1 = runif(nsamples,50,75)
  d1 = runif(nsamples,50,75)
  
  n2 = runif(nsamples,50,75)
  d2 = runif(nsamples,50,75)
  
  r1 = n1 / d1
  r2 = n2 / d2
  
  bp = my.misc(n1,d1,n2,d2,nsamples)
  ratio = c(r1,r2)
  distrA = data.frame(c('NS_DL','NL_DL','NS_DS','NL_DS',
                        'NE_DL','NE_DS','NS_DE','NL_DE',
                        'NE_DE'), bp)
  colnames(distrA) = c('Type','Frequency')
  # my.barplot(ratio, 
  #            'Fractions', 'Fractions', 
  #            0.0, 0.975, distrA, 
  #            #sprintf('Numerator and Denominator are \n%s',distr),
  #            sprintf('%s (50,75)(40,65)',distr), 'Larger fraction has ...')
}
unif = distrA

distr = 'LogN'
if (1==1) {
  n1 = rlnorm(nsamples,log(5),log(25))
  d1 = rlnorm(nsamples,log(10),log(50))
  
  n2 = rlnorm(nsamples,log(5),log(25))
  d2 = rlnorm(nsamples,log(10),log(50))
  
  r1 = n1 / d1
  r2 = n2 / d2
  
  bp = my.misc(n1,d1,n2,d2,nsamples)
  ratio = c(r1,r2)
  distrA = data.frame(c('NS_DL','NL_DL','NS_DS','NL_DS',
                        'NE_DL','NE_DS','NS_DE','NL_DE',
                        'NE_DE'), bp)
  colnames(distrA) = c('Type','Frequency')
  # my.barplot(ratio, 
  #            'Fractions', 'Fractions', 
  #            0.0, 0.975, distrA, 
  #            #sprintf('Numerator and Denominator are \n%s',distr),
  #            sprintf('%s (2,5)(10,50)',distr), 'Larger fraction has ...')
}
logn = distrA

distr = 'Beta'
if (1==1) {
  n1 = rbeta(nsamples,6,8)
  d1 = rbeta(nsamples,3,4)
  
  n2 = rbeta(nsamples,6,8)
  d2 = rbeta(nsamples,3,4)
  
  r1 = n1 / d1
  r2 = n2 / d2
  
  bp = my.misc(n1,d1,n2,d2,nsamples)
  ratio = c(r1,r2)
  distrA = data.frame(c('NS_DL','NL_DL','NS_DS','NL_DS',
                        'NE_DL','NE_DS','NS_DE','NL_DE',
                        'NE_DE'), bp)
  colnames(distrA) = c('Type','Frequency')
  # my.barplot(ratio, 
  #            'Fractions', 'Fractions', 
  #            0.0, 0.975, distrA, 
  #            #sprintf('Numerator and Denominator are \n%s',distr),
  #            sprintf('%s (6,8)(1,8)',distr), 'Larger fraction has ...')
}
betta = distrA

distr = 'Chi'
if (1==1) {
  n1 = rchisq(nsamples,13)
  d1 = rchisq(nsamples,44)
  
  n2 = rchisq(nsamples,13)
  d2 = rchisq(nsamples,44)
  
  r1 = n1 / d1
  r2 = n2 / d2
  
  bp = my.misc(n1,d1,n2,d2,nsamples)
  ratio = c(r1,r2)
  distrA = data.frame(c('NS_DL','NL_DL','NS_DS','NL_DS',
                        'NE_DL','NE_DS','NS_DE','NL_DE',
                        'NE_DE'), bp)
  colnames(distrA) = c('Type','Frequency')
  # my.barplot(ratio, 
  #            'Fractions', 'Fractions', 
  #            0.0, 0.975, distrA, 
  #            #sprintf('Numerator and Denominator are \n%s',distr),
  #            sprintf('%s (13)(44)',distr), 'Larger fraction has ...')
}
chi1 = distrA

distr = 'Unif.(D)'
if (1==1) {
  n1 = rdunif(nsamples,50,75)
  d1 = rdunif(nsamples,50,75)
  
  n2 = rdunif(nsamples,50,75)
  d2 = rdunif(nsamples,50,75)
  
  r1 = n1 / d1
  r2 = n2 / d2
  
  bp = my.misc(n1,d1,n2,d2,nsamples)
  ratio = c(r1,r2)
  distrA = data.frame(c('NS_DL','NL_DL','NS_DS','NL_DS',
                        'NE_DL','NE_DS','NS_DE','NL_DE',
                        'NE_DE'), bp)
  colnames(distrA) = c('Type','Frequency')
  # my.barplot(ratio, 
  #            'Fractions', 'Fractions', 
  #            0.0, 0.975, distrA, 
  #            #sprintf('Numerator and Denominator are \n%s',distr),
  #            sprintf('%s (50,75)(40,65)',distr), 'Larger fraction has ...')
}
unifD = distrA

distr = 'Poi'
if (1==1) {
  nsamplesT = 10*nsamples
  n1 = rpois(nsamplesT,20)
  n1 = n1[n1>0]
  n1 = n1[1:nsamples]
  d1 = rpois(nsamplesT,50)
  d1 = d1[d1>0]
  d1 = d1[1:nsamples]
  
  n2 = rpois(nsamplesT,20)
  n2 = n2[n2>0]
  n2 = n2[1:nsamples]
  d2 = rpois(nsamplesT,50)
  d2 = d2[d2>0]
  d2 = d2[1:nsamples]
  
  r1 = n1 / d1
  r2 = n2 / d2
  
  bp = my.misc(n1,d1,n2,d2,nsamples)
  ratio = c(r1,r2)
  distrA = data.frame(c('NS_DL','NL_DL','NS_DS','NL_DS',
                        'NE_DL','NE_DS','NS_DE','NL_DE',
                        'NE_DE'), bp)
  colnames(distrA) = c('Type','Frequency')
  # my.barplot(ratio, 
  #            'Fractions', 'Fractions', 
  #            0.0, 0.975, distrA, 
  #            #sprintf('Numerator and Denominator are \n%s',distr),
  #            sprintf('%s (44)(44)',distr), 'Larger fraction has ...')
}
poi1 = distrA

distr = 'Poi'
if (1==1) {
  nsamplesT = 10*nsamples
  n1 = rpois(nsamplesT,50)
  n1 = n1[n1>0]
  n1 = n1[1:nsamples]
  d1 = rpois(nsamplesT,20)
  d1 = d1[d1>0]
  d1 = d1[1:nsamples]
  
  n2 = rpois(nsamplesT,50)
  n2 = n2[n2>0]
  n2 = n2[1:nsamples]
  d2 = rpois(nsamplesT,20)
  d2 = d2[d2>0]
  d2 = d2[1:nsamples]
  
  r1 = n1 / d1
  r2 = n2 / d2
  
  bp = my.misc(n1,d1,n2,d2,nsamples)
  ratio = c(r1,r2)
  distrA = data.frame(c('NS_DL','NL_DL','NS_DS','NL_DS',
                        'NE_DL','NE_DS','NS_DE','NL_DE',
                        'NE_DE'), bp)
  colnames(distrA) = c('Type','Frequency')
  # my.barplot(ratio, 
  #            'Fractions', 'Fractions', 
  #            0.0, 0.975, distrA, 
  #            #sprintf('Numerator and Denominator are \n%s',distr),
  #            sprintf('%s (44)(44)',distr), 'Larger fraction has ...')
}
poi2 = distrA


distr = t(cbind(normal[,'Frequency'],
                unif[,'Frequency'],
                logn[,'Frequency'],
                betta[,'Frequency'],
                chi1[,'Frequency'],
                unifD[,'Frequency'],
                poi1[,'Frequency'],
                poi2[,'Frequency']))[,c(2:4,6,8)]
distr = distr / sum(distr[1,])

# par(mai = c(0.75,1,0.25,0.5))
par(mfrow = c(1,1), mai = c(0.75,1,0.25,0.5))
# layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
# layout(matrix(c(1,1,2,3, 4, 5), 3, 2, byrow = TRUE))
#colls = gray(0:(dim(distr)[1]-1) / (dim(distr)[1]-1))
#colls = rainbow(dim(distr)[1])
#gray(sort(runif(dim(distr)[1]-3, 0.25, 0.9)))
colls = c(c("#424242" ,  "#575757"  , "#777777" ,  "#A2A2A2" ,  "#D0D0D0"), #continuos
          rainbow(20)[c(1,3,12)]) #discrete
leggend1 = c('Normal(300,20)(300,20)', 'Unif(50,75)(50,75)',
            'LogN(5,25)(10,50)', 'Beta(6,8)(3,4)')
leggend2 = c('Chi(13)(44)', 'Unif.D (50,75)(50,75)', 'Poisson(20)(50)',
             'Poisson(50)(20)')
barplot(distr, beside = T, col = colls,
        main = 'Independent Components',
        ylim = c(0,1),
        ylab = 'Probability',
        xlab = '',#xlab2,
        names.arg = c('NLDL','NSDS','NLDS', "NEDS","NLDE"),
        cex.names = 1.25, cex.lab = 1.5, cex.axis = 1.5, cex.main = 1.5)
lines(seq(0,100, length.out = 200), rep(0.5, 200), lty = 2)
legend('topleft', leggend1,
       bty = 'n', fill = colls[1:4], cex = 0.8, y.intersp = 1.25)
legend('topright', leggend2,
       bty = 'n', fill = colls[5:8], cex = 0.8, y.intersp = 1.25)


collors = colls
leggend1 = c('Normal', 'Unif.',
             'LogN', 'Beta')
leggend2 = c('Chi', 'Unif.D', 'Poisson',
             'Poisson')
for (i in 1:dim(distr)[1]){
  b = distr[i,]
  lengths = c(b[1] + b[3] + b[5],
              b[1],
              b[2],
              b[2] + b[3] + b[4])
  if (i == 1) {
    my.radialplot( lengths, 5, 1, 'gray', 'gray', collors[i],
                   0.65, c('NL','DL','NS','DS'), 1, add = F)
  } else {
    my.radialplot( lengths, 5, 1, 'gray', 'gray', collors[i],
                   0.65, c('NL','DL','NS','DS'), 1, add = T)
  }
}
legend('topleft',c(leggend1,leggend2), bty = 'n',
       lty = 1, lwd = 2, col = collors, y.intersp = 1.2, cex = 0.8)
#title(main = 'Independent Components \n (Simulations)', cex.main = 1.5)

#Correlated sims####
#par(mfrow=c(2,3), mai = c(0.8,0.8,0.4,0.1))
#Corr and normal noise
# par(mai = c(0.9,1,0.25,0.5))
par(mfrow = c(2,2), mai = c(0.75,1,0.25,0.5))
x = seq(100,200, length.out = 1500)
y = 0.75*x + (440 + 560)/2 + rnorm(length(x), 0, 30 ) #the values divided by 2 are the range of the denominator
# y = 0.75*x + (440 + 560)/2 + rnorm(length(x), 0, 0.00000001 ) #the values divided by 2 are the range of the denominator
plot(x,y,
     #xlim = c(0,200),
     main = sprintf('r: %s',round(cor.test(x,y)$estimate,2)),
     xlab = 'Num', ylab = 'Den', bty = 'n',
     cex.lab = 1.5, cex.axis = 1.5, cex = 0.1) 
a = lm(y~x)
lines(x, predict(a), col = 'dodgerblue', lwd = 3)
A = round(cor.test(x,y)$estimate,2)
distrA = my.distr(x, y, '')
lines(seq(0,20, length.out = 100), rep(0.5, 100), lty =2)



#Corr and normal noise
x = seq(100,200, length.out = 1500)
y = 0.1*x + 50 + rnorm(length(x), 0, 0.1)
# y = -0.1*x + 50 + rnorm(length(x), 0, 0.1)
B = round(cor.test(x,y)$estimate,2)
distrB = my.distr(x, y, '')


#Corr and normal noise
x = seq(100,200, length.out = 1500)
y = 0.1*x + 0 + rnorm(length(x), 0, 0.1)
# y = -0.1*x + 0 + rnorm(length(x), 0, 0.1) 
C = round(cor.test(x,y)$estimate,2)
distrC = my.distr(x, y, '')

#Corr and normal noise
x = seq(100,200, length.out = 1500)
y = -0.75*x + (440 + 560)/2 + rnorm(length(x), 0, 30 ) 
D = round(cor.test(x,y)$estimate,2)
distrD = my.distr(x, y, '')


distrr = t(cbind(distrA[,'Frequency'],
                distrB[,'Frequency'],
                distrC[,'Frequency'],
                distrD[,'Frequency']))[,c(2:4)]
distrr = distrr / sum(distrr[1,])

colls = c('dodgerblue','dodgerblue4','purple','forestgreen')
barplot(distrr, beside = T, col = colls,
        main = 'Correlated Components',
        ylim = c(0,1),
        ylab = 'Probability',
        xlab = '',#xlab2,
        names.arg = c('NLDL','NSDS','NLDS'),
        cex.names = 1.25, cex.lab = 1.5, cex.axis = 1.5, cex.main = 1.5)
lines(seq(0,100, length.out = 200), rep(0.5, 200), lty = 2)
legend('topright', c(sprintf('r = %s', A), sprintf('r = %s', B),
                    sprintf('r = %s', C), sprintf('r = %s', D)),
       bty = 'n', fill = colls, cex = 0.8, y.intersp = 1)



# Proper fractions ######
par(mfrow=c(2,2))
nsamples =3000
d1 = runif(nsamples,1,100)
d2 = runif(nsamples,1,100)
#d1 = rlnorm(nsamples,7,1)
#d2 = rlnorm(nsamples,100,1)
#n1 = runif(nsamples,1,100)
#n2 = runif(nsamples,1,100)
s1 = 1
s2 = 1
n1 = d1*rbeta(nsamples, s1, s2) # + runif(length(n1), 300,900) #1,1 for uniform ratios
#d1 = n1*rbeta(nsamples, s1, s2) #1,1 for uniform ratios
r1 = n1/d1
n2 = d2*rbeta(nsamples, s1, s2) 
#d2 = n2*rbeta(nsamples, s1, s2)
#n2 = d2*rbeta(nsamples, s1*0.7, s2*1.33) 
r2 = n2/d2
myintegralH = function(den){#Works with uniform ratios
  (pbeta(s1/(s1+s2), s1, s2) - pbeta(den*s1/(s1+s2), s1, s2))/(pbeta(s1/(s1+s2), s1, s2))
}
myintegralL = function(den){#Works with uniform ratios
  pbeta(den*s1/(s1+s2), s1, s2)/(pbeta(s1/(s1+s2), s1, s2))
}
0.5*integrate(myintegralH, lower = 0, upper = 1)$value
0.5*integrate(myintegralL, lower = 0, upper = 1)$value


# 
# plot(n1, d1,
#      main = sprintf('r: %s',round(cor.test(n1,d1)$estimate,2)),
#      xlab = 'Num', ylab = 'Den', bty = 'n',
#      cex.lab = 1.5, cex.axis = 1.5, cex = 0.1)

plot(n2, d2,
     main = sprintf('r: %s',round(cor.test(n2,d2)$estimate,2)),
     xlab = 'Num', ylab = 'Den', bty = 'n',
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
my.barplot(ratio, 
           'Fractions', 
           'Fractions', 
           0.0, 0.975,
           distrA, 
           sprintf('Proper Fractions'),
           'Larger Fraction has ...')
S = distrA[,'Frequency']


#Cases 1: Prime numbers ####
# Case of independent numerator and denominator
sieve <- function(n){#generates primes with a sieve technique
  n <- as.integer(n)
  if (n>1e6) stop("n too large")
  primes = rep(T, n)
  primes[1] = F
  last.prime = 2L
  for (i in last.prime:floor(sqrt(n))){
    primes[seq.int(2L*last.prime, n, last.prime)]<-F
    last.prime = last.prime + min(which(primes[(last.prime+1):n]))
  }
  which(primes)
}
primes = sieve(1000000) #primes before 1 million

nsamples = 1000
n1 = primes[sample.int(length(primes),nsamples)]
d1 = primes[sample.int(length(primes),nsamples)]
r1 = n1/d1
n2 = primes[sample.int(length(primes),nsamples)]
d2 = primes[sample.int(length(primes),nsamples)]
r2 = n2/d2

par(mfrow=c(2,2))
plot(n1, d1,
     main = sprintf('r: %s',round(cor.test(n1,d1)$estimate,2)),
     xlab = 'Num', ylab = 'Den', bty = 'n',
     cex.lab = 1.5, cex.axis = 1.5, cex = 0.1)

plot(n2, d2,
     main = sprintf('r: %s',round(cor.test(n2,d2)$estimate,2)),
     xlab = 'Num', ylab = 'Den', bty = 'n',
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
my.barplot(ratio, 
           'Fractions', 
           'Fractions', 
           0.0, 0.975,
           distrA, 
           sprintf('Proper Fractions'),
           'Larger Fraction has ...')
S = distrA[,'Frequency']


#Cases 2: Fractals ####
# I think they are a case of independent ratio and denominator
# Sierpinsky triangle
p = c(0, 500, 1000)
q = c(0, 1000, 0)

#par(mar=rep(0,4))
par(mfrow = c(1,1))
plot(p, q, col = 'red', pch = 15, cex = 1, axes = F)
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

# idx = sample.int(length(shaded), nsamples, replace = T)
# n1 = area_shaded[idx]
# d1 = area_unshaded[idx]
# r1 = n1/d1
# idx = sample.int(length(shaded), nsamples, replace = T)
# n2 = area_shaded[idx]
# d2 = area_unshaded[idx]
# r2 = n2/d2


plot(n1, d1,
     main = sprintf('r: %s',round(cor.test(n1,d1)$estimate,2)),
     xlab = 'Num', ylab = 'Den', bty = 'n',
     cex.lab = 1.5, cex.axis = 1.5, cex = 0.1)

plot(n2, d2,
     main = sprintf('r: %s',round(cor.test(n2,d2)$estimate,2)),
     xlab = 'Num', ylab = 'Den', bty = 'n',
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
my.barplot(ratio, 
           'Fractions', 
           'Fractions', 
           0.0, 0.975,
           distrA, 
           sprintf('Proper Fractions'),
           'Larger Fraction has ...')
S = distrA[,'Frequency']









