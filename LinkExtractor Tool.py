import requests
from bs4 import BeautifulSoup
import urllib.parse

def extraer_enlaces(url):
    """
    Extrae todos los enlaces (href de etiquetas <a>) de una URL dada.

    Args:
        url (str): La URL de la página web a escanear.

    Returns:
        list: Una lista de URLs encontradas.
    """
    enlaces_encontrados = []
    
    print(f"[*] Intentando conectar a: {url}")
    try:
        # Realiza la petición HTTP a la URL
        # Añadimos un user-agent para simular un navegador real y un timeout
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'}
        respuesta = requests.get(url, headers=headers, timeout=10)
        respuesta.raise_for_status() # Lanza una excepción para errores HTTP (4xx o 5xx)

        print(f"[+] Conexión exitosa a {url} (Código de estado: {respuesta.status_code})")
        
        # Parsea el contenido HTML
        sopa = BeautifulSoup(respuesta.text, 'html.parser')
        
        # Encuentra todas las etiquetas 'a' (enlaces)
        for link in sopa.find_all('a', href=True):
            href = link['href']
            
            # Convierte enlaces relativos a absolutos
            enlace_absoluto = urllib.parse.urljoin(url, href)
            enlaces_encontrados.append(enlace_absoluto)
            
    except requests.exceptions.Timeout:
        print(f"[-] Error: Tiempo de espera agotado para {url}")
    except requests.exceptions.RequestException as e:
        print(f"[-] Error al conectar o procesar {url}: {e}")
    except Exception as e:
        print(f"[-] Ocurrió un error inesperado: {e}")

    return enlaces_encontrados

def main():
    print("=========================================")
    print(" Extractor de Enlaces de Páginas Web v1.0")
    print("=========================================")
    print("Herramienta para el reconocimiento de Red Team.")
    print("Recuerda usarla de forma ética y legal.")
    print("=========================================\n")

    url_objetivo = input("Ingresa la URL objetivo (ej. https://ejemplo.com): ")

    if not url_objetivo.startswith('http://') and not url_objetivo.startswith('https://'):
        print("[!] La URL debe empezar con 'http://' o 'https://'. Intentando añadir 'https://'...")
        url_objetivo = "https://" + url_objetivo

    enlaces = extraer_enlaces(url_objetivo)

    if enlaces:
        print(f"\n[+] Enlaces encontrados en {url_objetivo}:")
        for i, link in enumerate(sorted(set(enlaces))): # Usamos set() para eliminar duplicados y sorted() para ordenar
            print(f"  {i+1}. {link}")
        print(f"\n[+] Se encontraron {len(set(enlaces))} enlaces únicos.")
    else:
        print("\n[-] No se encontraron enlaces o hubo un problema al acceder a la URL.")

if __name__ == "__main__":
    main()