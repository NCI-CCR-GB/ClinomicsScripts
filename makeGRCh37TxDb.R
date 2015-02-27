# Script to create a GRCh37 TxDb object from biomaRt archive mart
# Usage: 
#    Rscript makeGRCh37TxDb.R
# 
# Output: Will generate a TxDb package
#

require(GenomicFeatures)

makeTxDbPackageFromBiomart = function (version, maintainer, author, destDir = ".", license = "Artistic-2.0", 
          biomart = "ensembl", dataset = "hsapiens_gene_ensembl", transcript_ids = NULL, 
          host='www.biomart.org', port=80, circ_seqs = DEFAULT_CIRC_SEQS, miRBaseBuild = NA) {
  if (missing(version) || !isSingleString(version)) {
    stop("'version' must be supplied as a single element", 
         " character vector.")
  }
  if (missing(maintainer) || !isSingleString(maintainer)) {
    stop("'maintainer' must be supplied as a single element", 
         " character vector.")
  }
  if (missing(author) || !isSingleString(author)) {
    stop("'author' must be supplied as a single element", 
         " character vector.")
  }
  if (!isSingleString(destDir)) {
    stop("'destDir' must be supplied as a single element", 
         " character vector.")
  }
  if (!isSingleString(license)) {
    stop("'license' must be supplied as a single element", 
         " character vector.")
  }
  if (!isSingleString(biomart)) {
    stop("'biomart' must be supplied as a single element", 
         " character vector.")
  }
  if (!isSingleString(dataset)) {
    stop("'dataset' must be supplied as a single element", 
         " character vector.")
  }
  if (!is.character(circ_seqs) || length(circ_seqs) < 1) {
    stop("'circ_seqs' must be supplied as a named character vector.")
  }
  if (!isSingleStringOrNA(miRBaseBuild)) {
    stop("'miRBaseBuild' must be supplied as a single element", 
         " character vector or be NA.")
  }
  txdb <- makeTxDbFromBiomart(biomart = biomart, dataset = dataset, 
                              transcript_ids = transcript_ids, circ_seqs = circ_seqs, 
                              miRBaseBuild = miRBaseBuild, host=host, port=port)
  makeTxDbPackage(txdb, version = version, maintainer = maintainer, 
                  author = author, destDir = destDir, license = license)
}

makeTxDbPackageFromBiomart(version='GRCh37_75',
                           maintainer='Sean Davis <seandavi@gmail.com>',
                           author='Sean Davis',
                           biomart='ENSEMBL_MART_ENSEMBL',host='grch37.ensembl.org',
                           dataset='hsapiens_gene_ensembl')