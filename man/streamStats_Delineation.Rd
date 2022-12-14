% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/streamStats_Delineation.R
\name{streamStats_Delineation}
\alias{streamStats_Delineation}
\title{StreamStats Autodelineate Multiple Watersheds}
\usage{
streamStats_Delineation(state, longitude, latitude, UID)
}
\arguments{
\item{state}{USGS StreamStats state info e.g. 'VA' **note: accepts vector or dataframe of multiple areas**}

\item{longitude}{Decimal Degree Longitude value, numeric **note: accepts vector, dataframe, or tibble for multiple inputs**}

\item{latitude}{Decimal Degree Latitude value, numeric **note: accepts vector, dataframe, or tibble for multiple inputs**}

\item{UID}{Unique station identifier to append to each feature **note: acccepts vector, dataframe, or tibble for multiple inputs**}
}
\value{
A list object with two elements, a polygon object of all polygons returned and a point object of all points used for pour point delineation
}
\description{
This function automates the scraping of multiple watersheds from the USGS StreamStats
API to delineate pour point watersheds and organizing them into
a single shapefile. This method replaces the arduous and inconsistent task of manually
delineating watersheds using ESRI mapping products.
This script was built with example code from Ryan King
https://ryan-hill.github.io/sfs-r-gis-2018/modules/rasters/extract-raster-data-r/ exercise 3
and modified by Emma Jones to fit DEQ's needs.
}
\examples{
exampleSites <-  tibble::tribble(~StationID, ~Latitude,  ~Longitude,
                                 "Station_1", 37.812840, -80.063946,
                                 "Station_2", 37.782322, -79.961449,
                                 "Station_3", 37.801644, -79.968441)
streamStats_Delineation(state= 'VA',
                       longitude = exampleSites$Longitude,
                       latitude = exampleSites$Latitude,
                       UID = exampleSites$StationID)
}
