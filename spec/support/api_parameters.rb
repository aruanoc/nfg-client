def create_cof_params
  {
    DonorIpAddress: '198.168.200.200',
    DonorToken: 'AIH3939',
    DonorFirstName: 'John',
    DonorLastName: 'Smith',
    DonorEmail: 'john@smith.com',
    DonorAddress1: '123 Address Way',
    DonorAddress2: '',
    DonorCity: 'Baltimore',
    DonorState: 'MD',
    DonorZip: '21210',
    DonorCountry: 'US',
    DonorPhone: '410-544-8778',
    CardType: 'Visa',
    NameOnCard: 'John Smith',
    CardNumber: '4111111111111111',
    ExpMonth: '12',
    ExpYear: '2016',
    CSC: '123'
  }
end

def delete_donor_cof_params
  {
    DonorToken: 'AIH3939',
    COFId: '1111111',
  }
end

def get_donation_report_params
  {
    StartDate: '2014-01-01 00:00:00',
    EndDate: '2014-01-01 12:00:00',
    DonationReportType: 'All'
  }
end

def get_donor_cofs_params
  {
    DonorToken: 'AIH3939',
  }
end

def get_donor_donation_history_params
  {
    DonorToken: 239949
  }
end

# default is NFG EIN
def get_fee_params(npo_ein = '68-0480736')
  {
    DonationLineItems: {
      DonationItem: {
        NpoEin: npo_ein,
        Designation: 'annual_fund',
        Dedication: 'For my grandfather',
        donorVis: 'ProvideAll',
        ItemAmount: 100.00,
        RecurType: 'NotRecurring',
        AddOrDeduct: 'Add',
        TransactionType: 'Donation'
      }
    },
    TipAmount: 1.00,
    CardType: 'Visa'
  }
end

def make_cof_donation_params(cof_id = '11111111')
  {
    DonationLineItems: {
      DonationItem: {
        NpoEin: '68-0480736',
        Designation: 'annual_fund',
        Dedication: 'For my grandfather',
        donorVis: 'ProvideAll',
        ItemAmount: 100.00,
        RecurType: 'NotRecurring',
        AddOrDeduct: 'Add',
        TransactionType: 'Donation'
      }
    },
    TotalAmount: 100.00,
    TipAmount: 3.00,
    PartnerTransactionIdentifier: 'my_order_id',
    DonorIpAddress: '198.168.200.200',
    DonorToken: 'AIH3939',
    COFId: cof_id
  }
end

def make_donation_add_cof_params(csc = '123')
  {
    DonationLineItems: {
      DonationItem: {
        NpoEin: '68-0480736',
        Designation: 'annual_fund',
        Dedication: 'For my grandfather',
        donorVis: 'ProvideAll',
        ItemAmount: 100.00,
        RecurType: 'NotRecurring',
        AddOrDeduct: 'Add',
        TransactionType: 'Donation'
      }
    },
    TotalAmount: 100.00,
    TipAmount: 3.00,
    PartnerTransactionIdentifier: 'my_order_id',
    DonorIpAddress: '198.168.200.200',
    DonorToken: donor_token,
    DonorFirstName: 'John',
    DonorLastName: 'Smith',
    DonorEmail: 'john@smith.com',
    DonorAddress1: '100 Address Way',
    DonorAddress2: '',
    DonorCity: 'Baltimore',
    DonorState: 'MD',
    DonorZip: '21210',
    DonorCountry: 'US',
    DonorPhone: '410-544-8778',
    CardType: 'Visa',
    NameOnCard: 'John Smith',
    CardNumber: '4111111111111111',
    ExpMonth: '12',
    ExpYear: '2015',
    CSC: csc
  }
end

def donor_token
  'NFG_' + Time.now.strftime("%Y-%m-%d-%H%M%S")
end