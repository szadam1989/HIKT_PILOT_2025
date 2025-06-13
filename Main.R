library("openxlsx")
library("ROracle")
library("stringr")
library("lubridate")
library("dplyr")
source("Functions.R")

ALAP <- read.csv(paste0(getwd(), "/CSV/MTM_ALAP_export.csv"), header = TRUE, sep = ";", colClasses = "character")
dim(ALAP) # 762 sor és 42 oszlop

ADAT <- read.csv(paste0(getwd(), "/CSV/MTM_ADAT_export.csv"), header = TRUE, sep = ";", colClasses = "character")
dim(ADAT) # 765 sor és 423 oszlop

HTTAG <- read.csv(paste0(getwd(), "/CSV/MTM_HTTAG_export.csv"), header = TRUE, sep = ";", colClasses = "character")
dim(HTTAG) # 762 sor és 160 oszlop

NYEREMENY <- read.csv(paste0(getwd(), "/CSV/MTM_NYEREMENY_export.csv"), header = TRUE, sep = ";", colClasses = "character")
dim(NYEREMENY) # 557 sor és 5 oszlop

LAKOS <- read.xlsx(paste0(getwd(), "/Excel/KAPCSOLAS_PERSID_LAKOS.xlsx"), sheet = "azon")
dim(LAKOS) # 13237 sor és 2 oszlop
LAKOS$PERSID <- as.character(LAKOS$PERSID)

ALAP$MHO <- str_pad(ALAP$MHO, 2, pad = "0")
ADAT$MHO <- str_pad(ADAT$MHO, 2, pad = "0")
HTTAG$MHO <- str_pad(HTTAG$MHO, 2, pad = "0")

ALAP$MC01 <- "2003"
ADAT$MC01 <- "2003"
HTTAG$MC01 <- "2003"
ALAP$MODOZAT <- "Pilot"
ADAT$MODOZAT <- "Pilot"
HTTAG$MODOZAT <- "Pilot"

ALAP$MDD14 <- "1"
ADAT$MDD14 <- "1"
HTTAG$MDD14 <- "1"

ADAT$MDD21 <- "1"
HTTAG$MDD21 <- "1"

ALAP$VEGLEGESITES <- gsub("\\.", "-", ALAP$VEGLEGESITES)
ALAP$EXP_DATE <- gsub("\\.", "-", ALAP$EXP_DATE)
ADAT$EXP_DATE <- gsub("\\.", "-", ADAT$EXP_DATE)
HTTAG$EXP_DATE <- gsub("\\.", "-", HTTAG$EXP_DATE)
ALAP$START_K <- gsub("\\.", "-", ALAP$START_K)
ALAP$STOP_K <- gsub("\\.", "-", ALAP$STOP_K)

ALAP$EXP_DATE <- as.Date(ALAP$EXP_DATE)
ADAT$EXP_DATE <- as.Date(ADAT$EXP_DATE)
HTTAG$EXP_DATE <- as.Date(HTTAG$EXP_DATE)
ALAP$START_K <- ymd_hm(ALAP$START_K)
ALAP$STOP_K <- ymd_hm(ALAP$STOP_K)
ALAP$START_K <- as.character(ALAP$START_K)
ALAP$STOP_K <- as.character(ALAP$STOP_K)


HTTAG$DFAA100_2 <- gsub("\\.", "-", HTTAG$DFAA100_2)
HTTAG$DFAA100_3 <- gsub("\\.", "-", HTTAG$DFAA100_3)
HTTAG$DFAA100_4 <- gsub("\\.", "-", HTTAG$DFAA100_4)
HTTAG$DFAA100_5 <- gsub("\\.", "-", HTTAG$DFAA100_5)
HTTAG$DFAA100_6 <- gsub("\\.", "-", HTTAG$DFAA100_6)
HTTAG$DFAA100_7 <- gsub("\\.", "-", HTTAG$DFAA100_7)
HTTAG$DFAA100_8 <- gsub("\\.", "-", HTTAG$DFAA100_8)
HTTAG$DFAA100_9 <- gsub("\\.", "-", HTTAG$DFAA100_9)
HTTAG$DFAA100_10 <- gsub("\\.", "-", HTTAG$DFAA100_10)
HTTAG$DFAA100_11 <- gsub("\\.", "-", HTTAG$DFAA100_11)
HTTAG$DFAA100_12 <- gsub("\\.", "-", HTTAG$DFAA100_12)
HTTAG$DFAA100_13 <- gsub("\\.", "-", HTTAG$DFAA100_13)
HTTAG$DFAA100_14 <- gsub("\\.", "-", HTTAG$DFAA100_14)
HTTAG$DFAA100_15 <- gsub("\\.", "-", HTTAG$DFAA100_15)
HTTAG$DFAA100_16 <- gsub("\\.", "-", HTTAG$DFAA100_16)
HTTAG$DFAA100_17 <- gsub("\\.", "-", HTTAG$DFAA100_17)
HTTAG$DFAA100_18 <- gsub("\\.", "-", HTTAG$DFAA100_18)
HTTAG$DFAA100_19 <- gsub("\\.", "-", HTTAG$DFAA100_19)
HTTAG$DFAA100_20 <- gsub("\\.", "-", HTTAG$DFAA100_20)
HTTAG$DFAA100_21 <- gsub("\\.", "-", HTTAG$DFAA100_21)
HTTAG$DFAA100_22 <- gsub("\\.", "-", HTTAG$DFAA100_22)
HTTAG$DFAA100_23 <- gsub("\\.", "-", HTTAG$DFAA100_23)
HTTAG$DFAA100_24 <- gsub("\\.", "-", HTTAG$DFAA100_24)
HTTAG$DFAA100_25 <- gsub("\\.", "-", HTTAG$DFAA100_25)
HTTAG$DFAA100_26 <- gsub("\\.", "-", HTTAG$DFAA100_26)
HTTAG$DFAA100_27 <- gsub("\\.", "-", HTTAG$DFAA100_27)
HTTAG$DFAA100_28 <- gsub("\\.", "-", HTTAG$DFAA100_28)
HTTAG$DFAA100_29 <- gsub("\\.", "-", HTTAG$DFAA100_29)
HTTAG$DFAA100_30 <- gsub("\\.", "-", HTTAG$DFAA100_30)

ALAP <- cbind(ALAP, ALAP %>% left_join(LAKOS, by = c("SORSZAM" = "PERSID")) %>% select("LAKOSAZON"))
ADAT <- cbind(ADAT, ADAT %>% left_join(LAKOS, by = c("SORSZAM" = "PERSID")) %>% select("LAKOSAZON"))
HTTAG <- cbind(HTTAG, HTTAG %>% left_join(LAKOS, by = c("SORSZAM" = "PERSID")) %>% select("LAKOSAZON"))

ALAP$MDD20 <- ALAP$LAKOSAZON
ALAP <- ALAP[, !(colnames(ALAP) %in% c("LAKOSAZON"))]

ADAT$MDD20 <- ADAT$LAKOSAZON
ADAT <- ADAT[, !(colnames(ADAT) %in% c("LAKOSAZON"))]

HTTAG$MDD20 <- HTTAG$LAKOSAZON
HTTAG <- HTTAG[, !(colnames(HTTAG) %in% c("LAKOSAZON"))]
                                                                          
str(ALAP)
str(ADAT)
str(HTTAG)

Sys.setenv(TZ = "CET")
Sys.setenv(ORA_SDTZ = "CET")

drv <- Oracle()
con <- dbConnect(drv, username = Sys.getenv("userid"), password = Sys.getenv("pwd"), dbname = "emerald.ksh.hu")

# columns_list(ALAP, ncol(ALAP))
# 
# rs <- dbSendQuery(con, paste0("insert into YS_DF.YS_2003_ALAP_PILOT_V25_V00_01(", columns, ") values (", values, ")"), data = ALAP)
# dbCommit(con)
# dbClearResult(rs)


# columns_list(ADAT, ncol(ADAT))
# 
# rs <- dbSendQuery(con, paste0("insert into YS_DF.YS_2003_ADAT_PILOT_V25_V00_01(", columns, ") values (", values, ")"), data = ADAT)
# dbCommit(con)
# dbClearResult(rs)

# columns_list(HTTAG, ncol(HTTAG))
# 
# rs <- dbSendQuery(con, paste0("insert into YS_DF.YS_2003_HTTAG_PILOT_V25_V00_01(", columns, ") values (", values, ")"), data = HTTAG)
# dbCommit(con)
# dbClearResult(rs)

dbDisconnect(con)