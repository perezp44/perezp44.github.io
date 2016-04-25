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

La fecha de compilación del post es [2016-04-25]


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

------------------------ 

<br>  

**LOADING LIBRARIES**:   
Escrito el: 2016-03-30


```
libs <- c("dplyr", "ggplot2", "pwt8", "sfsmisc", "personal.pjp")
sapply(libs, library, character.only = TRUE, logical.return = TRUE)
rm(libs)
```


{% highlight r %}
#- Loading eurostat package
if (!require(eurostat)) {install_github("ropengov/eurostat")}     #- installing
library(eurostat)                                                 #- loading
if (!require(forecast)) {install.packages("forecast")}            #- installing
{% endhighlight %}


{% highlight r %}
PACKAGES <- c("eurostat","ggplot2","countrycode","tidyr","dplyr","knitr")
#  Install packages
inst <- match(PACKAGES, .packages(all=TRUE))  #- mira si hay un match
need <- which(is.na(inst))
if (length(need) > 0) install.packages(PACKAGES[need])
# Load packages
lapply(PACKAGES, require, character.only=T)
{% endhighlight %}

------------------------ 

<br>  

**Creating directories**:   
Escrito el: 2016-03-30


{% highlight r %}
# create folders
dir.create("./zip/", recursive = TRUE)  #- en el wd
{% endhighlight %}


------------------------ 

<br>  

**VER las f. que tiene un package**:   
Escrito el: 2016-03-30



{% highlight r %}
funs.eurostat <- as.data.frame(ls("package:eurostat"))   #- las f. del package
{% endhighlight %}


------------------------ 

<br>  

**Aun puedo ser Hadley!!**:   
Escrito el: 2016-03-30

Estaba intentando resolver un Pb en R y me he encontrado con esto:  
<http://r.789695.n4.nabble.com/Extending-a-vector-to-length-n-td886064.html>   
En unos años puedo ser Hadley Wickham. Lo veo claro!!   


------------------------ 

<br>  

**Guardar df en . XLXS EXCEL**:   
Escrito el: 2016-03-30
Hay varios packages. Cuando hice el aplicativo de forecast las use y me funcionaban. Tanto en cas como despacho. Ahora solo me funciona la ultima (al menos en casa)


{% highlight r %}
#- 1) con xlsx  (no chuta por algo de Java)
library(xlsx)
write.xlsx(GDP_tot_a, "C:/users/perezp/Desktpo/namq_10_gdp.xlsx", sheetName="namq_10_gdp") #- no me chuta Java   
#- 2)   (no chuta x algo de PERL)
library(WriteXLS)
testPerl(perl = "perl", verbose = TRUE) #- tienes que tener Perl
WriteXLS("GDP_tot", "C://users/perezp/Desktpo/namq_10_gdp.xlsx",  col.names = T)  #- tampoco vale pasa algo a PERL  

3)- EL QUE ME FUNCIONA (XLCONNECT) (al menos en casa)
#- http://altons.github.io/r/2015/02/13/quick-intro-to-xlconnect/#install
install.packages("XLConnect")
require(XLConnect)
file_name =  loadWorkbook("../data/xlconnect1.xlsx",create=T)
createSheet(file_name,"sheet_name") #- 
writeWorksheet(file_name,df,"sheet_name")
saveWorkbook(file_name,"C://users/perezp/Desktop/namq_10_gdp.xlsx")
#- buano, al final el file_name se lo doy entre comilla , el "name_file" solo era el nombre de la conexión
{% endhighlight %}
------------------------ 

<br>  

**CLEAR the R CONSOLE**:   
Escrito el: 2016-03-30


{% highlight r %}
cat("\014")       #- clear the console
{% endhighlight %}


------------------------ 

<br>  

**Create explicit data frames and TS objects given a list**:   
Escrito el: 2016-03-30


{% highlight r %}
market.list<- c("GR","CY","RU","RO","PL","UA","ROW")
for (i in market.list) {
  tmp <- subset(data,Market==i)
  tmp<-ts(tmp) # It's a timeseries afterall...
  # Let's save the data somewhere so we don't get back all the time
  filename <- paste("data_", i, sep="")
  assign(filename, tmp)
  save(filename, file=paste(filename, ".rda",sep=""))
{% endhighlight %}



------------------------ 

<br>  

**SAVING & loading .RDATA**:      
Escrito el: 2016-03-30   
It’s also possible to save multiple objects into an single file, using the RData format.


{% highlight r %}
# Saving multiple objects in binary RData format
save(data, file="data.RData")
# Or, using ASCII format
save(data, file="data.RData", ascii=TRUE)
# Can save multiple objects
save(data, data1, file="data.RData")

# To load the data again:
load("data.RData")
{% endhighlight %}

------------------------ 

<br>  


**Get Environment Variables**:   
Escrito el: 2016-03-30










Find your R home directory from the command line with Sys.getenv("R_Home")

{% highlight r %}
Sys.getenv(x = NULL, unset = "", names = NA)
{% endhighlight %}

