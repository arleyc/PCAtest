#' PCAtest: Statistical Significance of PCA
#'
#'   PCAtest uses random permutations to build null distributions for
#'   several statistics of a PCA analysis: Psi (Vieira 2012), Phi (Gleason and
#'   Staelin 1975), the rank-of-roots (ter Braak 1988), the index of the
#'   loadings (Vieira 2012), and the correlations of the PC with the variables
#'   (Jackson 1991). Comparing these distributions with the observed values of
#'   the statistics, the function tests: (1) the hypothesis that there is more
#'   correlational structure among the observed variables than expected by
#'   random chance, (2) the statistical significance of each PC, and (3) the
#'   contribution of each observed variable to each significant PC. The
#'   function also calculates the sampling variance around mean observed
#'   statistics based on bootstrap replicates.
#'
#' @param x A matrix or dataframe with variables in the columns and the observations in the rows.
#' @param nperm Number of random permutations to build null distributions of the statistics.
#' @param nboot Number of bootstrap replicates to build 95%-confidence intervals of the observed statistics.
#' @param alpha Nominal alpha level for statistical tests.
#' @param corr A logical indicating whether to calculate the correlations of the variables with the significant PCs.
#' @param plot A logical specifying whether to plot the null distributions, observed statistics, and 95%-confidence intervals of statistics based on random permutation and bootstrap resampling.
#'
#' @details
#' PCAtest uses the function stats::prcomp to run a PCA using the arguments scale = TRUE and center = TRUE. PCAtest plots four types of graphs in a single page: (1) a histogram showing the null distribution and the observed value of the Psi statistic, (2) a histogram showing the null distribution and the observed value of the Phi statistic, (3) a bar plot of the percentage of explained variance of each PC1, PC2, ..., etc., showing the sampling variance based on bootstrap replicates and random permutations with 95%-confidence intervals, and (4) a bar plot of the index of the loadings of each observed variable for PC1, showing the sampling variance of bootstrap replicates and random permutations with 95%- confidence intervals. If more than one PC is significant, additional plots for the index of the loadings are shown in as many new pages as necessary given the number of significant PCs. If the PCA is not significant, based on the Psi and Phi testing results, only histograms (1) and (2) are shown.
#'
#' @return
#' An object of class “list” with the following elements:
#' \describe{
#'   \item{psiobs}{The observed Psi statistic.}
#'
#'   \item{phiobs}{The observed Phi statistic.}
#'
#'   \item{psi}{The null distribution of Psi values.}
#'
#'   \item{phi}{The null distribution of Phi values.}
#'
#'   \item{pervarobs}{The percentage of variance explained by each PC based on the observed data.}
#'
#'   \item{pervarboot}{The percentage of variance explained by each PC based on the bootstrapped data.}
#'
#'   \item{pervarperm}{The percentage of data explained by each PC based on the permuted data.}
#'
#'   \item{indexloadobs}{The index of the loadings of the observed data.}
#'
#'   \item{indexloadboot}{The index of the loadings of the bootstrapped data.}
#'
#'   \item{indexloadperm}{The index of the loadings of the permuted data.}
#'
#'   \item{corobs}{If corr=TRUE, the correlations of the observed variables with each significant PC.}
#'
#'   \item{corboot}{If corr=TRUE, the correlations of the observed variables with each significant PC based on the bootstrapped data.}
#'
#'   \item{corperm}{If corr=TRUE, the correlations of the observed variables with each significant PC based on permuted data.}
#'}
#'
#' @author
#' Arley Camargo
#'
#' @references
#' \itemize{
#'   \item Gleason, T. C. and Staelin R. (1975) A proposal for handling missing data. Psychometrika, 40, 229–252.
#'   \item Jackson, J. E. (1991) A User’s Guide to Principal Components. John Wiley & Sons, New York, USA.
#'   \item Ringnér, M. (2008) What is principal component analysis? Nature Biotechnology, 26, 303–304.
#'   \item ter Braak, C. F. J. (1990) Update notes: CANOCO (version 3.1). Agricultural Mattematic Group, Report LWA-88-02, Wagningen, Netherlands.
#'   \item Vieira, V. M. N. C. S. (2012) Permutation tests to estimate significances on Principal Components Analysis. Computational Ecology and Software, 2, 103–123.
#'   \item Wong, M. K. L. and Carmona, C. P. (2021) Including intraspecific trait variability to avoid distortion of functional diversity and ecological inference: Lessons from natural assemblages. Methods in Ecology and Evolution. \url{https://doi.org/10.1111/2041- 210X.13568}.
#'}
#' @export
#'
#' @examples
#'#PCA analysis of five uncorrelated variables
#'data("ex0")
#'result<-PCAtest(ex0, 100, 100, 0.05, corr=FALSE, plot=TRUE)
#'
#'#PCA analysis of five correlated (r=0.5) variables
#'data("ex05")
#'result<-PCAtest(ex05, 100, 100, 0.05, corr=FALSE, plot=TRUE)
#'
#'#PCA analysis of five correlated (r=1) variables
#'v1<-seq(0,1,0.01)
#'v5=v4=v3=v2=v1
#'ex1<-cbind(v1,v2,v3,v4,v5)
#'result<-PCAtest(ex1, 100, 100, 0.05, corr=FALSE, plot=TRUE)
#'
#'#PCA analysis of seven morphological variables from 29 ant species (from
#'#Wong and Carmona 2021, https://doi.org/10.1111/2041-210X.13568)
#'data("ants")
#'result<-PCAtest(ants, 100, 100, 0.05, corr=FALSE, plot=TRUE)

PCAtest <- function(x, nperm=1000, nboot=1000, alpha=0.05, corr=F, plot=T) {

# check dependencies

requireNamespace("stats", quietly = TRUE)
requireNamespace("grDevices", quietly = TRUE)
requireNamespace("graphics", quietly = TRUE)
requireNamespace("utils", quietly = TRUE)

# empirical eigenvalues, loadings, Psi, and Phi

pcaemp <- stats::prcomp(x, scale=T, center=T)
eigenvalues <- pcaemp$sdev^2

if (dim(x)[1] < dim(x)[2]) {
	eigenvalues <- eigenvalues[-length(eigenvalues)]
	}

eigenobs <- eigenvalues
pervarobs <- eigenvalues / sum(eigenvalues) * 100

# empirical index loadings

indexloadobs<-c()
for (i in 1:length(eigenvalues)) {
	indexloadobs <- rbind(indexloadobs, pcaemp$rotation[,i]^2 * eigenvalues[i]^2)
	}

# empirical correlations

if (corr==T) {
	corobs<-c()
	for (i in 1:length(eigenvalues)) {
		corobs <- rbind(corobs, pcaemp$rotation[,i] * sqrt(eigenvalues[i]))
	}
}

# empirical Psi

Psi<-0

for (i in 1:length(eigenvalues)) {
  Psi <-  Psi + (eigenvalues[i]-1)^2
  }

Psiobs<-Psi

# empirical Phi

Phi<-0

for (i in 1:length(eigenvalues)) {
  Phi <-  Phi + eigenvalues[i]^2
  }

Phi <- sqrt((Phi - dim(x)[2]) / (dim(x)[2] * (dim(x)[2]-1)))
Phiobs <- Phi

# bootstraped data for confidence intervals of empirical eigenvalues, index loadings, and
# correlations

pervarboot<-c()
indexloadboot<-vector("list", nboot)
corboot<-vector("list", nboot)

cat("\rSampling bootstrap replicates... Please wait\r")
#utils::flush.console()

for (i in 1:nboot) {

	pb <- txtProgressBar(min = 0, max = nboot, style = 3, width = 50, char = "=")
	#cat("\r",i, "of", nboot, "bootstrap replicates\r")
	#utils::flush.console()

	bootdata <- x[sample(nrow(x),size=dim(x)[1],replace=TRUE),]
	pcaboot <- stats::prcomp(bootdata, scale=T, center=T)
	eigenvalues <- pcaboot$sdev^2

	if (dim(x)[1] < dim(x)[2]) {
		eigenvalues <- eigenvalues[-length(eigenvalues)]
		}

	pervarboot <- rbind(pervarboot,eigenvalues / sum(eigenvalues) * 100)

	indexload<-c()
	for (j in 1:length(eigenvalues)) {
		indexload <- rbind(indexload, pcaboot$rotation[,j]^2 * eigenvalues[j]^2)
		}

	indexloadboot [[i]]<- indexload

	if (corr==T) {
		corload<-c()
		for (j in 1:length(eigenvalues)) {
			corload <- rbind(corload, pcaboot$rotation[,j] * sqrt(eigenvalues[j]))
			}

		corboot [[i]]<- corload
	}
	setTxtProgressBar(pb, i)
}

close(pb)

cat("\rCalculating confidence intervals of empirical statistics... Please wait\r")
#utils::flush.console()

confint <- apply(pervarboot,MARGIN=2,FUN=stats::quantile, probs=c(0.025,0.975)) # confidence intervals of percentage of variation

confintindboot<-c() # confidence intervals of index loadings
for (j in 1:length(eigenvalues)) {
	for (k in 1:dim(x)[2]) {
		indices<-c()
		for (i in 1:nboot) {
			indices <- c(indices, indexloadboot[[i]][j,k])
			}
		confintindboot<- rbind (confintindboot, stats::quantile (indices, probs=c(0.025,0.975)))
		}
	}

if (corr==T) {
	confintcorboot<-c() # confidence intervals of correlations
	for (j in 1:length(eigenvalues)) {
		for (k in 1:dim(x)[2]) {
			cors<-c()
			for (i in 1:nboot) {
				cors <- c(cors, corboot[[i]][j,k])
			}
			confintcorboot<- rbind (confintcorboot, stats::quantile (indices, probs=c(0.025,0.975)))
		}
	}
}

# null distributions based on randomizations of Psi, Phi, eigenvalues, percentage of variation, and index loadings

Psi<-c()
Phi<-c()
eigenrand<-c()
eigenprob<-c()
pervarperm<-c()
indexloadperm<-vector("list", nperm)
corperm<-vector("list", nperm)

cat("\rSampling random permutations... Please wait\r")

for (i in 1:nperm) {

	pb <- txtProgressBar(min = 0, max = nperm, style = 3, width = 50, char = "=")
	
	#cat("\r", i, "of", nperm, "random permutations                                                 \r")
    #utils::flush.console()

	repvalue<-0
	perm<-apply(x,MARGIN=2,FUN=sample)
	pcaperm <- stats::prcomp(perm, scale=T, center=T)
	eigenvalues <- pcaperm$sdev^2  # eigenvalues

	if (dim(x)[1] < dim(x)[2]) {
		eigenvalues <- eigenvalues[-length(eigenvalues)]
		}

	pervarperm <- rbind (pervarperm, eigenvalues / sum (eigenvalues) * 100)

	for (j in 1:length(eigenvalues)) {
		repvalue <-  repvalue + (eigenvalues[j]-1)^2
		}

	Psi[i] <- repvalue

	repvalue<-0

	for (j in 1:length(eigenvalues)) {
		repvalue <-  repvalue + eigenvalues[j]^2
		}

	Phi[i] <- sqrt((repvalue - dim(x)[2]) / (dim(x)[2]*(dim(x)[2]-1)))

	eigenrand <- rbind (eigenrand, eigenvalues)

	indexload<-c()
	for (j in 1:length(eigenvalues)) {
		indexload <- rbind(indexload, pcaperm$rotation[,j]^2 * eigenvalues[j]^2)
		}

	indexloadperm [[i]]<- indexload

	if (corr==T) {
		cor<-c()
		for (j in 1:length(eigenvalues)) {
			cor <- rbind(cor, pcaperm$rotation[,j] * sqrt(eigenvalues[j]))
		}

		corperm [[i]]<- cor
	}
	setTxtProgressBar(pb, i)
}

close(pb)

cat("\rComparing empirical statistics with their null distributions... Please wait\r")
#utils::flush.console()

confintperm <- apply (pervarperm, MARGIN=2, FUN=stats::quantile, probs=c(0.025,0.975))

confintind<-c()
meanind<-c()
for (j in 1:length(eigenvalues)) {
	for (k in 1:dim(x)[2]) {
		indices<-c()
		for (i in 1:nperm) {
			indices <- c(indices, indexloadperm[[i]][j,k])
			}
		confintind<- rbind (confintind, stats::quantile (indices, probs=c(0.025,0.975)))
		meanind<- c(meanind, mean(indices))
		}
	}

if (corr==T) {
confintcor<-c()
meancor<-c()
for (j in 1:length(eigenvalues)) {
	for (k in 1:dim(x)[2]) {
		cors<-c()
		for (i in 1:nperm) {
			cors <- c(cors, corperm[[i]][j,k])
			}
		confintcor<- rbind (confintcor, stats::quantile (cors, probs=c(0.025,0.975)))
		meancor<- c(meancor, mean(cors))
		}
	}
}

# comparing empirical Psi, Phi and eigenvalues with their null distributions to calculate p-values

Psiprob <- length (which (Psi>Psiobs)) / nperm
Phiprob <- length (which (Phi>Phiobs)) / nperm

for (k in 1:length(eigenvalues)) {
	eigenprob[k] <- length (which (eigenrand[,k] > eigenobs[k])) / nperm
	}

if (Psiprob < alpha & Phiprob < alpha) { # test PC axes if both Psi and Phi are significant

# find out which PCs are significant

	sigaxes <- 0
	for (i in 1:length(eigenprob)) {
    	if (eigenprob[i] < alpha) {
    		sigaxes <- sigaxes + 1
    		}
		}

# find out which index loadings are significant for each significant axis

	sigload <- list()

	for (j in 1:sigaxes) {
		conteo<-c()
		for (i in 1:nperm) {
			conteo <- c(conteo, which(indexloadperm[[i]][j,] > indexloadobs[j,]))
		}
		sigload [[j]]<- setdiff(c(1:dim(x)[2]), names(table(conteo)[table(conteo)/nperm > alpha]))
	}

# find out which correlations are significant for each significant axis

if (corr==T) {

	sigcor <- list()

	for (j in 1:sigaxes) {
		conteo<-c()
		for (i in 1:nperm) {
			conteo <- c(conteo, which(corperm[[i]][j,] > corobs[j,]))
		}
		sigcor [[j]]<- setdiff(c(1:dim(x)[2]), names(table(conteo)[table(conteo)/nperm > alpha]))
		}
	}
}

# screen output

cat(paste("\n", "========================================================", sep=""),
	paste("Test of PCA significance: ", dim(x)[2], " variables, ", dim(x)[1], " observations", sep=""),
	paste(nboot, " bootstrap replicates, ", nperm, " random permutations", sep=""),
	paste("========================================================", sep=""), sep="\n")

	cat(paste("\n", "Empirical Psi = ", format(round(Psiobs,4),nsmall=4), ", Max null Psi = ", format(round(max(Psi),4),nsmall=4), ", Min null Psi = ", format(round(min(Psi),4),nsmall=4), ", p-value = ", Psiprob, sep=""),
			paste("Empirical Phi = ", format(round(Phiobs,4),nsmall=4),", Max null Phi = ", format(round(max(Phi),4),nsmall=4),", Min null Phi = ", format(round(min(Phi),4),nsmall=4),", p-value = ", Phiprob, sep=""), sep="\n")

if (Psiprob >= alpha & Phiprob >= alpha) { # if both Psi and Phi are not significant
  cat(paste ("\n", "PCA is not significant!", sep=""))
  }

if (Psiprob < alpha & Phiprob < alpha) { # test PC axes if both Psi and Phi are significant

	for (i in 1:length(eigenobs)) {
		cat(paste ("\n", "Empirical eigenvalue #", i, " = ", round(eigenobs[i],5), ", Max null eigenvalue = ", round(max(eigenrand[,i]), 5), ", p-value = ", eigenprob[i], sep=""))
		}

	cat("\n")

	for (i in 1:sigaxes) {
		cat(paste ("\n", "PC ", i, " is significant and accounts for ", round(pervarobs[i], digits=1), "% (95%-CI:",round(confint[1,i],digits=1),"-",round(confint[2,i],digits=1),")"," of the total variation", sep=""))
		}

	if (sigaxes > 1) {
		cat("\n")
		cat(paste ("\n", "The first ", sigaxes, " PC axes are significant and account for ", round(sum(pervarobs[1:sigaxes]), digits=1), "% of the total variation", sep=""))
	}

	cat("\n")

	for (i in 1:sigaxes) {
		cat(paste("\n", "Variables ", paste(sigload[[i]][1:length(sigload[[i]])-1], collapse=", "), ", and ", paste(sigload[[i]][length(sigload[[i]])])," have significant loadings on PC ", i, sep=""))
	}

	if (corr==T) {
	cat("\n")

	for (i in 1:sigaxes) {
		cat(paste("\n", "Variables ", paste(sigcor[[i]][1:length(sigcor[[i]])-1], collapse=", "), ", and ", paste(sigcor[[i]][length(sigcor[[i]])])," have significant correlations with PC ", i, sep=""))
		}
	}

	cat("\n\n")
}

# plots

if (plot==T) {
graphics::par(mfrow=c(2,2), mar=c(5, 4, 1, 2) + 0.1)

# plot of empirical and randomized Psi

h <- graphics::hist(Psi,plot=FALSE)
h$density = h$counts/sum(h$counts)*100
plot(h,freq=FALSE, col="gray45", xlab="Psi", xlim=c(0, max(max(Psi), Psiobs)), ylab="Percentage of permutations", main="")
graphics::arrows(x0=Psiobs, y0=max(h$density)/10, y1=0, col="red", lwd=2, length=0.1)
graphics::legend("topright", legend=c("Null distribution","Empirical value"), fill=c("gray45","red"), bty="n", cex=0.8)

# plot of empirical and randomized Phi

h <- graphics::hist(Phi,plot=FALSE)
h$density <- h$counts/sum(h$counts)*100
plot(h,freq=FALSE, col="gray45", xlab="Phi", xlim=c(0, max(max(Phi), Phiobs)), ylab="Percentage of permutations", main="")
graphics::arrows (x0=Phiobs, y0=max(h$density)/10, y1=0, col="red", lwd=2, length=0.1)

# plot of bootstrapped and randomized percentage of variation for all PC's

if (Psiprob < alpha & Phiprob < alpha) { # test PC axes if both Psi and Phi are significant

	plot(pervarobs, ylab="Percentage of total variation", xlab="PC", bty="n", ylim=c(0, max(confint)), type="b", pch=19, lty="dashed", col="red", xaxt = "n")
  graphics::axis(1, at = 1:length(eigenobs))
	graphics::lines (apply(pervarperm,MARGIN=2,FUN=mean), type="b", pch=19, lty="dashed", col="gray45")
	suppressWarnings(graphics::arrows (x0=c(1:length(eigenvalues)), y0=confint[2,], y1=confint[1,], code=3, angle=90, length=0.05, col="red"))
	suppressWarnings(graphics::arrows (x0=c(1:length(eigenvalues)), y0=confintperm[2,], y1=confintperm[1,], code=3, angle=90, length=0.05, col="gray45"))

# plot of bootstrapped and randomized index loadings for significant PC's only

	k=1
	for (i in 1:sigaxes) {

		if (i %in% seq(2,max(2,sigaxes),4)) {	# if sigaxes is 2, 6, 10,... make another window to display more plots

			grDevices::dev.new()
			graphics::par (mfrow=c(2,2), mar=c(5, 4, 1, 2) + 0.1)
			plot (indexloadobs[i,], ylab=paste("Index loadings of PC",i), xlab="Variable", bty="n", ylim=c(0, max(confintindboot)), pch=19, col="red", xaxt = "n")
			graphics::axis(1, at = 1:dim(x)[2])
			graphics::lines (meanind[k:(k-1+dim(x)[2])], type="p", pch=19, col="gray45")
			suppressWarnings(graphics::arrows (x0=c(1:dim(x)[2]), y0=confintindboot[k:(k-1+dim(x)[2]),1], y1=confintindboot[k:(k-1+dim(x)[2]),2], code=3, angle=90, length=0.05, col="red"))
			suppressWarnings(graphics::arrows (x0=c(1:dim(x)[2]), y0=confintind[k:(k-1+dim(x)[2]),1], y1=confintind[k:(k-1+dim(x)[2]),2], code=3, angle=90, length=0.05, col="gray45"))

			} else {

			plot (indexloadobs[i,], ylab=paste("Index loadings of PC",i), xlab="Variable", bty="n", ylim=c(0, max(confintindboot)), pch=19, col="red", xaxt = "n")
			graphics::axis(1, at = 1:dim(x)[2])
			graphics::lines (meanind[k:(k-1+dim(x)[2])], type="p", pch=19, col="gray45")
			suppressWarnings(graphics::arrows (x0=c(1:dim(x)[2]), y0=confintindboot[k:(k-1+dim(x)[2]),1], y1=confintindboot[k:(k-1+dim(x)[2]),2], code=3, angle=90, length=0.05, col="red"))
			suppressWarnings(graphics::arrows (x0=c(1:dim(x)[2]), y0=confintind[k:(k-1+dim(x)[2]),1], y1=confintind[k:(k-1+dim(x)[2]),2], code=3, angle=90, length=0.05, col="gray45"))

			}
			k = k + dim(x)[2]
		}
	}
}

results <- list()

results[["Empirical Psi"]] <- Psiobs
results[["Empirical Phi"]] <- Phiobs
results[["Null Psi"]] <- Psi
results[["Null Phi"]] <- Phi

if (Psiprob < alpha & Phiprob < alpha) { # test PC axes if both Psi and Phi are significant

	results[["Percentage of variation of empirical PC's"]] <- pervarobs
	results[["Percentage of variation of bootstrapped data"]] <- pervarboot
	results[["Percentage of variation of randomized data"]] <- pervarperm

	results[["Index loadings of empirical PC's"]] <- indexloadobs
	results[["Index loadings with bootstrapped data"]] <- indexloadboot
	results[["Index loadings with randomized data"]] <- indexloadperm

	if (corr==T) {
		results[["Correlations of empirical PC's with variables"]] <- corobs
		results[["Correlations in bootstrapped data"]] <- corboot
		results[["Correlations in randomized data"]] <- corperm
	}


}

return (results)

}
