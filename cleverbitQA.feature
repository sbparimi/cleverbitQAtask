Feature: Currency converter UI 

    This feature verifies the currency converter UI elements 

    Scenario: Users should be able to convert the currencies 

        Given I enter the "amount to be converted" into the amount field 
        And  I select the Currency symbols in "From" and "To" dropdown lists
        When I Press Convert button for the first time
        Then I should see the full conversion amount for the value specified 
        And I should see the single conversion rate of single unit of From and To currencies

    Example:
            | amount to be converted | Source Currency | Target currency | Full conversion amount     | Source currency- single unit | Target currency - single unit |
            | 9 USD                  | USD             | EUR             | 7.924774 Euros             | 1 US Dollar=0.880530 EUR     | 1 Euros =1.13568 USD          |
            | 0.001 USD              | USD             | EUR             | 0.000                      | 1 US Dollar=0.880530 EUR     | 1 Euros =1.13568 USD          |
            | 0                      | USD             | EUR             | 0.00                       | 1 US Dollar=0.00 EUR         | 1 Euros =0.00 USD             |
            | 999,999,999,999,999    |                 | USD             | 880,424,355,099,999.10 EUR | 1 US Dollar= 0.880530 EUR    | 1 Euros =1.13568 USD          |
            | 1 USD                  | USD             | EUR             | 0.880530 Euros             | 1 US Dollar=0.880530 EUR     | 1 Euros = 1.13568 USD         |

   Scenario: The Amount field should not round off the value entered
        Given I enter the "amount to be converted" into the amount field 
        And  I select the Currency symbols in "From" and "To" dropdown lists
        When I Press Convert button for the first time
        Then I should see the value entered is as is in the amount field 
        
    Example:
            | amount to be converted  | Source Currency | Target currency | Full conversion amount         | Source currency- single unit   | Target currency - single unit |
            | 999,999,999,999,9999.00 | USD             | EUR             | 8,804,664,303,000,000.00 Euros | 1 US Dollar = 0.880466 EUR     | 1 Euros = 1.13576 USD         |
            | 999,999,999,999,999     | USD             | EUR             | 880,626,763,999,999.10 Euros   | 1 US Dollar= 0.880466 EUR      | 1 Euros = 1.13576 USD         |
            | 0.009                   | USD             | XBT             | 0.000000234724 XBT             | 1 US Dollar = 0.0000234977 XBT | 1 Bit coin =  42,557.4 USD    |

        Scenario: 

        Given I enter the "amount to be converted" into the amount field 
        And  I select the Currency symbol "XBT" in Source currency list
        And  I select the Currency symbol "USD" in target currency list
        When I Press Convert button for the first time
        Then I should see the valid conversion amount 


        Scenario Outline: Valid conversion should be displayed on changing the currency sybmbols in Source currency 
                """ The application is maintained at a state of displaying the full amount of convereted currency from soruce to target currency"""
            Background: The currency converter is already showing the full amount of currency converted from source to target currency

            When I change the "source currency" symbol
            And I do not change the "target currency "
            Then I should see the full amount of conversion from newly selected source currency to target currency
            And I should also see the single unit of newly selected source currenty and target currency 

    Example:
            | amount value entered | new source currecny | target currency | Full Conversion amount | Source Currency - single unit    | Target currency - single unit |
            | 0.009                | XBT                 | USD             | 425.6116 USD           | 1 Bit coin = 42,561.2 USD        | 1 USD = 0.0000234956 XBT      |
            | 1                    | INR                 | USD             | 0.01354202 USD         | 1 Indian Rupee  = 0.01354202 USD | 1 USD = 73.8388 INR           |


Scenario: Source currency dropdown should display most popular currencies and then all other currencies in alphabet order 

    Given I am on the currency converter page of the application 
    When I focus the cursor on the Source currency drop down 
    Then I should see the most popular currencies on top in the dropdown list 
    And I should see the other currencies after the popular currencies in the dropdownlist 
    And I should see the other currencies displayed in alphabet order 
    And I should see the obsolate currencies at the end of the dropdown list 


Scenario: Target currency dropdown should display most popular currencies and then all other currencies in alphabet order 

    Given I am on the currency converter page of the application 
    When I focus the cursor on the target currency drop down 
    Then I should see the most popular currencies on top in the dropdown list 
    And I should see the other currencies after the popular currencies in the dropdownlist 
    And I should see the other currencies displayed in alphabet order 
    And I should see the obsolate currencies at the end of the dropdown list

    Scenario:  Negative numeric values entered should be convereted to Positive numeric values before conversion 
        """ Assumption is when the user takes the focus out of the amount field, first, negative numeric"""
        When I enter the negative numeric values into amount field 
        And click anywhere out of the amount field 
        Then I should see the value convereted to Positive numeric values


    Scenario: Any non numeric values entered should be convereted to 1 and then convert 

        Given I entered the "non numeric value " into amount field 
        And select the source and target currency 
        Then I should see the currency conversion of 1 unit of source currency to target currency 
        Example:
            | NaN                     |
            | a'bcd                   |
            | Unicode chars           |
            | Crypto currency symbols |
            | 5e0                     |

Scenario Outline: User should be able to reverse the currency conversion using blue arrow button 
    Given I converted the currency from "source currency" to "target currencies" 
    When I click on the blue arrow button to reverse the currency conversion 
    Then I should see the "Source currency" becomes "target currecny "
    And I should see "target currency" becomes the "source currency "
    And the conversion is correctly displayed after reversal 

    Example:
            | Old source currency | Old target currency | new source currency | New target currecny | amount converted                      |
            | USD                 | EUR                 | EUR                 | USD                 | 1.00 Euros = 1.1359669 USD            |
            | EUR                 | VAL                 | VAL                 | EUR                 | 1.00 Vatican City Lira = 0.0005164569 |


Scenario Outline: The Page URI should correctly show the amount, source and target currencies 
    Given I select  the currency from "source" to "target" currency 
    And I enter the "amount" 
    When I convert the currency
    Then I should see Page URI contains "amount", "source" and "target" currencies 

    Example: 
            | amount  | source | target | Page URI parameters             |
            | 5       | USD    | EUR    | ?Amount=5&From=USD&To=EUR       |
            | 1       | XBT    | LUF    | ?Amount=5&From=XBT&To=LUF       |
            | 5e0     | XBT    | XBT    | ?Amount=5&From=XBT&To=XBT       |
            | -234    | USD    | EUR    | ?Amount=234&From=USD&To=EUR     |
            | NaN     | USD    | EUR    | ?Amount=1&From=USD&To=EUR       |
            | 999.99  | USD    | EUR    | ?Amount=999.99&From=USD&To=EUR  |
            | 0.01    | USD    | EUR    | ?Amount=0.01&From=USD&To=EUR    |
            | 0.00001 | USD    | EUR    | ?Amount=0.00001&From=USD&To=EUR |
            | 1       | LUF    | EUR    | ?Amount=1&From=LUF&To=EUR       |

Scenario Outline: The Page URI should correctly show the amount, source and target currencies , when reversed conversion happened
    Background: 
    Given I convereted the currencies from "old source" to "old target" currencies 
    When I reverse the currency conversion
    Then I should see Page URI contains "amount", "new source" and "new target" currencies 

    Example:
            | amount  | old source | old target | new source | new target | new page URI parameters         |
            | 5       | USD        | EUR        | EUR        | USD        | ?Amount=5&From=EUR&To=USD       |
            | 1       | XBT        | LUF        | LUF        | XBT        | ?Amount=5&From=LUF&To=XBT       |
            | 5e0     | XBT        | XBT        | XBT        | XBT        | ?Amount=5&From=XBT&To=XBT       |
            | -234    | USD        | EUR        | EUR        | USD        | ?Amount=234&From=EUR&To=USD     |
            | NaN     | USD        | EUR        | EUR        | USD        | ?Amount=1&From=EUR&To=USD       |
            | 999.99  | USD        | EUR        | EUR        | USD        | ?Amount=999.99&From=EUR&To=USD  |
            | 0.01    | USD        | EUR        | EUR        | USD        | ?Amount=0.01&From=EUR&To=USD    |
            | 0.00001 | USD        | EUR        | EUR        | USD        | ?Amount=0.00001&From=EUR&To=USD |
            | 1       | LUF        | EUR        | EUR        | LUF        | Amount=1&From=EUR&To=LUF        |


Scenario Outline: User should be able to access the conversion page directly using page URI 
Given the conversion page is available at "Base URL"
When I add the "query string paramters"
And hit enter 
Then I should see the conversion of currencies used in the query string parameters 

Example: 
            | Base URL                              | Query string parameters   | Is Conversion page accessible? |
            | https://www.xe.com/currencyconverter/ | ?Amount=5&From=EUR&To=USD | YES                            |
            | https://www.xe.com/currencyconverter/ | ?Amount=5;From=EUR;To=USD | YES                            |    // legal to separate query params by ;
            | https://www.xe.com/currencyconverter/ | ?Amount=1&From=EUR&To=LUF | YES                            |
            | http://www.xe.com/currencyconverter/  | ?Amount=5&From=EUR&To=USD | YES                            |
            | https://www.xe.com/currencyconverter/ | #Amount=1&From=EUR&To=LUF | NO                             |
            | https://www.xe.com/currencyconverter/ | ?1=Amount&From=EUR&To=LUF | NO                             |
         



Scenario:  Repalced currencies should be displayed on conversion 

""" When the currency is repalced with other currecy , that should be displayed when the user converts the currency  """
Given I select "obsolate currency" ( the currency that is repalced with new currency)
When I convert the currency 
Then I should see the information about the obsolate currency replaced with "new currency "

Example: 
            | obsolate currency | new currency |
            | LUF               | EUR          |
            | ITL               | EUR          |
            | ROL               | RON          |


Scenario: Display an error message when the user enters any amount that is rounded off to zero
    Given I enter the amount 0.00000001
    Then I should see the error message " Please enter the amount greater than zero"

Scenario: Conversion should automatically happen when user changes the currency in the source currency dropdown
    Given I enter the "amount"
    And I select source currecny 
    And I select the target currency 
    When I change the source currency to other currency 
    Then I should see the currency symbol in the amount field should reflect the newly selected source currency 
    And conversion of amount should be between the new source currency and target currency 
    And single units of currencies should also be changed 


Scenario: Conversion should automatically happen when user changes the currency in target currency dropdown
    Given I enter the "amount"
    And I select source currecny 
    And I select the target currency 
    When I change the target currency to other currency 
    Then I should see the currency symbol in the amount field should not change
    And conversion of amount should be between the source currency and newly selected target currency 
    And single units of currencies should also be changed 






    

        

    
            
            



