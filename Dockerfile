FROM tomcat:8
EXPOSE 8080

COPY tomcat/server.xml /usr/local/tomcat/conf

RUN mkdir -p /dhis2/home
ENV DHIS2_HOME /dhis2/home
COPY conf/dhis.conf /dhis2/home
COPY scripts/wait-for-it.sh *.war /dhis2/

RUN apt-get update \ 
    && apt-get install -y curl netcat unzip \
    && rm -rf /var/lib/apt/lists/*

RUN if [ ! -f /dhis2/dhis.war ]; \
    then \
        curl -L https://releases.dhis2.org/41/dhis2-stable-41.4.1.war -o /dhis2/dhis.war; \
    fi; \
    rm -rf /usr/local/tomcat/webapps/* \
    && unzip /dhis2/dhis.war -d /usr/local/tomcat/webapps/ROOT


    