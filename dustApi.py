from bs4 import BeautifulSoup
from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus,unquote
import requests

url = 'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty'
queryParams = '?' + urlencode({quote_plus('serviceKey') : 	
'qw1pOT9nzm25tE5QGojsWLP6f/qDpo4xAwyn5b+tpn9UeLbF0EL3FfiFU8i2HESx2AZWYjHu6whaVBjYTlVVvw==', quote_plus('returnType'):'xml',quote_plus('numOfRows') :'10',quote_plus('pageNo'):'2',quote_plus('sidoName'):'인천',quote_plus('ver'):'1.0'})

res = requests.get(url+queryParams)
#request = Request(url + queryParams)
#request.get_method = lambda: 'GET'
#response_body = urlopen(request).read()
#print(response_body)
soup = BeautifulSoup(res.content,'html.parser')
data = soup.find_all('item')
print(data)
for item in data:
    sidoname = item.find('sidoname')
    pm25value = item.find('pm25value')
    datatime = item.find('datatime')
    print(sidoname.get_text())
    print(pm25value.get_text())
    print(datatime.get_text())
#for i in soup.find_all("item"):
#    print(i.find('sidoName'))
#ItemList = soup.findAll('pm25Value')
#for item in ItemList:
#    print(item)
#print(root.tag)
#print(root.attrib)
#for pm25 in root.findall('item'):
#    print(pm25.attrib)
