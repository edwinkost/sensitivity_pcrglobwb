require(ncdf)

scenarios = c("100_100_100", "80_100_100", "90_100_100", "110_100_100", "120_100_100", "100_80_100", "100_90_100", "100_110_100", "100_120_100", "100_100_80", "100_100_90", "100_100_110", "100_100_120")

wmin = c(1,0.8,0.9,1.1,1.2,rep(1.0,8))
wmax = c(1,rep(1,4),0.8,0.9,1.1,1.2,rep(1,4))
ksat = c(rep(1,9), 0.8,0.9,1.1,1.2)

ref = 1

nyears = 44

recharge  = array()
baseflow  = array()
satDeg    = array()
discharge = array()
evap      = array()
runoff    = array()

## CellArea ##
NC = open.ncdf("cellarea.nc")
cellarea = get.var.ncdf(NC, "Band1")[,360:1]
close.ncdf(NC)

scenTel = 1
for(scen in scenarios){
  print(scen)
  ## Recharge ##
  NC = open.ncdf(paste(scen,"/netcdf/gwRecharge_monthTot_output.nc", sep=""))
  recharge[scenTel] = sum(rowMeans(get.var.ncdf(NC, "groundwater_recharge"), dims=2, na.rm=T) * 12 * cellarea, na.rm=T)
  close.ncdf(NC)

  ## Baseflow ##
  NC = open.ncdf(paste(scen,"/netcdf/accuBaseflow_annuaAvg_output.nc", sep=""))
  baseflow[scenTel] = mean(get.var.ncdf(NC, "accumulated_land_surface_baseflow"), na.rm=T)
  close.ncdf(NC)

  ## Soil Moisture ##
  NC = open.ncdf(paste(scen,"/netcdf/satDegUpp_monthEnd_output.nc", sep=""))
  satDeg[scenTel] = mean(get.var.ncdf(NC, "upper_soil_saturation_degree"), na.rm=T)
  close.ncdf(NC)

  ## Recharge ##
  NC = open.ncdf(paste(scen,"/netcdf/discharge_annuaAvg_output.nc", sep=""))
  discharge[scenTel] = mean(get.var.ncdf(NC, "discharge"), na.rm=T)
  close.ncdf(NC)

  ## Evap ##
  NC = open.ncdf(paste(scen,"/netcdf/totalEvaporation_annuaTot_output.nc", sep=""))
  evap[scenTel] = sum(rowMeans(get.var.ncdf(NC, "total_evaporation"), dims=2, na.rm=T) * cellarea, na.rm=T)
  close.ncdf(NC)

  scenTel = scenTel + 1

}

## Prec ##
NC = open.ncdf("precip_annuaAvg_input.nc")
prec = sum(rowMeans(get.var.ncdf(NC, "precipitation"), dims=2, na.rm=T) * cellarea, na.rm=T)
close.ncdf(NC)

## Runoff ##
runoff = prec - evap - recharge

ksatSel = c(which(ksat < 1.0), ref, which(ksat > 1.0))
wminSel = c(which(wmin < 1.0), ref, which(wmin > 1.0))
wmaxSel = c(which(wmax < 1.0), ref, which(wmax > 1.0))

sensBarPlot <- function(barData, orgData, title = "", leg=FALSE){
  barcols = c("Red", "Blue", "Black")
  barplot(barData, col=barcols, beside=T, ylim=c(min(barData)-0.005, max(barData)+0.005), main=title, ylab="Relative change", xlab="Parameter change")
  axis(1, at=c(2.5,6.5, 10.5, 14.5, 18.5), c("80%", "90%", "100%", "110%", "120%"))
  axis(4, at=c(min(barData), 0, max(barData)), round(c(min(orgData), orgData[ref], max(orgData)), digits=2))
  mtext("Absolute numbers", side=4, line=2.5, cex=0.7)
  if(leg == TRUE){
    legend("topright", c("Wmin", "Wmax", "Ksat"), col=barcols, pch = 15)
  }
  box()
}

pdf("SensAnalysis.pdf", width=10, height=14)
par(mfrow=c(3,2), mar=c(4,4,2,4))
barData = matrix(NA, 3, 5)
barData[1,] = evap[wminSel]/evap[1]-1
barData[2,] = evap[wmaxSel]/evap[1]-1
barData[3,] = evap[ksatSel]/evap[1]-1
sensBarPlot(barData, orgData = evap/1000/1000/1000/1000, title="Evaporation (*1000 km3/year)", leg=TRUE)

barData = matrix(NA, 3, 5)
barData[1,] = satDeg[wminSel]/satDeg[1]-1
barData[2,] = satDeg[wmaxSel]/satDeg[1]-1
barData[3,] = satDeg[ksatSel]/satDeg[1]-1
sensBarPlot(barData, orgData = satDeg, title="Saturation Degree (-)")

barData = matrix(NA, 3, 5)
barData[1,] = runoff[wminSel]/runoff[1]-1
barData[2,] = runoff[wmaxSel]/runoff[1]-1
barData[3,] = runoff[ksatSel]/runoff[1]-1
sensBarPlot(barData, orgData=runoff/1000/1000/1000/1000, title="Runoff (*1000 km3/year)")

barData = matrix(NA, 3, 5)
barData[1,] = baseflow[wminSel]/baseflow[1]-1
barData[2,] = baseflow[wmaxSel]/baseflow[1]-1
barData[3,] = baseflow[ksatSel]/baseflow[1]-1
sensBarPlot(barData, orgData=baseflow/86400, title="Baseflow (m3 s-1)")

barData = matrix(NA, 3, 5)
barData[1,] = recharge[wminSel]/recharge[1]-1
barData[2,] = recharge[wmaxSel]/recharge[1]-1
barData[3,] = recharge[ksatSel]/recharge[1]-1
sensBarPlot(barData, orgData=recharge/1000/1000/1000/1000, title="Recharge (*1000 km3/year)")

barData = matrix(NA, 3, 5)
barData[1,] = discharge[wminSel]/discharge[1]-1
barData[2,] = discharge[wmaxSel]/discharge[1]-1
barData[3,] = discharge[ksatSel]/discharge[1]-1
sensBarPlot(barData, orgData=discharge, title="Discharge  (m3 s-1)")
dev.off()
