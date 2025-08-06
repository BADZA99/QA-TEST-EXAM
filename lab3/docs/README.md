# Tests API eBay Fulfillment

Ce dossier contient les tests automatisés pour l'API Fulfillment d'eBay.

## Structure du Projet

```
lab3_final/
├── docs/
│   └── README.md
├── pageObject/
│   └── variables.py
├── resources/
│   └── resources.robot
└── testcases/
    └── api_tests.robot
```

## Configuration

1. Dans `pageObject/variables.py`, remplacez `YOUR_TOKEN_HERE` par votre token eBay valide.
2. Ajustez les IDs de test selon vos besoins.

## Exécution des Tests

Pour exécuter les tests :

```bash
robot testcases/api_tests.robot
```

## Tests Implémentés

1. Get Shipping Fulfillments
   - Cas passant
   - Cas non passant

2. Create Shipping Fulfillment
   - Cas passant
   - Cas non passant

3. Get Single Shipping Fulfillment
   - Cas passant
   - Cas non passant

## Notes

- Les tests utilisent la bibliothèque RequestsLibrary pour les appels API
- La vérification SSL est désactivée (verify=false) pour le développement
- Les réponses sont validées pour le code status et le contenu
