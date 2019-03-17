# docker-incidentHIVSN

A dockerfile to create an image of the R environment required to run the 'hivsn-incidence' data analysis scripts ([kamermanpr/hivsn-incidence](https://github.com/kamermanpr/hiv-incidence.git)).

----

## R environment

The image is built using the [_rocker/verse_](https://hub.docker.com/r/rocker/verse/) image of [_base R_](https://cran.r-project.org/) _v3.5.2_, and includes [_RStudio server_](https://www.rstudio.com/products/rstudio/#Server), the [_TinyTex_](https://yihui.name/tinytex/) Latex distribution, the [_tidyverse_](https://www.tidyverse.org/) suite of R packages (with dependencies), and several R packages (with dependencies) that are required to run the markdown scripts in [_hivsn-incidence_](https://github.com/kamermanpr/hivsn-incidence.git). CRAN packages were installed from [MRAN](https://mran.microsoft.com/timemachine) using latest package versions at the time of the build. The only package installed from GitHub (_thomasp85/patchwork_) was locked to the 22 September 2018 commit: [_fd7958bae3e7a1e30237c751952e412a0a1d1242_](https://github.com/thomasp85/patchwork/tree/fd7958bae3e7a1e30237c751952e412a0a1d1242).

### Details
- **OS:**  
    - Debian:stretch
- **R:**  
    - v3.5.2  
- **RStudio server:**  
    - v1.1.456 
- **GitHub packages:**  
    - patchwork  
- **MRAN packages:**  
    - boot
    - car
    - coin
    - ggplot2
    - glmnetUtils
    - knitr
    - lubridate
    - magrittr
    - readxl
    - rcompanion
    - skimr
    - survival
    - survminer
- **LaTex:**   
    - TinyTex

----

## Using Docker to run the SPARS analysis

You need to have Docker installed on your computer. To do so, go to [docker.com](https://www.docker.com/community-edition#/download) and follow the instructions for downloading and installing Docker for your operating system. Once Docker has been installed, follow the steps below, noting that Docker commands are entered in a terminal window (Linux and OSX/macOS) or command prompt window (Windows). Windows users also may wish to install [_GNU Make_](http://gnuwin32.sourceforge.net/downlinks/make.php) (required for the `make` method of running the scripts) and [_Git_](https://gitforwindows.org/) version control software (not essential). 

#### Download the latest image

Enter: `docker pull kamermanpr/docker-incidentHIVSN:v1.0.3`

#### Run the container

Enter: `docker run run --name hivsn -d -p 8787:8787 -e USER=user -e PASSWORD=password kamermanpr/docker-incidentHIVSN:v1.0.3`

#### Login to RStudio Server

- Open a web browser window and navigate to: `localhost:8787`

- Use the following login credentials: 
    - Username: _user_	
    - Password: _password_
    
#### Prepare the incidentHIVSN directory

The incidentHIVSN directory comes with the outputs for all the analysis scripts in the _/outputs_ directory (_html_ and *md* formats). However, should you wish to run the scripts yourself, there are several preparatory steps that are required:  

1. Acquire the data. The data required to run the scripts have not been included in the repo because participants in the studies did not consent to public release of their data. However, the data are available on request from Peter Kamerman (peter.kamerman@gmail.com). Once the data have been obtained, the files should be copied into the _/data_ subdirectory.

2. Clean the _/outputs_ directory by entering `make clean` in the _Terminal_ tab in RStudio.

#### Run the incidentHIVSN analysis scripts

To run all the scripts (including the data cleaning scripts), enter `make all` in the _Terminal_ tab in RStudio. 

To run individual RMarkdown scripts (_\*.Rmd_ files)

1. Generate the cleaned data using one of the following methods:  
    - Enter `make data-cleaned/clean-data.rds` in the _Terminal_ tab in RStudio.  
    - Enter `source('clean-data.R')` in the _Console_ tab in RStudio.  
    - Open the _clean-data.R_ script through the _File_ tab in RStudio, and then click the **'Source'** button on the right of the _Script_ console in RStudio for each script.  
    
2. Run the individual script by:  
    - Entering `make outputs/<NAME_OF_INPUT_FILE>.html` in the _Terminal_ tab in RStudio, **OR**
    - Opening the relevant _\*.Rmd_ file through the _File_ tab in RStudio, and then clicking the **'knit'** button on the left of the _Script_ console in RStudio. 

#### Shutting down

Once done, log out of RStudio Server and enter the following into a terminal to stop the Docker container: `docker stop hivsn`. If you then want to remove the container, enter: `docker rm hivsn`. If you also want to remove the Docker image you downloaded, enter: `docker rmi kamermanpr/docker-incidentHIVSN:v1.0.3`
