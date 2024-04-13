# Utilisation de l'image de base Ubuntu
FROM ubuntu:20.04

# Définir des variables d'environnement pour la configuration non interactive
ENV DEBIAN_FRONTEND=noninteractive

# Installation d'Apache et de PHP avec les extensions nécessaires
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Préconfiguration des paramètres de timezone
RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Activer les modules Apache nécessaires
RUN a2enmod php7.4
RUN a2enmod rewrite

# Configuration d'Apache pour utiliser monfichier.html comme index
RUN echo 'DirectoryIndex monfichier.html index.html index.php' > /etc/apache2/conf-available/directory-index.conf && a2enconf directory-index

# Copie des fichiers du site web dans le dossier du serveur web
COPY EXCOWEB/ /var/www/html/

# Exposition du port 80
EXPOSE 80

# Commande pour démarrer Apache lors du démarrage du conteneur
CMD ["apache2ctl", "-D", "FOREGROUND"]
