CREATE TABLE  COMMITTEE_MASTER_FILE (
    CMTE_ID              varchar(9) UNIQUE,
    CMTE_NM              varchar(200),
    TRES_NM              varchar(90),
    CMTE_ST1             varchar(34),
    CMTE_ST2             varchar(34),
    CMTE_CITY            varchar(30),
    CMTE_ST              varchar(2),
    CMTE_ZIP             varchar(9),
    CMTE_DSGN            varchar(1),
    CMTE_TP              varchar(1),
    CMTE_PTY_AFFILIATION varchar(3),
    CMTE_FILING_FREQ     varchar(1),
    ORG_TP               varchar(1),
    CONNECTED_ORG_NM     varchar(200),
    CAND_ID              varchar(9)
);


CREATE TABLE  CONTRIBUTIONS_BY_INDIVIDUALS (
    CMTE_ID          varchar(9) REFERENCES COMMITTEE_MASTER_FILE(CMTE_ID) ,
    AMNDT_IND        varchar(1),
    RPT_TP           varchar(3),
    TRANSACTION_PGI  varchar(5),
    IMAGE_NUM        varchar(18),
    TRANSACTION_TP   varchar(3),
    ENTITY_TP        varchar(3),
    NAME             varchar(200),
    CITY             varchar(30),
    STATE            varchar(2),
    ZIP_CODE         varchar(9),
    EMPLOYER         varchar(38),
    OCCUPATION       varchar(38),
    TRANSACTION_DT   varchar(8),
    TRANSACTION_AMT  money,
    OTHER_ID         varchar(9),
    TRAN_ID          varchar(32),
    FILE_NUM         varchar(22),
    MEMO_CD          varchar(1),
    MEMO_TEXT        varchar(100),
    SUB_ID           varchar(19)
);
