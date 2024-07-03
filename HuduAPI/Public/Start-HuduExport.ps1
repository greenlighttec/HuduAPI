function Start-HuduExport {
    <#
    .SYNOPSIS
    Initiate an export of a company with specified settings and filters.

    .DESCRIPTION
    Uses Hudu API to initiate an export.

    .PARAMETER IncludeWebsites
    Boolean value to include Websites in export.

    .PARAMETER IncludePasswords
    Boolean value to include Passwords in export.

    .PARAMETER CompanyID
    Required parameter to indicate which Company ID should be exported.

    .PARAMETER Format
    Parameter to set the format of the export.

    .PARAMETER AssetLayoutIds
    Array of Asset Layout IDs to identify which assets should be included in the export.

    .EXAMPLE
    $AllAssetLayouts = Get-HuduAssetLayouts
    Start-HuduExport -CompanyID 1 -Format pdf -IncludeWebsites $true -IncludePasswords $true -AssetLayoutIds $AllAssetLayouts.id
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [Int]$CompanyID,

        [Parameter(Mandatory = $true)]
        [ValidateSet("pdf", "csv", "s3")]
        [String]$Format,

        [Parameter(Mandatory = $false)]
        [Boolean]$IncludeWebsites = $false,

        [Parameter(Mandatory = $false)]
        [Boolean]$IncludePasswords = $false,

        [Parameter(Mandatory = $false)]
        [Int[]]$AssetLayoutIds
    )

    $ExportData = @{
        include_websites   = $IncludeWebsites
        include_passwords  = $IncludePasswords
        company_id         = $CompanyID
        format             = $Format
        asset_layout_ids   = $AssetLayoutIds
    }

    $JSON = $ExportData | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess($CompanyID, "Initiate export")) {
        return Invoke-HuduRequest -Method Post -Resource "/api/v1/exports" -Body $JSON
    }
}
