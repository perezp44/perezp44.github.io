---
layout: post
title: "Proceso(largo) de creación del blog"
author: Pedro J. Perez
description: 
category: r
tags: [jekyll, minimal-mistakes, blog]
comments: true
---






En este post voy a describir el proceso por el que pasé para poder crear este blog. En 2-3 días fui capaz de crear un blog; pero luego quise mejorarlo y eso me llevó más tiempo y tener que seguir diversas rutas. Al final el blog lo hice con Jekyll y Minimal-mistakes theme, partiendo del blog de [David Robinson](http://varianceexplained.org/)   

**Backgroung:** mientras iba intentando montar el blog iba escribiendo este documento, pero ahora que ya tengo montado el blog estoy reescribiendolo. Ahora sé más cosas que cuando lo escribí.   
Todos los post son principalmente para mí, pero este especialmente pues aunque lo he intentando pulir y ordenar, está muy "verbose" y algo desordenado. Dudo que se entienda pero es que quiero acordarme de las cosas que probé.  

## Primer intento (Jekyll blog en Github **à la Barry Clark**)

En mi primer intento cree un blog haciendo caso a [Barry Clark](https://github.com/barryclark/jekyll-now). **Gracias Barry!!**. Sí, conseguí crear el blog. Para ello tuve que hacer un fork de su repo. Es decir, al final cree un repo en mi cuenta de github forkeando el suyo. Luego solo había que cambiar el fichero `_config_yml`.  

Conseguí subir posts pero vi una pega: solo se pueden subir post en formato .md y yo quiero trabajar con `.Rmd`. (En realidad **sí se puede** pero entonces no lo sabía)

En su día escribí lo siguiente: he intentado subir ficheros `.Rmd` y no chuta. Tb he intentado subir la `.md` intermedia que hace Rstudio cuando knittea la .Rmd y sí pero no, porque los gráficos etc... los guarda como archivos externos. Tb he intentado subir el `.html` final pero tampoco ha funcionado. Ahora sé que solo es redirigir los gráficos etc...

Es decir, el blog llego  a estar operativo pero no me sirvió porque quería subir directamente ficheros `.RMd` al blog, así que pasé a intentar montar el blog de otra forma. 


**PERO**, por si acaso retomo mas adelante esta via, voy a describir (mas o menos) la forma de crear el blog y subir un post:

- Cree la estructura del blog desde el ordenador del despacho haciendo un `fork`  del [repo de Barry Clark](https://github.com/barryclark/jekyll-now)  

- Una vez esté el repo `jeckyll-now` en tu espacio de Github, le cambias el nombre a `tuusuariogithub.github.io` que en mi caso se convierte en  `perezp44.github.io `

- modificas el fichero `_config_yml`   para poner tus datos (esto lo cuento con mas detalle más abajo) y **YA ESTA!!**

- Puedes ver el blog en `http://tuusuariogithub.github.io`. Sólo te queda subir tus posts poniéndolos en la carpeta `_posts` en formato markdown (.md)




Como ya he dicho creé mi jekyll blog en el despacho y estab alojado en Github, PERO quería trabajar desde casa, así que tuve que **clonar el repo** de mi blog en el PC de casa. Para ello (**desde el Bash de Git**) has de hacer:   

1) Te sitúas en la carpeta donde quieres clonar el repo. En mi caso en "C:/Users/perezp/Desktop/a_R_2016"    
    

{% highlight r %}
cd C:/Users/perezp/Desktop/a_R_2016  
{% endhighlight %}

2) Clonas el repo que esta(ba) alojado en Github  
    

{% highlight r %}
git clone https://github.com/perezp44/perezp44.github.io.git   
{% endhighlight %}

3) Una vez clonado el repo, para **publicar un post en el blog**:  

    - ya sabemos que solo se pueden subir ficheros .md  (mentira)    
    
    - El fichero debe tener un YAML header específico  
    
    - un ejemplo de post muy sencillo seria:  
    
        
        {% highlight r %}
        ---
        layout: post   
        title: My first test!!!   
        --- 
        Post hecho solo para ver si se publicar en el blog. Solo para ver si todo chuta   
        {% endhighlight %}

    - Este texto lo has de guardar en un fichero `.md` y después lo has de incluir en la carpeta ` /perezp44.github.io/_posts`  
    
    - El nombre del fichero ha de tener esta estructura `2015-12-15-mi-primer-post-de-prueba.md`  (o sea, el nombre del fichero lleva la fecha y el titulo del post. En el nombre del fichero están prohibidas las mayúsculas. **NO MAYUSCULAS!!**
    
4) Una vez tienes el post guardado en tu PC (en Local), has de llevarlo a Github para que se publique. para ello has de hacer lo siguiente desde el Bash de Git:   
    
    {% highlight r %}
    1) cd C:/Users/perezp/Desktop/a_R_2016/perezp44.github.io    
    2) git add . 
    3) git commit --all --message "Publicación de un post en el blog"    
    4) git push -u origin master  
    {% endhighlight %}

## Segundo intento  (tb Jeckyll blog en Github pero **à la Brendan Rocks/Yihui Xie**) 

Esta vía fue un poco desastre pero fue la que me permitió aprender (un poco) que es Ruby (un lenguaje de programación), Jekyll (en realidad es un package/gem de Ruby) .... Así que desde CMD se puede (si tienes instalado Ruby y Jekyll) montar un blog con una simple linea de código, sólo que luego has de configurarlo a tu gusto (para ello conviene saber algo de CSS y HTML, vamos que lo dejé estar y me centré en ver algún blog que me gustase y utilizarlo como inspiración). 

Ya he dicho que fue un desastre pero casí lo consigo (ahora ya sabría hacerlo). Para acordarme cuanto más o menos lo que hice:  


- Seguí lo que se cuenta  [aquí](http://www.r-bloggers.com/blogging-with-rmarkdown-knitr-and-jekyll/). **Gracias Brendan**     

- [Aquí](http://yihui.name/knitr-jekyll/2014/09/jekyll-with-knitr.html) lo cuenta Yihui Xie  con mas detalle. **Gracias Yihui**    

- Como Brendan dice: 

> "the posts are written in `.Rmd` format. knitr parses the input file, executes code (e.g. data analysis), and saves any output assets to appropriate folders in > the blog's directory structure (e.g. plots/graphs/statistics). knitr also generates an .md format of the content, which is then fed to Jekyll to continue the process as normal. The entire local blog-generation process from .Rmd to HTML happens automatically". Fantastico, que bien suena!!!!   

> This system works flawlessly for static plots, but a few extra steps are required if you'd like to use one of the new htmlwidgets packages.(Ok, ya lo mirare despues)   

> Using Jekyll is easy. Although it's written in Ruby (a command-line programme) you don't need to know any Ruby to use it.

> While knitr-jekyll handles the process of generating blog posts, you'll probably want to customise the appearance of your blog before you start publishing. 


####  Para poder hacer un post *à la Brendan*:

Lo explica en su post pero:

1) Install R dependencies


{% highlight r %}
- install.packages(c("knitr", "servr", "devtools"))                 #- To process .Rmd files      
- devtools::install_github("hadley/lubridate")                      #- brocks reqs dev version   
- devtools::install_github("brendan-r/brocks")                      #- My lazy wrapper funs   
{% endhighlight %}


2)  Install Ruby & Jekyll   
- Instálate [Ruby](http://rubyinstaller.org/downloads/)  (yo me he instalado la versión 2.2.3 y al ejecutar la instalación he dicho que si a las 3 opciones que aparecen)    
- Instálate [Jekyll](http://jekyllrb.com/docs/installation/). Putadita, para windows es más complicado  

- PERO, parece que David Burela lo ha podido hacer a traves de Chocolateley. Lo explica [aquí](https://davidburela.wordpress.com/2015/11/28/easily-install-jekyll-on-windows-with-3-command-prompt-entries-and-chocolatey/).  
- ¿Qué qué es chocolateley? no idea, pero es `the BEST way to install and keep applications updated on windows`    

- O sea, para instalar Jekyll en windows hace falta Chocolatey, 

- Para instalar Chocolately, has de hacer lo siguiente desde CMD:  


{% highlight r %}
  - @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin  
  
  - Yo he corrido esa instrucción desde C:\     
  
  - Has de cerrar CMD y volver a abrirlo: Close the command prompt as Chocolatey will not be available until you close and reopen  
{% endhighlight %}

-Una vez instalado Chocolatey has de hacer lo siguiente (para instalar Ruby y Jekyll (yo ya había instalado Ruby pero lo he hecho igualmente):   


{% highlight r %}
- Open a command prompt with Administrator access y correr las siguientes instrucciones:
    - choco install ruby -y    [esto instalar Ruby]  
    
    - [Close and open a new command prompt with Administrator access]  
    
    - gem install jekyll  [esta linea instala jekyll que es un package de Ruby]  
{% endhighlight %}

- Sí, OK, a mí se me ha instalado y ahora: **you can use standard Jekyll commands to create a new site and serve it e.g.**  


{% highlight r %}
jekyll new myblog6666   #- con este comando de CMD me ha creado una plantilla para un blog: myblog6666
cd myblog
jekyll serve
{% endhighlight %}

Aquí es donde me dí cuenta de que Jekyll es un package/gem de Ruby que crea blogs, pero luego hay que personalizarlos y eso duele, así que clone (forkee) el de Yihui   

- Tb, para instalar Ruby y Jekyll lo explican mejor en http://jekyll-windows.juthilo.com/  


3) Clone or download Yihui's knitr-jekyll repo (has de hacer un fork  de su repo alojado en Github). Para ello:
    
- he hecho un fork del repo de Yihui: https://github.com/yihui/knitr-jekyll . Solo hay que ir a esa dirección y darle al botón fork y se te crea una copia del repo en tu cuenta de Github)  

- mi copia del repo en Github esta en: https://github.com/perezp44/knitr-jekyll.git   

- Para clonar mi repo en el PC de casa, has de hacer en la shell de Git:

{% highlight r %}
cd C:/Users/perezp/Desktop/a_R_2016         #-te sitúas en el directorio donde quieres clonarlo
git clone https://github.com/perezp44/knitr-jekyll.git 
{% endhighlight %}


4) Dentro del repo hay un archivo `knitr-jekyll/knitr-jekyll.Rproj`, ábrelo y a hacer posts haciendo lo siguiente: 



{% highlight r %}
library(brocks) #- te instalas la librería personal de Brendan Rocks (https://github.com/brendan-R/brocks) donde está la función `new_post()`  

new_post("My first blog post!") #- con esta función se debería crear el primer post  
{% endhighlight %}

<br>


#### A probar!!!!! A ver si funciona!!!

- Casi va pero no. En su momento no me funciono, así que cambie de vía pero creo que ahora si sabría hacer que funcionase, pero ya tengo mi blog en marcha, así que lo dejo correr  

- Al correr la siguiente instrucción ` new_post("Post title!")` con diferentes nombres del post me da el siguiente mensaje de error:   

{% highlight r %}
   File .skeleton_post does not exist. Using package default
   Error in shell.exec(f) : '_source/post-title/post-title.R' not found
   In addition: Warning message:
   In dir.create(fpath) : '_source\post-title' already exists
{% endhighlight %}

- Así que estuve probando cosas, en concreto probé: ` http://jekyll-windows.juthilo.com/1-ruby-and-devkit/ `. Donde explican como instalar Ruby y Jekyll en Windows  

- Creo que sí que me funciona ok Ruby y Jekyll, incluso pude crear la estructura de un Jekyill blog locally. Las instrucciones están en : `http://jekyllrb.com/`. En concreto hay que hacer en CMD:


{% highlight r %}
~ $ gem install jekyll     #- en realidad yo ya tengo instalado el gem jekill  
~ $ jekyll new myblog      #- va a crear un blog en la carpeta myblog (en la ruta ~ en la que estes en CMD )  
~ $ cd myblog              #- situo a CMD en el directorio myblog  
~/myblog $ jekyll serve    #- inicializa el blog  
                              # => A development server will run at http://localhost:4000/  
                              # => Now browse to http://localhost:4000  y veras tu blog "myb"  
{% endhighlight %}


- Probé bastantes mas cosas, por ejemplo probé algo como:     

{% highlight r %}
bb <- "C:/Users/perezp/Desktop/a_R_2016/knitr-jekyll"  
servr::jekyll()  
{% endhighlight %}

- Creo que estaba usando el package servr que ya tiene una funcion jekyll()


- Obviamente probé las funciones que preparo Brendan en su package/repo called `brocks`  


{% highlight r %}
new_post("Post title!")   #- sets up RStudio (or your default applications) for writing a blog post. 
                          #- I use a slightly different directory structure from normal,                           
                          #- with each blog post in it's own folder, just to keep the files tidy. 
blog_push()               #- Rebuilds the site locally
blog_serve()              #- is a tiny wrapper around Yihui's servr::jekyll(serve = TRUE), 
                             accounting for my extra directory levels above
blog_gen()                #- Generates all the static files (without running a local webserver).
                             Wraps servr::jekyll(serve = FALSE).
blog_opts()               #- Is a set of knitr chunk options I find useful for blogging. 
                             In general I want to show plots, not the code that derived them, 
                             so adding this to my boilerplate saves me typing echo=FALSE, 
                             warning=FALSE, ... in every chunk.
blog_push()               #- The laziest wrapper function of all, this just runs blog_gen() 
                             followed by an arbitrary system() command, 
                             which I use to push this site up on S3.
{% endhighlight %}


-  Puff!!! Aquí estuve luchando para que me funcionase. Conseguí que se publicaran un post localmente pero no puede hacer que se viesen online. Así que cabreado y confuso probé otra vía 





## TERCER intento de montaje del blog (tb Jekyll blog en Github pero *à la Andy South*)

Este sí que funcionó, incluso fui capaz de tunearlo a mi gusto (con tags etc...) pero luego me gustó mas el blog de David Robinson que es el que utilicé para crear el mio.


Me leí el [post de Andy South](http://www.r-bloggers.com/blog-with-rstudio-r-rmarkdown-jekyll-and-github/). Andy quería lo mismo que yo quiero:  

  > to write about R related things without having to copy and paste code, figures or files.
  
- Andy escribe sus post en Rmarkdown (.Rmd) y corre una funcion de R para convertirlo a markdown (.md). No tuvo que instalarse Ruby ni Jekyll. Es un tio listo:  

> The blog is hosted for free on Github (you get one free personal site). The site is created using Jekyll on Github, so I didn't need to install Jekyll or Ruby. I simply edit files locally, then commit and push to Github. I manage the site as an RStudio project, enabling me to edit text, keep track of files and interact with Git all from one interface. 

- Andy usa the Barry Clarks amazing Jekyll-Now repository which you can fork directly from Github and start editing to customize (o sea, usa el primer método por el que intenté crear el blog. Realmente lo cree y funcionaba, el Pb era que solo cargaba `.md` files y yo quiero trabajar con `.Rmd` (en realidad sí se puede pero yo no sabía, Andy me enseño).


> Andy: Thanks to Jan Gorecki whose answer on stackoverflow pointed me in this direction and I've copied some extra features like the Links and Index pages from his site.  

**Jan Gorecki answer a una pregunta de Andy**

{% highlight r %}
As of November 2014 there is easy method to blog from R to your blog hosted on github pages. No databases, no local environment, no new admin panels. Only web browser, github and R are required.
    Fork Jekyll Now to deploy pre-configuerd Jekyll (a static site generator) into your github repo. 
    Change new repo name.  
    Edit _config.yml to set some global variables (here you can setup RSS, Disqus, Google Analytics, etc.)  
    Your blog posts will be located in _posts directory.  
    Use R packages rmarkdown or knitr to render your Rmd file to md.  
    Upload/copy&paste your YYYY-MM-DD-my-first_post.md to _posts directory.  

As example my minimalist blog at: jangorecki.github.io
It's repo at github.com/jangorecki/jangorecki.github.io

Also storing Rmd files in your repo gives ability to reproduce the post (+R chunks of course) locally in R by anybody.
{% endhighlight %}

##### En el blog de Andy South no se mostraban los tags ¿Como incluirlas?   

Sí que se mostraba en la página de inicio del blog, pero luego no se generaba el índice de tags.   
Tuve que modificar el fichero `default` . Solo tuve que modificar una linea:   


{% highlight r %}
<!--<a href="{{ site.baseurl }}/tags">Tags</a>-->      #- quite esta linea (esta capada)
<a href="{{ site.baseurl }}/tags">Tags</a>             #- puse esta linea
{% endhighlight %}



Aquí yo ya estaba muy cerca de entenderlo todo (parece un caso de doble o triple asesinato) y me paré a jugar con los repos de Jan Gorecky y Andy South. Creo que [este post](http://www.smashingmagazine.com/2014/08/build-blog-jekyll-github-pages/) me ayudo mucho a entenderlo. Vamos que al final podía crear blogs similares al de Andy South y tunearlos a mi gusto (añadir tags me costó un poco) y medio entendía lo que estaba haciendo.  

Aun me quede con ganas de mirar en profundidad estos dos post:  

- http://lcolladotor.github.io/2013/11/09/new-Fellgernon-Bit-setup-in-Github/  


- http://yihui.name/knitr-jekyll/2014/09/jekyll-with-knitr.html 

> The R package servr can be used to set up an HTTP server to serve files under a directory. Since servr v0.2, it has added a function servr::jekyll()  specifically designed for websites based on Jekyll and R Markdown  
 

Ya he dicho que me quede con ganas de mirar esos 2 posts, pero lo que hice fue utilizar el blog de [David Robinson](http://varianceexplained.org/) para crear el mio. Lo forkee y lo tunee a mi gusto.  


## CUARTO (y en principio último) intento de montaje del blog (tb Jekyll blog en Github pero con Minimal-Mistakes theme)  *à la David Robinson*  

Al final mi blog (este blog) es muy parecido al de David Robinson. Forkee su repo y después lo modifique con mis datos y añadí algunas cosas:  

1) Forkear el blog/website de David Robinson at https://github.com/dgrtwo/dgrtwo.github.com  

  - se crea el repo `dgrtwo.github.com` en tu sitio de Github  
  - cámbiale el nombre a `tu_usuario_github.github.io`   
  - puedes ver "tu blog" en http://tu_usuario_github.github.io   **PERO** claro aparece con todos los datos de David Robinson y sus post   
  
2) Para que aparezcan tus datos has de modificar los siguientes ficheros:   

- el fichero `_config.yml`. Concretamente has de modificar las siguientes lineas de  `_config.yml` :  
  

{% highlight r %}
# Site wide configuration  
title:            Variance Explained  
url:              http://varianceexplained.org  
name: Variance Explained  
description: Thoughts on statistics, data science, computational biology, education, and R  
# Site owner  
owner:  
name: David Robinson  
avatar: david_robinson_picture2.jpg  
bio: "Data Scientist at Stack Overflow, works in R and Python."  
email: drobinson@stackoverflow.com  
disqus-shortname: varianceexplained  
twitter: drob  
github: dgrtwo    
stackoverflow: 712603     
Si por ejemplo no tienes cuenta de twitter (o disqus o stackoverflow), deja la linea de twitter como `twitter:`. Seguro que has de tener cuanta de github pues pones `github: tu_ususario_github`  
{% endhighlight %}

- Para cambiar la foto de Andy por la tuya. Sustituye el fichero `/images/david_robinson_picture2.jpg' por una foto tuya en formato `.jpg`  

- El fichero `index.md` . Este fichero es una pequeña descripcion del blog y su temática.     
    
- Borra todos los post de David. Para ello borra todos los ficheros de las carpetas `_R`  y `posts`. Logicamente luego habrás de subir tus posts  

- Modifica el fichero `about/index.md`. En este fichero hay una bio de David. Pon tus datos/bio  

- Borra la carpeta `courses`. Es un curso de David   

- En el fichero `_data/navigation.yml`   borra la ultima parte y guarda el archivo. Borra lo siguiente:

    
    {% highlight r %}
    - title: R Course  
      url: /RData/  
    {% endhighlight %}

Creo que eso es todo. Al menos eso es todo lo que recuerdo. Espero que funcione pero no lo aseguro 100%. No voy a repetir el proceso.   

También lo enlace a Google Analytics: hay que registarse y Google te da un nº que hay que poner en el archivo `_Config.yml` y un trozo de código que hay que poner en el archivo `_includes/_head.html`

### Tuneado del blog 

El blog de david es muy bonito pero habían cosas que no me gustaban, así que las cambie:


- El indentado/sangrado de los parrafos. Quería que no  sangrase el principio del párrafo y que los párrafos se separasen por una linea en blanco, así que google me dio la respuesta [aquí](https://github.com/mmistakes/minimal-mistakes/blob/master/theme-setup/index.md#paragraph-indentation)  

{% highlight r %}
To disable the indents and add spacing between paragraphs change the following line in _sass/variables.scss from true !default to false like so.  
{% highlight css %} $paragraph-indent: false; {% endhighlight %}  
{% endhighlight %}

- Quería añadir TAGS al blog. Encontre la solución [aquí](http://dareneiri.github.io/Jekyll-Themes-and-Tags/)  

{% highlight r %}
In your primary GitHub directory, create a new directory called tags
Create an index.md file, and copy-paste the following (courtesy of lanyonm):   
{% endhighlight %}
    - has de crear un carpeta llamada tags y crear un fichero `index.md` como se muestra en el anterior link  
    - Lo hice pero no me funciono porque has de incluir en tu fichero de navegación el link a la hoja de tags. esto lo aprendí [aquí](https://github.com/mmistakes/minimal-mistakes/blob/master/theme-setup/index.md#navigation-links)  
    
    {% highlight r %}
    To set what links appear in the top navigation edit _data/navigation.yml. Use the following format to set the URL and title for as many links as you'd like. External links will open in a new window.  
    {% endhighlight %}
    - Así que modifiqué el archivo `_data/navigation.yml` para que parecieron los tags  
 

- Aprovechando que ya sabía incluir pestañas de navegación dentro del blog. Añadí 2 pestañas mas: `Links` y `Tareas`. Para ello tuve que crear 2 carpetas mas (links y tareas) con un fichero index.md y otra vez modificar el fichero `_data/navigation.yml` para que apareciesen en el home del blog. Incluí lo siguiente:   


{% highlight r %}
- title: Tags
  url: /tags/
  
- title: Links
  url: /links/   
  
- title: Tareas
  url: /tareas/  
{% endhighlight %}
    


<br>
Bueno y creo que eso es todo. **Fin del tuneado**


### ¿Cómo subir post al blog?  

1) Los post se escriben en formato `.Rmd`. La cabecera del post debe ser como:   


{% highlight r %}
  ---
  layout: post
  title: "Hello world!!"
  author: Pedro J. Perez
  description: "Only to say hello world"
  category: r
  tags: [r, blog]
  comments: true
  ---
{% endhighlight %}
  
  
No te olvides que el nombre de los ficheros .Rmd deben contener la fecha y el titulo del post en un formato como: `2015-12-30-titulo-del-post.Rmd`. **Las mayúsculas y acentos están prohibidas** en el nombre de los ficheros .Rmd   

Después de la cabecera del post, también has de incluir lo siguiente:  

{% highlight r %}
  #```{r setup, echo = FALSE, warning=FALSE}  
  library(knitr)  
  opts_chunk$set(message=FALSE, cache=TRUE, warning=FALSE, echo=TRUE, dev="jpeg")  
  #```     
{% endhighlight %}
Obviamente los `#` no has de ponerlos. Los tuve que poner xq sino knitr fallaba x un Pb en el setup (creo que fallaba porque utilizaba la marca de chunk normal en lugar de chunk de R)

2) una vez escrito el post. Guárdalo en la carpeta `_R`   
3) Abre el fichero `_scripts/knitpages_pjp.Rmd`  y modifica la siguiente linea con la ruta a tu repo Local  

{% highlight r %}
ruta_in <- "C:/Users/perezp/Desktop/a_R_2016/perezp44.github.io"  #- has de poner la ruta donde tengas el "repo" local
{% endhighlight %}
4) Al correr el fichero (por ejemplo en RStudio) se kniteran todas las .Rmd files que hayan en la carpeta `_R`. Se crearan los correspondientes ficheros .md en la carpeta `posts` que son los que realmente se publicarán en tu blog   

5) OK, ya están creados los post (.md) solo queda subirlos a Github y esperar a que se actualice tu blog   



Ale, voy a subir este post al blog (espero saber hacerlo, que ya hace 4-5 días que aprendí a hacerlo y por poco se me olvida)




