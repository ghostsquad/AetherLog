function Log-Fatal {
    param(
        [Parameter(Mandatory=$false,Position=1)]
        [object]$object,
        [Parameter(Mandatory=$false,Position=2)]
        [Exception]$exception,
        [Parameter(Mandatory=$false,ValueFromPipeline=$true,Position=3)]
        [log4net.ILog]$logger
    )

    if($logger -eq $null){
        $logger = Get-Logger -callStackStart 2
    }

    if($exception -ne $null){
        $logger.Fatal($object, $exception)
    }
    else {
        $logger.Fatal($object)
    }
}
