# API Configuration
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

BASE_URL = "https://api.ebay.com/sell/fulfillment/v1"

# eBay API Credentials from environment variables
EBAY_CLIENT_ID = os.getenv('EBAY_CLIENT_ID')
EBAY_CLIENT_SECRET = os.getenv('EBAY_CLIENT_SECRET')
EBAY_OAUTH_TOKEN = os.getenv('EBAY_OAUTH_TOKEN')

# Sandbox test data
VALID_ORDER_ID = "6348905!25689031"
VALID_FULFILLMENT_ID = "123456"
INVALID_ORDER_ID = "invalid-id"
INVALID_FULFILLMENT_ID = "invalid-fulfillment"

# Test Payloads avec données valides pour Production
VALID_FULFILLMENT_PAYLOAD = {
    "lineItems": [
        {
            "lineItemId": "654321",
            "quantity": 1
        }
    ],
    "shippedDate": "2025-08-01T10:00:00.000Z",
    "shippingCarrierCode": "USPS",
    "trackingNumber": "1********6"
}

# Invalid Payloads pour les tests négatifs
INVALID_FULFILLMENT_PAYLOAD = {
    "lineItems": [],
    "shippingCarrierCode": "",
    "trackingNumber": "",
    "shippedDate": "invalid-date"
}

# Headers requis selon la documentation
HEADERS = {
    "Authorization": f"Bearer {EBAY_OAUTH_TOKEN}",
    "Content-Type": "application/json",
    "Accept": "application/json",
    "X-EBAY-C-MARKETPLACE-ID": "EBAY_US"
}

# API Endpoints exacts selon la documentation
SHIPPING_FULFILLMENT_ENDPOINT = "/order/{orderId}/shipping_fulfillment"  # POST pour création
GET_FULFILLMENT_ENDPOINT = "/order/{orderId}/shipping_fulfillment/{fulfillmentId}"  # GET spécifique
GET_FULFILLMENTS_ENDPOINT = "/order/{orderId}/shipping_fulfillment"  # GET tous
