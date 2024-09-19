# Use the official Maven image to build the app
FROM maven:3.8.6-openjdk-8 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src /app/src

# Build the application
RUN mvn clean package

# Use a smaller base image for running the app
FROM openjdk:8-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=build /app/target/sample-project-maven-1.0.0-SNAPSHOT.jar /app/sample-project-maven-1.0.0-SNAPSHOT.jar

# Expose port 9100 (or adjust if necessary)
EXPOSE 9100

# Command to run the application
ENTRYPOINT ["java", "-jar", "sample-project-maven-1.0.0-SNAPSHOT.jar"]
