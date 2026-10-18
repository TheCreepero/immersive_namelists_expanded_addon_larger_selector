BeforeAll {
    $script:RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
    . (Join-Path $script:RepoRoot 'tools\HoiModBuild.ps1')
    $script:BuildConfig = Get-ModBuildConfig -RepoDir $script:RepoRoot
}

Describe 'build.ps1 configuration' {
    It 'ships the interface folder with the descriptor and thumbnail' {
        $shippedTopLevel = @(Get-ModContentFiles -Config $script:BuildConfig | ForEach-Object { ($_ -split '/')[0] } | Sort-Object -Unique)
        $shippedTopLevel | Should -Be @('descriptor.mod', 'interface', 'thumbnail.png') -Because 'common holds only a .gitkeep placeholder'
    }

    It 'installs as immersive_namelists_expanded_addon_larger_selector and packages immersive_namelists_expanded_addon_larger_selector.zip' {
        $script:BuildConfig.ModFolderName | Should -Be 'immersive_namelists_expanded_addon_larger_selector'
        $script:BuildConfig.ZipArchiveName | Should -Be 'immersive_namelists_expanded_addon_larger_selector.zip'
        $script:BuildConfig.PackageLayout | Should -Be 'Flat'
    }
}
