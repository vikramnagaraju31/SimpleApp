From tomcat:8-jre8 
MAINTAINER "vikramnagaraju31@gmail.com" 
COPY webapp/target/webapp.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
