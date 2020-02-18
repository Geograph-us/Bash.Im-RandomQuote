<#
    Выводит случайную цитату с сайта bash.im из "Лучшего" за неделю, используя RSS feed.
	Выводит случайный комикс с сайта bash.im, используя RSS feed.

    Чтобы цитата выводилась при запуске PowerShell - нужно добавить весь код из файла в файл профиля.
    Открыть файл профиля (powershell команда):
    notepad $profile

    Если выходит ошибка, значит файла профиля еще нет - нужно его создать:
    New-Item -path $profile -type file -force

    После чего открыть, добавить код и сохранить
	
	Теперь можно использовать команды:
	bashim #вывод случайной цитаты
	comics #показ случайного комикса
#>

Add-Type -assembly System.Windows.Forms
Add-Type -AssemblyName System.Web
$utils = [Web.HttpUtility]

$rssfeed = Invoke-RestMethod -Uri "http://bash.im/rss/"
$comicsfeed = Invoke-RestMethod -Uri "https://bash.im/rss/comics.xml"

Function BashIm
{
  Write-Host $utils::HtmlDecode($rssfeed[(Get-Random $rssfeed.Count)].description.innerText).Replace("<br>", "`r`n") -foreground Yellow
  echo ""
}

Function ShowImageUrl
{
	param([string]$url = $(throw "Image url"))

	[System.Windows.Forms.Application]::EnableVisualStyles();
	$form = new-object Windows.Forms.Form
	$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
	$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterParent
	$form.AutoSizeMode = [System.Windows.Forms.AutoSizeMode]::GrowAndShrink
	$form.AutoSize = $true
	$form.TopMost = $true
	$form.KeyPreview = $true
	$form.Add_KeyDown({ if($_.KeyCode -eq "Escape") { $form.Close() } })
	$form.Add_Shown({ $form.Activate() })

	$pictureBox = new-object Windows.Forms.PictureBox
	$pictureBox.AutoSize = $true
	$pictureBox.Dock = [System.Windows.Forms.DockStyle]::Fill
	try
	{
		$pictureBox.Load($url)
		$pictureBox.Add_Click({ $form.Close() })
		$form.controls.add($pictureBox)
		$form.ShowDialog() | Out-Null
	}
	catch{}
}

Function Comics
{
	ShowImageUrl ($comicsfeed[(Get-Random $comicsfeed.Count)].description.innerText -replace '.+"(.+)".+',  '$1')	
}

bashim
#comics
