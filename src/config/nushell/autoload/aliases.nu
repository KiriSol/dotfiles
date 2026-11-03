### Aliases & Abbreviations
$env.config.abbreviations.cls = "clear"
$env.config.abbreviations.e = "echo"

# Editor
if $env.VISUAL? != null { $env.config.abbreviations.v = $env.VISUAL | path basename }

## External
if (which mise | is-not-empty) { $env.config.abbreviations.m = "mise" }
if (which just | is-not-empty) { $env.config.abbreviations.j = "just" }
if (which zellij | is-not-empty) { $env.config.abbreviations.zj = "zellij" }

if (which git | is-not-empty) {
    $env.config.abbreviations.g = "git"
    $env.config.abbreviations.gpl = "git pl"
    $env.config.abbreviations.gps = "git ps"
    $env.config.abbreviations.ga = "git a"
    $env.config.abbreviations.gd = "git d"
    $env.config.abbreviations.gst = "git st"
    $env.config.abbreviations.gco = "git co"
    $env.config.abbreviations.gbr = "git br"
    $env.config.abbreviations.gc = "git c"
    $env.config.abbreviations.gca = "git ca"
    $env.config.abbreviations.gcm = "git cm"
    $env.config.abbreviations.gcam = "git cam"
    $env.config.abbreviations.gcl = "git cl"
    $env.config.abbreviations.glg = "git lg"
}
