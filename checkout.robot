*** Settings ***

Library  SeleniumLibrary

*** Variables ***

${URL}  https://www.saucedemo.com/
${Browser}   Chrome

*** Test Cases ***
Valid Login

    Open Browser   ${URL}  ${Browser}

    Maximize Browser Window

    Set Selenium Speed    2s


    Input Text    xpath=//input[@id="user-name"]   standard_user


    Input Text    xpath=//input[@id="password"]    secret_sauce

    Click Button    xpath=//input[@type="submit"]

    Click Button    xpath=//button[@id="add-to-cart-sauce-labs-backpack"]

    Click Link    xpath=//a[@class="shopping_cart_link"]

    Click Button    xpath=//button[@id="checkout"]

    Input Text    xpath=//input[@id="first-name"]    amyma
    
    Input Text    xpath=//input[@id="last-name"]    usman

    Input Text    xpath=//input[@id="postal-code"]    23456

    Click Button    xpath=//input[@id="continue"]

    Click Button    xpath=//button[@id="finish"]
    
    Sleep    10s
    
    Wait Until Element Is Visible    xpath=//img[@class="pony_express"]

  


    Close Browser


