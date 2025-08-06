# API Configuration

import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()
BASE_URL = "https://api.sandbox.ebay.com"    

# eBay API Credentials from environment variables
EBAY_CLIENT_ID = os.getenv('EBAY_CLIENT_ID')
EBAY_CLIENT_SECRET = os.getenv('EBAY_CLIENT_SECRET')
EBAY_OAUTH_TOKEN = os.getenv('EBAY_OAUTH_TOKEN')
# Headers pour l'authentification
HEADERS = {
    'Authorization': f'Bearer {EBAY_OAUTH_TOKEN}',
    'Content-Type': 'application/json',
    'Accept': 'application/json'
}

# IDs valides pour les tests
ORDER_ID = "01-12345-67890" 
FULFILLMENT_ID = "12345678901"  

# IDs invalides pour les tests négatifs
WRONG_ORDER_ID = "invalid-order-id"
WRONG_FULFILLMENT_ID = "invalid-fulfillment-id"

# Corps de la requête pour créer un fulfillment
REQUEST_BODY = {
    "lineItems": [
        {
            "lineItemId": "124343434",
            "quantity": 1
        }
    ],
    "shippingCarrierCode": "USPS",
    "trackingNumber": "123456789",
    "shippedDate": "2025-08-05T10:00:00.000Z"
}

# Corps de la requête invalide
INVALID_REQUEST_BODY = {
    "lineItems": [],
    "shippingCarrierCode": "",
    "trackingNumber": "",
    "shippedDate": "invalid-date"
}
