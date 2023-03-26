$1CServiceName = "����� ������� 1�:����������� 8.3 (x86-64)"
$logFilePath = "C:\Log-1C_Server_Agent.txt" #���� ���������� ����� ���� �������
$logFileSizeInBytes = "1000000"
$clearCache = "1" #������� ���� ��� ������� ������, ���� 1 - �������.
$pathCache = "E:\*" #���������� ��� ��������� ��� �������� 1�



function writeLog($message, [switch]$error) {
    if (Test-Path "$logFilePath") {
        $currentLogFile = Get-Item "$logFilePath"
        if ($currentLogFile.Length -ge $logFileSizeInBytes) {
            gci "$($currentLogFile.PSParentPath)" -File | ? {$_.Name -match "$($currentLogFile.Name)$"} | % {
                $now = Get-Date
                $old = $_.LastWriteTime 
                $daysOld = ($now - $old).TotalDays
                if ($daysOld -gt $deleteOldLogsAfterDays) {
                    Remove-Item $_.FullName | Out-Null
                }
            }
			$time = Get-Date -Format "hh-mm"
            $timestamp = Get-Date -Format "dd-MM-yyyy__hh-mm"
            $newName = $timestamp + "__" + $($currentLogFile.Name)
            Rename-Item -path "$logFilePath" -NewName $newName
        }
    }
    
    if($error) {
        $message = "(-> ERROR -> " + $message
        Write-Host "$message" -ForegroundColor Red
    } else {
        $message = "$(get-date)" + "-> " + $message
        Write-Host "$message" -ForegroundColor White
    }
    Write-Output $message | Out-File -FilePath "$logFilePath" -Encoding utf8 -Append -Force
}

try {	
		writeLog " "
		writeLog " "
		writeLog " "
		writeLog "���������� ����������� ������ $1CServiceName �� ������� $env:COMPUTERNAME"
		$service1C = Get-Service -Name "$1CServiceName"
		Start-Sleep 5
		writeLog "$timestamp"
        writeLog "��������� ������ $1CServiceName"   
        Stop-Service "$1CServiceName" -Force -Confirm:$false 
        Start-Sleep 10  
		$service1C = Get-Service -Name "$1CServiceName"
        writeLog "�������� ������� ������ $1CServiceName"
		do {
			$service1C = Get-Service -Name "$1CServiceName"
			($($service1C.Status) -eq "Running") 
			writeLog "������ �� �����������"
			writeLog "��������� ������� ���������� ������ $1CServiceName"
			Stop-Service "$1CServiceName" -Force -Confirm:$false
			Start-Sleep 10
			}
		until ($($service1C.Status) -eq "Stopped")
			writeLog "������ �����������"
		Start-Sleep 10 
		if ($clearCache -eq 1){
			writeLog "��� ��� � ���������� ������� ������ �������� ��� ������� ����, ������ ���"
			Remove-Item �path $pathCache -exclude *.lst -recurse} 
		else {($clearCache -eq 0)
			writeLog "��� ��� � ���������� ������� �� ������ �������� ��� ������� ����, ��� �� �������, ���������� ������"}
		do {
			$service1C = Get-Service -Name "$1CServiceName"
			($($service1C.Status) -eq "Stopped") 
			writeLog "������ �� ��������, ���������� ������"
			
			Start-Service "$1CServiceName"
			Start-Sleep 10
			}
		until ($($service1C.Status) -eq "Running")
			writeLog " "
			writeLog "������ ������ $1CServiceName ������ �������"
			writeLog " "
			writeLog " "
			writeLog " "
			{
			}
}
catch {
    writeLog "ERROR: $($error[0].Exception.Message)" -error
}


