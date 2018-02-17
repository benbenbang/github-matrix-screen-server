echo "apiToken=$API_KEY" >> src/main/resources/application.properties 
mvn -DapiToken=$API_KEY package
java -jar target/*.jar -XX:MaxMetaspaceSize=64m -Xmx256m -Djava.awt.headless=true