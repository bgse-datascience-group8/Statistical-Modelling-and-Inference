#!/bin/bash
nohup R -e "shiny::runApp('shiny_app')" </dev/null >shiny_app.log 2>&1 &
