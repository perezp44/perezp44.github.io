---
layout: post
title: "¿Cómo subir posts a este Jekyll blog?"
author: Pedro J. Perez
description: 
category: r
tags: [blog]
comments: true
---



Post para acordarme de como subir post al blog. Parece una tontería pues ahora mismo voy a subir este post, pero la probabilidad de que dentro de 20 días no me acuerde del todo no es despreciable.  


#### Escribiendo el post:    


1) Escribe el post en formato `.Rmd`. El encabezamiento del post debe ser algo como:  

{% highlight r %}
---
layout: post
title: "Hello world!!"
author: Pedro J. Perez
description: "Only to say hello world & intenciones"
category: r
tags: [blog]
comments: true
---
#```{r setup, echo = FALSE, warning=FALSE}
library(knitr)
opts_chunk$set(message=FALSE, cache=TRUE, warning=FALSE, echo=TRUE, dev="jpeg")
#```
Hello world,   y lo que quieras contar  
{% endhighlight %}


2) Guarda el post en la carpeta `_R`. El nombre del fichero debe ser algo como `2016-12-12-Hola-mundo.Rmd`  (no espacios, no tildes)  
  
  
3) Abre el fichero `perezp44.github.io/_scripts/knitpages_pjp.R` y ejecútalo  

<br>
  
Ya está, knitr ha knitteado los ficheros .Rmd y ha creado los ficheros .md, imágenes y demás en las carpetas adecuadas. Solo queda subirlo a Github para que se incorpore y actualice el blog.  

<br>


#### Para subir los cambios a Github:  

De momento estoy utilizando Git Bash (creo que más adelante utilizaré Source Tree).  

Si el blog ya está operátivo en Github y sólo vas a añadir un post nuevo o corregir algo, has de hacer lo siguiente:     


{% highlight r %}
  cd c:/Users/perezp/Desktop/a_R_2016/perezp44.github.io  
  git add .   
  git commit --all --message "Subiendo el post nº 77"  
  git push -u origin master    
{% endhighlight %}

<br>


#### Subiendo a Github el blog entero:  

Si resulta que vas a subir el blog entero porque en Github todavía no has subido nada, has de hacer lo siguiente:    


{% highlight r %}
0) En GITHUB has de crear un repo nuevo y le pones el nombre que quieres. En mi caso "perezp44.github.io"  

  Lo siguiente es todo en local, en tu PC:  

1) pones los ficheros que quieres llevar a Github para hacerlos un repo en una carpeta. Esta carpeta se ha de llamar igual que el repo, o sea: "perezp44.github.io"   

2) Te sitúas en esa carpeta en Git Bash. Para ello has de ejecutar:  [  cd c:/Users/perezp/Desktop/a_R_2016/perezp44.github.io  ]   

3) Inicializas el repo Local con: [ git init ]  

4) Añades todas las files de la carpeta al repo con:  [ git add . ]  (el punto hay que dejarlo)   

5) Haces el commit: [ git commit --all --message "Creando el REPO "]

  Ahora hay que subir los ficheros a Github, así que en tu PC, en Git Bash haces:  
  
6) git remote add origin https://github.com/perezp44/perezp44.github.io.git   [fijate en el .git] 

7) git push -u origin master


**Ya está hecho**
{% endhighlight %}


Todo junto sería:  



{% highlight r %}
  1) en Github crear un new repo  

  2) en Git Bash haces:  
    
  cd c:/Users/perezp/Desktop/a_R_2016/perezp44.github.io 
  git init  
  git add .  
  git commit --all --message "Creando el REPO"  
  git remote add origin https://github.com/perezp44/perezp44.github.io.git 
  git push -u origin master  
{% endhighlight %}




<br>




#### Cosas que me gustaría probar/mejorar de este proceso:  

1) Cuando quiero poner un chunk de code (bueno en realidad no es código pero quiero que salga resaltado) lo normal sería utilizar tres veces la marca ` al principio y final del chunk. En Rstudio esto por supuesto que funciona, pero al pasarlo por el fichero `knitpages_pjp.R` no sale bien  formateado el fichero .md resultante. Para poder resaltar un párrafo tengo que hacer como si fuera un chunk de R pero con la opción `eval=FALSE`. CREO que si pongo al ppio y final `$` funcionaría (No, no funciona, lo he probado!), pero ya no quiero dedicarle más tiempo: como lo del chunk de R me funciona, de momento me vale.  


2) Me gustaría ver si puedo modificar el fichero `perezp44.github.io/_scripts/knitpages_pjp.R` que uso para knittear los posts, para en lugar de utilizar la función `knit()`, utilizar la función `spin()`. Esto me lo planteé tras echarle un vistazo a [este post](http://deanattali.com/2015/03/24/knitrs-best-hidden-gem-spin/). Vamos, lo que quiero es en lugar de escribir ficheros `.Rmd` utilizar ficheros `.R`. Yo ya utilizaba la función spin() sin saberlo porque lo hacía a través de RStudio, pero ya en su momento me parecia más cómodo escribir lo que en RStudio se llaman `Notebooks`, pero no tengo claro si con esta forma de escribir es posible utilizar todas las posibilidades que tiene Rmarkdown.   

Como dice [Dean Attali](http://deanattali.com/2015/03/24/knitrs-best-hidden-gem-spin/):  

> The “compile notebook” button in RStudio, which calls the rmarkdown::render function, will achieve a similar result if given an R input. This is because render actually calls spin under the hood. It doesn’t really matter if you choose to call spin or to call render - both functions require the same R sript as input rather than an Rmd (or any other literate programming file).  

3) Al procesar este post he visto que la cita de Dean Attali sale con un tamaño más grande que el texto. Eso no me gusta, pero me imagino que es tocar el CSS, del que tengo un conocimiento minus zero  

4) También me gustaría poner dentro del blog dos pestañas para post, una para post de R/computing y otra por si se me escurre escribir posts un poco diferentes (Raspberry P o las fases de la luna, for instance). Sé que con Jekyll se pueden gestionar `tags` y también `categories`. Supongo que será relativamente fácil, pero lo dejo para más adelante.  
5) De momento no me ha hecho falta pero parece ser que para poder usar those fancy new htmlwidgets packages hay que hacer varias modificaciones. Lo cuenta [aquí](http://www.r-bloggers.com/using-htmlwidgets-with-knitr-and-jekyll/) Brendan Rocks  


