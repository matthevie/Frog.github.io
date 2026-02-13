$ErrorActionPreference = 'Stop'
$listener = New-Object System.Net.HttpListener
$prefix = "http://localhost:8080/"
$listener.Prefixes.Add($prefix)
$listener.Start()
Write-Host "Serving $prefix - press Ctrl+C to stop"
try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $localPath = $request.Url.LocalPath.TrimStart('/')
        if ([string]::IsNullOrEmpty($localPath)) { $localPath = 'index.html' }
        $file = Join-Path (Get-Location) $localPath
        if (Test-Path $file -PathType Leaf) {
            try {
                $bytes = [System.IO.File]::ReadAllBytes($file)
                $context.Response.ContentLength64 = $bytes.Length
                switch ([IO.Path]::GetExtension($file).ToLower()) {
                    '.html' { $context.Response.ContentType = 'text/html' }
                    '.css'  { $context.Response.ContentType = 'text/css' }
                    '.js'   { $context.Response.ContentType = 'application/javascript' }
                    '.png'  { $context.Response.ContentType = 'image/png' }
                    '.jpg'  { $context.Response.ContentType = 'image/jpeg' }
                    '.svg'  { $context.Response.ContentType = 'image/svg+xml' }
                    default { $context.Response.ContentType = 'application/octet-stream' }
                }
                $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
            } catch {
                $context.Response.StatusCode = 500
            }
        } else {
            $context.Response.StatusCode = 404
        }
        $context.Response.Close()
    }
} finally {
    if ($listener -and $listener.IsListening) { $listener.Stop(); $listener.Close() }
}
