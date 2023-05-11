FROM nginx:alpine

# Copiar los archivos compilados de la aplicación de React al directorio de Nginx
COPY --from=build /. /usr/share/nginx/html

# Copiar la configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto 80 para que se pueda acceder a la aplicación a través de HTTP
EXPOSE 80

# Comando para iniciar Nginx cuando se ejecute el contenedor
CMD ["nginx", "-g", "daemon off;"]
