# Seleccionar una imagen base con Node.js para compilar la aplicación de React
FROM node:14 AS build

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo package.json y package-lock.json al contenedor
COPY package*.json ./

# Instalar las dependencias de la aplicación
RUN npm install

# Copiar el resto de los archivos de la aplicación al contenedor
COPY . .

# Compilar la aplicación de React
RUN npm run build


# Crear la imagen final de Nginx
FROM nginx:alpine

# Copiar los archivos compilados de la aplicación de React al directorio de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Copiar la configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto 80 para que se pueda acceder a la aplicación a través de HTTP
EXPOSE 80

# Comando para iniciar Nginx cuando se ejecute el contenedor
CMD ["nginx", "-g", "daemon off;"]
