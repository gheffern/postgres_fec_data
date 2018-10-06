FROM postgres:10.4-alpine
# add curl and unzip to help get fec data
# add vim and vimdiff for when interactively shelled into the container
# had to add sed here due to issue with busy box version of sed not wanting to replace hex values. E.G. 'sed -i -e "s/\xA0//g" oppexp.txt'
RUN apk add --update curl unzip vim vimdiff sed
RUN mkdir election_data
WORKDIR election_data
# Download URL taken from https://classic.fec.gov/finance/disclosure/ftpdet.shtml#a2015_2016
ENV FEC_DOWNLOAD_URL="https://cg-519a459a-0ea3-42c2-b7bc-fa1143481f74.s3-us-gov-west-1.amazonaws.com/bulk-downloads/"
RUN curl -O ${FEC_DOWNLOAD_URL}2016/cm16.zip && \
    curl -O ${FEC_DOWNLOAD_URL}2016/cn16.zip && \
    curl -O ${FEC_DOWNLOAD_URL}2016/ccl16.zip && \
    curl -O ${FEC_DOWNLOAD_URL}2016/oth16.zip && \
    curl -O ${FEC_DOWNLOAD_URL}2016/pas216.zip && \
    curl -O ${FEC_DOWNLOAD_URL}2016/indiv16.zip && \
    curl -O ${FEC_DOWNLOAD_URL}2016/oppexp16.zip && \
    unzip \*.zip && \
    rm *zip && \
    rm -r by_date/ && \
    # Some ugly data minipulation, here be dragons. 
    # Single double quotes in a field break postgres csv import, also double single quotes instead of closing double quote.
    # A few committees candidate values broke fk constraints, blanked out or attempted to fix as seemed prudent.
    # C00042366 -> blanked - Not a candidate 
    # H6MD10024 -> H6MI10250 NOFS, BENJAMIN - attempted to fix, assumed data quality issue
    # H6NY26123 -> H6NY26115 SCH  RATZ, SHELLY - attempted to fix, assumed data quality issue
    sed -i "s/BOOTY\"S/BOOTY'S/g;" cm.txt && \
    sed -i "s/WHITEFEAT/WHITEFEAT\"/g; s/PHIBIAN''/PHIBIAN\"/g; s/\"RENT IS TOO DAMN HIGH/\"RENT IS TOO DAMN HIGH\"/g;"  cn.txt &&\
    # Remove non utf-8 char
    sed -i "s/\xA0//g" oppexp.txt && \
    chmod -R o+w .
COPY sql/* /docker-entrypoint-initdb.d/
COPY 3_db_startup.sh /docker-entrypoint-initdb.d/
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY my-postgres.conf /election_data/postgresql.conf
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh
