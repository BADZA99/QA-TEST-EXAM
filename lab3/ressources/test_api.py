import requests
import json

# Configuration from variable.py
EBAY_OAUTH_TOKEN = "v^1.1#i^1#I^3#f^0#r^0#p^3#t^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"

BASE_URL = "https://api.sandbox.ebay.com/sell/fulfillment/v1"

# Headers configuration
headers = {
    "Authorization": f"Bearer {EBAY_OAUTH_TOKEN}",
    "Content-Type": "application/json",
    "Accept": "application/json",
    "X-EBAY-C-MARKETPLACE-ID": "EBAY_US"
}

# Test data
order_id = "11-07783-52435"
payload = {
    "lineItems": [
        {
            "lineItemId": "1234",
            "quantity": 1
        }
    ],
    "shippingCarrierCode": "USPS",
    "trackingNumber": "1234567890",
    "shippedDate": "2025-08-01T10:00:00.000Z"
}

def test_get_order():
    """Test getting the order details"""
    url = f"{BASE_URL}/order/{order_id}"
    print(f"\nTesting GET order {order_id}...")
    response = requests.get(url, headers=headers)
    print(f"Status code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2)}")
    return response.status_code == 200

def test_create_fulfillment():
    """Test creating a fulfillment"""
    url = f"{BASE_URL}/order/{order_id}/shipping_fulfillment"
    print(f"\nTesting POST fulfillment for order {order_id}...")
    response = requests.post(url, headers=headers, json=payload)
    print(f"Status code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2) if response.content else 'No content'}")
    return response.status_code in [200, 201]

if __name__ == "__main__":
    print("Testing eBay Fulfillment API...")
    if test_get_order():
        print("\nOrder exists, trying to create fulfillment...")
        if test_create_fulfillment():
            print("\nSuccess! Fulfillment created.")
        else:
            print("\nFailed to create fulfillment.")
    else:
        print("\nFailed to get order. Make sure the order ID exists.")
