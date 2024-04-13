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

# Préconfiguration des paramètres de timezone pour éviter les interactions
RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Activer les modules Apache nécessaires
RUN a2enmod php7.4
RUN a2enmod rewrite

# Copie des fichiers du site web dans le dossier du serveur web
COPY src/ /var/www/html/

# Mise à jour du fichier de configuration Apache pour pointer vers le dossier public
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html|' /etc/apache2/sites-available/000-default.conf

# Exposition du port 80
EXPOSE 80

# Commande pour démarrer Apache lors du démarrage du conteneur
CMD ["apache2ctl", "-D", "FOREGROUND"]
