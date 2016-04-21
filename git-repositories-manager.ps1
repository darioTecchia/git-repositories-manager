<#
  That script work like Yaourt Package Manager
  
  Author: Dario Tecchia
#>

$apiUrl = 'https://api.github.com/search/repositories?q='

# Read the Search Query
$query = Read-Host 'Insert search query'

$requestUrl = $apiUrl + $query

# Make the query
$response = Invoke-WebRequest $requestUrl -UseBasicParsing

# Parse the response
$parsedResponse = ConvertFrom-Json $response
$items = $parsedResponse.items

# Output the query result
for ($i = 0; $i -lt $items.Count; $i++) {
  
  # Write the number
  Write-Host $i -NoNewline -BackgroundColor 'Yellow' -ForegroundColor 'Black'
  
  # Write the name
  Write-Host ' ' -NoNewline
  Write-Host $items[$i].owner.login -NoNewline -ForegroundColor 'Green'
  Write-Host '/' -NoNewline -ForegroundColor 'Green'
  Write-Host $items[$i].name
  
  # Write the description
  if($items[$i].description -eq "") {
    Write-Host '   ' -NoNewline
    Write-Host "No Description`n"
  }
  else {
    Write-Host '   ' -NoNewline
    Write-Host $items[$i].description -ForegroundColor 'Gray'
  }
}

# Select the Repository to clone
$choice = Read-Host "Enter n of repository to be cloned`n-----------------------------------"
git clone $items[$choice].clone_url

Write-Host "Bye!"