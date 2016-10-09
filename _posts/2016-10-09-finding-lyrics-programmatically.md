---
layout: post
title: "Finding lyrics programatically (encontrando letras de canciones en APIs)"
author: Pedro J. Perez
description: 
category: r
tags: [music, flowers]
comments: true
---



Hace ya unos meses quisé/tuvé que buscar letras de canciones. No eran muchas, unas 60, pero me dio por buscarlas con R; por supuesto tardé más tiempo que buscándolas a mano, pero ... y lo que aprendí; además, si las hubiese buscado a mano, ahora no habría post. Eso sí, como no lo escribí cuando tocaba, ahora casí no me acuerdo. Time machine start!  

En la búsqueda de conocimineto encontré 2 post fantásticos sobre lyrics y R: [este](http://kaylinwalker.com/50-years-of-pop-music/) y [este](https://mytinyshinys.shinyapps.io/musicChartsFlexDB/).El segundo tengo que hacerlo, ya veremos si el año que viene.
 

Como siempre lo primero fue buscar en internet y me llevó [aquí](http://www.baykalhafizoglu.com/obtaining-song-lyrics-using-music-apis/). En ese post, Baykal buscaba letras de canciones en 5 music APIs, ok, ya lo tenía!, pero problema, estaba programado en PHP. Nada, rápidamente le pregunté pero tardó en responderme, así que tuve que buscarme la vida y aprender algo de APIs, etc ... Creo que donde finalmente entendí un poquito como funciona esto de las APIs fue [aquí](https://www.r-bloggers.com/using-the-httr-package-to-retrieve-data-from-apis-in-r/), también aprendí algo [aquí](http://stackoverflow.com/questions/30020465/retrieve-whole-lyrics-from-url).

Bueno, *en* resumiendo que conseguí bajarme lyrics de [Chart Lyrics](http://www.chartlyrics.com/). Probé en varias API, pero esta no pedía API keys, no tenía limite de calls y Baykal decía en su post que era sencilla. Tras unos cuantos prueba-error conseguí bajarme las letras, pero como muchas canciones eran *spanish*, pues sólo se bajaron around un 30% y lo dejé ahí, el resto las bajé a mano. Como Hadley se entere me quita la licencia de R programmer! 


Ok, hasta aquí el background y la biblio, pero ¿cómo se baja la letra de una canción en [Chart Lyrics](http://www.chartlyrics.com/)[^1]? 

<br>


#### Para buscar una canción concreta se hace ...


Veamos un ejemplo con una canción que sé que está(ba) en Chart Lyrics: El hombre que casi conoció a Michi Panero de NV


{% highlight r %}
names <- c(1, 2)
names[1] <-  "\'Nacho&Vegas\'"       #- nombre del artista. Los \ son para hacerlo literal
names[2] <- "\'Michi&panero\'"       #- título del song
{% endhighlight %}

<br>

Almaceno la query en `querrye` y la hago con `GET()`. Para entender un poco el package `httr` ve [aquí](entender httr: https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html)



{% highlight r %}
library(httr)
library(RCurl)
library(XML) 
querrye <- paste("http://api.chartlyrics.com/apiv1.asmx/SearchLyricDirect?artist=", names[1],"&song=",  names[2], sep='')
data <- GET(querrye)     #- hago la query (funcionaba, hoy no chuta, ¿qué pasa Chart Lyrics)
{% endhighlight %}


{% highlight r %}
# str(data)
# data$content       #- AJA, el contenido está en  data$content    : raw [1:1986] 3c 3f 78 6d ...
# http_status(data)  #- te dice si ha sido un exito (200 es éxito)
aa <- content(data, "text")  #- aqui esta el texto pero en HTML y la lyric esta entre los tags  <Lyric>  </Lyric>
# content(data, "text", encoding = "UTF-8")
# aa1 <- content(data, "parsed", encoding = 'UTF-8')   #- aqui esta el texto pero en HTML y la lyric esta entre los tags  <Lyric>  </Lyric> ESte lo hace mal
{% endhighlight %}

<br>

OK, tengo la lyrics en `aa`, pero en xml/html , así que hay que trabajarlo. [Aquí](http://www.r-bloggers.com/htmltotext-extracting-text-from-html-via-xpath/) lo aprendí.



{% highlight r %}
doc <- htmlParse(aa, asText=TRUE)   #- Aqui es donde se estropician las tildes
plain.text <- xpathSApply(doc, "//lyric//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)  #- aqui está el texto  (es character). Tuve que poner //lyric// para que sólo me cogiera el texto de lyrics
plain.text <- iconv(plain.text, from = "UTF-8", to = "latin1", sub = NA, mark = TRUE, toRaw = FALSE) #- aqui arreglo lo de las tildes pero no acabo de entenderlo 100%
# cat(paste(plain.text, collapse = " "))  #- asi muestras la poesia
#- Sys.setlocale("LC_CTYPE", "spanish")
{% endhighlight %}

<br>

Al final hice una función (que funcionaba). Que gusto!

<br>



{% highlight r %}
library(httr)
library(RCurl)
library(XML)

df <- data.frame(artist = c('Led Zeppellin', 'Adele'), song = c('Rock´n roll', 'Hello'), stringsAsFactors = F)

make.querrye <- function(xx) {
  names_ok <- gsub(" ", "&", xx)
  names_ok2 <- paste("\'", names_ok, "\'", sep = '')
 querrye <- paste("http://api.chartlyrics.com/apiv1.asmx/SearchLyricDirect?artist=", names_ok[1],"&song=",  names_ok[2], sep='')
 data <- GET(querrye)
 aa <- content(data, "text")   
 doc <- htmlParse(aa, asText=TRUE)  
 plain.text <- xpathSApply(doc, "//lyric//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue)  
 if (length(plain.text)==0) {
   plain.text2 <- 'Lyrics not found'
 } else {
   plain.text2 <- iconv(plain.text, from = "UTF-8", to = "latin1", sub = NA, mark = TRUE, toRaw = FALSE)  
 }
 return(plain.text2)
 }

names <- c(df$artist[1], df$song[1])
make.querrye(names) #- it works (Led Zeppelling si mi gustar)
names <- c(df$artist[2], df$song[2])
make.querrye(names) #- it also works (Adele mi no gustar)
{% endhighlight %}

<br>

Estaba contento, solo tenía que poner un loop o hacer un *apply o purr y ya estaba, me bajaria las letras de las 60 canciones de golpe, pero .... si metías la función inside a loop ya no chutaba. Yo creo que es porque Chart Lyrics no dejaba hacer calls más que tras haber pasado algo de tiempo (esto es lo que yo quiero creer) y como me dolió en el alma que no funcionase mi función, pues tuve que pedir ayuda.  ¿A quien? ... en mi entorno, de programming van justitos, así que tuve que recurrir a Stack Overflow y eso me dará para el siguiente post.   



Bueno, pues eso es todo amigos. Me he quedado preocupado, ¿qué le habrá pasado a Chart Lyrics?

Bye, que voy a escribir 3 posts del tirón. Que ansia!! Sí, es que me voy a Albacete y me ha dado por arreglar el blog.   



------------------------    
**FOOTNOTES:**

[^1]: Mientras escribo esto he ido a la web de Chart Lyrics y no chuta. ¿Habrá desaparecido o sólo que la gente esta como loca buscando letras y recibe muchas API calls?
