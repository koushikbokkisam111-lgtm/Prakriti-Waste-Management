# GreenPulse / Prakriti - Multi-Device Online Web & Sync Server (PowerShell)
# Serves static files and provides a shared live JSON database across all devices.

$Port = 8080
$RootFolder = $PSScriptRoot
$DbFile = Join-Path $RootFolder "db_shared.json"

# Initialize default shared database if not present
if (-not (Test-Path $DbFile)) {
    $DefaultDb = @{
        reports = @(
            @{ id = "VMC-101"; wasteType = "dry"; status = "pending"; reporter = "Lakshmi Narayana"; reporterUsername = "lakshmi_v"; desc = "Commercial packaging & plastic cartons dumped near Benz Circle market alley"; lat = 16.5062; lng = 80.6480; photo = "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='400' height='260' viewBox='0 0 400 260'><rect width='400' height='260' fill='%230f172a'/><rect x='30' y='60' width='340' height='160' rx='12' fill='%231e293b'/><path d='M60 180 L120 110 L180 170 L250 90 L340 180 Z' fill='%230284c7' opacity='0.7'/><circle cx='100' cy='95' r='20' fill='%2338bdf8' opacity='0.8'/><rect x='130' y='140' width='70' height='50' fill='%2364748b' rx='4'/><rect x='210' y='150' width='60' height='40' fill='%2394a3b8' rx='4'/><text x='200' y='235' fill='%237dd3fc' font-size='13' font-family='sans-serif' text-anchor='middle' font-weight='bold'>DRY: Cardboard &amp; Single-use Plastic</text></svg>"; points = 10; timestamp = (Get-Date).AddHours(-1).ToString("o") },
            @{ id = "VMC-102"; wasteType = "wet"; status = "accepted"; reporter = "Srinivas Rao"; reporterUsername = "srinivas_r"; officerId = "VMC-OFF-104"; officerName = "Insp. Ramesh Naidu"; officerPhone = "+91 98480 44554"; officerBadge = "AP-VMC-SWM-104"; desc = "Rotting vegetable waste overflowing behind Governorpet Rythu Bazar"; lat = 16.5185; lng = 80.6200; photo = "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='400' height='260' viewBox='0 0 400 260'><rect width='400' height='260' fill='%23022c22'/><rect x='30' y='60' width='340' height='160' rx='12' fill='%23064e3b'/><path d='M50 190 C100 130, 160 180, 220 120 C280 170, 320 130, 350 190 Z' fill='%23059669' opacity='0.8'/><circle cx='280' cy='100' r='18' fill='%2334d399' opacity='0.7'/><ellipse cx='140' cy='160' rx='40' ry='20' fill='%2310b981'/><text x='200' y='235' fill='%23a7f3d0' font-size='13' font-family='sans-serif' text-anchor='middle' font-weight='bold'>WET: Decomposing Market Food Waste</text></svg>"; points = 10; timestamp = (Get-Date).AddHours(-2).ToString("o") },
            @{ id = "VMC-103"; wasteType = "hazardous"; status = "proof_submitted"; reporter = "Divya Teja"; reporterUsername = "divya_t"; officerId = "VMC-OFF-108"; officerName = "Insp. K. Venkatesh"; officerPhone = "+91 94401 33441"; officerBadge = "AP-VMC-SWM-108"; officerNote = "Hazardous electronic waste packed into safety bin."; officerPhoto = "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='400' height='260' viewBox='0 0 400 260'><rect width='400' height='260' fill='%23042f2e'/><rect x='30' y='60' width='340' height='160' rx='12' fill='%23134e4a'/><path d='M40 210 L360 210 L330 150 L70 150 Z' fill='%23334155'/><line x1='200' y1='150' x2='200' y2='210' stroke='%23f8fafc' stroke-width='4' stroke-dasharray='10,10'/><circle cx='200' cy='105' r='24' fill='%2310b981'/><path d='M192 105 L198 111 L210 99' stroke='%23ffffff' stroke-width='4' fill='none' stroke-linecap='round'/><text x='200' y='238' fill='%23a7f3d0' font-size='13' font-family='sans-serif' text-anchor='middle' font-weight='bold'>AFTER: Spot Swept, Bleached &amp; 100% Cleared</text></svg>"; desc = "Discarded fluorescent tube lights and computer batteries"; lat = 16.4970; lng = 80.6550; photo = "data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='400' height='260' viewBox='0 0 400 260'><rect width='400' height='260' fill='%23450a0a'/><rect x='30' y='60' width='340' height='160' rx='12' fill='%237f1d1d'/><polygon points='200,80 230,140 170,140' fill='%23ef4444'/><text x='200' y='130' fill='%23ffffff' font-size='22' font-family='sans-serif' text-anchor='middle' font-weight='bold'>!</text><rect x='80' y='150' width='90' height='40' fill='%23b91c1c' rx='6'/><rect x='230' y='145' width='90' height='45' fill='%23991b1b' rx='6'/><text x='200' y='235' fill='%23fca5a5' font-size='13' font-family='sans-serif' text-anchor='middle' font-weight='bold'>HAZARDOUS: Broken Mercury Bulbs &amp; Cells</text></svg>"; points = 10; officerCredits = 50; timestamp = (Get-Date).AddHours(-4).ToString("o") }
        )
        citizens = @(
            @{ username = "lakshmi_v"; passkey = "1234"; name = "Lakshmi Narayana"; phone = "+91 98480 22334"; idType = "Aadhaar"; idNo = "8841"; kycStatus = "verified"; status = "active" }
        )
        officers = @(
            @{ id = "VMC-OFF-104"; username = "ramesh_officer"; passkey = "1234"; pin = "1234"; name = "Insp. Ramesh Naidu"; ward = "Ward 14 (Benz Circle)"; badge = "AP-VMC-SWM-104"; phone = "+91 98480 44554"; kycStatus = "verified"; status = "approved" }
        )
        version = 1
    }
    $DefaultDb | ConvertTo-Json -Depth 10 | Set-Content -Path $DbFile -Encoding UTF8
}

$MimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".jsx"  = "application/javascript; charset=utf-8"
    ".mjs"  = "application/javascript; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".svg"  = "image/svg+xml"
    ".json" = "application/json; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".ico"  = "image/x-icon"
}

$Listener = New-Object System.Net.HttpListener
$Listener.Prefixes.Add("http://localhost:$Port/")
$Listener.Prefixes.Add("http://127.0.0.1:$Port/")

try {
    $Listener.Start()
    Write-Host "==============================================================" -ForegroundColor Green
    Write-Host "   Prakriti Multi-Device Live Sync Server is RUNNING!" -ForegroundColor Cyan
    Write-Host "   Port: $Port | Database: db_shared.json" -ForegroundColor Yellow
    Write-Host "==============================================================" -ForegroundColor Green

    while ($Listener.IsListening) {
        $Context = $Listener.GetContext()
        $Request = $Context.Request
        $Response = $Context.Response

        # Add CORS Headers for all responses
        $Response.AddHeader("Access-Control-Allow-Origin", "*")
        $Response.AddHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        $Response.AddHeader("Access-Control-Allow-Headers", "Content-Type")

        if ($Request.HttpMethod -eq "OPTIONS") {
            $Response.StatusCode = 200
            $Response.OutputStream.Close()
            continue
        }

        $UrlPath = $Request.Url.LocalPath

        $Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

        # REST API Endpoints for Multi-Device Shared Database
        if ($UrlPath -eq "/api/data" -and $Request.HttpMethod -eq "GET") {
            $Response.ContentType = "application/json; charset=utf-8"
            if (Test-Path $DbFile) {
                $Text = [System.IO.File]::ReadAllText($DbFile, $Utf8NoBom)
                $Bytes = $Utf8NoBom.GetBytes($Text)
                $Response.ContentLength64 = $Bytes.Length
                $Response.OutputStream.Write($Bytes, 0, $Bytes.Length)
            } else {
                $Empty = $Utf8NoBom.GetBytes('{"reports":[],"citizens":[],"officers":[]}')
                $Response.ContentLength64 = $Empty.Length
                $Response.OutputStream.Write($Empty, 0, $Empty.Length)
            }
            $Response.StatusCode = 200
            $Response.OutputStream.Close()
            continue
        }

        if ($UrlPath -eq "/api/sync" -and $Request.HttpMethod -eq "POST") {
            $Reader = New-Object System.IO.StreamReader($Request.InputStream, $Utf8NoBom)
            $Body = $Reader.ReadToEnd()
            $Reader.Close()

            if (-not [string]::IsNullOrWhiteSpace($Body)) {
                [System.IO.File]::WriteAllText($DbFile, $Body, $Utf8NoBom)
            }

            $Response.ContentType = "application/json; charset=utf-8"
            $Text = [System.IO.File]::ReadAllText($DbFile, $Utf8NoBom)
            $Bytes = $Utf8NoBom.GetBytes($Text)
            $Response.ContentLength64 = $Bytes.Length
            $Response.OutputStream.Write($Bytes, 0, $Bytes.Length)
            $Response.StatusCode = 200
            $Response.OutputStream.Close()
            continue
        }

        # Serve Static Files
        $FilePathName = $UrlPath.TrimStart('/')
        if ([string]::IsNullOrWhiteSpace($FilePathName) -or $FilePathName -eq "/") {
            $FilePathName = "index.html"
        }

        $SafePath = $FilePathName -replace '/', '\'
        $FilePath = Join-Path $RootFolder $SafePath

        if (Test-Path -Path $FilePath -PathType Leaf) {
            $Extension = [System.IO.Path]::GetExtension($FilePath).ToLower()
            $ContentType = if ($MimeTypes.ContainsKey($Extension)) { $MimeTypes[$Extension] } else { "application/octet-stream" }
            
            $Bytes = [System.IO.File]::ReadAllBytes($FilePath)
            $Response.ContentType = $ContentType
            $Response.ContentLength64 = $Bytes.Length
            $Response.StatusCode = 200
            $Response.OutputStream.Write($Bytes, 0, $Bytes.Length)
        } else {
            $Response.StatusCode = 404
            $ErrorMsg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $UrlPath")
            $Response.ContentType = "text/plain"
            $Response.OutputStream.Write($ErrorMsg, 0, $ErrorMsg.Length)
        }

        $Response.OutputStream.Close()
    }
}
catch {
    Write-Host "Server encountered error: $_" -ForegroundColor Red
}
finally {
    $Listener.Stop()
}
