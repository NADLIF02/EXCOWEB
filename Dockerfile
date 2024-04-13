# Utilisation de l'image de base Ubuntu
FROM ubuntu:20.04

# Installation d'Apache et de PHP avec les extensions nécessaires
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    && rm -rf /var/lib/apt/lists/*

# Activer Apache mods.
RUN a2enmod php7.4
RUN a2enmod rewrite

# Copie des fichiers du site web dans le dossier du serveur web
COPY src/ /var/www/html/

# Mise à jour du fichier de configuration Apache pour pointer vers le dossier public
RUN sed -i 's|/var/www/html|/var/www/html|' /etc/apache2/sites-available/000-default.conf

# Exposition du port 80
EXPOSE 80

# Commande pour démarrer Apache lors du démarrage du conteneur
CMD ["apache2ctl", "-D", "FOREGROUND"]
