# Pipeline d'illustration

Le fournisseur d'images n'est pas présumé installé. Avant de coder un client API :
1. comparer les fournisseurs disponibles et leurs conditions commerciales ;
2. confirmer l'accès API, les quotas, le coût et la résolution ;
3. vérifier que les images peuvent être téléchargées dans leur format original ;
4. définir le format de sortie, la taille cible et la méthode de contrôle ;
5. faire un test sur trois briefs très différents ;
6. inspecter les résultats avant d'automatiser un lot.

Prévoir dans l'implémentation :
- un adaptateur par fournisseur ;
- les secrets dans les variables d'environnement ou le gestionnaire de secrets ;
- une relance limitée en cas d'erreur réseau ;
- un journal de prompt, modèle, date, statut et fichier de sortie ;
- une commande pour générer une seule image ;
- une commande pour générer un lot ;
- une étape d'approbation manuelle ;
- aucune génération factice en cas d'échec d'API.

Une API de langage ne doit pas être confondue avec une API de génération d'images.
