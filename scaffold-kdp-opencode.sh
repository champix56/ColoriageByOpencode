
#!/usr/bin/env bash
set -Eeuo pipefail

# Scaffold OpenCode pour un studio de livres de coloriage KDP.
# La racine du projet est le répertoire courant au lancement.
ROOT="$(pwd)"
cd "$ROOT"

echo "Racine du projet : $ROOT"

# Ne pas écraser des instructions ou une configuration déjà présentes.
for file in AGENTS.md opencode.json; do
  if [[ -e "$file" ]]; then
    echo "ERREUR : $file existe déjà dans $ROOT."
    echo "Lance ce script dans un dossier de projet dédié ou sauvegarde ce fichier."
    exit 1
  fi
done

mkdir -p \
  docs/visual \
  docs/production \
  docs/memory \
  .opencode/command \
  .opencode/agent \
  .opencode/skill/kdp-art-direction \
  config \
  prompts/illustrations \
  prompts/covers \
  data \
  scripts \
  assets/reference \
  assets/fonts \
  output/art/source \
  output/art/approved \
  output/interior \
  output/cover \
  output/previews \
  logs

write_file() {
  local path="$1"
  mkdir -p "$(dirname "$path")"
  cat > "$path"
}

write_file .gitignore <<'EOF'
.env
.venv/
__pycache__/
*.py[cod]
.DS_Store
output/art/source/*
output/interior/*
output/cover/*
output/previews/*
logs/*
!output/art/source/.gitkeep
!output/interior/.gitkeep
!output/cover/.gitkeep
!output/previews/.gitkeep
!logs/.gitkeep
EOF

write_file opencode.json <<'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "instructions": ["AGENTS.md"]
}
EOF

write_file AGENTS.md <<'EOF'
# Instructions principales du projet

## Mission
Créer des livres de coloriage originaux, cohérents et imprimables pour Amazon KDP.
OpenCode doit concevoir et maintenir les outils du projet, documenter ses choix
et ne jamais prétendre qu'un PDF est validé par KDP sans vérification réelle.

## Règles visuelles impératives
- Lire docs/visual/VISUAL_BIBLE.md avant de proposer des illustrations.
- Lire docs/visual/ILLUSTRATION_CATALOG.md avant toute nouvelle génération.
- Chaque illustration doit avoir un identifiant unique et un brief individuel.
- Ne jamais produire une série en changeant seulement un petit élément du même SVG.
- Varier intentionnellement sujet, silhouette, composition, point de vue,
  décor, densité, motifs secondaires et espace négatif.
- Éviter les compositions clonées, les bordures répétitives et les arrière-plans
  remplis de détails inutiles.
- Maintenir le style général du livre sans rendre toutes les pages identiques.
- Ne pas recopier de personnages protégés, logos, marques ou œuvres existantes.
- Ne pas ajouter de gris, d'ombres, de hachures denses ou de grandes zones noires
  sauf demande explicite dans le brief.
- Une illustration destinée au coloriage doit avoir des contours lisibles,
  des zones fermées et suffisamment d'espaces à remplir.
- Vérifier les mains, visages, membres, objets fusionnés, détails coupés,
  texte accidentel et éléments flottants avant approbation.
- Les images générées doivent être inspectées : un prompt réussi ne garantit
  pas une image correcte.

## Architecture et qualité
- Commencer par examiner les fichiers présents avant de les modifier.
- Proposer un plan avant toute modification importante.
- Utiliser des scripts reproductibles, des noms stables et des journaux utiles.
- Ne jamais supprimer ou écraser des illustrations approuvées sans accord.
- Séparer sources, images approuvées, intérieur PDF et couverture.
- Ne jamais placer de clé API dans Git, les prompts ou les fichiers de documentation.
- Ne pas supposer qu'un fournisseur d'images est configuré. Détecter et documenter
  le fournisseur réellement choisi.
- Si une API ou une dépendance manque, expliquer l'installation au lieu de simuler
  une génération réussie.

## KDP
- Vérifier les spécifications officielles correspondant au format, au nombre de
  pages, au papier, au fond perdu et au type de couverture choisis.
- La couverture complète doit inclure quatrième, dos et première de couverture.
- Calculer la largeur du dos à partir des règles KDP applicables au livre final.
- Garder une zone de sécurité pour le texte et le code-barres.
- La quatrième de couverture doit prévoir une zone de texte modifiable par prompt.
- Le PDF produit par le projet est un livrable à contrôler, pas une garantie
  d'acceptation par Amazon.

## Mémoire de session
Avant de terminer une session de travail importante, mettre à jour :
docs/memory/CURRENT_STATE.md
docs/memory/NEXT_SESSION.md
docs/memory/DECISIONS.md

Conserver ces fichiers courts, factuels et utiles à la reprise.
EOF

write_file README.md <<'EOF'
# KDP Coloring Studio

Projet OpenCode pour concevoir, illustrer, assembler et contrôler des livres
de coloriage destinés à l'impression.

## Démarrage
1. Lire `docs/PROJECT_BRIEF.md`.
2. Définir le livre dans `config/book.json`.
3. Définir le style dans `docs/visual/VISUAL_BIBLE.md`.
4. Lancer OpenCode à la racine du projet : `opencode`.
5. Exécuter `/kdp-plan` et examiner le plan avant la production.

## Commandes OpenCode
- `/kdp-plan` : analyse et plan de production.
- `/kdp-brief` : prépare ou améliore le cahier des charges visuel.
- `/kdp-catalog` : planifie des illustrations réellement distinctes.
- `/kdp-art` : prépare les briefs et le pipeline de génération d'images.
- `/kdp-build` : construit ou exécute l'assemblage PDF.
- `/kdp-cover` : conçoit la couverture complète en couleur.
- `/kdp-check` : vérifie les fichiers et les règles de production.

Les commandes sont des instructions pour l'agent. Elles ne remplacent pas
les outils de génération d'images, qui doivent être configurés séparément.
EOF

write_file docs/PROJECT_BRIEF.md <<'EOF'
# Brief général du projet

## Objectif
Produire un livre de coloriage original, agréable à utiliser et préparé pour
l'impression à la demande Amazon KDP.

## Principes
1. La qualité prime sur la quantité.
2. Chaque illustration doit avoir une identité visuelle propre.
3. Le style général est cohérent, mais les compositions sont variées.
4. La production est organisée en étapes contrôlables et reproductibles.
5. Aucun fichier n'est considéré comme approuvé avant inspection.

## Avant la production
Demander ou déterminer avec l'utilisateur :
- public visé et âge ;
- thème principal et sous-thèmes ;
- niveau de difficulté ;
- format de coupe et orientation ;
- nombre d'illustrations ;
- présence ou non d'une page blanche au verso ;
- style de ligne ;
- contraintes de contenu ;
- langues du livre ;
- titre, sous-titre, nom d'auteur ou nom de marque ;
- ambiance de la couverture ;
- texte souhaité pour la quatrième de couverture.

Ne pas inventer silencieusement les décisions importantes. Présenter les
hypothèses à valider par l'utilisateur.
EOF

write_file docs/visual/VISUAL_BIBLE.md <<'EOF'
# Bible visuelle

Ce document est la source de vérité artistique. Le compléter avant la production.

## Identité du livre
- Titre provisoire :
- Public :
- Âge ou niveau :
- Thème central :
- Sous-thèmes :
- Ambiance :
- Niveau de complexité :

## Trait et rendu
- Type de ligne :
- Épaisseur cible :
- Contours fermés : oui/non
- Fond : blanc propre
- Couleur intérieure : noir et blanc, sans niveaux de gris
- Ombres : à éviter sauf exception explicitement décidée
- Texture :
- Densité de détails :
- Espace blanc à préserver :
- Marges de sécurité :

## Variété de composition
Sur l'ensemble du livre, varier autant que le thème le permet :
- vue rapprochée, vue moyenne, vue large ;
- sujet centré, décentré, composition diagonale, composition en cercle ;
- scène narrative, sujet isolé, motif décoratif, scène en environnement ;
- objets seuls, personnages, animaux, plantes, architectures ou paysages ;
- espaces ouverts et scènes plus riches ;
- orientations et silhouettes ;
- motifs secondaires et formes des zones à colorier.

Ne pas appliquer chaque variation mécaniquement à toutes les images.
Choisir les variations en fonction du sujet et du public.

## Interdictions et points de vigilance
- Répéter la même silhouette avec seulement un accessoire différent.
- Réutiliser la même composition en changeant le sujet.
- Accumuler des micro-détails impossibles à colorier.
- Laisser des contours ouverts qui rendent les zones ambiguës.
- Couper accidentellement des éléments importants.
- Produire du texte illisible dans l'illustration.
- Imiter un artiste vivant ou une franchise protégée.

## Contrôle d'acceptation
Chaque image doit être examinée à sa taille réelle d'impression et en zoom.
Refuser ou corriger les défauts de contour, anatomie, perspective, lisibilité,
éléments parasites, zones trop noires et répétitions avec les autres pages.
EOF

write_file docs/visual/ILLUSTRATION_CATALOG.md <<'EOF'
# Catalogue des illustrations

Tenir une entrée par illustration. Ce fichier doit être actualisé avant de lancer
un nouveau lot, afin de prévenir les répétitions.

| ID | Sujet principal | Action/scène | Composition | Point de vue | Densité | Motifs distinctifs | Statut | Fichier |
|---|---|---|---|---|---|---|---|---|
| I001 | À définir | À définir | À définir | À définir | Moyen | À définir | À planifier | |
EOF

write_file docs/visual/VARIETY_MATRIX.md <<'EOF'
# Matrice de variété

Avant de créer les briefs, construire une matrice avec une ligne par image :
ID, sujet, action, silhouette, composition, point de vue, décor, densité,
motifs secondaires, espace négatif, difficulté.

Contrôles :
- Aucun sujet ne doit être répété sans raison artistique.
- Deux images consécutives ne doivent pas partager la même composition.
- Repérer les doublons sémantiques même si les objets diffèrent.
- Diversifier les échelles, les angles et les espaces blancs.
- Réserver les variations stylistiques exceptionnelles à une décision explicite.
- Pour un grand livre, planifier par lots de 5 à 10 images et contrôler le lot
  avant de passer au suivant.
EOF

write_file docs/production/IMAGE_PIPELINE.md <<'EOF'
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
EOF

write_file docs/production/PRINT_AND_KDP.md <<'EOF'
# Contrôles d'impression et KDP

Avant de finaliser, vérifier la documentation officielle KDP en vigueur :
https://kdp.amazon.com/en_US/help/topic/G201857950

À confirmer pour chaque livre :
- format de coupe ;
- marges intérieures et extérieures ;
- fond perdu ou absence de fond perdu ;
- nombre de pages ;
- type et couleur du papier ;
- dimensions exactes du PDF intérieur ;
- couverture complète et largeur du dos calculée pour le livre final ;
- zone de sécurité du texte ;
- espace réservé au code-barres ;
- résolution et profil de couleur appropriés ;
- polices intégrées si nécessaire ;
- transparences, images manquantes et pages blanches intentionnelles.

La quatrième de couverture doit avoir une zone de texte modifiable depuis
`config/book.json` ou un prompt distinct. Le code doit réserver cet espace
dans la composition, sans générer de faux texte illisible à l'intérieur.

La validation automatique ne remplace pas l'inspection visuelle et l'aperçu
de couverture KDP. Ne jamais promettre l'acceptation automatique par Amazon.
EOF

write_file docs/production/COVER_BRIEF.md <<'EOF'
# Brief de couverture

La couverture est une composition couleur unique comprenant :
- première de couverture ;
- dos ;
- quatrième de couverture.

Créer la première de couverture pour être lisible en vignette :
titre contrasté, hiérarchie nette, sujet immédiatement identifiable.
Le style couleur peut être plus riche que les pages intérieures.

La quatrième de couverture doit réserver une zone propre et lisible pour un
texte généré ou modifié par prompt. Le texte doit être rendu avec une vraie
police et une mise en page contrôlée, plutôt que confié au générateur d'images.

Le dos doit être calculé à partir du nombre de pages définitif, du papier et des
règles KDP en vigueur. Ne jamais figer une largeur approximative.

Le pipeline doit permettre :
1. de générer ou sélectionner l'illustration couleur ;
2. de composer les textes et éléments graphiques ;
3. de calculer les dimensions complètes ;
4. d'exporter le PDF couverture ;
5. de contrôler dimensions, marges, lisibilité et espace code-barres.
EOF

write_file docs/memory/CURRENT_STATE.md <<'EOF'
# État actuel

- Le scaffold OpenCode est créé.
- Le fournisseur de langage n'est pas encore confirmé.
- Le fournisseur de génération d'images n'est pas encore configuré.
- Aucun dessin n'est encore approuvé.
- Aucun PDF final n'est encore validé.

Mettre à jour ce fichier après chaque étape importante.
EOF

write_file docs/memory/NEXT_SESSION.md <<'EOF'
# Prochaine session

1. Lire AGENTS.md et docs/PROJECT_BRIEF.md.
2. Lire docs/memory/CURRENT_STATE.md et docs/memory/DECISIONS.md.
3. Vérifier la configuration des modèles et des fournisseurs.
4. Demander confirmation des décisions visuelles encore ouvertes.
5. Reprendre au premier point non terminé.
6. Ne pas régénérer les fichiers approuvés.
EOF

write_file docs/memory/DECISIONS.md <<'EOF'
# Décisions du projet

Consigner ici uniquement les décisions confirmées :
- date ;
- décision ;
- raison ;
- fichiers concernés ;
- conséquences sur les étapes suivantes.

Ne pas transformer une hypothèse de l'agent en décision confirmée.
EOF

write_file config/book.json <<'EOF'
{
  "title": "Titre à définir",
  "subtitle": "",
  "author": "",
  "language": "fr",
  "audience": "à définir",
  "theme": "à définir",
  "trim_size": "8.5x11",
  "orientation": "portrait",
  "interior_color": "black_and_white",
  "cover_color": "full_color",
  "illustration_count": 30,
  "blank_back_pages": true,
  "paper_type": "à confirmer dans KDP",
  "cover_back_text_prompt": "Rédige une quatrième de couverture claire, attractive et honnête, adaptée au public cible. Ne promets aucun résultat irréaliste. Retourne un texte court, relu et prêt à composer.",
  "image_provider": "à configurer",
  "image_model": "à configurer",
  "status": "planning"
}
EOF

write_file prompts/illustrations/BRIEF_TEMPLATE.md <<'EOF'
# Brief individuel d'illustration

- ID :
- Rôle dans le livre :
- Sujet précis :
- Action ou scène :
- Composition :
- Point de vue :
- Forme générale / silhouette :
- Décor :
- Motifs secondaires :
- Densité :
- Difficulté :
- Espace blanc :
- Détails à mettre en valeur :
- Éléments à exclure :
- Différences intentionnelles par rapport aux images précédentes :
- Contraintes de trait :
- Critères d'acceptation :

## Prompt image
Rédiger un prompt autonome décrivant une seule image. Il doit exprimer le sujet,
la composition, le point de vue, la densité et les contraintes de coloriage.
Ne pas utiliser seulement « même style que l'image précédente ».
EOF

write_file prompts/covers/FRONT_COVER_PROMPT.md <<'EOF'
# Prompt de première de couverture

À partir de la bible visuelle et des informations du livre, proposer une
illustration de couverture couleur originale, lisible en miniature, avec une
hiérarchie visuelle forte. Garder une zone de titre libre et suffisamment
contrastée. Ne pas inclure de logos, de marques ou de texte parasite.

Retourner séparément :
1. le prompt de génération de l'image ;
2. les textes exacts à composer ensuite ;
3. les recommandations de placement, de contraste et de palette.
EOF

write_file prompts/covers/BACK_COVER_TEXT_PROMPT.md <<'EOF'
# Prompt de quatrième de couverture

Utiliser les informations confirmées du livre pour rédiger un texte bref,
précis et attrayant. Ne pas inventer de caractéristiques, de bonus ou de
promesses. Prévoir un titre court, un paragraphe de présentation et, si utile,
une liste de bénéfices factuels. Éviter le texte qui touche la zone code-barres.
La composition finale doit utiliser de vraies polices et un texte relisible.
EOF

write_file .opencode/command/kdp-plan.md <<'EOF'
---
description: Analyse le projet et prépare un plan de production KDP
---
Lis AGENTS.md, README.md, docs/PROJECT_BRIEF.md, config/book.json et les documents
de docs/visual et docs/production. Examine les fichiers présents sans les écraser.
Liste les décisions manquantes, les dépendances, les risques et un plan par étapes.
Propose une architecture réaliste pour les briefs, la génération d'images, les
contrôles, l'intérieur PDF et la couverture couleur complète.
Ne génère pas encore de grand lot d'images. Attends validation du plan.
EOF

write_file .opencode/command/kdp-brief.md <<'EOF'
---
description: Définit ou améliore la direction artistique du livre
---
Lis la bible visuelle, le brief général et la configuration. Pose les questions
essentielles manquantes en une liste concise. Puis propose une bible visuelle
complète et concrète, adaptée au public, à l'impression et au thème choisi.
Décris les règles de trait, les exclusions, la difficulté et les axes de variété.
Ne considère pas une proposition comme confirmée sans validation utilisateur.
Mets à jour les documents uniquement après validation.
EOF

write_file .opencode/command/kdp-catalog.md <<'EOF'
---
description: Planifie un catalogue d'illustrations distinctes
---
Lis AGENTS.md, VISUAL_BIBLE.md, ILLUSTRATION_CATALOG.md et VARIETY_MATRIX.md.
Construis le plan d'illustrations demandé dans config/book.json.
Pour chaque entrée, définir un sujet précis, une action, une composition, un point
de vue, une densité et des motifs distinctifs. Éviter les doublons de sujet comme
les doublons de composition. Répartir les types de scènes de façon intentionnelle.
Produire d'abord une matrice à examiner, puis les briefs individuels.
Ne lance pas la génération d'images avant approbation du catalogue.
EOF

write_file .opencode/command/kdp-art.md <<'EOF'
---
description: Prépare les briefs et le pipeline de génération des illustrations
---
Lis les documents artistiques et de production. Examine les outils déjà présents.
Détermine quel fournisseur d'images est réellement configuré, ses limites et ses
conditions commerciales. Si aucun fournisseur n'est configuré, compare les
options et demande confirmation avant d'implémenter un client spécifique.
Prépare un pipeline reproductible avec génération unitaire, génération par lots,
journal des prompts, gestion d'erreurs et approbation manuelle. Commence par trois
illustrations de test très différentes. Ne simule jamais des images manquantes.
EOF

write_file .opencode/command/kdp-build.md <<'EOF'
---
description: Construit ou améliore l'assemblage du livre intérieur en PDF
---
Examine le projet, les illustrations approuvées et les exigences KDP à jour.
Conçois ou exécute un pipeline qui assemble uniquement les images approuvées,
respecte le format, les marges, les versos blancs décidés et la pagination.
Le script doit signaler les images manquantes, les tailles incorrectes et les
pages inattendues. Conserver les fichiers source et ne pas écraser les sorties
approuvées sans confirmation. Ajouter un aperçu et un rapport de validation.
Ne prétends pas que le PDF est accepté par KDP sans contrôle réel.
EOF

write_file .opencode/command/kdp-cover.md <<'EOF'
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
EOF

write_file .opencode/command/kdp-check.md <<'EOF'
---
description: Contrôle les illustrations et les PDF avant publication
---
Effectue des contrôles reproductibles sur les fichiers existants.
Contrôler le nombre de pages, dimensions, images manquantes, pages blanches,
résolution, marges, zones de sécurité et cohérence de la couverture.
Inspecter les illustrations pour détecter répétitions, détails parasites,
contours trop fins, zones noires et erreurs visuelles lorsque les outils le
permettent. Distinguer les contrôles automatiques des contrôles manuels.
Créer un rapport avec erreurs bloquantes, avertissements et actions recommandées.
Ne jamais annoncer une conformité KDP garantie.
EOF

write_file .opencode/agent/kdp-art-editor.md <<'EOF'
---
description: Relecteur artistique des livres de coloriage
mode: subagent
---
Tu es directeur artistique et contrôleur qualité de livres de coloriage.
Lis la bible visuelle et le catalogue avant d'évaluer une image. Évalue :
adéquation au public, originalité, variété de composition, qualité des contours,
espaces à colorier, lisibilité à taille imprimée, éléments coupés, artefacts,
texte accidentel et répétition avec les autres pages.
Attribue un statut : APPROUVÉ, À CORRIGER ou REJETER, avec des raisons précises.
Ne confonds pas cohérence de style et répétition de composition.
EOF

write_file .opencode/skill/kdp-art-direction/SKILL.md <<'EOF'
---
name: kdp-art-direction
description: Direction artistique, variété et contrôle qualité des livres de coloriage KDP
---
# Skill de direction artistique

À utiliser pour planifier, générer ou contrôler des illustrations de coloriage.

1. Lire `docs/visual/VISUAL_BIBLE.md`.
2. Lire `docs/visual/ILLUSTRATION_CATALOG.md`.
3. Vérifier les entrées dans `docs/visual/VARIETY_MATRIX.md`.
4. Donner à chaque illustration un brief autonome, détaillé et unique.
5. Comparer le brief avec les images déjà planifiées et approuvées.
6. Contrôler la lisibilité des contours et les zones à colorier.
7. Conserver le prompt et les métadonnées du modèle pour chaque image.
8. Ne pas lancer de génération massive avant validation d'un lot de test.
9. Demander une inspection manuelle avant d'approuver les images.
10. Mettre à jour le catalogue et la mémoire de session.
EOF

touch output/art/source/.gitkeep \
  output/art/approved/.gitkeep \
  output/interior/.gitkeep \
  output/cover/.gitkeep \
  output/previews/.gitkeep \
  logs/.gitkeep

if command -v git >/dev/null 2>&1; then
  if [[ ! -d .git ]]; then
    git init -q
  fi
  git add .
  git commit -m "Scaffold OpenCode KDP coloring studio" >/dev/null 2>&1 || true
fi

echo
echo "Scaffold OpenCode terminé dans : $ROOT"
echo
echo "Prochaines étapes :"
echo "  1. Vérifier les fichiers créés."
echo "  2. Configurer un fournisseur de modèle avec OpenCode."
echo "  3. Lancer : opencode"
echo "  4. Exécuter : /kdp-plan"
echo
