from bs4 import BeautifulSoup 
import requests
url = "http://testphp.vulnweb.com/artists.php"
req = requests.get(url)
soup = BeautifulSoup(req.text, "html.parser")
print("The href links are :")
for link in soup.find_all('a'):
   print(link.get('href'))
