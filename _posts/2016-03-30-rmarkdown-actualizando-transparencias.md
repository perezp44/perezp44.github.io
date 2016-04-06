---
layout: post
title: "Actualizando (un poco) my knowledge de Rmarkdown y demás"
author: Pedro J. Perez
description: 
category: r
tags: [Rmarkdon, In progress]
comments: true
---



Se acabó la SS y se aproxima la fecha en que tengo de dar clase en el Máster de Economía; concretamente en la asignatura Macroeconometrics y tengo que revisar/actualizar mis transparencias de clase. En el curso utilizo R, así que las transparencias las escribí en Rmarkdown y para visualizarlas utilice el formato presentación de **slidy** directamente desde RStudio. Para saber algo de slidy y ver que chulas quedan estas presentaciones puedes ir [aquí](https://www.w3.org/Talks/Tools/Slidy2/Overview.html). Creo que el formato slidy quedaba bastante apañado pero este año creo que voy a usar directamente transparencias en html. Ya veremos. Allá vamos con el post sobre mis conocimientos (de usuario básico) de Rmarkdown.     


Disclaimer: seguro que me equivoco en algunos detalles técnicos. Recordad que mi nivel es de ususario y además, muchas veces explicar bien las cosas me llevaría mucho mas tiempo y espacio. No!!      

**Primera idea:** para escribir en internete (paginas web, blogs, ...) el lenguaje de referencia es HTML, pero escribir en html es complicado y feo-feo para leer su código; así que [John Gruber](http://daringfireball.net/) (con la ayuda del tristemente fallecido activista de internet [Aaron Swartz](https://es.wikipedia.org/wiki/Aaron_Swartz)) crearon [**markdown**](https://es.wikipedia.org/wiki/Markdown), un lenguaje de marcado sencillo cuyo objetivo era que permitiera una fácil escritura/lectura de textos que serían fácilmente exportables a HTML para publicarlos en internet. En palabras de Jhon Gruber: `Markdown is a text-to-HTML conversion tool for web writers`

Cuando veáis esta entrada en el blog la veréis en HTML pero la estoy escribiendo en markdown, concretamente en **Rmarkdown**, una variante de markdown desarrollada por RStudio. (menudo lio!!!). En la web de Rmarkdown podemos leer que:  

> R Markdown is an authoring format that enables easy creation of dynamic documents, presentations, and reports from R. 
> It combines the core syntax of markdown (an easy to write plain text format) with embedded R code chunks that are run 
> so their output can be included in the final document. R Markdown documents are fully reproducible (they can be automatically regenerated whenever underlying R code or data changes). R Markdown has many available output formats including HTML, PDF, MS Word, Beamer, HTML5 presentations, Tufte handouts, R package vignettes, and even entire websites.  

Con mis palabras: R Markdown es una versión de Markdown que permite incorporar trozos de código R. Una vez escrito el documento en .Rmd, se puede usar knitr para crear documentos reproducibles.  


**Segunda idea:** si utilizas R para hacer algún tipo de análisis estadístico es muy fácil que sepas escribir documentos en Rmarkdown desde RStudio. Realmente es muy fácil, solo hay que usar los menús desplegables y crear un documento Rmarkdon, escribir lo que quieres contar y darle al botón knitr.  Muy-muy fácil. Para aprender aprender Rmarkdown, tienes que ir [aquí](http://rmarkdown.rstudio.com/). La cheatsheet es fantástica. Con esta cheatsheet no tengo que explicarme/recordarme a mi mismo en este post como escribir en .Rmd. Me basta con mirar la chuleta para recordar como escribir ecuaciones, links, imágenes, notas al pie, negrita, options chunks, inline chunks, etc...  , así que ese no será el objetivo del post. Mi objetivo es poder "customizar" un poco más mis transparencias. Yo ya se cosas de knitr, md ... pero quiero ver si profundizo/sistematizo un poco más y con este post no olvidarlo después.  

<br>

He avanzado bastante las transparencias. Uso Rmarkdown v.2 que permite tener un toc flotante y algunas cosas mas. El estilo. El YAML header es:  

```
---
title: "Notes on Applied VAR Modelling"
author: "Pedro J. Perez"
date: "30 de marzo de 2016"
output: 
  html_document:
    highlight: pygments 
    number_sections: no
    theme: united
    toc: true
    toc_float: true
    code_folding: show
    self_contained: TRUE
---
```

----------------------------------------------------------------------------------------         
----------------------------------------------------------------------------------------         
  
##### El resto de este post/entrada ya Síí que es para mí, así que es como un post *continuamente* **in progress**.  

Muchas de los trucos/cosas que cuento más bajo están sacadas de algunas de estas webs/blogs: 

- http://daringfireball.net/projects/markdown/syntax#html [Documentación oficial de markdown]   

- http://daringfireball.net/projects/markdown/dingus [Dingus: traductor de markdown a HTML]   

- http://rmarkdown.rstudio.com/ [Documentación oficial de Rmarkdown]  




- http://kbroman.org/knitr_knutshell/  [Karl Broman tiene tutoriales, ... y un **curso muy bueno en RR**]   




----------------------------------------------------------------------------------------         
----------------------------------------------------------------------------------------         
      
<br>

El **worflow** para crear documentos reproducibles es:  

  1. Escribes el documento en Rmarkdown: an `.Rmd` file
  2. `knitr` ejecuta los code chunks y pone el texto y los resultados en una `.md` file. Las "figures" las pone aparte, puedes decir donde con la option chunk `fig.path='Figs/'`[^1]   
  
  3. `pandoc` convierte la .md file a diferentes formatos: html, pdf ....  
  
  
> To process an R Markdown document, you need the rmarkdown package (which in turn will make use of the knitr package
> plus a bunch of other packages), as well as pandoc.  

A mí me funcionó así (al ppio tuve pbs con las tildes, pb de encoding):   


```
library(rmarkdown)
rmarkdown::render('knitr_example.Rmd', encoding = 'UTF-8')
```


------------------------          
<br>
 
Si quieres poner un **H1 header en color**, puedes escribirlo directamente en HTML (recuerdas que dije que el HTML era feo-feo):  

{% highlight r %}
 <center><h1 style="color:darkblue;"><big><b>Introduccion practica a</br> R y RStudio<br> INTRODUCCION</h1></b></big></center> 
{% endhighlight %}
Aunque es mejor definir estilos al ppio del documento.  

<br>

------------------------     

<br>

Para fijar **opciones globales para los chunks** hay que usar `knitr::` (o cargar knitr con library()). Yo hago las 2 cosas:   

<pre><code>```{r setup2, echo = T, warning=FALSE, eval = T}    
library(knitr)    
opts_chunk$set(message=FALSE, cache=TRUE, warning=FALSE, echo=TRUE, dev="jpeg", fig.width=12, fig.height=8, fig.path='Figs/' )   
```</code></pre>



------------------------ 

<br>  

Para formatear **tablas con knitr** mira este post: http://kbroman.org/knitr_knutshell/pages/figs_tables.html

------------------------ 

<br>  

[Aquí](http://kbroman.org/knitr_knutshell/pages/Rmarkdown.html) explica cosas del **YAML header**: YAML is a simple text-based format for specifying data, sort of like JSON but more human-readable.  

- `output: html_document` le dice al `rmarkdown` package que convierta la .Rmd file a html. 


------------------------ 

<br>  

**cargando packages: ** Karl Broman al comienzo de sus .Rmd  incluye:

```

{r load_packages, include=FALSE}
      library(broman)  
      
(faltan los 3 backtips al ppio y al final)
```





------------------------ 

<br>  

**Backslash Escapes in markdown**  [aquí](http://daringfireball.net/projects/markdown/syntax#backslash)

Por ejemplo: si pones una palabra rodeada de arteriscos sale en cursiva. Si quieres que salgan lso arteriscos has de poner Backslashes antes de los arterisco como:   

```
si escribes:    \*literal asterisks\*  
dará como resultado *literal asterisks*
```  


------------------------ 

<br>  

**Formulas con Lix y knitr** [aquí](http://yihui.name/knitr/demo/lyx/)   



------------------------ 

<br>  

Dean Atalli crea the **ezknitr package** para poder knittear desde cualquier directorio:  
> The two main functions are ezknit() and ezspin(), which are wrappers around knitr’s knit() and spin(), used to make rendering markdown/HTML documents easier.  

http://deanattali.com/blog/ezknitr-package/

------------------------ 

<br>  

Diferentes formatos para las .Rmd  en : http://blog.rstudio.org/2016/03/21/r-markdown-custom-formats/

Los formatos propios de RStudio, los que mas me gustan son: `theme: readable o  united` (que sale naranjita)
para cargar las templates:
```
install.packages("rticles", type = "source")  
install.packages("tufte")
install.packages("rmdformats")
```

Se puede hacer desde RStudio, pero si quieres hacerlo  a mano, en lugar de `output: html_document`:  
```
---
output: html_document
output: tufte::tufte_handout
output:
  rmdformats::readthedown:
---
``` 

<br>  


------------------------ 

<br>  

Para incluir **verbatim (R code chunks)** se hace con  (otra vez ggracias a Karl Broman) `<pre> and <code> tags`:  

``` 
<pre><code>```{r whatever3}
data(cars)
summary(cars)
 ```</code></pre>
```  

Se vería así:  

<pre><code>```{r whatever3}
data(cars)
summary(cars)
```</code></pre>

<br> 

------------------------ 

<br>  

Para introducir **estilos** sin tener que tener una CSS file propia   htttp://stackoverflow.com/questions/34022558/r-markdown-how-to-change-style-with-internal-css  

```
Después del YAML header tienes que:

<style>
    #header1 {color: red;}
</style>  

 y después poner el estilo, asín: 
## Header 1 {#header1}   #- funciona pero me ponía en red toda la seccion, asi que es mejor hacerlo como digo mas abajo
```


Estilos que estoy usando en mis transparencias:  

```
<style>
  p {margin: 15px 0 17px 0;}  #- "Margenes entre parrafos"    top, izquierda, abajo, left
</style> 

<style>
  body { line-height:2.0;}   #- anchura de las lineas 1.0 is the default in Firefox. 2.0 provides a large space
</style>
  
<style>
  h1, h2, h3, h4, h5  {color:darkblue;}  #- esto me hace los h1, h2 ... en dark blue
</style>  
```






Otros estilos que me han sido utiles:

```
#- En lugar de usar una CSS file puedes definir estilos al  ppio del .Rmd     
#-- lo puedes poner al ppio de tu .Rmd (debajo del YAML)

h1, h2, h3 {font-family: tahoma, color: #333} 
  
<style>
  para_1{border: 1px solid grey; padding: 10px; }   #- pone un cuadro alrededor del texto
</style>
    
  
<style>
  p {margin-top: 0em; margin-bottom: 2em; }   #- espaciado entre parrafos
</style> 
```


Si en lugar de definir estilos quieres usar tu propia CSS file:

```
#- puedes usar tu propia CSS file. Lo has de especificar en el YAML
#- La file  CSS que usa markdown esta en la lib de R dentro de Markdown
------ 
output: 
  html_document: 
  css: C:/Users/perezp/Desktop/CSS/markdown.css
-------
```








------------------------    
**FOOTNOTES:**

[^1]: the ending slash in Figs/ is important. Si haces fig.path='Figs' then the figures would go in the main directory but with Figs as the initial part of their names
