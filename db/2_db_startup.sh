#!/bin/sh
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
\copy CANDIDATE_MASTER_FILE FROM '/election_data/cn.txt' DELIMITER '|' CSV;
\copy COMMITTEE_MASTER_FILE FROM '/election_data/cm.txt' DELIMITER '|' CSV;
\copy CONTRIBUTIONS_BY_INDIVIDUALS FROM '/election_data/itcont.txt' DELIMITER '|' CSV;

EOSQL