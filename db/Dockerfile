FROM postgres:10.4-alpine
RUN apk add --update curl unzip
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
#A double quote used instead of an apostrophe breaks psotgres CSV import, fixing it.
RUN sed -i -e "s/BOOTY\"S/BOOTY'S/g" cm.txt 

COPY sql/* /docker-entrypoint-initdb.d/
COPY 2_db_startup.sh /docker-entrypoint-initdb.d/
