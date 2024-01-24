Add-Type -AssemblyName System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='Gui for the pos script'
$main_form.Width = 600
$main_form.Height = 200
$main_form.AutoSize =$true
$main_form.ShowDialog()

#Add Control Items to a PowerShell Form

$Label = New-Object System.Windows.Forms.Label

$Label.Text = "AD users"

$Label.Location = New-Object System.Drawing.Point(0,10)$form.StartPosition = 'CenterScreen'

$Label.AutoSize = $true

$main_form.Controls.Add($Label)

#The Location property sets the element’s relative position on the form

$ComboBox = New-Object System.Windows.Forms.ComboBox

$ComboBox.Width = 300

$ComboBox = New-Object System.Windows.Forms.ComboBox

$ComboBox.Width = 300

$Users = Get-ADuser -filter * -Properties SamAccountName

Foreach ($User in $Users)

{

$ComboBox.Items.Add($User.SamAccountName);

}

$ComboBox.Location  = New-Object System.Drawing.Point(60,10)

$main_form.Controls.Add($ComboBox)


#Add two more labels to the form. The first should show a static text, and the second should show the last time that the password for the selected AD user account was changed.

$Label2 = New-Object System.Windows.Forms.Label

$Label2.Text = "Last Password Set:"

$Label2.Location  = New-Object System.Drawing.Point(0,40)

$Label2.AutoSize = $true

$main_form.Controls.Add($Label2)

$Label3 = New-Object System.Windows.Forms.Label

$Label3.Text = ""

$Label3.Location  = New-Object System.Drawing.Point(110,40)

$Label3.AutoSize = $true

$main_form.Controls.Add($Label3)


#Add the button inside the form

$Button = New-Object System.Windows.Forms.Button

$Button.Location = New-Object System.Drawing.Size(400,10)

$Button.Size = New-Object System.Drawing.Size(120,23)

$Button.Text = "Check"

$main_form.Controls.Add($Button)


#Add Event Handlers to PowerShell Script

$Button.Add_Click(

{

$Label3.Text =  [datetime]::FromFileTime((Get-ADUser -identity $ComboBox.selectedItem -Properties pwdLastSet).pwdLastSet).ToString('MM dd yy : hh ss')

}

)


#Some of the GUI elements on a form can be hidden using the Visible property.

$Label3.Text.Visible = $false

# or $True if you want to show it