// Ceci est un exemple basique, il faudrait une validation plus poussée en pratique
document.querySelector('form').onsubmit = function() {
    if (!document.getElementById('username').value || !document.getElementById('password').value) {
        alert('Veuillez remplir tous les champs.');
        return false;
    }
    return true;
};
