# Utilisation de l'image de base officielle PHP avec Apache, appropriée pour les déploiements Ubuntu
FROM php:7.4-apache

# Installation des extensions PHP nécessaires et des utilitaires de base
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    vim \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli

# Activation du mod_rewrite pour Apache
RUN a2enmod rewrite

# Copie des fichiers du site web dans le dossier du serveur web
COPY EXCOWEB/ /var/www/html/

# Configuration des permissions des fichiers et des dossiers
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Exposition du port 80 pour le trafic HTTP
EXPOSE 80
