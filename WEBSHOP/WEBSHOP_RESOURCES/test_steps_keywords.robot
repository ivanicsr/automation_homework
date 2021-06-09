*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           String
Library           OperatingSystem
Library           DateTime
Library           Dialogs
Resource          locators.robot
Resource          helper_keywords.robot

*** Variables ***
${selenium_timeout}    30
${browser_download_dir}    C:\\ROBOT_TEMP\\

*** Keywords ***
Add Item To Cart
    [Arguments]    ${itemnum}
    UI Click    loc xpath    //li[contains(@class,'active')]//*[contains(.,'Popular')]
    UI Mouse Over    loc xpath    (//a[contains(@class,'product_img_link')])[${itemnum}]
    UI Wait Until Element Is Visible    loc xpath    (//a[contains(@title,'Add to cart')])[${itemnum}]
    UI Click    loc xpath    (//a[contains(@title,'Add to cart')])[${itemnum}]
    UI Wait Until Element Is Visible    loc xpath    (//div[contains(@class,'clearfix')]//*[contains(.,'Product successfully added to your shopping cart')])[2]
    UI Click    loc xpath    //span[contains(@class,'cross')]
    UI Wait Until Element Is Visible    loc xpath    //li[contains(@class,'active')]//*[contains(.,'Popular')]
