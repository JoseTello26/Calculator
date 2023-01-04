FROM openjdk:17-oracle
COPY calculator/target/calculator-0.0.1-SNAPSHOT-jar-with-dependencies.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
