*** Settings ***
Library           Collections

*** Keywords ***
loc element by id
    [Arguments]    ${id}    ${is_strict}=1
    ${loc}    Set Variable If    ${is_strict}==1    id=${id}    //*[contains(@id,'${id}')]
    [Return]    ${loc}

loc xpath
    [Arguments]    ${xpath}
    ${loc}    Set Variable    ${xpath}
    [Return]    ${loc}

loc button by name
    [Arguments]    ${name}
    ${loc}    Set Variable    //button[@name='${name}']
    [Return]    ${loc}
