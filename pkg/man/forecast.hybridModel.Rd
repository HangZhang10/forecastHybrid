% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/forecast.hybridModel.R
\name{forecast.hybridModel}
\alias{forecast.hybridModel}
\title{Hybrid forecast}
\usage{
\method{forecast}{hybridModel}(
  object,
  h = ifelse(object$frequency > 1, 2 * object$frequency, 10),
  xreg = NULL,
  level = c(80, 95),
  PI = TRUE,
  fan = FALSE,
  PI.combination = c("extreme", "mean"),
  ...
)
}
\arguments{
\item{object}{a hybrid time series model fit with \link{hybridModel}.}

\item{h}{number of periods for forecasting. If \code{xreg} is used, \code{h} is ignored
and the number of forecast periods is set to the number of rows of \code{xreg}.}

\item{xreg}{future values of regression variables (for use if one of the ensemble methods used
in creating the hybrid forecast was \code{auto.arima}, \code{nnetar}, or \code{stlm}
and the model(s) used \code{xreg} in the fit).
It should be supplied as a matrix.}

\item{level}{confidence level for prediction intervals. This can be expressed as a decimal
between 0.0 and 1.0 or numeric between 0 and 100.}

\item{PI}{should prediction intervals be produced? If a \code{nnetar} model is in the ensemble,
this can be quite slow, so disabling prediction intervals will speed up the forecast generation.
If \code{FALSE}, the arguments \code{level} and \code{fan} are ignored.}

\item{fan}{if \code{TRUE}, level is set to \code{seq(51, 99, by = 3)}. This is suitable
for fan plots.}

\item{PI.combination}{Method for combining the prediction intervals from each of the
forecasts. Supplying \code{"mean"}
will simply average each of the lower/upper intervals from each model without using the model
weights used for the point forecasts. The default value \code{"extreme"} will take
the most pessimistic intervals (i.e. the highest upper interval from all the component models
and the lowest prediction interval from all of the component models').}

\item{...}{other arguments passed to the individual \code{forecast} generic methods.}
}
\value{
An object of class \link[forecast]{forecast}.
}
\description{
Forecast method for hybrid models.
}
\details{
if \code{xreg} was used in constructing the \code{hybridModel},
it must also be passed into \code{forecast.hybridModel}.
\cr
\cr
While prediction intervals are produced for the
final ensemble forecast model, these should be viewed conservatively as insights
to the forecast's uncertainty. Currently these are constructed using the most extreme interval
from each component model for each horizon, so the composite prediction intervals do not
have statistical guarantees of asymptotic efficiency. More sophisticated
and rigorous techniques are planned, however, particularly when cross validation
approaches are used.
}
\examples{
\dontrun{
mod <- hybridModel(AirPassengers)
fc <- forecast(mod)

# View the point forecasts
fc$mean

# View the upper prediction interval
fc$upper

# View the lower prediction interval
fc$lower

# Plot the forecast
plot(fc)
}
}
\seealso{
\code{\link{hybridModel}}
}
\author{
David Shaub
}
