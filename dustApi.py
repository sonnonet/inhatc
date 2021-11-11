from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus
import requests

url = 'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty'
queryParams = '?' + urlencode({quote_plus('serviceKey') : 'qw1pOT9nzm25tE5QGojsWLP6f%2FqDpo4xAwyn5b%2Btpn9UeLbF0EL3FfiFU8i2HESx2AZWYjHu6whaVBjYTlVVvw%3D%3D'
                               , quote_plus('returnType'):'xml',quote_plus('numOfRows') : '10',quote_plus('pageNo'):'1',quote_plus('sidoName'):'인천',quote_plus('ver'):'1.0'})

request = Request(url + queryParams)
request.get_method = lambda: 'GET'
response_body = urlopen(request).read()
print(response_body)