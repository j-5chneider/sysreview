# sysreview

## This is...

__This is__ a Rmd-template for protocols and reporting of systematic reviews and meta-analyses. It synthesizes three sources of standards:

* [PRISMA-P](https://doi.org/10.1136/bmj.i4086)
* [PROSPERO](https://www.crd.york.ac.uk/prospero/)
* [MARS](https://doi.org/10.1037/amp0000389)

The template is __aimed at__

* guiding the process of planning the systemtic review/ meta-analysis
* providing a form for preregistration (enter your text, export as standalone html, upload as preregistration)

We are aware that MARS targets aspects of reporting after the systemtic review/ meta-analysis is completed rather than decisions and reasoning in the planning phase as PRISMA-P and PROSPERO. MARS nevertheless provides a good framework to determine crucial points for systemtic reviews/ meta-analyses to be addressed as early as in the planning phase.


## How to use

How to use the template for guiding the planning phase and registration of your systematic review or meta-analysis:

1. Pull the project from github into a new R-Project
2. Check out the file "form_template.html" from your new R-Project or [here](https://raw.githack.com/j-5chneider/sysreview/master/form_template.html): 
   * Which aspects are relevant for your systematic review or meta-analysis?
   * Need further information? Click the show sources button. That'll show you the wording from PRISMA-P, PROSPERO and MARS.
3. Open the "form_template.Rmd" file and enter your information.
4. Knit to HTML [PDF option pending. maybe.]

This will produce you a standalone HTML that you can upload as preregistration or protocol.

## Why Rmd?

R Markdown will allow you to include

* R script, analyses and plots while being reproducible to the max (e.g. a reproducible power analysis)
* pictures, videos, links or entire webpages (e.g. via iframe)
