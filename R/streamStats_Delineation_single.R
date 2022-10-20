#' StreamStats Autodelineate a Single Watershed
#'
#' This function establishes a standardized, automated method for scraping
#' the USGS StreamStats API to delineate pour point watersheds and organizing them into
#' a single shapefile. This method replaces the arduous and inconsistent task of manually
#' delineating watersheds using ESRI mapping products.
#' This script was built with example code from Ryan King
#' https://ryan-hill.github.io/sfs-r-gis-2018/modules/rasters/extract-raster-data-r/ exercise 3
#' and modified by Emma Jones to fit DEQ's needs.
#'
#' @param state USGS StreamStats state info e.g. 'VA'
#' @param longitude Decimal Degree Longitude value, numeric
#' @param latitude Decimal Degree Latitude value, numeric
#' @param UID Unique station identifier to append to each feature
#' @return A list object with two elements, a polygon and a point
#' @examples
#' streamStats_Delineation_single(state = "VA", longitude = -80.063946, latitude = 37.812840, UID = "Example Site")
#' @export



streamStats_Delineation_single <- function(state,
                                           longitude,
                                           latitude,
                                           UID
){ # function based off code by Ryan King https://ryan-hill.github.io/sfs-r-gis-2018/modules/rasters/extract-raster-data-r/ exercise 3
  outData <- list(polygon = list(), point = list())

  query <-  paste0('https://streamstats.usgs.gov/streamstatsservices/watershed.geojson?rcode=',
                   state, '&xlocation=', toString(longitude),
                   '&ylocation=', toString(latitude),
                   '&crs=4326&includeparameters=false&includeflowtypes=false&includefeatures=true&simplify=true')
  # data pulled
  mydata <-  tryCatch({
    fromJSON(query, simplifyVector = FALSE, simplifyDataFrame = FALSE)},
    error = function(cond){
      message(paste('StreamStats Error:', cond))
      return(NULL)},
    warning = function(cond){
      message(paste('StreamStats Error:', cond))
      return(NULL)})

  # catch if server bomb out for any reason
  if(!is.null(mydata)){
    # organize watershed
    poly_geojsonsting <- toJSON(mydata$featurecollection[[2]]$feature, auto_unbox = TRUE)
    outData$polygon <- geojson_sf(poly_geojsonsting) %>%
      mutate(UID = UID) %>%
      dplyr::select(UID)

    # organize point
    point_geojsonsting <- toJSON(mydata$featurecollection[[1]]$feature, auto_unbox = TRUE)
    outData$point <- geojson_sf(point_geojsonsting) %>%
      mutate(UID = UID)%>%
      dplyr::select(UID)
  } else {
    outData$polygon <- st_sf(UID = NA, geometry=  st_sfc(st_polygon()), crs = 4326)#data.frame(UID = NA, geometry= NA)
    outData$point <- st_sf(UID = NA, geometry=  st_sfc(st_point()), crs = 4326)#data.frame(UID = NA, geometry= NA)
  }

  return(outData)
}
