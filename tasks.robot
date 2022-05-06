*** Settings ***
Documentation     Template robot main suite.
...               Get Input from DataBase.
...               Data Scrapping from different ecommerce site.
...               Comparing results on excel.
...               Send result by email.
Library           RPA.Browser.Selenium    auto_close=${FALSE}
Library           Collections
Library           RPA.HTTP
Library           RPA.Excel.Files
Library           RPA.Tables
Library           RPA.Excel.Application
Library           RPA.Email.ImapSmtp
Library           RPA.Database
Library           RPA.Email.ImapSmtp    smtp_server=smtp.gmail.com    smtp_port=587

*** Variables ***
${URL-1}          https://www.amazon.in/
${URL-2}          https://www.flipkart.com/
${URL-3}          https://www.alibaba.com/
${Search}         realme narzo 50A
${USERNAME}       abagde61@gmail.com
${PASSWORD}       xxxx xxxx xxxx xxxx
${RECIPIENT}      abagde82@gmail.com

*** Tasks ***
Web scrapping from different ecommerce site.
    Create Excel File.
    Search Product Data from Amazon website.
    Search product data from flipkart website.
    Search product data from Alibaba website.
    Send Data File to the customer via emails.

*** Keywords ***
Create Excel File.
    Create Workbook    Data.xlsx
    ${Values}    Create List    Model Name    Memory Storage Capacity    Camera    Bettery    Processor    Price
    ${column}    Set Variable    ${1}
    FOR    ${n}    IN    @{Values}
        Set Cell Value    1    ${column}    ${n}
        ${column}    Set Variable    ${${column}+${1}}
    END
    Save Workbook

Search Product Data from Amazon website.
    Open Available Browser    ${URL-1}
    Maximize Browser Window
    Wait Until Element Is Enabled    xpath://*[@id="twotabsearchtextbox"]
    Input Text    xpath://*[@id="twotabsearchtextbox"]    ${Search}
    Click Button    xpath://*[@id="nav-search-submit-button"]
    Click Element When Visible    xpath://*[@id="search"]/div[1]/div[1]/div/span[3]/div[2]/div[6]/div/div/div/div/div/div[2]/div/div/div[1]/h2/a/span
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[1]
    ${Model Name1}=    Get Text    xpath://*[@id="productOverview_feature_div"]/div/table/tbody/tr[1]
    ${Memory Storage Capacity1}=    Get Text    xpath://*[@id="productOverview_feature_div"]/div/table/tbody/tr[5]
    ${Camera1}=    Get Text    xpath://*[@id="feature-bullets"]/ul/li[2]/span
    ${Battery1}=    Get Text    xpath://*[@id="feature-bullets"]/ul/li[3]/span
    ${Processor1}=    Get Text    xpath://*[@id="feature-bullets"]/ul/li[1]/span
    ${Price1}=    Get Text    xpath://*[@id="corePrice_desktop"]/div/table/tbody/tr[2]
    @{LIST1}=    Create list    ${Model Name1}    ${Memory Storage Capacity1}    ${Camera1}    ${Battery1}    ${Processor1}    ${Price1}
    Close Window
    RPA.Excel.Files.Open Workbook    Data.xlsx
    ${table}=    Read Worksheet As Table
    ${count_table}    Get Length    ${table}
    ${row}    Set Variable    ${${count_table}+${1}}
    ${column}    Set Variable    ${1}
    FOR    ${Values}    IN    @{LIST1}
        Set Cell Value    ${row}    ${column}    ${Values}
        ${column}    Set Variable    ${${column}+${1}}
        Log    ${Values}
    END
    Save Workbook
    Close Browser

Search product data from flipkart website.
    Open Available Browser    ${URL-2}
    Maximize Browser Window
    Click Button    xpath:/html/body/div[2]/div/div/button
    #Wait Until Element Is Enabled    xpath://*[@id="container"]/div/div[1]/div[1]/div[2]/div[2]/form/div/div
    Input Text    xpath://*[@id="container"]/div/div[1]/div[1]/div[2]/div[2]/form/div/div/input    ${Search}
    Click Button    xpath://*[@id="container"]/div/div[1]/div[1]/div[2]/div[2]/form/div/button
    Click Element When Visible    xpath://*[@id="container"]/div/div[3]/div[1]/div[2]/div[2]/div/div/div/a/div[2]/div[1]/div[1]
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[1]
    ${Model Name2}=    Get Text    xpath://*[@id="container"]/div/div[3]/div[1]/div[2]/div[2]/div/div[1]/h1/span
    ${Memory Storage Capacity2}=    Get Text    xpath://*[@id="container"]/div/div[3]/div[1]/div[2]/div[8]/div[1]/div/div[2]/ul/li[1]
    ${Camera2}=    Get Text    xpath://*[@id="container"]/div/div[3]/div[1]/div[2]/div[8]/div[1]/div/div[2]/ul/li[3]
    ${Battery2}=    Get Text    xpath://*[@id="container"]/div/div[3]/div[1]/div[2]/div[8]/div[1]/div/div[2]/ul/li[4]
    ${Processor2}=    Get Text    xpath://*[@id="container"]/div/div[3]/div[1]/div[2]/div[8]/div[1]/div/div[2]/ul/li[5]
    ${Price2}=    Get Text    xpath://*[@id="container"]/div/div[3]/div[1]/div[2]/div[2]/div/div[4]/div[1]/div
    @{list2}=    Create list    ${Model Name2}    ${Memory Storage Capacity2}    ${Camera2}    ${Battery2}    ${Processor2}    ${Price2}
    Close Window
    RPA.Excel.Files.Open Workbook    Data.xlsx
    ${table}=    Read Worksheet As Table
    ${count_table}    Get Length    ${table}
    ${row}    Set Variable    ${${count_table}+${1}}
    ${column}    Set Variable    ${1}
    FOR    ${Values}    IN    @{LIST2}
        Set Cell Value    ${row}    ${column}    ${Values}
        ${column}    Set Variable    ${${column}+${1}}
        Log    ${Values}
    END
    Save Workbook
    Close Browser

Search product data from Alibaba website.
    Open Available Browser    ${URL-3}
    Maximize Browser Window
    Click Button    xpath://*[@id="J_SC_header"]/header/div[2]/div[3]/div/div/form/div[2]/input
    #Wait Until Element Is Enabled    xpath://*[@id="container"]/div/div[1]/div[1]/div[2]/div[2]/form/div/div
    Input Text    xpath://*[@id="J_SC_header"]/header/div[2]/div[3]/div/div/form/div[2]/input    ${Search}
    Click Button    xpath://*[@id="J_SC_header"]/header/div[2]/div[3]/div/div/form/input[4]
    Click Element When Visible    xpath://*[@id="root"]/div/div[3]/div[2]/div/div/div/div[1]/div/div[2]/div[1]/h2/a
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[1]
    ${Model Name3}=    Get Text    xpath://*[@id="ali-anchor-AliPostDhMb-xv6ga"]/div[2]/table/tbody/tr[1]
    ${Memory Storage Capacity3}=    Get Text    xpath://*[@id="ali-anchor-AliPostDhMb-xv6ga"]/div[2]/table/tbody/tr[4]
    ${Camera3}=    Get Text    xpath://*[@id="ali-anchor-AliPostDhMb-xv6ga"]/div[2]/table/tbody/tr[6]
    ${Battery3}=    Get Text    xpath://*[@id="ali-anchor-AliPostDhMb-xv6ga"]/div[2]/table/tbody/tr[5]
    ${Processor3}=    Get Text    xpath://*[@id="ali-anchor-AliPostDhMb-xv6ga"]/div[2]/table/tbody/tr[7]
    ${Price3}=    Get Text    xpath://*[@id="module_price"]/div/div/div/span[1]/span
    @{list3}=    Create list    ${Model Name3}    ${Memory Storage Capacity3}    ${Camera3}    ${Battery3}    ${Processor3}    ${Price3}
    Close Window
    RPA.Excel.Files.Open Workbook    Data.xlsx
    ${table}=    Read Worksheet As Table
    ${count_table}    Get Length    ${table}
    ${row}    Set Variable    ${${count_table}+${1}}
    ${column}    Set Variable    ${1}
    FOR    ${Values}    IN    @{LIST3}
        Set Cell Value    ${row}    ${column}    ${Values}
        ${column}    Set Variable    ${${column}+${1}}
        Log    ${Values}
    END
    RPA.Excel.Application.Open Workbook    Data.xlsx
    Save Excel As    Data.xls    file_format=${56}
    Log    Data.xlsx
    Save Workbook
    Close Browser

Send Data File to the customer via emails.
    Authorize Smtp    account=${USERNAME}    password=${PASSWORD}    smtp_server=smtp.gmail.com    smtp_port=587
    Send Message    sender=${USERNAME}
    ...    recipients=${RECIPIENT}
    ...    subject=Regarding your request of eCommerce Data.
    ...    body=Dear Sir, Greetings from Xorion Technologies Pvt. Ltd.
    ...    attachments=Data.xlsx
