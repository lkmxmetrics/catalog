# Import the dependencies
import requests
import pandas as pd
from bs4 import BeautifulSoup

# list of active sets (owned)
set_listx = ['WWK', 'RNA', 'IMA', 'KTK', 'M19', 'THB', 'GTC', 'GRN',
    'DOM', 'SHM', 'UMA', 'KLD', 'ARB', 'MM3', 'MRD', 'WAR', 'DKA',
    'XLN', 'CON', 'AER', 'MH1', 'RTR', 'M13', 'C18', '7E', 'EMN', 
    'ISD', 'NPH', 'MBS', 'SOI', 'AVR', 'EMA','M11', 'C13', 
    'SOM', 'IN', 'ELD', 'ONS', 'DDP', 'MMA', 'FRF', 'RAV', 
    'CNS', 'AKH', 'THS', 'BFZ', 'M20']
set_list = ['WWK', 'RNA', 'IMA', 'KTK', 'M19', 'THB']

## set up base url 
full_list = []
for _ in set_list:
    base_url = 'https://www.mtggoldfish.com/index/{}#paper'
    res = requests.get(base_url.format(_))
    soup = BeautifulSoup(res.text, 'lxml') 
    for row in soup.select('tr'):
        cols = row.findAll('td')
        cols = [element.text.strip() for element in cols]
        for col in cols:
            full_list.append(col)

# separate columns
parse_list = []
K = 8
for i in range(0,K):
    parse_list.append(full_list[i::K])

## isolate the columns 
card_name = parse_list[0]
card_set = parse_list[1]
card_rarity = parse_list[2]
card_price = parse_list[3]
x1 = parse_list[4][:]
x2 = parse_list[5][:]
x3 = parse_list[6][:]
x4 = parse_list[7][:]

# all attributes, with columns specified for dataframe
dict = {
  'Name': card_name, 
  'Price': card_price, 
  'Set': card_set, 
  'Rarity': card_rarity, 
  'x1': x1, 
  'x2': x2, 
  'x3': x3, 
  'x4': x4
  }
df = pd.DataFrame(dict)

# remove special characters
df.Name = df.Name.str.replace("[!@#$%^&*,/'-]", '')
df.Price = df.Price.str.replace("[!@#$%^&*,/'-]", '')
df.Set = df.Set.str.replace("[!@#$%^&*,/'-]", '')
df.Rarity = df.Rarity.str.replace("[!@#$%^&*,/'-]", '')

# csv formating
df.to_csv(r'fulllist.csv',index=False, header=True)
df
