FROM postgres:10.4-alpine
RUN apk add --update curl unzip vim vimdiff sed
RUN mkdir election_data
WORKDIR election_data
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
    rm -r by_date/ 
# Some ugly data minipulation, here be dragons. 
# Single double quotes in a field break postgres csv import.
# Also a few committees candidate values broke fk constraints, blanked out or attempted to fix as seemed prudent.
# C00042366 blanked
# H6MD10024 -> H6MI10250 NOFS, BENJAMIN
# H6NY26123 -> H6NY26115 SCHRATZ, SHELLY
RUN sed -i -e "s/BOOTY\"S/BOOTY'S/g; s/C00042366$//g; s/H6MD10024$/H6MI10250/g; s/H6NY26123$/H6NY26115/g;" cm.txt && \
    sed -i -e "s/WHITEFEAT/WHITEFEAT\"/g; s/PHIBIAN''/PHIBIAN\"/g; s/\"RENT IS TOO DAMN HIGH/\"RENT IS TOO DAMN HIGH\"/g;"  cn.txt &&\
    # deleted a few linkages at the start that pointed at committees instead of candidates  ¯\_(ツ)_/¯.
    sed -i -e "/^C/d; s/^H6MD10024/H6MI10250/g; s/^H6NY26123/H6NY26115/g;" ccl.txt && \
    # Remove non utf-8 char
    sed -i -e "s/\xA0//g" oppexp.txt && \
    # Remove records with invalid committee id
    sed -i -e '/C00455357/d; /C00607698/d;' itoth.txt && \
    chmod -R o+w .
COPY sql/* /docker-entrypoint-initdb.d/
COPY 2_db_startup.sh /docker-entrypoint-initdb.d/
