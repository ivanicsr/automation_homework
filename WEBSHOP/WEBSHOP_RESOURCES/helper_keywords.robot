*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           String
Library           OperatingSystem
Library           DateTime
Library           Dialogs
Resource          locators.robot

*** Variables ***
${selenium_timeout}    30
${browser_download_dir}    C:\\ROBOT_TEMP\\

*** Keywords ***
UI Click
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}
    Scroll Element Into View    ${result}
    Wait Until Keyword Succeeds    5x    500ms    Click Element    ${result}

UI Input Text
    [Arguments]    ${text}    ${locator}    @{keywordargs}
    ${result}    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}
    Scroll Element Into View    ${result}
    Clear Element Text    ${result}
    Input Text    ${result}    ${text}

UI Open Chrome Browser
    [Arguments]    ${url}
    Close All Browsers
    ${chromeoptions}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs}    Create Dictionary    download.default_directory=${browser_download_dir}
    Call Method    ${chromeoptions}    add_experimental_option    prefs    ${prefs}
    ${webdriver_created}    Run Keyword And Return Status    Create Webdriver    Chrome    chrome_options=${chromeoptions}
    ${actual_webdriver}    Run Keyword Unless    ${webdriver_created}    Create Webdriver    Chrome    chrome_options=${chromeoptions}
    Set Window Size    1280    720
    Go To    ${url}

UI Press Enter
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Press Keys    ${result}    RETURN

UI Mouse Over
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Page Contains Element    ${result}    ${selenium_timeout}
    Wait Until Element Is Visible    ${result}
    Scroll Element Into View    ${result}
    Set Focus To Element    ${result}
    Scroll Element Into View    ${result}
    Mouse Over    ${result}

UI Wait Until Element Is Visible
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}

UI Get Text
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Visible    ${result}    ${selenium_timeout}
    ${text}    Set Variable    ${EMPTY}
    FOR    ${loopvar}    IN RANGE    1    99999
        sleep    300ms
        ${text}    Get Text    ${result}
        Exit For Loop If    '${text}'!='${EMPTY}' or ${loopvar}==50
    END
    Run Keyword If    '${text}'=='${EMPTY}'    FAIL    Getting text is not possible in 15s
    [Return]    ${text}

UI Wait Until Element Is Not Visible
    [Arguments]    ${locator}    @{keywordargs}
    ${result}=    Run Keyword    ${locator}    @{keywordargs}
    Wait Until Element Is Not Visible    ${result}    ${selenium_timeout}
