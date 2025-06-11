library("ROracle")
library("stringr")
library("lubridate")
source("Functions.R")

ALAP <- read.csv(paste0(getwd(), "/CSV/MTM_ALAP_export.csv"), header = TRUE, sep = ";", colClasses = "character")
dim(ALAP) # 762 sor és 42 oszlop

ADAT <- read.csv(paste0(getwd(), "/CSV/MTM_ADAT_export.csv"), header = TRUE, sep = ";", colClasses = "character")
dim(ADAT) # 765 sor és 423 oszlop

HTTAG <- read.csv(paste0(getwd(), "/CSV/MTM_HTTAG_export.csv"), header = TRUE, sep = ";", colClasses = "character")
dim(HTTAG) # 762 sor és 160 oszlop

NYEREMENY <- read.csv(paste0(getwd(), "/CSV/MTM_NYEREMENY_export.csv"), header = TRUE, sep = ";", colClasses = "character")
dim(NYEREMENY) # 557 sor és 5 oszlop

ALAP$MHO <- str_pad(ALAP$MHO, 2, pad = "0")
ADAT$MHO <- str_pad(ADAT$MHO, 2, pad = "0")
HTTAG$MHO <- str_pad(HTTAG$MHO, 2, pad = "0")

ALAP$MC01 <- "2003"
ADAT$MC01 <- "2003"
HTTAG$MC01 <- "2003"
ALAP$MODOZAT <- "Pilot"
ADAT$MODOZAT <- "Pilot"
HTTAG$MODOZAT <- "Pilot"

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

# columns_list(ADAT, ncol(ADAT))
# 
# rs <- dbSendQuery(con, paste0("insert into YS_DF.YS_2003_ADAT_PILOT_V25_V00_01(", columns, ") values (", values, ")"), data = ADAT)
# dbCommit(con)

# columns_list(HTTAG, ncol(HTTAG))
# 
# rs <- dbSendQuery(con, paste0("insert into YS_DF.YS_2003_HTTAG_PILOT_V25_V00_01(", columns, ") values (", values, ")"), data = HTTAG)
# dbCommit(con)

dbDisconnect(con)
HTTAG[, "DFAA068"]
unique(HTTAG$UUID)
HTTAG[, "DFAA014"]
HTTAG[, "DFAA027"]
HTTAG[, "DFAA026"]
