# Configuration de l'environnement

Pour faire fonctionner l'application, vous devez créer un fichier `.env` dans ce dossier avec les variables d'environnement suivantes :

## Variables requises

```bash
# eBay API Credentials
EBAY_CLIENT_ID=       # Votre ID client eBay Sandbox (App ID)
EBAY_CLIENT_SECRET=   # Votre Secret client eBay Sandbox (Cert ID)
EBAY_OAUTH_TOKEN=     # Votre token OAuth eBay
```

## Comment obtenir ces credentials

1. Créez un compte développeur sur [eBay Developers Program](https://developer.ebay.com/)
2. Créez une nouvelle application dans votre compte développeur
3. Les credentials seront générés automatiquement dans la section "Keys"

## Instructions

1. Copiez le fichier d'exemple :
   ```bash
   cp .env.example .env
   ```
2. Remplacez les valeurs par vos propres credentials eBay
3. Ne commitez jamais le fichier `.env` dans le dépôt Git

⚠️ **Important** : Ne jamais commiter ou partager vos credentials réels. Le fichier `.env` est déjà dans le `.gitignore`.
