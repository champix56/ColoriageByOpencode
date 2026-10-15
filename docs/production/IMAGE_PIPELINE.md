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

## État confirmé (2026-10-15)
- Aucune clé API disponible ; budget de génération : 0 $.
- Conséquence : la comparaison de fournisseurs doit d'abord porter sur les
  options gratuites — génération locale type Stable Diffusion (à condition
  qu'un GPU soit disponible), paliers gratuits éventuels, ou production
  vectorielle programmatique (SVG) — avant tout client API payant.
- Si aucune option gratuite n'est viable, en discuter avec l'utilisateur avant
  d'engager des coûts. Ne jamais simuler une génération réussie.
- Format de sortie cible : PNG 300 DPI. Pour une pleine page 8 × 10 po,
  cela correspond à 2400 × 3000 px minimum par illustration.
- Style attendu : mandala Día de los Muertos, trait moyen régulier, contours
  fermés, noir pur sur blanc, sans gris (voir VISUAL_BIBLE.md).
