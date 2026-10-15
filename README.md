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
