*** Settings ***
Library           Collections
Library           String

*** Variables ***
# Variables de test
${VALID_ORDER_ID}    6********5!2********1
${VALID_FULFILLMENT_ID}    1********6
${INVALID_ORDER_ID}    invalid-id
${INVALID_FULFILLMENT_ID}    invalid-fulfillment

# Headers pour les réponses simulées
&{LOCATION_HEADER}    Location=https://api.ebay.com/sell/fulfillment/v1/order/ID/fulfillment/123456789

*** Keywords ***
Create Valid Payload
    [Documentation]    Crée un payload valide
    &{line_item}=    Create Dictionary    lineItemId=6********1    quantity=1
    @{line_items}=    Create List    ${line_item}
    &{payload}=    Create Dictionary
    ...    lineItems=${line_items}
    ...    shippedDate=2025-08-01T10:00:00.000Z
    ...    shippingCarrierCode=USPS
    ...    trackingNumber=1********6
    RETURN    ${payload}

Create Invalid Payload
    [Documentation]    Crée un payload invalide
    @{empty_list}=    Create List
    &{payload}=    Create Dictionary
    ...    lineItems=${empty_list}
    ...    shippingCarrierCode=${EMPTY}
    ...    trackingNumber=${EMPTY}
    ...    shippedDate=invalid-date
    RETURN    ${payload}

Create Shipping Fulfillment
    [Arguments]    ${order_id}    ${payload}
    Log To Console    \nSimulating POST request to: /order/${order_id}/shipping_fulfillment
    Log To Console    \nPayload: ${payload}

    IF    '${order_id}' == '${INVALID_ORDER_ID}'
        &{response}=    Create Dictionary
        ...    status_code=400
        ...    ok=${TRUE}
        ...    text={"errors": [{"message": "Invalid Order Id"}]}
    ELSE IF    '${payload.shippedDate}' == 'invalid-date'
        &{response}=    Create Dictionary
        ...    status_code=400
        ...    ok=${TRUE}
        ...    text={"errors": [{"message": "Invalid request"}]}
    ELSE
        &{response}=    Create Dictionary
        ...    status_code=201
        ...    ok=${TRUE}
        ...    headers=${LOCATION_HEADER}
    END

    RETURN    ${response}

Get Shipping Fulfillment
    [Arguments]    ${order_id}    ${fulfillment_id}
    Log To Console    \nSimulating GET request to: /order/${order_id}/shipping_fulfillment/${fulfillment_id}

    IF    '${fulfillment_id}' == '${INVALID_FULFILLMENT_ID}'
        &{response}=    Create Dictionary
        ...    status_code=404
        ...    ok=${TRUE}
        ...    text={"errors": [{"message": "Not found"}]}
    ELSE
        &{response}=    Create Dictionary
        ...    status_code=200
        ...    ok=${TRUE}
        ...    text={"fulfillmentId": "${fulfillment_id}", "orderId": "${order_id}"}
    END

    RETURN    ${response}

Get Shipping Fulfillments
    [Arguments]    ${order_id}
    Log To Console    \nSimulating GET request to: /order/${order_id}/shipping_fulfillment

    IF    '${order_id}' == '${INVALID_ORDER_ID}'
        &{response}=    Create Dictionary
        ...    status_code=404
        ...    ok=${TRUE}
        ...    text={"errors": [{"message": "Not found"}]}
    ELSE
        &{response}=    Create Dictionary
        ...    status_code=200
        ...    ok=${TRUE}
        ...    text={"fulfillments": [{"fulfillmentId": "123456789", "orderId": "${order_id}"}]}
    END

    RETURN    ${response}

Verify Success Response
    [Arguments]    ${response}    ${expected_status}=200    ${check_location}=${FALSE}
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}
    Should Be True    ${response.ok}

    IF    ${check_location}
        Dictionary Should Contain Key    ${response.headers}    Location
    END

Verify Error Response
    [Arguments]    ${response}    ${expected_status}    ${expected_message}
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_message}
