# LinkExtractor Tool

Herramienta de reconocimiento para Red Team que extrae todos los enlaces de una página web objetivo. Desarrollada en Python para fines educativos y de seguridad ética.

## Descripción

LinkExtractor Tool es una herramienta de línea de comandos que permite extraer todos los enlaces (URLs) presentes en una página web. Es útil para:

-  Reconocimiento en pruebas de penetración
-  Mapeo de la estructura de sitios web
-  Análisis de arquitectura web
-  Aprendizaje sobre web scraping

## Características

-  Extracción de todos los enlaces de una página
-  Conversión automática de URLs relativas a absolutas
-  Eliminación de enlaces duplicados
-  Manejo robusto de errores
-  User-Agent personalizado para evitar bloqueos
-  Timeout configurable
-  Interfaz amigable en línea de comandos

## Instalación Rápida

```bash
# Clonar el repositorio
git clone https://github.com/sarboledam/LinkExtractor-tool.git
cd LinkExtractor-Tool

# Instalar dependencias
pip install -r requirements.txt

# Ejecutar la herramienta
python LinkExtractor-Tool.py
```

## Uso

### Ejecución Básica

```bash
python LinkExtractor-Tool.py
```

El programa te pedirá ingresar la URL objetivo:

```
Ingresa la URL objetivo (ej. https://ejemplo.com): https://example.com
```

### Ejemplos de Uso

#### Ejemplo 1: Escanear un sitio web simple

```bash
$ python link_extractor.py

=========================================
 Extractor de Enlaces de Páginas Web v1.0
=========================================
Herramienta para el reconocimiento de Red Team.
Recuerda usarla de forma ética y legal.
=========================================

Ingresa la URL objetivo (ej. https://ejemplo.com): https://example.com

[*] Intentando conectar a: https://example.com
[+] Conexión exitosa a https://example.com (Código de estado: 200)

[+] Enlaces encontrados en https://example.com:
  1. https://example.com/
  2. https://example.com/about
  3. https://example.com/contact
  4. https://www.iana.org/domains/example

[+] Se encontraron 4 enlaces únicos.
```

#### Ejemplo 2: URL sin protocolo

```bash
Ingresa la URL objetivo (ej. https://ejemplo.com): example.com
[!] La URL debe empezar con 'http://' o 'https://'. Intentando añadir 'https://'...
[*] Intentando conectar a: https://example.com
```

#### Ejemplo 3: Manejo de errores

```bash
Ingresa la URL objetivo (ej. https://ejemplo.com): https://sitio-no-existe.com
[*] Intentando conectar a: https://sitio-no-existe.com
[-] Error al conectar o procesar https://sitio-no-existe.com: ...
```

## Cómo Funciona

1. **Solicitud HTTP**: La herramienta realiza una petición GET a la URL objetivo
2. **Parsing HTML**: Utiliza BeautifulSoup para analizar el HTML
3. **Extracción**: Busca todas las etiquetas `<a>` con atributo `href`
4. **Normalización**: Convierte URLs relativas en absolutas
5. **Deduplicación**: Elimina enlaces duplicados
6. **Presentación**: Muestra los resultados ordenados

## Requisitos

- Python 3.6 o superior
- Conexión a Internet
- Módulos Python:
  - `requests`
  - `beautifulsoup4`
  - `urllib` (incluido en la biblioteca estándar)

## Consideraciones de Seguridad

**IMPORTANTE**: Esta herramienta debe usarse únicamente con fines éticos y legales:

**Uso Permitido:**
- Sitios web propios
- Sitios con autorización explícita
- Entornos de laboratorio
- Fines educativos

**Uso Prohibido:**
- Escanear sitios sin permiso
- Actividades maliciosas
- Violación de términos de servicio
- Sobrecarga de servidores

## Solución de Problemas

### Error: "No module named 'bs4'"
```bash
pip install beautifulsoup4
```

### Error: "No module named 'requests'"
```bash
pip install requests
```

### Timeout en sitios lentos
El timeout está configurado a 10 segundos. Para sitios más lentos, puedes modificar el valor en el código:
```python
respuesta = requests.get(url, headers=headers, timeout=30)  # 30 segundos
```

## Autores

- **Santiago Arboleda Martínez**
- **Andrés Felipe Nieto**
- **Juan Manuel Caicedo**

Universidad Católica de Manizales  
Especialización en Ciberseguridad - 2025