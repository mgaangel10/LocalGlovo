# Usar una imagen base de Java 17
FROM openjdk:17-jdk-slim

# Variables de entorno para la aplicación
ENV APP_HOME=/usr/app/

# Crear el directorio de la aplicación
WORKDIR $APP_HOME

# Copiar el archivo jar de la aplicación al contenedor de Docker
COPY ./target/LocalGlovo-0.0.1-SNAPSHOT.jar ./app.jar

# Exponer el puerto que usa la aplicación
EXPOSE 9000

# Comando para ejecutar la aplicación
ENTRYPOINT ["java","-jar","app.jar"]
