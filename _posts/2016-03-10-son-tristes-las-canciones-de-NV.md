---
layout: post
title: "¿Son tristes las canciones de Nacho Vegas? (Sentiment analysis of NV lyrics)"
author: Pedro J. Perez
description: 
category: r
tags: [PNL, music, flowers]
comments: true
---




Pues eso, se trata de que la Ciencia se pronuncie por fin: ¿son tristes las canciones de ese cantante/cantautor recientemente convertido al populismo llamado Nacho Vegas? Diga lo que diga la ciencia, la respuesta, como sabemos todos los que seguimos a NV, es que NO, o bueno un poco, depende, ¡yo que sé! ¡Que más da! son canciones que hacen sentir. Veamos si la ciencia coincide con mi valoración.  

Utilizaré una técnica/método llamada **Analisis de sentimiento(s)** (bonito nombre!!). Como la Wikipedia dice [aquí](https://es.wikipedia.org/wiki/An%C3%A1lisis_de_sentimiento), el análisis de sentimiento se refiere al uso de procesamiento de lenguaje natural (PNL), análisis de texto y lingüística computacional para identificar y extraer información subjetiva de unos recursos (WTF?). La propia Wikipedia aclara que:  

> En términos generales, el análisis de sentimiento intenta determinar la actitud de un interlocutor o un escritor con respecto a algún tema o la polaridad contextual general de un documento. La actitud puede ser su juicio o evaluación, estado afectivo (o sea, el estado emocional del autor al momento de escribir), o la intención comunicativa emocional (o sea, el efecto emocional que el autor intenta causar en el lector).   

Vamos, que pretendo desentrañar, sin hacer daño a nadie, cual era la intención (comunicativa emocional) de NV al componer esas extrañas canciones, ¿hacernos llorar/reír/pensar.... o las hace para él? (Se me esta ocurriendo ahora mientras escribo hacer el mismo análisis a este texto para ver que pretendo: ¿aprender R? ¿conocer a NV? ¿enamorar a BB? ¿ir a Albacete?, who knows!!, igual las 3 cosas). Al lío que me disperso.  

Para ello voy a utilizar R y varios packages. La verdad es que mientras escribo esto aun no se prácticamente nada de PNL ni de análisis de sentimiento, pero intentaré aprender algo.   


Lo primero que tengo que hacer es hacerme con las letras de algunas canciones de NV. Esto debería hacerlo programáticamente haciendo web scrapping (pero sé muy poquito de esto, así que lo hago a mano, ya aprenderé web scrapping). De momento cogeré solo 3 canciones. Si todo chuta añadiré alguna más, al menos 10 canciones, para que sea un poco representativo del corpus/universo creativo de NV. Pero eso será en otra vida, ahora no.   

Primer dilema, ¿que canciones cojo?, pues para ver si la técnica acierta voy a coger 3: una triste, una alegre y otra in the midle; así podré ver si la técnica coincide con mi opinión personal. No diré cual es cada cual, así los potenciales lectores podrán jugar y mantendré algo el misterio.  

Por votación popular las canciones son, estrictamente en este orden : Ocho y medio, En mi nueva vida y Detener el tiempo




Bueno, aunque no lo hayáis visto, he cargado las letras de 6 canciones. ¿Para qué he hecho la votación? Meto las letras en un vector:  




{% highlight r %}
letras <- c(letra_ocho, letra_alnorte, letra_simon, letra_brujita, letra_nuevavida, letra_detener)
{% endhighlight %}


Para que veis lo bonitas (y poco tristes) que son las letras os dejo la de Brujita:  

> Brujita, hoy quiero, desde este agujero, decirte que muero por ti. Por tus manos frías, por las brujerías, por tu forma de toser.  Tal vez esté escrita mi vida, brujita. Tal vez te llegue a perder. Pero ¡cuánto te quiero, mi amor verdadero! Sin ti está mal hecho el mundo.  Ya huele a tormenta, rechinan veletas, mas tú, tú me puedes salvar. Desciendes deprisa, sin paracaídas, en tu escoba a todo gas.  Brujita, me irrita la gente, ¡maldita!, que trata de hacerte sufrir. Yo los mataría, les arrancaría la piel hasta verlos morir.  Como un cocotero, como un rascacielos, así de bonita eres tú. Te observo durmiendo, pequeño misterio que nadie jamás resolvió.  Tal vez esté escrita mi vida, brujita. Tal vez te llegue a perder. Pero ¡cuánto te quiero, mi amor verdadero! Sin ti está mal hecho el mundo. ¡Sin ti está mal hecho el mundo!"




Si os ha gustado la letra de Brujita , podéis ver a NV tocándola el solito [aquí](https://www.youtube.com/watch?v=20011Cccisg). Es un vídeo largo, merece la pena pero Brujita empieza por el minuto 21.   

¿Triste? Puff, muchos matices, que se pronuncien los   críticos musicales o NV.  

Me ha dado por buscar en Google lo siguiente: "son tristes las canviones de Nacho vegas" canciones con v. Literal. Y el segundo resultado de la búsqueda ha sido [este](http://www.dodmagazine.es/canciones-mas-triste-del-indie-espanol/). Como podéis ver, según **dod Magazin**, la quinta canción más triste del indie español es .... Ocho y medio. No puede ser, NV aparece también en los puestos 12,19,21 y 97 de una lista de 109; ademas, en uno de los comentarios se dice literalmente "prácticamente cualquier canción de nacho vegas podría estar en esta lista"; ademas, varios dicen que va a empezar a llover es triste. Discrepo, ¡pero si esta canción se la ponía yo a mis niños y les encantaba! Bueno, quizás esta frase `Tache los días de calendario en los que nos hicimos daño y quedaron tres` puede que sea un poco triste. Los Planetas también aparecen mucho en la lista (8,25,26,55,106 y 107), y McEnroe, ¿que pasa con ellos? (16,40,76)


Dejamos a Brujita y al dod Magazine. Cargo los packages que harán el trabajo sucio:  


{% highlight r %}
library(syuzhet)
library(tm)
library(wordcloud)
library(dplyr)
{% endhighlight %}

Ahora hay que trabajar/destripar las letras. Tal como la escribió NV no vale para el trabajo riguroso de la ciencia. hay que quitar las tildes, interrogantes, exclamaciones ... Viva el castellano!  



{% highlight r %}
letras <- base::chartr('áéíóú' , 'aeiou',letras)  #- quitar tildes
{% endhighlight %}



{% highlight text %}
## Error in base::chartr("áéíóú", "aeiou", letras): 'old' is longer than 'new'
{% endhighlight %}



{% highlight r %}
letras <- base::chartr('ÁÉÍÓÚ' , 'AEIOU',letras)  #- quitar tildes
{% endhighlight %}



{% highlight text %}
## Error in base::chartr("ÁÉÍÓÚ", "AEIOU", letras): 'old' is longer than 'new'
{% endhighlight %}



{% highlight r %}
#letras <- chartr('?¿()!¡','      ',letras)          #- interrogantes, parentesis y exclamaciones
letras <- gsub(';|,|\\.|?|¿|!|¡|(|)' , '', letras)          #- comas, puntos y comas ....
{% endhighlight %}
Ya podemos hacer un análisis de sentimientos de estas canciones ¿cual será la más triste? Yo tengo mi opinión, pero ¿y la ciencia? Utilizaré la función `get_nrc_sentiment()` del package `syuzhet`. Esta función usa the NRC sentiment dictionary to calculate the presence of eight different emotions and their corresponding prevalence in a text file. 


{% highlight r %}
sentiment_NV <- get_nrc_sentiment(letras)
row.names(sentiment_NV) <- c('8 y 1/2', 'Al Norte' , 'Simon', 'Brujita' , 'Nueva vida' , 'Detener')
{% endhighlight %}
El veredicto es: 


{% highlight r %}
print(sentiment_NV[,1:8])
{% endhighlight %}



{% highlight text %}
##            anger anticipation disgust fear joy sadness surprise trust
## 8 y 1/2        3            0       2    3   0       2        1     1
## Al Norte       1            0       1    1   0       1        0     0
## Simon          1            0       1    1   0       1        0     0
## Brujita        1            0       1    1   0       1        0     0
## Nueva vida     1            0       1    1   0       0        0     0
## Detener        1            0       1    1   0       0        0     0
{% endhighlight %}
Como podéis ver, **Ocho y medio** se lleva la palma: puntúa en todo, tiene 3 puntos en tristeza y 4 en miedo pero también 1 en joy (¿eh?!, pero si la tabla no pone 1 punto en joy) 

Notita al margen: Ese punto de joy del que hablo no aparece en el cuadro de arriba por un detalle técnico que no quiero/puedo resolver: no sé que pasa con las tildes al pasar el post por jekyll, pero juro y perjuro que 8 y 1/2 tenía un puntito en joy. Más adelante hay más fallos de concordancia entre las puntuaciones de las tablas y el texto. En realidad salé todo como dice el texto, pero aquí, al pasarlo por Jekyl no me quita las tildes y eso hace que las palabras se clasifiquen de forma distinta.  Creo que tiene que ver con la codificación cuando kniteo la .R file, creo que debería poner UTF-8.    

Veamos el índice de tristeza/alegría ¿que canción ganará?


{% highlight r %}
print(sentiment_NV[,9:10])
{% endhighlight %}



{% highlight text %}
##            negative positive
## 8 y 1/2           6        3
## Al Norte          2        1
## Simon             1        0
## Brujita           1        1
## Nueva vida        2        0
## Detener           2        0
{% endhighlight %}
Pues **8 y medio** gana de calle en palabros tristes/negativos (6), PERO también tiene 4 happies ... 

NV, lo siento, todas tus canciones tienen al menos un punto negativo, así que .... **pero**, un momento, todo en esta vida es relativo, quizás debamos compararlo con otro cantante, ¿cual? NPI , ya ... Serrat y Mediterráneo.   

Vamos allá, repito el análisis incorporando mediterráneo de Serrat:




{% highlight r %}
letras2 <- c(letras, letra_mediterraneo)
letras2 <- chartr('áéíóúÁÉÍÓÚ','aeiouAEIOU',letras2)  #- quitar tildes
{% endhighlight %}



{% highlight text %}
## Error in chartr("áéíóúÁÉÍÓÚ", "aeiouAEIOU", letras2): 'old' is longer than 'new'
{% endhighlight %}



{% highlight r %}
letras2 <- chartr('?¿()!¡','      ',letras2)          #- interrogantes, parentesis y exclamaciones
{% endhighlight %}



{% highlight text %}
## Error in chartr("?¿()!¡", "      ", letras2): 'old' is longer than 'new'
{% endhighlight %}



{% highlight r %}
letras2 <- gsub(';|,|\\.|?|¿' , '', letras2)          #- comas, puntos y comas ....

sentiment_NV2 <- get_nrc_sentiment(letras2)
row.names(sentiment_NV2) <- c('8 y 1/2', 'Al Norte' , 'Simon', 'Brujita' , 'Nueva vida' , 'Detener', 'Mediterraneo')
{% endhighlight %}

Y los resultados se sentimientos son: 


{% highlight r %}
print(sentiment_NV2[,1:8])
{% endhighlight %}



{% highlight text %}
##              anger anticipation disgust fear joy sadness surprise trust
## 8 y 1/2          3            0       2    3   0       2        1     1
## Al Norte         1            0       1    1   0       1        0     0
## Simon            1            0       1    1   0       1        0     0
## Brujita          1            0       1    1   0       1        0     0
## Nueva vida       1            0       1    1   0       0        0     0
## Detener          1            0       1    1   0       0        0     0
## Mediterraneo     1            0       1    1   0       1        0     1
{% endhighlight %}
 Guau!, Mediterráneo tiene 1 punto en anger, disgust, fear y sadness. Casi mejor no escucharla :)


Y de tristeza/ alegría: 


{% highlight r %}
#sentiment_NV3 <- as.data.frame(sentiment_NV2) %>% arrange(desc(negative))
print(sentiment_NV2[,9:10])
{% endhighlight %}



{% highlight text %}
##              negative positive
## 8 y 1/2             6        3
## Al Norte            2        1
## Simon               1        0
## Brujita             1        1
## Nueva vida          2        0
## Detener             2        0
## Mediterraneo        3        2
{% endhighlight %}
Como veis mediterráneo tiene 2 puntos de tristeza. Sí, también 2 puntos de alegría, pero gana en tristeza a todas las de NV excepto 8 y 1/2 y Al Norte; es decir, las otras 4 canciones de NV son menos tristes que Mediterráneo: 4/6 es un  66.67 % 

Hasta aquí mi análisis de sentimientos de canciones de NV. Ya os dije que aprendería PNL en mi nueva vida, ahora que parece ser que va a llover sólo tengo un ambicioso plan, consistente en sobrevivir. 




Como ha quedado un poco cojo el análisis, ¡lo sé! voy a hacer un gráfico que siempre queda bonito. 



{% highlight r %}
corpus = Corpus(VectorSource(letras))   #- construye un corpus
corpus = tm_map(corpus, content_transformer(tolower))  #- a minusculas
corpus = tm_map(corpus, removeWords, c(stopwords("spanish"), "camila_vallejo"))  #- quita "palabras vacias"
corpus = tm_map(corpus, stripWhitespace)   #- quita espacion en blanco
tdm <- TermDocumentMatrix(corpus)          #- crea una matriz de términos
m = as.matrix(tdm)   #- convierte en matriz
wf <- sort(rowSums(m),decreasing=TRUE) #- conteo de palabras en orden decreciente

dm <- data.frame(word = names(wf), freq=wf) #- crea un df con las palabras y sus frecuencias
{% endhighlight %}

Finalmente el gráfico de nube de palabras:


{% highlight r %}
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
{% endhighlight %}

![center](/figs/2016-03-10-son-tristes-las-canciones-de-NV/nube-1.jpeg)

¿Como quedaría el gráfico de palabros si juntamos las 6 de NV con Mediterráneo? Pues así: 
![center](/figs/2016-03-10-son-tristes-las-canciones-de-NV/corpus_me-1.jpeg)
Salen un poco pequeñitos los gráficos. Ya los arreglaré.  

Eh!! Un momento, si no aparece la palabra Mediterráneo!! Así es, sorprendentemente Mediterraneo solo nombra 2 veces al (M)mediterráneo. Brujita aparece 4 veces y las que mas aparece en las 7 canciones es: ahora, vida y nueva. Mas de 40 veces!



PD: Maxi, espero que veas esto!!! Animo!!! Además el gráfico te lo sugiere:  Ahora vida nueva, !a aprovecharla!!

PD2: he querido arreglar algunas faltas y se me han ido los gráficos. Con lo chulos que estaban!, pequeñitos pero chulos
