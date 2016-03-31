Quiero poner una nueva pestaña en el blog donde poner mis tutoriales.

Los quiero subir directamente en HTML: esto se puede hacer. generas el HTML con RStudio y luego le pones el YAML header y la extension .md con Notepad++ y luego lo pones en la carpeta del blog _posts


Como he visto que esto funciona, entonces he queriod ponerlos en otra pestaña. esto tb lo he conseguido:

  #-las pestanas del blog estan en :   _data/navigation.yml
La carpeta con el fichero index se llama "Progres" 
el yaml del index es:
---
layout: progre-index
title: All Progres
excerpt: "A List of Progres"
---
  
  
Asi que para esa pagina he de definir un layout. Los layouts estan en la carpeta  _layouts


Lo que he hecho es duplicar casi el layout de post-index


A los posts en html (mis tutoriales) les pondre un YAML como
---
  layout: progre
title: "prueba 55"
author: Pedro J. Perez
description: "prueba 2 html"
category: r
tags: [blog]
comments: true
---
  
  
  Para mi esta todo bien. 


Lo unico que no me cuadra es una file que se llama "archive"  que esta en _templates y que no se que otra file utiliza "archive"
