-- candidate_master_file
INSERT INTO fec.candidate_master_file 
SELECT * 
FROM   error.candidate_master_file; 

DELETE FROM error.candidate_master_file;

-- committee_master_file
INSERT INTO fec.committee_master_file 
(SELECT ecm.* 
 FROM   error.committee_master_file ecm 
        inner join fec.candidate_master_file fcn 
                ON ecm.cand_id = fcn.cand_id 
 UNION 
 SELECT ecm.* 
 FROM   error.committee_master_file ecm 
 WHERE  cand_id IS NULL); 

DELETE FROM error.committee_master_file where cand_id is null;

DELETE FROM error.committee_master_file ecm 
USING  fec.candidate_master_file fcn 
WHERE  ecm.cand_id = fcn.cand_id; 

ALTER TABLE error.committee_master_file
ADD COLUMN ERROR_DESC varchar(50);

UPDATE error.committee_master_file set ERROR_DESC= 'Invalid CAND_ID';

-- candidate_to_committee_linkage
INSERT INTO fec.candidate_to_committee_linkage 
SELECT ecl.* 
FROM   error.candidate_to_committee_linkage ecl 
       INNER JOIN fec.candidate_master_file fcn 
               ON ecl.cand_id = fcn.cand_id; 

DELETE FROM error.candidate_to_committee_linkage ecl 
USING  fec.candidate_master_file fcn 
WHERE  ecl.cand_id = fcn.cand_id; 

ALTER TABLE error.candidate_to_committee_linkage
ADD COLUMN ERROR_DESC varchar(50);

UPDATE error.candidate_to_committee_linkage set ERROR_DESC= 'Invalid CAND_ID';

-- operating_expenditures
INSERT INTO fec.operating_expenditures 
SELECT e.cmte_id, 
       amndt_ind, 
       rpt_yr, 
       rpt_tp, 
       image_num, 
       line_num, 
       form_tp_cd, 
       sched_tp_cd, 
       NAME, 
       city, 
       state, 
       zip_code, 
       To_date(transaction_dt, 'MM/DD/YYYY') AS TRANSACTION_DT, 
       transaction_amt, 
       transaction_pgi, 
       purpose, 
       category, 
       category_desc, 
       memo_cd, 
       memo_text, 
       entity_tp, 
       sub_id, 
       file_num, 
       tran_id, 
       back_ref_tran_id, 
       unknown 
FROM   error.operating_expenditures e 
       INNER JOIN fec.committee_master_file cm 
               ON e.cmte_id = cm.cmte_id;

DELETE FROM error.operating_expenditures eo
USING  fec.committee_master_file cm 
WHERE  eo.cmte_id = cm.cmte_id; 

ALTER TABLE error.operating_expenditures
ADD COLUMN ERROR_DESC varchar(50);

UPDATE error.operating_expenditures set ERROR_DESC= 'Invalid CMTE_ID';

-- contributions_to_committees_from_committees
INSERT INTO fec.contributions_to_committees_from_committees 
SELECT e.cmte_id, 
       amndt_ind, 
       rpt_tp, 
       transaction_pgi, 
       image_num, 
       transaction_tp, 
       entity_tp, 
       NAME, 
       city, 
       state, 
       zip_code, 
       employer, 
       occupation, 
       To_date(transaction_dt, 'MMDDYYYY') AS TRANSACTION_DT, 
       transaction_amt, 
       other_id, 
       tran_id, 
       file_num, 
       memo_cd, 
       memo_text, 
       sub_id 
FROM   error.contributions_to_committees_from_committees e 
       INNER JOIN fec.committee_master_file cm 
               ON e.cmte_id = cm.cmte_id;

DELETE FROM error.contributions_to_committees_from_committees e
USING  fec.committee_master_file cm 
WHERE  e.cmte_id = cm.cmte_id; 

ALTER TABLE error.contributions_to_committees_from_committees
ADD COLUMN ERROR_DESC varchar(50);

UPDATE error.contributions_to_committees_from_committees set ERROR_DESC= 'Invalid CMTE_ID';

--CONTRIBUTIONS_BY_INDIVIDUALS
INSERT INTO fec.contributions_by_individuals 
SELECT i.cmte_id, 
       amndt_ind, 
       rpt_tp, 
       transaction_pgi, 
       image_num, 
       transaction_tp, 
       entity_tp, 
       NAME, 
       city, 
       state, 
       zip_code, 
       employer, 
       occupation, 
       To_date(transaction_dt, 'MMDDYYYY') AS transaction_dt, 
       transaction_amt, 
       other_id, 
       tran_id, 
       file_num, 
       memo_cd, 
       memo_text, 
       sub_id 
FROM   error.contributions_by_individuals i 
       INNER JOIN fec.committee_master_file cm 
               ON i.cmte_id = cm.cmte_id 
WHERE  Length(transaction_dt) = 8 
       AND To_date(transaction_dt, 'MMDDYYYY') < To_date('20170101', 'YYYYMMDD');

DELETE FROM error.contributions_by_individuals e 
USING  fec.committee_master_file cm 
WHERE  e.cmte_id = cm.cmte_id 
       AND Length(transaction_dt) = 8 
       AND To_date(transaction_dt, 'MMDDYYYY') < To_date('20170101', 'YYYYMMDD');

ALTER TABLE error.contributions_by_individuals
ADD COLUMN ERROR_DESC varchar(50);

UPDATE error.contributions_by_individuals set ERROR_DESC= 'Null, invalid, future dated dates, or invalid fk id';

--update stats now that we are done messing with the data.
ANALYZE;