---
layout: post
title: "Recopilación de trucos/cozitas de R"
author: Pedro J. Perez
description: 
category: r
tags: [Truquitos, R, In progress]
comments: true
---



En este post iré recopilando cosas que voy aprendiendo de R que creo que me pueden ser útiles. Como las iré recopilando poquet a poquet resultará en que este post va a estar continuamente (al menos hasta que DoRR) en progreso. 

Este post lo empecé a escribir el 30 de marzo de 2016 pero lo voy a poner despues de hello worls (en 2015), y lo voy a ir actualizando conforme vaya recopilando los truquitos. Muchos los tengo/tenía ya en un archivo pero no estaban subidos al blog.    

La fecha de compilación del post es [2016-03-30]


------------------------ 

<br>  

**METACRAN**: para bucear en los R-packages ve a:  [METACRAN](http://www.r-pkg.org/)






------------------------ 

<br>  
**REDONDEO**:   
Escrito el 2016-03-30

Karl Broman ayudó [aquí](https://gist.github.com/kbroman/5217617) a la chica de la taza (Hilary Parker). Son una pandilla!! Se conocen todos entre ellos!!!  

Karl Broman dixit [aquí](http://kbroman.org/knitr_knutshell/pages/Rmarkdown.html)(more or less):  

> I'm very particular about the rounding of results. I don’t want to see 0.9032738. I want 0.90. You could use the R function round, like this: `round(cor(x,y), 2)` But that would produce 0.9 instead of 0.90. One solution is to use: `sprintf("%.2f", cor(x,y))`. But a problem arises if the value is -0.001. `sprintf("%.2f", -0.001)` will produce -0.00. My solution to this problem is the myround function in my R/broman package.


{% highlight r %}
# a function to deal with sprintf("%.2f", ...) returning -0.00
# see https://twitter.com/hspter/status/314858331598626816

f <- function(..., dig=2) {
  g <- sprintf(paste0("%.", dig, "f"), ...)
  z <- paste0("0.", paste(rep("0", dig), collapse=""))
  g[g==paste0("-",z)] <- z
  g
}

# this should return c("0.000", "0.000", "0.500", "-0.500", "-0.002")
f(c(-0.0002, 0.0002, 0.5, -0.5, -0.002), dig=3)
{% endhighlight %}



{% highlight text %}
## [1] "0.000"  "0.000"  "0.500"  "-0.500" "-0.002"
{% endhighlight %}



------------------------ 

<br>  

**SESSION INFO**:   
Escrito el: 2016-03-30


{% highlight r %}
devtools::session_info()
{% endhighlight %}



{% highlight text %}
##  setting  value                       
##  version  R version 3.2.3 (2015-12-10)
##  system   x86_64, mingw32             
##  ui       RStudio (0.99.893)          
##  language (EN)                        
##  collate  Spanish_Spain.1252          
##  tz       Europe/Paris                
##  date     2016-03-30                  
## 
##  package   * version date       source        
##  codetools   0.2-14  2015-07-15 CRAN (R 3.2.3)
##  devtools    1.10.0  2016-01-23 CRAN (R 3.2.3)
##  digest      0.6.9   2016-01-08 CRAN (R 3.2.3)
##  evaluate    0.8.3   2016-03-05 CRAN (R 3.2.3)
##  formatR     1.3     2016-03-05 CRAN (R 3.2.3)
##  htmltools   0.3.5   2016-03-21 CRAN (R 3.2.4)
##  knitr     * 1.12.3  2016-01-22 CRAN (R 3.2.3)
##  magrittr    1.5     2014-11-22 CRAN (R 3.2.3)
##  memoise     1.0.0   2016-01-29 CRAN (R 3.2.1)
##  Rcpp        0.12.4  2016-03-26 CRAN (R 3.2.4)
##  rmarkdown   0.9.5   2016-02-22 CRAN (R 3.2.4)
##  stringi     1.0-1   2015-10-22 CRAN (R 3.2.3)
##  stringr     1.0.0   2015-04-30 CRAN (R 3.2.3)
##  yaml        2.1.13  2014-06-12 CRAN (R 3.2.3)
{% endhighlight %}


------------------------ 

<br>  

**Viewing R-Markdown output in real-time** with **servr** package   
[servr](https://github.com/yihui/servr)   provide real-time viewing of document in RStudio viewer while editing the source file.


```
install.packages('servr')  # stable version; use a CRAN mirror, or
servr::httd()
servr::httd(dir = "C:/Users/perezp/Desktop/a_GIT_2016/perezp44.github.io/"  )

```

Hice lo de arriba y me creo como una pagina web de "todo" mi PC
