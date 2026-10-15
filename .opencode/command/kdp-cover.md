---
description: Prépare la couverture complète en couleur
---
Lis docs/production/COVER_BRIEF.md, config/book.json et les règles KDP officielles.
Propose un concept de première de couverture couleur et un texte de quatrième
de couverture à partir de cover_back_text_prompt. Le texte doit être composé
avec de vraies polices, pas dessiné par le modèle d'image.
Implémente ou adapte le pipeline pour générer une couverture complète : quatrième,
dos et première. Calculer la largeur du dos à partir des dimensions et du nombre
de pages définitifs, en utilisant les règles KDP applicables. Réserver la zone
de code-barres et les marges de sécurité. Vérifier les dimensions du PDF final.
Demander validation du concept avant une production définitive.
