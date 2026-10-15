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

## Valeurs confirmées pour ce livre (2026-10-15)
- Format de coupe : 8 × 10 po, portrait.
- Fond perdu : non — marges blanches, compositions centrées.
- Nombre de pages visé : 104 (4 liminaires + 50 illustrations + 50 versos
  blancs) — à consolider au moment de la mise en page.
- Papier : blanc, impression noir et blanc.
- Couverture : paperback, finition mate.
- Dimensions du PDF intérieur : 8 × 10 po exactement (pas de fond perdu).
- Marges de sécurité : au moins 0,25 po depuis les bords de coupe ;
  viser 0,5 po pour les zones graphiques.
- Dos : à calculer au moment de la couverture. Estimation papier blanc
  noir et blanc : 104 pages × 0,002252 po ≈ 0,234 po — formule à re-vérifier
  sur la documentation officielle KDP.
- Zone code-barres : réserver l'espace standard en bas à droite de la
  quatrième de couverture (dimensions exactes à vérifier).
- Résolution : 300 DPI partout. Noir pur pour l'intérieur (pas de gris) ;
  couleur pour la couverture.
- Polices : intégrées dans les PDF.

## Point de vigilance — page de test des feutres
La demande initiale mentionne une page « en couleur » de test des feutres.
Avec un intérieur imprimé en noir et blanc, une page imprimée en couleur est
impossible sans passer à un intérieur premium couleur (coût nettement
supérieur). Interprétation retenue par défaut : une page de test imprimable
en noir et blanc, avec des zones vides à remplir par le lecteur pour tester
ses propres feutres (rendu, transmission). À confirmer explicitement avant
la mise en page.
