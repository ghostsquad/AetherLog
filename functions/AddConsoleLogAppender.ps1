function AddConsoleLogAppender {
    param(
        [log4net.Core.Level]$logLevelThreshold = [log4net.Core.Level]::Debug,
        [string]$logPattern = "%date{ISO8601} %-5level [%ndc] - %message%newline"
    )

    function AddMapping {
        [cmdletbinding()]
        param(
            [Parameter(ValueFromPipeline=$True)]
            $appender,
            [log4net.Core.Level]$level,
            [int]$fore
        )

        $mapping = New-Object log4net.Appender.ColoredConsoleAppender+LevelColors
        $mapping.Level = $level
        $mapping.ForeColor = $fore
        $mapping.BackColor = 0

        $null = $appender.AddMapping($mapping)
    }

    $patternLayout = new-object log4net.Layout.PatternLayout($logPattern)
    $consoleAppender = new-object log4net.Appender.ColoredConsoleAppender($patternLayout)

    # determines the log statements that show up
    $consoleAppender.Threshold = $logLevelThreshold

    [int]$white = [log4net.Appender.ColoredConsoleAppender+Colors]::White
    [int]$red = [log4net.Appender.ColoredConsoleAppender+Colors]::Red
    [int]$yellow = [log4net.Appender.ColoredConsoleAppender+Colors]::Yellow
    [int]$cyan = [log4net.Appender.ColoredConsoleAppender+Colors]::Cyan
    [int]$highIntensity = [log4net.Appender.ColoredConsoleAppender+Colors]::HighIntensity

    $consoleAppender | AddMapping -level ([log4net.Core.Level]::Debug) -fore ($cyan -bor $highIntensity)
    $consoleAppender | AddMapping -level ([log4net.Core.Level]::Info)  -fore $white
    $consoleAppender | AddMapping -level ([log4net.Core.Level]::Warn)  -fore ($yellow -bor $highIntensity)
    $consoleAppender | AddMapping -level ([log4net.Core.Level]::Error) -fore ($red -bor $highIntensity)
    $consoleAppender | AddMapping -level ([log4net.Core.Level]::Fatal) -fore ($red -bor $highIntensity)

    $consoleAppender.ActivateOptions()

    $repository = [log4net.LogManager]::GetRepository() -as [log4net.Repository.Hierarchy.Hierarchy]
    $repository.Root.Level = $logLevelThreshold
    $repository.Configured = $true;
    $repository.Root.AddAppender($consoleAppender)
}