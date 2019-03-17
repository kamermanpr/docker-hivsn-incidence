###############################################################################
#                                                                             #
# KAMERMANPR/incidentHIVSN                                                    #
#                                                                             #
# <-- Build command -->                                                       #
# docker build -t kamermanpr/docker-incidentHIVSN:<version>                   #
#                                                                             #
# <-- The build image can be downloaded from Docker Hub -->                   #
# docker pull kamermanpr/docker-incidentHIVSN:<version>                       #
#                                                                             #
# <-- Run command -->                                                         #
# docker run --name hivsn -d -p 8787:8787 -e USER=user -e PASSWORD=password   #
# kamermanpr/docker-incidentHIVSN:<version>                                   #
#                                                                             #
# <-- Login to RStudio -->                                                    #
# In your browser, navigate to: localhost:8787                                #
# Username: user                                                              #
# Password: password                                                          #
#                                                                             #
###############################################################################

#-- Get the verse rocker image --#

FROM rocker/verse:3.5.2

MAINTAINER Peter Kamerman <peter.kamerman@gmail.com>

# <-- Add GitHub package -->
RUN Rscript -e "devtools::install_github('thomasp85/patchwork')"

#-- Install extra packages --#

RUN Rscript -e "install.packages(c('tidyverse', 'magrittr', 'skimr', 'rcompanion', 'knitr', 'boot', 'coin', 'lubridate', 'glmnetUtils', 'survival', 'survminer', 'readxl'))"
