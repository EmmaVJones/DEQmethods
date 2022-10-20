#' StreamStats Autodelineate Multiple Watersheds
#'
#' This function automates the scraping of multiple watersheds from the USGS StreamStats
#' API to delineate pour point watersheds and organizing them into
#' a single shapefile. This method replaces the arduous and inconsistent task of manually
#' delineating watersheds using ESRI mapping products.
#' This script was built with example code from Ryan King
#' https://ryan-hill.github.io/sfs-r-gis-2018/modules/rasters/extract-raster-data-r/ exercise 3
#' and modified by Emma Jones to fit DEQ's needs.
#'
#' @param state USGS StreamStats state info e.g. 'VA' **note: accepts vector or dataframe of multiple areas**
#' @param longitude Decimal Degree Longitude value, numeric **note: accepts vector, dataframe, or tibble for multiple inputs**
#' @param latitude Decimal Degree Latitude value, numeric **note: accepts vector, dataframe, or tibble for multiple inputs**
#' @param UID Unique station identifier to append to each feature **note: acccepts vector, dataframe, or tibble for multiple inputs**
#' @return A list object with two elements, a polygon object of all polygons returned and a point object of all points used for pour point delineation
#' @examples
#' exampleSites <-  tibble::tribble(~StationID, ~Latitude,  ~Longitude,
#'                                  "Station_1", 37.812840, -80.063946,
#'                                  "Station_2", 37.782322, -79.961449,
#'                                  "Station_3", 37.801644, -79.968441)
#'streamStats_Delineation(state= 'VA',
#'                        longitude = exampleSites$Longitude,
#'                        latitude = exampleSites$Latitude,
#'                        UID = exampleSites$StationID)
#' @export

streamStats_Delineation <- function(# accepts multiple
  state, # StreamStats state info e.g. 'VA'
  longitude, # longitude value, numeric
  latitude, # latitude value, numeric
  UID # Unique station identifier to append to dataset
){ # function based off code by Ryan King https://ryan-hill.github.io/sfs-r-gis-2018/modules/rasters/extract-raster-data-r/ exercise 3

  outDataAll <- list(polygon = list(), point = list()) # holder in case server bomb out
  #outDataAllFinal <- list(polygon = list(), point = list())


  for(i in 1:length(longitude)){
    print(paste('Delineating Site:',i, 'of', length(longitude)))

    dat <- streamStats_Delineation_single(state= 'VA',
                                          longitude = longitude[i],
                                          latitude = latitude[i],
                                          UID = UID[i])

    #catch in case streamstats bombs out
    #if(is.na(dat[['polygon']]$UID) | is.na(dat[['point']]$UID) ){dat <- list(polygon = data.frame(UID = NA), point = data.frame(UID = NA))}
    outDataAll$polygon[[i]] <- dat[['polygon']]
    outDataAll$point[[i]] <- dat[['point']]
  }

  return(outDataAll)
}
