benchmarkFunction = function(functionToTest)
    if not @functionToTest isa funcRef then 
        print "Whoops. You need to pass a funcRef into the benchmark function."
        return
    end if

    startTime = time

    functionToTest

    endTime = time
    totalTime = endTime - startTime
    print "This took " + totalTime + " seconds"
    return totalTime
end function