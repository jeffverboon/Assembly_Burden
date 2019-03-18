require(biomaRt)
require(dplyr)
require(gtools)

toolssetwd("/broad/sankaranlab/DBA_cohort_analysis/12_assembly")

ensembl_75 = useMart(biomart="ENSEMBL_MART_ENSEMBL", host="feb2014.archive.ensembl.org", path="/biomart/martservice", dataset="hsapiens_gene_ensembl")
uniparc <- read.table(
  file = "./resources/uniparc.txt",
  header = F
)

info <- getBM(
  attributes = c("uniparc", "hgnc_symbol", "ensembl_gene_id"),
  filters = "uniparc",
  values = uniparc[,1],
  mart = ensembl_75
)

bed <- getBM(
  attributes = c("chromosome_name", "start_position", "end_position", "hgnc_symbol"),
  filters = "uniparc",
  values = uniparc[,1],
  mart = ensembl_75
) %>%
  filter(!grepl("H", chromosome_name)) %>%
  arrange(start_position) 

bed <- bed[mixedorder(bed$chromosome_name),]

write.table(info, "./resources/id.txt", col.names = F, row.names = F, quote = F, sep = "\t")
write.table(bed, "./resources/rib_assem.bed", col.names = F, row.names = F, quote = F, sep = "\t")

