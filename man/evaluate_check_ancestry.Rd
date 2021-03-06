% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/individualQC.R
\name{evaluate_check_ancestry}
\alias{evaluate_check_ancestry}
\title{Evaluate results from PLINK PCA on combined study and reference data}
\usage{
evaluate_check_ancestry(
  indir,
  name,
  prefixMergedDataset,
  qcdir = indir,
  europeanTh = 1.5,
  refSamples = NULL,
  refColors = NULL,
  refSamplesFile = NULL,
  refColorsFile = NULL,
  refSamplesIID = "IID",
  refSamplesPop = "Pop",
  refColorsColor = "Color",
  refColorsPop = "Pop",
  studyColor = "#2c7bb6",
  refPopulation = c("CEU", "TSI"),
  legend_labels_per_row = 6,
  interactive = FALSE
)
}
\arguments{
\item{indir}{[character] /path/to/directory containing the basic PLINK data
files name.bim, name.bed, name.fam files.}

\item{name}{[character] Prefix of PLINK files, i.e. name.bed, name.bim,
name.fam.}

\item{prefixMergedDataset}{[character] Prefix of merged dataset (study and
reference samples) used in plink --pca, resulting in
prefixMergedDataset.eigenvec.}

\item{qcdir}{[character] /path/to/directory/with/QC/results containing
prefixMergedDataset.eigenvec results as returned by plink --pca. Per default
qcdir=indir.}

\item{europeanTh}{[double] Scaling factor of radius to be drawn around center
of European reference samples, with study samples inside this radius
considered to be of European descent and samples outside this radius of
non-European descent. The radius is computed as the maximum Euclidean distance
of European reference samples to the centre of European reference samples.}

\item{refSamples}{[data.frame] Dataframe with sample identifiers
[refSamplesIID] corresponding to IIDs in prefixMergedDataset.eigenvec and
population identifier [refSamplesPop] corresponding to population IDs
[refColorsPop] in refColorsfile/refColors. Either refSamples or
refSamplesFile have to be specified.}

\item{refColors}{[data.frame, optional] Dataframe with population IDs in
column [refColorsPop] and corresponding colour-code for PCA plot in column
[refColorsColor]. If not provided and is.null(refColorsFile) default colors
are used.}

\item{refSamplesFile}{[character] /path/to/File/with/reference samples. Needs
columns with sample identifiers [refSamplesIID] corresponding to IIDs in
prefixMergedDataset.eigenvec and population identifier [refSamplesPop]
corresponding to population IDs [refColorsPop] in refColorsfile/refColors. If
both refSamplesFile and refSamples are not NULL, refSamplesFile information
is used.}

\item{refColorsFile}{[character, optional]
/path/to/File/with/Population/Colors containing population IDs in column
[refColorsPop] and corresponding colour-code for PCA plot in column
[refColorsColor].If not provided and is.null(refColors) default colors for
are used. If both refColorsFile and refColors are not NULL, refColorsFile
information is used.}

\item{refSamplesIID}{[character] Column name of reference sample IDs in
refSamples/refSamplesFile.}

\item{refSamplesPop}{[character] Column name of reference sample population
IDs in refSamples/refSamplesFile.}

\item{refColorsColor}{[character] Column name of population colors in
refColors/refColorsFile}

\item{refColorsPop}{[character] Column name of reference sample population
IDs in refColors/refColorsFile.}

\item{studyColor}{[character] Colour to be used for study population if plot
is TRUE.}

\item{refPopulation}{[vector] Vector with population identifiers of European
reference population. Identifiers have to be corresponding to population IDs
[refColorsPop] in refColorsfile/refColors.}

\item{legend_labels_per_row}{[integer] Number of population names per row in PCA plot.}

\item{interactive}{[logical] Should plots be shown interactively? When
choosing this option, make sure you have X-forwarding/graphical interface
available for interactive plotting. Alternatively, set interactive=FALSE and
save the returned plot object (p_ancestry) via ggplot2::ggsave(p=p_ancestry,
other_arguments) or pdf(outfile) print(p_ancestry) dev.off().}
}
\value{
Named [list] with i) fail_ancestry, containing a [data.frame] with
FID and IID of non-European individuals and ii) p_ancestry, a ggplot2-object
'containing' a scatter plot of PC1 versus PC2 colour-coded for samples of the
reference populations and the study population, which can be shown by
print(p_ancestry).
}
\description{
Evaluates and depicts results of plink --pca (via
\code{\link{run_check_ancestry}} or externally conducted pca) on merged
genotypes from individuals to be QCed and individuals of reference population
of known genotypes. Currently, check ancestry only supports automatic
selection of individuals of European descent. It uses information from
principal components 1 and 2 returned by plink --pca to find the center of
the European reference samples (mean(PC1_europeanRef), mean(PC2_europeanRef).
It computes the maximum Euclidean distance (maxDist) of the European
reference samples from this centre. All study samples whose Euclidean
distance from the centre falls outside the circle described by the radius
r=europeanTh* maxDist are considered non-European and their IDs are returned
as failing the ancestry check.
check_ancestry creates a scatter plot of PC1 versus PC2 colour-coded for
samples of the reference populations and the study population.
}
\details{
Both \code{\link{run_check_ancestry}} and
\code{\link{evaluate_check_ancestry}} can simply be invoked by
\code{\link{check_ancestry}}.
}
\examples{
\dontrun{
qcdir <- system.file("extdata", package="plinkQC")
name <- "data"
fail_ancestry <- evaluate_check_ancestry(indir=qcdir, name=name,
refSamplesFile=paste(qcdir, "/HapMap_ID2Pop.txt",sep=""),
refColorsFile=paste(qcdir, "/HapMap_PopColors.txt", sep=""),
prefixMergedDataset="data.HapMapIII", interactive=FALSE)
}
}
