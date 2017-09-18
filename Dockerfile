# in order to avoid compatability issues with computers at the lab, 
# start from verse:latest (which is 3.4.1 at the time of writing this manual)

#### Dockerfile contents

# standing on shoulders of giants
FROM rocker/verse:3.4.1                     
LABEL maintainer="alperyilmaz@gmail.com"

RUN apt-get update && apt-get install -y --no-install-recommends imagemagick libudunits2-dev \
    && rm /var/lib/dpkg/info/* \
    && rm /var/lib/apt/lists/*debian*

## these packages are already in rocker/verse so no need to install separately,
## but still need to maintain a list for local install
## bookdown data.table devtools git2r igraph Lahman maps microbenchmark nycflights13 PKI RefManageR rmarkdown RMySQL rsconnect RSQLite shiny splines tidyverse zoo

RUN install2.r animation blogdown caret citr corrplot DT e1071 feather flexdashboard formatR gapminder ggraph ggrepel leaflet mindr plotly plumber pryr rcrossref swirl tidytext tidygraph tm tweenr wordcloud xgboost \
    && installGithub.r dgrtwo/gganimate yihui/xaringan

# swirl courses and bioconductor packages installed by Rscript
RUN > rscript.R \
    && echo 'library(swirl)' >> rscript.R \
    && echo 'install_course("R Programming")' >> rscript.R \
    && echo 'install_course("R Programming E")' >> rscript.R \
    && echo 'install_course("Getting and Cleaning Data")' >> rscript.R \
    && echo 'install_course("Exploratory Data Analysis")' >> rscript.R \
    && echo 'install_course("A_(very)_short_introduction_to_R")' >> rscript.R \
    && echo 'source("https://bioconductor.org/biocLite.R")' >> rscript.R \
    && echo 'biocLite(ask=FALSE)' >> rscript.R \
    && echo 'biocLite("Gviz",ask=FALSE)' >> rscript.R \
    && echo 'biocLite("biomaRt",ask=FALSE)' >> rscript.R \
    && echo 'biocLite("TxDb.Mmusculus.UCSC.mm9.knownGene",ask=FALSE)' >> rscript.R \
    && echo 'biocLite("TxDb.Hsapiens.UCSC.hg19.knownGene",ask=FALSE)' >> rscript.R \
    && Rscript rscript.R \
    && rm /tmp/downloaded_packages/*