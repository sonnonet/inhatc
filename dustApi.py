from bs4 import BeautifulSoup
from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus,unquote
import requests

url = 'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty'
queryParams = '?' + urlencode({quote_plus('serviceKey') : 	
'qw1pOT9nzm25tE5QGojsWLP6f/qDpo4xAwyn5b+tpn9UeLbF0EL3FfiFU8i2HESx2AZWYjHu6whaVBjYTlVVvw=='
                               ,quote_plus('returnType'):'xml'
                               ,quote_plus('numOfRows') :'10'
                               ,quote_plus('pageNo'):'1'
                               ,quote_plus('stationName'):'주안'
                               ,quote_plus('dataTerm'):'DAILY'
                               ,quote_plus('ver'):'1.0'})

res = requests.get(url+queryParams)
soup = BeautifulSoup(res.content,'html.parser')
data = soup.find_all('item')
print(data)

for item in data:
    dataterm = item.find('태그이름')
    pm25value = item.find('태그이름')
    print(pm25value.get_text())
    print(dataterm.get_text())
