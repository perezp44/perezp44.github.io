---
layout: post
title: "¿Cómo crear un package de R para uso personal?"
author: Pedro J. Perez
description: 
category: r
tags: [R, Github]
comments: true
---



Pues eso, se trata de describir como crear un package personal de R. Y, ¿esto para que sirve? pues para poder tener almacenadas las funciones de R que utilizas habitualmente y poder cargarlas todas juntas como un package. Una vez creado, el package se puede cargar desde local pero lo subiré a github para que se pueda usar desde cualquier lugar del mundo mundial.      

Dividiré el post en:  
1) Preparando el ordenador  
2) Creando la estructura del package con devtools   
3) Incorporando/añadiendo funciones al package  
4) Documentando el package con roxygen   
5) Usando el package desde local
6) Alojando el pacakge en Github    

**¿Quién me ha ayudado?** Pues la chica de la taza, [Hilary Parker](http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/), moltes gracies Hilary!! Siguiendo sus instrucciones conseguí, alla por el 2015,  crear un package que declaraba mi amor a los gatos. Desde entonces yo ya tenía en mi cabeza la idea de hacer mi personaL package en serio, pero el empujón final me lo dio [este post de Pablo Casas](http://www.r-bloggers.com/package-funmodeling-data-cleaning-importance-variable-analysis-and-model-perfomance/). En su package Pablo tenía una función de la que yo tenía mi propia versión (mi versión era un poco más fea, bueno mucho mas fea, pero era mi versión y funcionaba, solo que no la tenía en un package, sino que la copiaba y pegaba en mis scripts). Al ver su superfuncion dije: ya esta!! empiezo mi personal package con esta función, y aquí estoy escribiendo este post. En realidad es una función muy sencilla, metes un df y te saca un df con los nombres de las variables del df original y alguna cosa mas. Parece una tontería pero a mi me ayuda a ver lo que hay en el df. Debo llevar ya 30 o 40 faltas porque estoy escribiendo de corrido (leer mi primer post).    

#### 1) Preparando el odenador      

Ya he dicho que quien me enseñó fue Hilary Parker, pero para escribir este post he intentado documentarme un poco más y llegue a [este curso](https://stat545-ubc.github.io/packages02_activity.html) en el que hacían mucho hincapié en preparar el PC antes de crear el package, así que lo hice, principalmente porque necesitaba actualizar mi RStudio, pero si tienes prisa prueba a leer solo el post de Hilary, supongo que seguirá funcionando. Siguiendo lo que se cuenta en el [curso STAT545](https://stat545-ubc.github.io/packages01_system-prep.html) para preparar el ordenador hace falta lo siguiente:   

- **Actualizar R**. Yo lo hice desde la consola  de R (no RStudio) con el package `installr`. Obviamente hay que instalarlo, cargar el package con `library(installr)` y después ejecutar la función `updateR()`. Installr buscará la actualización de R y la instalará (si es que la hay)   

- **Actualizar RStudio**. En el propio  Rstudio, ve a la ventana Help: Check for updates   

- **Instalate el package devtools**: 1) `install.packages("devtools")`   `library(devtools)`

- **Instalate Rtools**. No es un package. Lo puedes encontrar [aquí](http://cran.r-project.org/bin/windows/Rtools/). Cuando lo estés instalando haz tick o señala la casilla de “Edit the system PATH”   

- Reinicia Rstudio y en RStudio correlas siguientes instrucciones: a)  `library(devtools)`  b)`find_rtools()` tiene que devolver el mensaje TRUE, vamos q si tienes instalado Rtools  c) `update.packages(c("knitr","roxygen2", "testthat" ))`. 

Lo siguiente no hace falta, es solo para acordarme yo:   

- `old.packages()`  para ver que packages tienes out of date   
-  `update.packages(ask = FALSE)`   actualiza todos los packages de tu library


#### 1') Preparando el ordenador à la Hilary Parker

Hilary Parker (la que me enseñó) no prepara tanto el ordenador; de hecho, solo instala 2 packages, y a mí me funcionó.  Concretamente hace lo siguiente:   


{% highlight r %}
  install.packages("devtools")
  library("devtools")  
  devtools::install_github("klutometis/roxygen")  
  library(roxygen2)
{% endhighlight %}



#### 2) Creando la estructura del package con devtools (documentación con roxygen) 

Un package requiere una estructura concreta de carpetas y algunos ficheros, pero todo esto lo hace automáticamente `devtools` por nosotros.


Concretamente Hay que hacer lo siguiente:  

- Hay que elegir  la ruta donde se generará nuestro package. En mi caso en `C:/Users/perezp/Desktop/a_GIT_2016/`   
- (es recomendable) poner alguna información referente al package (quien lo ha hecho, para que sirve etc...)   
- Hay que decirle a devtools que lo cree

Todo esto se hace ejecutando:  


{% highlight r %}
#- donde creare el personal package
bb <- "C:/Users/perezp/Desktop/a_GIT_2016/"   
setwd(bb)  
#- alguna información sobre el package que vas a crear    
my_description <- list("Maintainer" = "Pedro J. Perez  <pjperez@uv.es>" , "Title" = "Personal functions of pjp", "Description" = "Funciones que utilizo habitualmente", "Version" = "0.0", "License" = "Para mí, pero estas invitado")  
#- devtools creará a new package llamado personal.pjp following all devtools package conventions.
create("personal.pjp", rstudio = FALSE, my_description)    
{% endhighlight %}


El package ya está creado, puedes ir a ver que se ha creado una serie de ficheros en la carpeta `C:/Users/perezp/Desktop/a_GIT_2016/personal.pjp`. El único problema es que el package no hace nada porque aun no tiene ningún script de R, pero enseguida añadiremos uno.    


#### 3) Incoporando/añadiendo funciones al package 

Como dije en la introducción, la primera función que añadiré a mi package esta muy-muy basada en una de Pablo Casas en su package `funmodelling`. Pero como ejemplo para el post usaré la función que usa Hilary Parker, algo así como `I love cats`. la verdad es ella lo cuenta mucho mejor que yo, con dibujos y todo, y encima no quiero gastar tanto tiempo, así que tendréis que ir a su blog: ya sabéis (los que leísteis el primer post) que estos post son fundamentalmente para mí. Sorry!!


#### 4) Documentando el package 


4) Documentando el package con roxygen  

Es muy fácil (al menos lo básico). En palabras de Hilary: 

> This always seemed like the most intimidating step to me. I’m here to tell you — it’s super quick. The package `roxygen2` that makes everything amazing and simple. The way it works is that you add special comments to the beginning of each function, that will later be compiled into the correct format for package documentation   

Vamos que lo hace todo (casi) el package `roxygen2`. Sólo hay que escribir la documentación en el mismo script donde está la función. Tiene que ir al principio, en la cabecera de la función y hay que escribirla en un formato especial que empieza con `#'`. Mirando un ejemplo eres capaz de modificarlo para que aparezca  al menos el nombre de la función, para que sirve, sus argumentos y algún ejemplo de uso. Ya aprenderé más en un futuro (espero no lejano)    
Una vez tienes escrita la documentación de tu script donde está la función, hay que decirle a `roxygen` (o es devtools?, da un poco igual, ya lo aprenderé) que generé la documentación, ¿cómo?  


{% highlight r %}
#- recuerda que el package se ha creado en "C:/Users/perezp/Desktop/a_GIT_2016/personal.pjp" 
#- lo primero es situarnos en ese directorio, para ello, como estamos en "C:/Users/perezp/Desktop/a_GIT_2016/" , hay que ejecutar:  
setwd("./personal.pjp")
document()   #- ya ha creado la documentacion. Guarda un fichero para cada función del package en el directorio /man del package
{% endhighlight %}
 Tras ejecutar estas 2 instrucciones, se habrá generado una nueva carpeta `..personal.pjp/man` donde se habrá creado el fichero que documenta a nuestra función. Este fichero no hay (bajo peligro de que todo casque) que editarlo a mano. Si lo queremos editar hay que cambiar el script donde esta la función y volver a ejecutar el comando `document()` desde el directorio que toca.   
 
Venga que tengo que acabar el post en un rato. La verdad es que me está gustando esto de escribir, pero es por estas parrafadas de comentarios que me permito hacer. La verdad es que aun no he inaugurado la sección flowers del blog. Hoy he leído un libro de poesía sobre el miedo. Estab muy chulo (esa  es mi critica literaria, no me da tiempo ni ganas para elaborarla mas, pero lo he leído y me ha emocionado/sorprendido varias veces) y me he quedado con un montón de frases pero la que mas, una de Mikel Caverna, que entre otras cosas tenia miedo a la mirada vacía de las vacas. Hay que leerlo para entenderlo.   
Bueno, esto ya es un "sin dios", retomo lo del package...   

#### 5) Usando el package desde local. Como dije, tras ejecutar `document()`, el package esta operativo, solo queda, como con cualquier package instalarlo y cargarlo con:   


{% highlight r %}
#- has de situarte en directorio conde está la carpeta del package. Como estábamos dentro de el, pues hay que bajar un nivel, y eso se hace así:
setwd("..")
#- tambien se puede hacer y mas seguro con:
setwd("C:/Users/perezp/Desktop/a_GIT_2016/" )  
#- Una vez en el directorio correcto, hayq ue instalarlo:
install("personal.pjp")
#- y luego cargarlo
library(personal.pjp)
{% endhighlight %}

Una vez cargado el package pues puede ejecutar las funciones que tiene en su interior. En mi caso `names_v_df.pjp()` que es una función que genere un dataframe(df) con los nombres de las columnas (y algún dato mas) de un df. En el caso de Hilary `cat_function()`.      



#### 6) Alojando el package en Github

Poder tener agrupadas tus funciones en un package y con documentación estándar está bien, pero también se podría hacer con un fichero y hacer un `source(file)`, pero ¿y si alguien me pide usar mi función? Ahora en serio no es tan raro tener que compartir un script y si en tu workflow usas un personal package deberías mandarle tb el package, un lío!. Mejor tenerlo en github e instalarlo con devtools. !!!Y os pareció raro lo del mirada asustada de las vacas!!!   

Como alojar un repo en github lo conté en otros post y ya no me acuerdo de como hacerlo, así que voy a informarme en mi propio blog ` R & flowers`. Y la solución es:   
  


{% highlight r %}
0) En Github crear un repo que se llame igual que tu package. En mi caso `personal.pjp`
1) en Git Bash te situas en la carpeta del package. en mi caso con:   `cd c:/Users/perezp/Desktop/a_GIT_2016/personal.pjp`    
2) Inicializas el repo vacio con :  `git init`
3) Añades los archivos al repo: `git add .`  El punto indica que añades todos? (ya no me acuerdo, ves como n'hi ha que fer un blog)
4) Commit inicial: `git commit --all --message "Creando el REPO"`
5) `git remote add origin https://github.com/perezp44/personal.pjp.git`
6) `git push -u origin master`
{% endhighlight %}

A ver si chuta. Sí, al segundo intento he conseguido subido mi personal.pjp package a Github.   
Sólo queda ver si puedo instalar mi package desde Github con devtools, y como aun estoy fresco pues haré un cambio, añadiré una función en local en mi PC y lo llevare a Github (son ilusiones)    

#### 7) Instalando mi propio package desde Github 

Para instalarlo solo hay que usar la función `install_github()`:

{% highlight r %}
library(devtools)
install_github('perezp44/personal.pjp')
library(personal.pjp)
{% endhighlight %}

Sí, parece que se instala, pero, a la hora de pedirle que me muestre la documentación no me la ha mostrado. Sí que ha funcionado la función.   


#### 8) Modificando y actualizando mi personal package

Voy a probar a añadir una función, muy sencilla para probar `print_pepe()`.Para ello:  


1) Crear un script con la funcion y ponerlo en la carpeta local donde está el package. En mi caso en `C:/Users/perezp/Desktop/a_GIT_2016/personal.pjp` Acuérdate de la documentación con roxygen. 


2) Situar el working directory en tu package: `setwd("C:/Users/perezp/Desktop/a_GIT_2016/personal.pjp" )`  


3) Genera la documentación de la funcón desde RStudio con la f. `document()`    

```
library("devtools")  
devtools::install_github("klutometis/roxygen")  
library(roxygen2)
document() 
devtools::document()   #- tampoco así me crea bien la documentacion
```  

4) si quieres probar (antes de subirlo a Github) si el package funciona en Local, debes hacer:   

```
setwd("C:/Users/perezp/Desktop/a_GIT_2016/" )  
install("personal.pjp")  #- lo instalas desde local
library(personal.pjp)
ls(name = "package:personal.pjp") #- debe salir la nueva funcion


```



5) Para subirlo a Github, has de volver a Git Bash y, como el package ya esta en Github, solo es subir los cambios. Para ello:     

Como yo trabajo en 2 ordenadores, está bien antes de subir a Github los cambios hechos en un PC, ver si tu copia local está al día, y esto se hace en Git Bash con: `git pull origin master`. Lógicamente primero has de estar en la carpeta del proyecto que estas trackeando.




{% highlight r %}
  cd c:/Users/perezp/Desktop/a_GIT_2016/personal.pjp 
  git add .   
  git commit --all --message "Incoporando la f. Pepe"  
  git push -u origin master    
{% endhighlight %}


Ahora es la hora de verdad: 
Para instalarlo solo hay que usar la función `install_github()`:   

{% highlight r %}
library(devtools)
install_github('perezp44/personal.pjp')
library(personal.pjp)
print_pepe.pjp()
{% endhighlight %}


SÍ, it works!!!, pero tengo un Pb con la documentación roxygen. Yo que creía que viendo el ejemplo de Hilary era bastante, pero no, me va a tocar leer algo de roxygen2. Me ha venido la inspiración, ¿a que va a ser que no tenia cargado el package roxygen?   No, no era eso, me tocará mirarlo     

Ahora tengo que subir el post y tampoco me acuerdo... pero "R & flowers" lo explica bien      
Si lo  ves es que pude. ya arreglaré el post. Desde luego, primero difícil que alguien lo lea, pero si alguien consigue, siguiendo solo mis indicaciones, crearse un package es que es uno genio. Igual dentro de 1 mes no lo entiendo ni yo, pero ya no le dedico mas tiempo, que esto es para aprender no para patir     

Que no me sube al blog. Last chance. Go!!!   
  
<br>
<br>

3-4 dias pespues retomo el post. Conseguí subir el post al blog **PERO** no se genera bien la documentación del package, asi que he estado leyendo en blogs y entiendo algo más (sólo algo) lo que hacen devtools/roxygen2 , que son las files `.Rd` y demás. Esta vez quien me ha ayudado es el mismísimo Hadley Wickham. ¿Qué quien es? Me estás tomando el pelo, es imposible que estés leyendo esto si no lo sabes. En el universo R Hadley es Dios,al menos semi-. (pondría el puto amo pero no puedo) 
Pues Hadley me ha ayudado [aquí](http://r-pkgs.had.co.nz/description.html) y [aquí](https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html) ya que es quien ha creado tanto devtools como roxygen2.   

En palabras de Hadley:   

> Documentation is one of the most important aspects of good code   

> The goal of `roxygen2` is to make documenting your code as easy as possible. R provides a standard way of documenting packages: you write .Rd files in the man/ directory. These files use a custom syntax, loosely based on latex. Roxygen2 provides a number of advantages over writing `.Rd` files by hand  


He apendido alguna cosa (no lo estructuro denasiado, progress ongoing):

1) There are three main ways to run roxygen:

    - roxygen2::roxygenise(), or

    - devtools::document(), if you’re using devtools, or

    - Ctrl + Shift + D, if you’re using RStudio.


2) Roxygen tambien puede manejar el archivo `NAMESPACE` del package. Para mí lo que cuenta es que tengo que `@export` mis funciones en los comentarios roxygen de cada función    


3)  **Roxygen comments start with #' and include tags like @tag details**. Tags break the documentation up into pieces, and the content of a tag extends from the end of tag name to the start of the next tag (or the end of the block). Because @ has a special meaning in roxygen, you need to write @@ to add a literal @ to the documentation 


El package funciona, incluso he mejorado la función (tuneado a mi gusto) varias veces. Lo instalo desde Github y la funcion hace lo que tiene que hacer pero la documentación del package no se genera bien. Nada, ya lo conseguiré
