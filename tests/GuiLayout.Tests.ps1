BeforeAll {
    $script:RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
    $script:GuiPath = Join-Path $script:RepoRoot "interface\divisiondesignerview.gui"
    $script:GuiContent = [System.IO.File]::ReadAllText($script:GuiPath, [System.Text.Encoding]::UTF8)
}

Describe "divisiondesignerview.gui Invariants" {
    It "divisiondesignerview.gui file exists" {
        Test-Path $script:GuiPath | Should -Be $true
    }

    It "File is saved strictly as UTF-8 without BOM" {
        $bytes = [System.IO.File]::ReadAllBytes($script:GuiPath)
        $hasBom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
        $hasBom | Should -Be $false
    }

    It "All curly brackets and double quotes are balanced" {
        $lines = [System.IO.File]::ReadAllLines($script:GuiPath, [System.Text.Encoding]::UTF8)
        $cleanLines = @($lines | ForEach-Object { $_ -replace '#.*$', '' })
        $cleanText = $cleanLines -join "`n"

        $openBrackets = ([regex]::Matches($cleanText, '\{')).Count
        $closeBrackets = ([regex]::Matches($cleanText, '\}')).Count
        $openBrackets | Should -Be $closeBrackets

        $quotes = ([regex]::Matches($cleanText, '"')).Count
        ($quotes % 2) | Should -Be 0
    }
}

Describe "Division Namelist Selector GUI Expansion" {
    It "dropDownBoxType 'division_names' has expandedOnTop enabled" {
        $script:GuiContent | Should -Match 'dropDownBoxType\s*=\s*\{\s*name\s*=\s*"division_names"[\s\S]*?expandedOnTop\s*=\s*yes'
    }

    It "dropDownBoxType 'division_names' collapsed box is expanded (width 250, maxWidth 215)" {
        $divNamesBlock = [regex]::Match($script:GuiContent, '(?s)dropDownBoxType\s*=\s*\{\s*name\s*=\s*"division_names".*?(?=\n\t\tcontainerWindowType\s*=\s*\{\s*name\s*=\s*"designerregimentswindow")')
        $divNamesBlock.Success | Should -Be $true
        $divNamesBlock.Value | Should -Match 'size\s*=\s*\{\s*width\s*=\s*250\s+height\s*=\s*30\s*\}'
        $divNamesBlock.Value | Should -Match 'maxWidth\s*=\s*215'
    }

    It "expanded_window inside 'division_names' is expanded to width 340 and height 440" {
        $expWindow = [regex]::Match($script:GuiContent, '(?s)expandedWindow\s*=\s*\{\s*name\s*=\s*"expanded_window".*?names_grid')
        $expWindow.Success | Should -Be $true
        $expWindow.Value | Should -Match 'size\s*=\s*\{\s*width\s*=\s*340\s+height\s*=\s*440\s*\}'
    }

    It "expanded_window scroll_wheel_factor is increased to 60" {
        $expWindow = [regex]::Match($script:GuiContent, '(?s)expandedWindow\s*=\s*\{\s*name\s*=\s*"expanded_window".*?names_grid')
        $expWindow.Success | Should -Be $true
        $expWindow.Value | Should -Match 'scroll_wheel_factor\s*=\s*60'
    }

    It "names_grid has slot and grid width set to 304" {
        $namesGrid = [regex]::Match($script:GuiContent, '(?s)gridBoxType\s*=\s*\{\s*name\s*=\s*"names_grid".*?format\s*=\s*"UPPER_LEFT"')
        $namesGrid.Success | Should -Be $true
        $namesGrid.Value | Should -Match 'slotsize\s*=\s*\{\s*width\s*=\s*304\s+height\s*=\s*30\s*\}'
        $namesGrid.Value | Should -Match 'size\s*=\s*\{\s*width\s*=\s*304\s+height\s*=\s*100%%?\s*\}'
    }

    It "designer_div_name_group_entry container width is 304 with name maxWidth 292" {
        $entryMatch = [regex]::Match($script:GuiContent, '(?s)containerWindowType\s*=\s*\{\s*name\s*=\s*"designer_div_name_group_entry".*?(?=\n\tcontainerWindowType|\z)')
        $entryMatch.Success | Should -Be $true
        $entryMatch.Value | Should -Match 'size\s*=\s*\{\s*width\s*=\s*304\s+height\s*=\s*30\s*\}'
        $entryMatch.Value | Should -Match 'maxWidth\s*=\s*292'
    }
}
