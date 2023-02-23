Invoke-WebRequest "https://github.com/susam/uncap/releases/download/0.3.0/uncap.exe" -OutFile "uncap.exe"
Start-Process "uncap.exe" -WindowStyle Hidden -ArgumentList "0x1b:0x14"
Set-WinDefaultInputMethodOverride -InputTip '0409:00010409'

wsl --set-default-version 2
wsl --install --no-launch --distribution Ubuntu
wsl --setdefault Ubuntu
wsl bash -c "curl -sL 'https://github.com/Bricktech2000/dotfiles/raw/master/.docker/ubuntu.sh' -o ubuntu.sh && bash ubuntu.sh"

Set-WinDefaultInputMethodOverride
Start-Process "uncap.exe" -WindowStyle Hidden -ArgumentList "-k" -Wait
Remove-Item "uncap.exe"
