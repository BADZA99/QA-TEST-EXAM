import base64
import requests
import json
import os
import time
from datetime import datetime
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Configuration API
API_CONFIG = {
    "client_id": os.getenv('EBAY_CLIENT_ID'),
    "client_secret": os.getenv('EBAY_CLIENT_SECRET'),
    "auth_url": "https://api.sandbox.ebay.com/identity/v1/oauth2/token",
    "scopes": ["https://api.ebay.com/oauth/api_scope/sell.fulfillment"]
}

def get_oauth_token():
    """Obtient un nouveau token OAuth"""
    print("\nObtention d'un nouveau token OAuth...")

    # Construction des en-têtes d'authentification
    credentials = f"{API_CONFIG['client_id']}:{API_CONFIG['client_secret']}"
    encoded_credentials = base64.b64encode(credentials.encode('utf-8')).decode('utf-8')

    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": f"Basic {encoded_credentials}"
    }

    data = {
        "grant_type": "client_credentials",
        "scope": " ".join(API_CONFIG['scopes'])
    }

    try:
        response = requests.post(API_CONFIG['auth_url'], headers=headers, data=data)
        print(f"Code de réponse OAuth: {response.status_code}")

        if response.status_code == 200:
            token_data = response.json()
            access_token = token_data.get('access_token')
            if access_token:
                print("Token OAuth obtenu avec succès")
                update_variable_file(access_token)
                return access_token
            else:
                print("Erreur: access_token non trouvé dans la réponse")
                return None
        else:
            print(f"Erreur lors de l'obtention du token: {response.status_code}")
            print(f"Réponse: {response.text}")
            return None
    except Exception as e:
        print(f"Exception lors de l'obtention du token: {str(e)}")
        return None

def update_variable_file(token):
    """Met à jour le token OAuth dans le fichier variable.py"""
    try:
        variable_path = os.path.join(os.path.dirname(__file__), "..", "po", "variable.py")
        with open(variable_path, 'r', encoding='utf-8') as file:
            content = file.read()

        # Mise à jour du token dans le contenu
        if 'EBAY_OAUTH_TOKEN = "' in content:
            start = content.index('EBAY_OAUTH_TOKEN = "') + len('EBAY_OAUTH_TOKEN = "')
            end = content.index('"', start)
            new_content = content[:start] + token + content[end:]

            with open(variable_path, 'w', encoding='utf-8') as file:
                file.write(new_content)
                print("Token mis à jour dans variable.py")
        else:
            print("Erreur: EBAY_OAUTH_TOKEN non trouvé dans variable.py")
    except Exception as e:
        print(f"Erreur lors de la mise à jour du fichier: {str(e)}")

def create_inventory_item():
    """Crée un article dans l'inventaire eBay"""
    url = "https://api.sandbox.ebay.com/sell/inventory/v1/inventory_item"
    headers = {
        "Authorization": f"Bearer {API_CONFIG['oauth_token']}",
        "Content-Type": "application/json",
        "Accept": "application/json"
    }

    # SKU unique basé sur le timestamp
    sku = f"TEST-SKU-{int(time.time())}"

    inventory_item = {
        "availability": {
            "shipToLocationAvailability": {
                "quantity": 1
            }
        },
        "condition": "NEW",
        "product": {
            "title": "Test Item",
            "description": "This is a test item",
            "aspects": {
                "Brand": ["Test Brand"],
                "Type": ["Test Type"]
            }
        }
    }

    try:
        response = requests.put(f"{url}/{sku}", headers=headers, json=inventory_item)
        if response.status_code in [200, 201]:
            print(f"Article créé avec succès. SKU: {sku}")
            return sku
        else:
            print(f"Erreur lors de la création de l'article: {response.status_code}")
            print(response.text)
            return None
    except Exception as e:
        print(f"Exception: {str(e)}")
        return None

def create_offer(sku):
    """Crée une offre pour un article"""
    url = "https://api.sandbox.ebay.com/sell/inventory/v1/offer"
    headers = {
        "Authorization": f"Bearer {API_CONFIG['oauth_token']}",
        "Content-Type": "application/json",
        "Accept": "application/json"
    }

    offer_data = {
        "sku": sku,
        "marketplaceId": "EBAY_US",
        "format": "FIXED_PRICE",
        "availableQuantity": 1,
        "categoryId": "15032",  # Catégorie de test
        "listingDescription": "Test item for API testing",
        "listingPolicies": {
            "fulfillmentPolicyId": "78842368018",  # ID de politique de livraison
            "paymentPolicyId": "78842368017",      # ID de politique de paiement
            "returnPolicyId": "78842368016"        # ID de politique de retour
        },
        "pricingSummary": {
            "price": {
                "currency": "USD",
                "value": "10.00"
            }
        },
        "merchantLocationKey": "DEFAULT"
    }

    try:
        response = requests.post(url, headers=headers, json=offer_data)
        if response.status_code == 201:
            print("Offre créée avec succès")
            return response.json().get("offerId")
        else:
            print(f"Erreur lors de la création de l'offre: {response.status_code}")
            print(response.text)
            return None
    except Exception as e:
        print(f"Exception: {str(e)}")
        return None

def create_test_order():
    """Crée une commande test complète"""
    print("\n=== Création d'une commande test ===")

    # 1. Obtenir un nouveau token OAuth
    print("\n1. Obtention du token OAuth...")
    oauth_token = get_oauth_token()
    if not oauth_token:
        print("Impossible d'obtenir le token OAuth")
        return None

    API_CONFIG['oauth_token'] = oauth_token

    # 2. Créer un article dans l'inventaire
    print("\n2. Création de l'article dans l'inventaire...")
    sku = create_inventory_item()
    if not sku:
        return None

    # 3. Créer une offre pour l'article
    print("\n3. Création de l'offre...")
    offer_id = create_offer(sku)
    if not offer_id:
        return None

    # 4. Simuler une commande (dans le Sandbox, nous devons créer manuellement)
    print("\n4. Création de la commande test...")
    url = "https://api.sandbox.ebay.com/sell/fulfillment/v1/order"
    headers = {
        "Authorization": f"Bearer {API_CONFIG['oauth_token']}",
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-EBAY-C-MARKETPLACE-ID": "EBAY_US"
    }

    order_data = {
        "orderPaymentStatus": "PAID",
        "orderFulfillmentStatus": "NOT_STARTED",
        "lineItems": [
            {
                "itemId": sku,
                "quantity": 1,
                "purchaseMarketplaceId": "EBAY_US"
            }
        ],
        "fulfillmentStartInstructions": [{
            "shippingStep": {
                "shipTo": {
                    "fullName": "Test Buyer",
                    "contactAddress": {
                        "addressLine1": "123 Test St",
                        "city": "San Jose",
                        "stateOrProvinceCode": "CA",
                        "postalCode": "95131",
                        "countryCode": "US"
                    }
                }
            }
        }]
    }

    try:
        response = requests.post(url, headers=headers, json=order_data)
        print(f"Code de réponse: {response.status_code}")
        print(f"Réponse: {response.text}")
        
        if response.status_code == 201:
            order_id = response.json().get("orderId")
            print(f"\nCommande créée avec succès. Order ID: {order_id}")
            update_variables(order_id, sku)
            return order_id
        else:
            print(f"\nErreur lors de la création de la commande: {response.status_code}")
            print(f"Message d'erreur: {response.text}")
            return None
    except Exception as e:
        print(f"\nException: {str(e)}")
        return None

def update_variables(order_id, line_item_id):
    """Met à jour le fichier variable.py avec les nouvelles données de test"""
    try:
        with open('../po/variable.py', 'r') as file:
            content = file.read()

        # Mettre à jour VALID_ORDER_ID et le line_item_id dans VALID_FULFILLMENT_PAYLOAD
        content = content.replace(
            'VALID_ORDER_ID = "01-07783-52435"',
            f'VALID_ORDER_ID = "{order_id}"'
        )
        content = content.replace(
            '"lineItemId": "21234567890"',
            f'"lineItemId": "{line_item_id}"'
        )

        with open('../po/variable.py', 'w') as file:
            file.write(content)

        print(f"\nvariable.py mis à jour avec:")
        print(f"- Order ID: {order_id}")
        print(f"- Line Item ID: {line_item_id}")
    except Exception as e:
        print(f"\nErreur lors de la mise à jour de variable.py: {str(e)}")

if __name__ == "__main__":
    print("\n=== Création d'une commande test dans eBay Sandbox ===")
    order_id = create_test_order()
    if order_id:
        print("\nCommande test créée avec succès!")
        print(f"Order ID: {order_id}")
        print("\nLes tests peuvent maintenant être exécutés avec cet ID de commande.")
    else:
        print("\nÉchec de la création de la commande test.")
