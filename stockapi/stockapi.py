import requests
import json
from firebase import Firebase
from time import sleep
from tqdm import tqdm


def get_symbols():    
    # api for ticker data to fetch symbols
    URL = "http://api.marketstack.com/v1/tickers?access_key=ff8dec439aaa43bbcc5120cd6ebf2310"
    r = requests.get(url = URL) 
    data_t = r.json()
    
    # list for storing stock symbols 
    stock_symbols = []
    for i in range(len(data_t['data'])):
        stock_symbols.append(data_t['data'][i]['symbol'])
    return stock_symbols
        
def get_stock(symbol):
    
        # api for intraday stock data
        URL = f"http://api.marketstack.com/v1/intraday?access_key=ff8dec439aaa43bbcc5120cd6ebf2310&symbols={symbol}"
        r = requests.get(url = URL) 
        data = r.json()
        
        # Creating Dictionary of the data
        d = dict()
        d['symbol'] = data['data'][0]['symbol']
        d['open'] = data['data'][0]['open']
        
        # Getting percentage up or down value of the stock
        newprice = data['data'][0]['open']
        oldprice = data['data'][2]['open']
        percentage = 100 * (newprice - oldprice) / oldprice
        
        # deciding the trend based on percentage
        percentage = float("{:.4f}".format(percentage))
        d['percent'] = percentage
        if percentage >= 0:
            d['trend'] = "UP"
        else:
            d['trend'] = "DOWN"   
            
        d['date'] = data['data'][0]['date']
        return d
        
def stock_fetcher():

    print("Its Loading........")
    stock_symbols = get_symbols()
    
    val = []
    for i in range(len(stock_symbols[:20])):
        val.append(get_stock(stock_symbols[i]))
    stock = dict()
    stock['total'] = len(val)
    stock['data'] = val
    
    stockjson = json.dumps(stock)
    stockjson = json.loads(stockjson)
    
    return stockjson

def makeapi():
    
    #stockjson = stock_fetcher()
    
    firebase = Firebase.FirebaseApplication("https://finezylogin-default-rtdb.firebaseio.com/", None)
    #firebase.post("/",stockjson)

    # database api
    print(" \n------------------------- Your API -------------------------")
    print("API: https://finezylogin-default-rtdb.firebaseio.com/-MVdRvDOkGcJ7fwwuika/data.json \n")
    res = firebase.get('/', None)
    
    print("------------------------- Database Key -------------------------")
    key = "-MVdRvDOkGcJ7fwwuika"
    print("Key: {} \n".format(key))
    for i in range(len(res[key]['data'])):
        print(res[key]['data'][i]['symbol'], end = "   ")
        print(res[key]['data'][i]['open'], end = "   ")
        print(res[key]['data'][i]['trend'], end = "   ")
        print(res[key]['data'][i]['percent'], end = "\n")

for i in tqdm(range(10)):
    sleep(0.2)
makeapi()