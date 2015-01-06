NodeBase <- setRefClass(Class = "NodeBase",
                    fields = list(
                      name = "character",
                      preferences = "matrix",
                      children = "list",
                      priority = "numeric"
                    ),
                    methods = list(
                      
                      
                      SetPreferences = function(preferences) {
                        preferences <<- preferences
                        priorities <- Ahp(preferences)$ahp
                        for (childName in names(priorities)) {
                          children[[childName]]$priority <<- priorities[[childName]]
                        }
                          
                      },
                      
                      
                      GetGlobalPriority = function() {
                        if (!isNull(parent)) {
                          return (priority * parent$GetGlobalPriority)
                        } else {
                          return (priority)
                        }
                      },
                      
                      Count = function() {
                        return (length(children))
                      },
                      
                      AddChild = function(child) {
                        children[[child$name]] <<- child
                      },
                      
                      AddAlternatives = function(alternativesList) {
                        for (child in children) {
                          if (child$Count() == 0) {
                            #leave
                            for (alternative in alternativesList) {
                              child$AddChild(alternative)
                            }
                          } else {
                            child$AddAlternatives(alternativesList)
                          }
                        }
                        
                      },
                      
                      GetPreferenceCombinations = function() {
                          combn(names(children), 2)
                      },
                      
                      initialize=function(name = "NA", ...) {
                      
                        callSuper(...)
                        
                        .self$name <<- name
                        
                        .self
                      }
                      
                    )
                  )


Node <- setRefClass(Class = "Node", 
                    contains = "NodeBase",
                    fields = list(parent = "NodeBase"),
                    
                    methods = list(
                      AddChild = function(child) {
                        callSuper(child)
                        child$parent <- .self
                      },
                      
                      initialize=function(name = "NA", ...) {
                        callSuper(name, ...)
                        .self
                      }
                    
                      )
                    
                    )



print.Node <- function(root, level = 0) {
  nq <- noquote(paste0(paste(rep("* ", level), collapse=""), "", root$name, "\n"))
  cat(nq)
  for (child in root$children) {
    print(child, level+1)
  }
}
