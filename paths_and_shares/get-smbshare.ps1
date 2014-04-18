gwmi -class Win32_Share | % { $_.Name }
