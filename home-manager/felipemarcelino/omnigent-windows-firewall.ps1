# Libera a porta do servidor Omnigent (WSL) para a LAN.
# Rodar UMA VEZ, em PowerShell COMO ADMINISTRADOR, no Windows.
#
# Contexto: com networkingMode=mirrored (ver ~/.wslconfig) o WSL compartilha as
# interfaces de rede do Windows, entao um servico bindado em 0.0.0.0 dentro do
# WSL fica acessivel pelo IP LAN da maquina -- mas passa por DOIS firewalls:
#   1. o firewall Hyper-V, que filtra o trafego que entra na VM do WSL;
#   2. o Windows Defender Firewall do proprio host.
# As duas regras abaixo cobrem os dois, restritas a LocalSubnet: so quem esta
# na mesma rede local alcanca a porta, nunca a internet.
#
# Par nix: home-manager/felipemarcelino/omnigent.nix

$ErrorActionPreference = 'Stop'

$Port          = 6767
$WslVMCreator  = '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}'  # Get-NetFirewallHyperVVMCreator
$RuleName      = 'WSL-Omnigent-6767'

# 1. Firewall Hyper-V: deixa o trafego chegar na VM do WSL.
Get-NetFirewallHyperVRule -Name $RuleName -ErrorAction SilentlyContinue |
    Remove-NetFirewallHyperVRule -ErrorAction SilentlyContinue
New-NetFirewallHyperVRule `
    -Name        $RuleName `
    -DisplayName 'Omnigent server (WSL) 6767' `
    -Direction   Inbound `
    -VMCreatorId $WslVMCreator `
    -Protocol    TCP `
    -LocalPorts  $Port `
    -Action      Allow

# 2. Windows Defender Firewall: deixa o trafego chegar no host, so da LAN.
Get-NetFirewallRule -DisplayName 'Omnigent server (WSL) 6767' -ErrorAction SilentlyContinue |
    Remove-NetFirewallRule -ErrorAction SilentlyContinue
New-NetFirewallRule `
    -DisplayName   'Omnigent server (WSL) 6767' `
    -Direction     Inbound `
    -Protocol      TCP `
    -LocalPort     $Port `
    -RemoteAddress LocalSubnet `
    -Profile       Any `
    -Action        Allow

Write-Host "OK -- porta $Port liberada para a rede local." -ForegroundColor Green
Write-Host "Agora rode 'wsl --shutdown' para o networkingMode=mirrored entrar em vigor."
