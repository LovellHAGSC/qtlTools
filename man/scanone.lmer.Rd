% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scanone.lmer.R
\name{scanone.lmer}
\alias{scanone.lmer}
\title{Conduct mixed effect QTL mapping.}
\usage{
scanone.lmer(cross, base.formula, test.formula, ...)
}
\arguments{
\item{cross}{A cross object}

\item{base.formula}{The formula of a model that serves as the baseline. Must
contain at least one random effect per lmer's functionality. All terms in the
formula must be contained in the `cross` phenotype matrix slot.}

\item{test.formula}{The formula containing an additional fixed effect to test.
The word "QTL" must be contained here, and may also occur in the base.formula.
This term is a placeholder and is replaced by the genotypes at each postion in the
conditional probability matrix when lmer is called.}

\item{...}{Additional arguments to pass on to lmer.}
}
\value{
An object of class scanone
}
\description{
\code{scanone.lmer} Use lmer linear mixed effect models
as the engine for scanone
}
\details{
This function is still under development and is too
slow for permutations as it stands now. An overly conservative approach is to
adjust the p-values. However, since each marker is not independent, this results in a
severe reduction in power.
}
\examples{
\dontrun{
data(fake.f2)
cross<-fake.f2
cross<-subset(cross, ind = c(1:nind(cross),1:nind(cross)))
cross$pheno<-data.frame(cross$pheno, block = rep(1:(nind(cross)/2),2))
cross$pheno<-data.frame(cross$pheno, pheno2 = jitter(cross$pheno$phenotype))
sex<-data.frame(sex = pull.pheno(cross, pheno.col = "sex"))
cross = calc.genoprob(cross)

base.formula = "pheno2 ~ sex + (1|block)"
qtl.formula = "pheno2 ~ sex + QTL + sex*QTL + (1|block)"

s1<-scanone.lmer(cross, base.formula = base.formula, test.formula = qtl.formula)
par(mfrow = c(2,1))
plot(s1, main = "linear mixed effect model")
plot(scanone(cross, pheno.col = "pheno2", intcovar = sex), col = "grey", main = "scanone")
}
}
