# R script for "carob"


carob_script <- function(path) {
  
"The International Bread Wheat Screening Nursery (IBWSN) is designed to rapidly assess a large number of advanced generation (F3-F7) lines of spring bread wheat under Mega-environment 1 (ME1) which represents diversity for a wide range of latitudes, climates, daylengths, fertility conditions, water management, and (most importantly) disease conditions. The distribution of these nurseries is deliberately biased toward the major spring wheat regions of the world where the diseases of wheat are of high incidence. It is distributed to 180 locations and contains 300-450 entries. (2015)"

	uri <- "hdl:11529/10450"
	group <- "varieties_wheat"
	ff	<- carobiner::get_data(uri, path, group)
	
	meta <- carobiner::get_metadata(uri, path, group, major=4, minor=1,
		data_organization = "CIMMYT",
		publication= NA,
		project="International Bread Wheat Screening Nursery",
		data_type= "experiment",
		response_vars = "yield",
		treatment_vars = "variety_code",	
		carob_contributor= "Fredy Chimire",
		carob_date="2024-05-19"
	)
	
	proc_wheat <- carobiner::get_function("proc_wheat", path, group)
	d <- proc_wheat(ff)	

	d$yield[d$yield > 100000] <- NA
	d$yield[(d$yield > 9999) & (d$location == "Uas, Mas Dharward")] <- NA

	d <- d[!is.na(d$yield), ]

	carobiner::write_files(path, meta, d)
}

