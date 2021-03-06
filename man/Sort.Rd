% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/node_methods_sideeffect.R
\name{Sort}
\alias{Sort}
\title{Sort children of a \code{Node} or an entire \code{data.tree} structure}
\usage{
Sort(node, attribute, ..., decreasing = FALSE, recursive = TRUE)
}
\arguments{
\item{node}{The node whose children are to be sorted}

\item{attribute}{determines what is collected. The \code{attribute} can be
\itemize{
  \item a.) the name of a \bold{field} of each \code{Node} in the tree
  \item b.) the name of a \bold{method} of each \code{Node} in the tree
  \item c.) a \bold{function}, whose first argument must be a \code{Node}
 }}

\item{...}{any parameters to be passed on the the attribute (in case it's a method or a
function)}

\item{decreasing}{sort order}

\item{recursive}{if \code{TRUE}, Sort will be called recursively on the \code{Node}'s children.
This allows sorting an entire tree.}
}
\value{
Returns the node on which Sort is called, invisibly. This can be useful to chain Node methods.
}
\description{
You can sort with respect to any argument of the tree.
}
\examples{
data(acme)
acme$Do(function(x) x$totalCost <- Aggregate(x, "cost", sum), traversal = "post-order")
acme$Sort("totalCost", decreasing = FALSE)
print(acme, "totalCost")
}
\seealso{
\code{\link{Node}}
}
\keyword{internal}

