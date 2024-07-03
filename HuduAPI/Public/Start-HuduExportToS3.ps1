function Start-HuduExportToS3 {
    <#
    .SYNOPSIS
    Initiate an S3 export.

    .DESCRIPTION
    Uses Hudu API to initiate an S3 export. Ensure that your S3-compatible credentials are configured in the account settings page before using this endpoint.

    .EXAMPLE
    Start-HuduExportToS3
    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param ()

    if ($PSCmdlet.ShouldProcess("Initiate S3 export")) {
        Return Invoke-HuduRequest -Method Post -Resource "/api/v1/s3_exports"
    }
}
