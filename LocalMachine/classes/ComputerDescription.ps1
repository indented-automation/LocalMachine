[DscResource()]
class ComputerDescription {
    # Ensure a description is present, or absent.
    [DscProperty(Key)]
    [Ensure]$Ensure

    # The description to set.
    [DscProperty()]
    [String]$Description

    [ComputerDescription] Get() {
        $currentDescription = Get-ComputerDescription
        if ($currentDescription) {
            $this.Ensure = 'Present'
            $this.Description = $currentDescription
        } else {
            $this.Ensure = 'Absent'
        }
        return $this
    }

    [Void] Set() {
        if ($this.Ensure -eq 'Present') {
            Set-ComputerDescription -Description $this.Description
        } else {
            Remove-ComputerDescription
        }
    }

    [Boolean] Test() {
        $currentDescription = Get-ComputerDescription
        if ($this.Ensure -eq 'Present') {
            if (-not $currentDescription) {
                return $false
            }
            return $currentDescription -ceq $this.Description
        } else {
            if ($currentDescription) {
                return $false
            }
        }
        return $true
    }
}