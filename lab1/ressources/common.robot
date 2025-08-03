*** Settings ***
Library    ../ressources/mongodb_library.py

*** Variables ***
# Product test data
${VALID_PRODUCT}       {"title": "Samsung S24", "price": 899.99, "description": "Latest smartphone", "category": "phones", "image": "http://example.com/s24.jpg"}
${INVALID_PRODUCT}     {"price": 899.99, "category": "phones"}
${BAD_TYPE_PRODUCT}    {"title": "Test", "price": "invalid", "description": "Bad price type", "category": "test", "image": "test.jpg"}

# User test data
${VALID_USER}         {"email": "test@example.com", "username": "testuser", "password": "password123"}
${INVALID_USER}       {"username": "testuser", "password": "password123"}
${BAD_TYPE_USER}      {"email": "invalid-email", "username": "testuser", "password": "password123"}

# Category test data
${VALID_CATEGORY}     {"name": "TestCategory1", "description": "Test description"}
${INVALID_CATEGORY}   {"description": "Missing name"}
${DUPLICATE_CATEGORY}    {"name": "TestCategory1", "description": "Duplicate test"}

# Order test data
${VALID_ORDER}        {"product_id": "123", "user_id": "456", "quantity": 1}
${INVALID_ORDER}      {"user_id": "456"}
${BAD_TYPE_ORDER}     {"product_id": "123", "user_id": "456", "quantity": "invalid"}
