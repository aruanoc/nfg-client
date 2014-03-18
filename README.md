# NFG Client

A client to interact with the NFG (Network for Good) API via SOAP requests.

## Installation

Install the gem:

    gem install nfg-client

Or add it to your Gemfile:

    gem "nfg-client"

## Usage

Create a NFG Client instance using your NFG credentials:

    nfg_client = NFGClient.new(partner_id, partner_password, partner_source, partner_campaign, use_sandbox)

The fifth parameter is optional (defaults to false), and indicates the Client which API URLs to use (sandbox or production).

Use the Client to make calls to the NFG API, each call will take a hash with the parameters you want to send along with it (apart from the NFG credentials).

Example:

    nfg_client.get_donor_cofs({"DonorToken" => donor_token})
    
All required parameters for the different calls should have the name specified by the NFG documentation.

For more information, refer to the official NFG documentation:

http://www.thenetworkforgood.org/t5/Developer-Resource-Center/ct-p/Developer

## Supported Calls

Below, the list of supported calls and examples of usage. All functions return a hash with the response from NFG.

### CreateCOF

Creates a Card on File without a transaction.

**_Call_**

    response = nfg_client.create_cof({
        "DonorToken" => "",
        "DonorFirstName" => "",
        "DonorLastName" => "",
        "DonorEmail" => "",
        "DonorAddress1" => "",
        "DonorAddress2" => "",
        "DonorCity" => "",
        "DonorState" => "",
        "DonorZip" => "",
        "DonorCountry" => "",
        "DonorPhone" => "",
        "CardType" => "", # Unk, Visa, Mastercard, Amex or Discover
        "NameOnCard" => "",
        "CardNumber" => "",
        "ExpMonth" => "",
        "ExpYear" => "",
        "CSC" => ""
    })

**_Response on Success_**

    {
        "StatusCode" => "Success", 
        "Message" => "", # Empty
        "ErrorDetails" => "", # Empty
        "CallDuration" => "x.x", 
        "DonorToken" => "x", 
        "COFId" => "x" # Integer
    }
    
### GetDonorCOFs

Gets a list of donor Cards on File.

**_Call_**

    response = nfg_client.get_donor_cofs({
        "DonorToken" => ""
    })

**_Response on Success_**

    {
        "StatusCode" => "Success", 
        "Message" => "", # Empty
        "ErrorDetails" => "", # Empty
        "CallDuration" => "x.x", 
        "DonorToken" => "x", 
        "Cards" => [
            {
                "COFId" => "x", # Integer 
                "CardType" => "x", # e.g. Mastercard 
                "CCSuffix" => "xxxx", # Last four digits 
                "CCExpMonth" => "", # 1 or 2 digits 
                "CCExpYear" => "", # 4 digits
                "bInUseByLiveRD" => "", # true or false 
                "COFEmailAddress" => ""
            },
            ...
        ]
    }
    
### DeleteDonorCOF

Removes an existing Card on File.

**_Call_**

    response = nfg_client.delete_donor_cof({
        "DonorToken" => "",
        "COFId" => ""
    })

**_Response on Success_**

    {
        "StatusCode" => "Success", 
        "Message" => "", # Empty
        "ErrorDetails" => "", # Empty
        "CallDuration" => "x.xx"
    }
    
### MakeCOFDonation

Triggers a one-time or recurring donation to one or more charities with an existing Card on File.

**_Call_**

    response = nfg_client.make_cof_donation({
        "DonationLineItems" => {
            "DonationItem1" => {
                "NpoEin" => "",
                "donorVis" => "", # ProvideAll, ProvideNameAndEmailOnly or Anonymous
                "ItemAmount" => "",
                "RecurType" => "", # NotRecurring, Monthly, Quarterly or Annually
                "Designation" => ""
                "Dedication" => ""
            },
            "DonationItem2" => {
                ...
            },
            ...
        },
        "TotalAmount" => "",
        "TipAmount" => "",
        "DonorIpAddress" => "",
        "DonorToken" => "",
        "COFId" => ""
    })

**_Response on Success_**

    {
        "StatusCode" => "Success", 
        "Message" => "", # Empty
        "ErrorDetails" => "", # Empty
        "CallDuration" => "x.x", 
        "ChargeId" => "x",  # Integer
        "COFId" => "0"
    }
    
### MakeDonationAddCOF

Triggers a one-time or recurring donation to one or more charities with a new Card on File.

**_Call_**

    response = nfg_client.make_donation_add_cof({
        "DonationLineItems" => {
            "DonationItem1" => {
                "NpoEin" => "",
                "donorVis" => "", # ProvideAll, ProvideNameAndEmailOnly or Anonymous
                "ItemAmount" => "",
                "RecurType" => "", # NotRecurring, Monthly, Quarterly or Annually
                "Designation" => ""
                "Dedication" => ""
            },
            "DonationItem2" => {
                ...
            },
            ...
        },
        "TotalAmount" => "",
        "TipAmount" => "",
        "DonorIpAddress" => "",
        "DonorToken" => "",
        "COFId" => "",
        "DonorFirstName" => "",
        "DonorLastName" => "",
        "DonorEmail" => "",
        "DonorAddress1" => "",
        "DonorAddress2" => "",
        "DonorCity" => "",
        "DonorState" => "",
        "DonorZip" => "",
        "DonorCountry" => "",
        "DonorPhone" => "",
        "CardType" => "", # Unk, Visa, Mastercard, Amex or Discover
        "NameOnCard" => "",
        "CardNumber" => "",
        "ExpMonth" => "",
        "ExpYear" => "",
        "CSC" => ""
    })

**_Response on Success_**

    {
        "StatusCode" => "Success", 
        "Message" => "", # Empty
        "ErrorDetails" => "", # Empty
        "CallDuration" => "x.x", 
        "ChargeId" => "x",  # Integer
        "COFId" => "0"
    }
    
### GetFee

Calculates the fee for a transaction that would ultimately be used with payment functions.

**_Call_**

    response = nfg_client.get_fee({
        "DonationLineItems" => {
            "DonationItem1" => {
                "NpoEin" => "",
                "donorVis" => "", # ProvideAll, ProvideNameAndEmailOnly or Anonymous
                "ItemAmount" => "",
                "RecurType" => "", # NotRecurring, Monthly, Quarterly or Annually
                "Designation" => ""
                "Dedication" => ""
            },
            "DonationItem2" => {
                ...
            },
            ...
        },
        "TipAmount" => "",
        "CardType" => ""
    })

**_Response on Success_**

    {
        "Message" => "", # Empty
        "ErrorDetails" => "", # Empty
        "CallDuration" => "x.x", 
        "TotalChargeAmount" => "x.x", 
        "TotalAddFee" => "x.x", 
        "TotalDeductFee" => "x.x",
        "TipAmount" => "x.x"
     }
    
### GetDonorDonationHistory

Gets donor transactions.

**_Call_**

    response = nfg_client.get_donor_donation_history({
        "DonorToken" => ""
    })

**_Response on Success_**

    {
        "StatusCode" => "Success", 
        "Message" => "", # Empty
        "ErrorDetails" => "", # Empty
        "CallDuration" => "x.x", 
        "DonorToken" => "x", 
        "Donations"=>[
            {
                "DonationDate" => "xxxx-xx-xxTxx:xx:xx.xx", 
                "RecurType" => "x", # e.g. NotRecurring 
                "IsTpcAddOnFee" => "", # true or false 
                "NpoName" => "", # e.g. Smithsonian Institution 
                "Designation" => "", 
                "Dedication" => "", 
                "Amount" => "x.x", 
                "ChargeId" => "x" # Integer
            },
            ...
        ]
    }

### GetDonationReport

Returns a report of partner transactions during a specific period of time.

**_Call_**

    response = nfg_client.get_donation_report({
        "StartDate" => "",
        "EndDate" => "",
        "DonationReportType" => "" # All, OneTime or Recurring
    })

**_Response on Success_**

    {
        "StatusCode" => "Success", 
        "Message" => "", # Empty
        "ErrorDetails" => "", # Empty
        "CallDuration" => "x.x", 
        "ReturnCount" => "x", 
        "ReportResults"=>[
            {
                "Source" => "x", 
                "Campaign" => "x", 
                "ChargeId" => "x", # Integer 
                "ShareWithCharity" => "x", # e.g. No Donor Info - Anonymous
                "DonorEmail" => "x", 
                "DonorFirstName" => "x",
                "DonorLastName" => "x", 
                "DonorAddress1" => "x", 
                "DonorAddress2" => "x", 
                "DonorCity" => "x", 
                "DonorState" => "x", 
                "DonorZip" => "x", 
                "DonorCountry" => "x", 
                "DonorPhone" => "x", 
                "Designation" => "", 
                "DonateInName" => "", 
                "RecurringPeriod" => "", 
                "EventDate" => "xxxx-xx-xxTxx:xx:xx.xxxZ", 
                "NpoEIN" => "x", 
                "NpoName" => "x", 
                "ChargeStatus" => "", # e.g. CS_SUCCESS 
                "ChargeAmount" => "x.x", 
                "NpoTPC" => "x.x", 
                "DonationItemAmount" => "x.x", 
                "TotalDonationAmount" => "x.x", 
                "HistoryRecordId" => "x"
            },
            ...
        ]
    }

## Failed calls

When a call fails (i.e. the "StatusCode" is different than "Success"), it's usually possible to find out more about the error looking at the "Message" and "ErrorDetails" fields. "Message" is a string, while "ErrorDetails" is a hash with the following format:

    {
            "StatusCode" => "Other", 
            "Message" => "x",
            "ErrorDetails" => {
                "ErrorInfo"=>{
                    "ErrCode" => "x", 
                    "ErrData" => "x"
                }
            }
            "CallDuration" => "x.x",
            ...
    }
