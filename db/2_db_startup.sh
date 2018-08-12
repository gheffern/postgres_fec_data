#!/bin/sh
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
\copy CANDIDATE_MASTER_FILE FROM '/election_data/cn.txt' DELIMITER '|' CSV;
\copy COMMITTEE_MASTER_FILE FROM '/election_data/cm.txt' DELIMITER '|' CSV;
\copy CANDIDATE_TO_COMMITTEE_LINKAGE FROM '/election_data/ccl.txt' DELIMITER '|' CSV;
\copy CONTRIBUTIONS_TO_COMMITTEES_FROM_COMMITTEES FROM '/election_data/itoth.txt' DELIMITER '|' CSV;
\copy OPERATING_EXPENDITURES FROM '/election_data/oppexp.txt' DELIMITER '|' CSV;
\copy CONTRIBUTIONS_BY_INDIVIDUALS FROM '/election_data/itcont.txt' DELIMITER '|' CSV;

EOSQL

rm /election_data/*