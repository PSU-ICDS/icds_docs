prefsAB = read.csv("prefsAB.csv")
##View(prefsAB)
prefsAB$Subject = factor(prefsAB$Subject) # convert to nominal factor
summary(prefsAB)
plot(prefsAB$Pref)

# Pearson chi-square test
prfs = xtabs( ~ Pref, data=prefsAB)
prfs # show counts
chisq.test(prfs)

# binomial test
binom.test(prfs)

# read in a data file with 3 response categories
prefsABC = read.csv("prefsABC.csv")
##View(prefsABC)
prefsABC$Subject = factor(prefsABC$Subject) # convert to nominal factor
summary(prefsABC)
plot(prefsABC$Pref)

# Pearson chi-square test
prfs = xtabs( ~ Pref, data=prefsABC)
prfs # show counts
chisq.test(prfs)

# multinomial test
library(XNomial)
xmulti(prfs, c(1/3, 1/3, 1/3), statName="Prob")

# post hoc binomial tests with correction for multiple comparisons
aa = binom.test(sum(prefsABC$Pref == "A"), nrow(prefsABC), p=1/3)
bb = binom.test(sum(prefsABC$Pref == "B"), nrow(prefsABC), p=1/3)
cc = binom.test(sum(prefsABC$Pref == "C"), nrow(prefsABC), p=1/3)
p.adjust(c(aa$p.value, bb$p.value, cc$p.value), method="holm")


## Two-sample tests of proportions

# revisit our data file with 2 response categories, but now with sex (M/F)
prefsABsex = read.csv("prefsABsex.csv")
##View(prefsABsex)
prefsABsex$Subject = factor(prefsABsex$Subject) # convert to nominal factor
summary(prefsABsex)
plot(prefsABsex[prefsABsex$Sex == "M",]$Pref)
plot(prefsABsex[prefsABsex$Sex == "F",]$Pref)

# Pearson chi-square test
prfs = xtabs( ~ Pref + Sex, data=prefsABsex) # the '+' sign indicates two vars
##View(prfs)
chisq.test(prfs)

# G-test, asymptotic like chi-square
library(RVAideMemoire)
G.test(prfs)


