CREATE SCHEMA ERROR;

CREATE TABLE ERROR.CANDIDATE_MASTER_FILE (
    CAND_ID              varchar(9) PRIMARY KEY,
    CAND_NAME            varchar(200),
    CAND_PTY_AFFILIATION varchar(3),
    CAND_ELECTION_YR     smallint,
    CAND_OFFICE_ST       varchar(2),
    CAND_OFFICE          varchar(1),
    CAND_OFFICE_DISTRICT varchar(2),
    CAND_ICI             varchar(1),
    CAND_STATUS          varchar(1),
    CAND_PCC             varchar(9),
    CAND_ST1             varchar(34),
    CAND_ST2             varchar(34),
    CAND_CITY            varchar(30),
    CAND_ST              varchar(2),
    CAND_ZIP             varchar(9) 
);

CREATE TABLE ERROR.COMMITTEE_MASTER_FILE (
    CMTE_ID              varchar(9) PRIMARY KEY,
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

CREATE TABLE ERROR.CONTRIBUTIONS_TO_COMMITTEES_FROM_COMMITTEES (
    CMTE_ID            varchar(9),
    AMNDT_IND          varchar(1),
    RPT_TP             varchar (3),
    TRANSACTION_PGI    varchar (5),
    IMAGE_NUM          varchar (18),
    TRANSACTION_TP     varchar (3),
    ENTITY_TP          varchar (3),
    NAME               varchar (200),
    CITY               varchar (30),
    STATE              varchar (2),
    ZIP_CODE           varchar (9),
    EMPLOYER           varchar (38),
    OCCUPATION         varchar (38),
    TRANSACTION_DT     varchar (8),
    TRANSACTION_AMT    money,
    OTHER_ID           varchar (9),
    TRAN_ID            varchar (32),
    FILE_NUM           varchar (22),
    MEMO_CD            varchar (1),
    MEMO_TEXT          varchar (100),
    SUB_ID             varchar(19) PRIMARY KEY
);

CREATE TABLE ERROR.OPERATING_EXPENDITURES (
    CMTE_ID          varchar(9),
    AMNDT_IND        varchar(1),
    RPT_YR           smallint,
    RPT_TP           varchar(3),
    IMAGE_NUM        varchar(18),
    LINE_NUM         varchar(3),
    FORM_TP_CD       varchar (8),
    SCHED_TP_CD      varchar (8),
    NAME             varchar (200),
    CITY             varchar (30),
    STATE            varchar (2),
    ZIP_CODE         varchar (9),
    TRANSACTION_DT   varchar (10),
    TRANSACTION_AMT  money,
    TRANSACTION_PGI  varchar (5),
    PURPOSE          varchar (100),
    CATEGORY         varchar(3),
    CATEGORY_DESC    varchar(40),
    MEMO_CD          varchar(1),
    MEMO_TEXT        varchar(100),
    ENTITY_TP        varchar(3),
    SUB_ID           varchar(19) PRIMARY KEY,
    FILE_NUM         integer,
    TRAN_ID          varchar(32),
    BACK_REF_TRAN_ID varchar(32),
    UNKNOWN          varchar(9)
);

CREATE TABLE ERROR.CANDIDATE_TO_COMMITTEE_LINKAGE (
    CAND_ID           varchar(9),
    CAND_ELECTION_YR  smallint,
    FEC_ELECTION_YR   smallint,
    CMTE_ID           varchar(9),
    CMTE_TP           varchar(1),
    CMTE_DSGN         varchar(1),
    LINKAGE_ID        int  PRIMARY KEY
);

CREATE TABLE ERROR.CONTRIBUTIONS_BY_INDIVIDUALS (
    CMTE_ID          varchar(9) ,
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
    SUB_ID           varchar(19) PRIMARY KEY
);
