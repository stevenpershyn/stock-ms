# Use a Maven image with JDK to build and run the application (no multi-stage)
FROM maven:3.8.7-eclipse-temurin-17

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and download dependencies (layered to optimize build cache)
COPY pom.xml .

# Download the dependencies
RUN mvn dependency:go-offline -B

# Copy the entire project source code
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Expose the application port
EXPOSE 8081

# Run the application directly from the same image, as build and runtime are together
CMD [ "java", "-jar", "target/myapp-0.0.1-SNAPSHOT.jar" ]