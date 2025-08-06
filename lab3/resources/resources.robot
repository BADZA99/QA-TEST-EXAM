*** Settings ***
Library    RequestsLibrary
Library    Collections
Variables    ../pageObject/variables.py

*** Keywords ***
Create Session To Ebay API
    [Documentation]    Create a session to the eBay API with the base URL and headers
    Create Session    ebay    ${BASE_URL}    ${HEADERS}    verify=false

#Scenarios pour getShippingFulfillment
Get Shipping Fulfillment Pass
    [Documentation]    Get the shipping fulfillment details from eBay API (successful case)
    TRY
        ${response}=    GET On Session    ebay    /sell/fulfillment/v1/order/${ORDER_ID}/shipping_fulfillment/${FULFILLMENT_ID}
        Should Be Equal As Integers    ${response.status_code}    200
        Log To Console    ${response.json()}
        RETURN    ${response}
    EXCEPT    HTTPError    AS    ${error}
        FAIL    ${error}
    END

Get Shipping Fulfillment No Pass
    [Documentation]    Get the shipping fulfillment details from eBay API (unsuccessful case)
    ${response}=    GET On Session    ebay    /sell/fulfillment/v1/order/${WRONG_ORDER_ID}/shipping_fulfillment/${WRONG_FULFILLMENT_ID}    expected_status=400
    Should Be Equal As Integers    ${response.status_code}    400
    ${error_json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${error_json}    errors
    RETURN    ${response}

#getShippingFulfillments
Get Shipping Fulfilments Pass
    [Documentation]    Get all shipping fulfillments from eBay API (successful case)
    ${response}=    GET On Session    ebay    /sell/fulfillment/v1/order/${ORDER_ID}/shipping_fulfillment
    Should Be Equal As Integers    ${response.status_code}    200
    RETURN    ${response}

Get Shipping Fulfilments No Pass
    [Documentation]    Get all shipping fulfillments from eBay API (unsuccessful case)
    ${response}=    GET On Session    ebay    /sell/fulfillment/v1/order/${WRONG_ORDER_ID}/shipping_fulfillment    expected_status=400
    Should Be Equal As Integers    ${response.status_code}    400
    ${error_json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${error_json}    errors
    RETURN    ${response}

# createShippingFulfillment
Create Shipping Fulfillment Pass
    [Documentation]    Create a shipping fulfillment in eBay API (successful case)
    ${response}=    POST On Session    ebay    /sell/fulfillment/v1/order/${ORDER_ID}/shipping_fulfillment    json=${REQUEST_BODY}
    Should Be Equal As Integers    ${response.status_code}    201
    RETURN    ${response}

Create Shipping Fulfillment No Pass
    [Documentation]    Create a shipping fulfillment in eBay API (unsuccessful case)
    ${response}=    POST On Session    ebay    /sell/fulfillment/v1/order/${WRONG_ORDER_ID}/shipping_fulfillment    json=${REQUEST_BODY}    expected_status=400
    Should Be Equal As Integers    ${response.status_code}    400
    ${error_json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${error_json}    errors
    RETURN    ${response}

# Added a keyword to create a shipping fulfillment and log the response
# Create Shipping Fulfillment And Log ID
#     [Documentation]    Create a shipping fulfillment in eBay API and log the ID
#     TRY
#         ${response}=    POST On Session    ebay    /sell/fulfillment/v1/order/${ORDER_ID}/shipping_fulfillment    json=${REQUEST_BODY}
#         Should Be Equal As Integers    ${response.status_code}    201
#         ${response_json}=    Set Variable    ${response.json()}
#         Log To Console    \nResponse Details:
#         Log To Console    Status Code: ${response.status_code}
#         RETURN    ${response}
#     EXCEPT    HTTPError    AS    ${error}
#         Log To Console    \nError Details:
#         Log To Console    Status Code: ${error.response.status_code}
#     END

# #validation communes

Validate Response Status
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}

Validate Response Contains
    [Arguments]    ${response}    ${key}
    Dictionary Should Contain Key    ${response.json()}    ${key}
