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

## Paramètres confirmés du livre en cours
Résumé des décisions validées le 2026-10-15 — source de vérité :
docs/memory/DECISIONS.md.
- Livre : « Coloriage anti-stress – Mandalas du Día de los Muertos »,
  public tous âges, ambiance mystique et ésotérique, rendu ornemental et
  respectueux de la tradition mexicaine.
- 50 illustrations type mandala, trait moyen régulier (1,5-2 pt), vectoriel
  net sans gris, sans texte intérieur (hors liminaires).
- Format 8 × 10 po portrait, marges blanches (sans fond perdu), verso blanc
  après chaque illustration, papier blanc, couverture paperback mat.
- Sources PNG 300 DPI. Fournisseur d'images non configuré : aucune clé API,
  budget 0 $ — comparer les options gratuites avant tout client payant.
