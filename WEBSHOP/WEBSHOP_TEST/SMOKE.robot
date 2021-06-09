*** Settings ***
Resource          ../WEBSHOP_RESOURCES/helper_keywords.robot
Resource          ../WEBSHOP_RESOURCES/locators.robot
Resource          ../WEBSHOP_RESOURCES/test_steps_keywords.robot

*** Test Cases ***
SUCCESSFUL_REGISTRATION
    [Documentation]    - User is able to start registration from the ‘Sign in’ link in
    ...    the header of the home page
    ...
    ...    - User is logged in after successful registration
    ...
    ...    - User is located on the ‘My Account’ page after successful
    ...    registration
    UI Open Chrome Browser    http://www.automationpractice.com
    UI Click    loc xpath    //div[@class='header_user_info']
    UI Input Text    nikrobert12@gmail.com    loc element by id    email_create
    Ui Click    loc element by id    SubmitCreate
    Ui Click    loc element by id    id_gender1
    UI Input Text    ivanics    loc element by id    customer_firstname
    UI Input Text    robert    loc element by id    customer_lastname
    UI Input Text    q1w2e3r4t5    loc element by id    passwd
    UI Input Text    szodd matyas kiraly u    loc element by id    address1
    UI Input Text    szod    loc element by id    city
    UI Input Text    21342    loc element by id    postcode
    UI Input Text    +36302547737    loc element by id    phone_mobile
    UI Click    loc element by id    uniform-days
    Sleep    1
    Press Keys    \    6
    Sleep    1
    Press Keys    \    RETURN
    Sleep    1
    UI Click    loc element by id    uniform-months
    Sleep    1
    Press Keys    \    F
    Sleep    1
    Press Keys    \    RETURN
    Sleep    1
    UI Click    loc element by id    uniform-years
    Press Keys    \    6
    Sleep    1
    Press Keys    \    ARROW_DOWN
    Press Keys    \    ARROW_DOWN
    Press Keys    \    ARROW_DOWN
    Press Keys    \    ARROW_DOWN
    Press Keys    \    RETURN
    Sleep    1
    UI Click    loc element by id    uniform-id_state
    Sleep    1
    Press Keys    \    ARROW_DOWN
    Sleep    1
    Press Keys    \    RETURN
    UI Click    loc element by id    uniform-id_country
    Sleep    1
    Press Keys    \    ARROW_DOWN
    Sleep    1
    Press Keys    \    RETURN
    UI Click    loc element by id    submitAccount
    UI Click    loc xpath    //div[contains(@id,'center_column')]//*[contains(.,'My account')]

SEARCHING FOR PRODUCTS
    [Documentation]    - User is able to search for products from the search bar on
    ...    the home page
    ...
    ...    - User only sees items that match the entered search term
    ...    (use the word `Printed` as a search term for simplicity)
    UI Open Chrome Browser    http://www.automationpractice.com
    UI Click    loc element by id    search_query_top
    UI Input Text    Printed    loc element by id    search_query_top
    UI Click    loc button by name    submit_search
    UI Click    loc xpath    //div[contains(@class,'product-container')]//*[contains(.,'Printed')]

ADD PRODUCTS TO CART FROM POPULAR TAB ON HOME PAGE
    [Documentation]    - User is able to add multiple items to the cart from the
    ...    Popular tab on the Home Page
    ...    - User sees message that the item has been successfully
    ...    added to the cart
    ...    - User sees product count updating in the cart on the
    ...    Home Page
    ...    - Upon navigating to the cart user sees the same items in
    ...    the cart that were previously added
    ...    - User sees the same quantity of items that were previously
    ...    added
    ...    - User sees the same price of items that were previously
    ...    added
    UI Open Chrome Browser    http://www.automationpractice.com
    Add Item To Cart    2
    UI Mouse Over    loc xpath    (//a[contains(@class,'product_img_link')])[2]
    UI Click    loc xpath    (//span[contains(.,'More')])[2]
    ${itemprice_1}    UI Get Text    loc element by id    our_price_display
    ${itemname_1}    UI Get Text    loc xpath    //h1[contains(@itemprop,'name')]
    UI Click    loc element by id    header_logo
    log    ${itemname_1}
    log    ${itemprice_1}
    Add Item To Cart    3
    UI Mouse Over    loc xpath    (//a[contains(@class,'product_img_link')])[3]
    UI Click    loc xpath    (//span[contains(.,'More')])[3]
    ${itemprice_2}    UI Get Text    loc element by id    our_price_display
    ${itemname_2}    UI Get Text    loc xpath    //h1[contains(@itemprop,'name')]
    UI Click    loc element by id    header_logo
    UI Wait Until Element Is Visible    loc xpath    //div[contains(@class,'shopping_cart')]//*[.='2']
    UI Mouse Over    loc xpath    //a[contains(@title,'View my shopping cart')]
    UI Wait Until Element Is Visible    loc xpath    //span[contains(text(),'${itemprice_1}')]
    UI Wait Until Element Is Visible    loc xpath    //span[contains(text(),'${itemprice_2}')]
    UI Wait Until Element Is Visible    loc xpath    //a[contains(text(),'${itemname_1}') and @class='cart_block_product_name']
    UI Wait Until Element Is Visible    loc xpath    //a[contains(text(),'${itemname_2}') and @class='cart_block_product_name']
    Close Browser

DELETE PRODUCTS FROM CART
    [Documentation]    - User is able to delete items from the cart
    ...    - User sees the TOTAL price amount decreasing
    ...    - The reduction equals the price amount of the item that
    ...    has been deleted
    ...    - Whenever the last item is removed from the cart the page
    ...    states that the shopping cart is empty
    UI Open Chrome Browser    http://www.automationpractice.com
    Add Item To Cart    2
    Add Item To Cart    3
    UI Mouse Over    loc xpath    //a[contains(@title,'View my shopping cart')]
    ${second_item_price}    UI Get Text    loc xpath    (//span[contains(@class,'price')])[2]
    ${total_price}    UI Get Text    loc xpath    //span[contains(@class,'price cart_block_total ajax_block_cart_total')]
    UI Click    loc xpath    (//span[@class='remove_link'])[2]
    UI Wait Until Element Is Not Visible    loc xpath    (//span[@class='remove_link'])[2]
    ${total_price_dec}    UI Get Text    loc xpath    //span[contains(@class,'price cart_block_total ajax_block_cart_total')]
    Should Not Be Equal    ${total_price_dec}    ${total_price}
    ${first_total_price}    String.Get Substring    ${total_price}    1    3
    ${second_total_price}    String.Get Substring    ${total_price_dec}    1    3
    ${second_item_price}    String.Get Substring    ${second_item_price}    1    3
    ${first_total_price}    Convert To Integer    ${first_total_price}
    ${second_total_price}    Convert To Integer    ${second_total_price}
    ${second_item_price}    Convert To Integer    ${second_item_price}
    ${result}    Evaluate    ${first_total_price}-${second_item_price}
    Run Keyword If    ${result}!=${second_total_price}    Fail    Amount not decreasing correctly
    UI Click    loc xpath    (//span[@class='remove_link'])[1]
    UI Wait Until Element Is Visible    loc xpath    //div[contains(@class,'shopping_cart')]//*[.='(empty)']
