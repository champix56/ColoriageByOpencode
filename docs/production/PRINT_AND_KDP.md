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
