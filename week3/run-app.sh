#!/bin/bash
R -e "shiny::runApp('prior_modeling_app')" >> app.log 2>&1 &
