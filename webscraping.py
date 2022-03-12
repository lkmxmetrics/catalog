# Import the dependencies
import requests
import pandas as pd
from bs4 import BeautifulSoup

## set up base url 
base_url = 'https://www.mtggoldfish.com/index/{}#paper'
res = requests.get(base_url.format('DOM'))
soup = BeautifulSoup(res.text, 'lxml')

## strats?
full_list = []
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

## isolate the attributes 
card_name = parse_list[0][1:]
card_set = parse_list[1][1:]
card_rarity = parse_list[2][1:]
card_price = parse_list[3][1:]

# all attributes, with columns specified for dataframe
df = pd.DataFrame(list(
  zip(
    card_name, 
    card_set,
    card_rarity,
    card_price
    )),
  columns =[
    'Name', 
    'Set',
    'Rarity',
    'Price'
    ])

df.to_csv(r'domscrape.csv',index=False, header=True)

df