# universal-dashboard-bootstrap
UD framework for easy and fast deployment

# How to use

1. Install [Universal Dashboard](https://github.com/ironmansoftware/universal-dashboard)
1. Place the project files anywhere you want
1. run the `dashboard.ps1`

# How to learn

1. Inspect the `dashboard.ps1`
1. Look in the `Pages\50-Example-Process*.ps1` to see the example of a dynamic page
1. Use templates in `Templates\*.ps1` as building blocks for your dashboard.

# How to / Best practices

Do not store your envirnoment specific names/values (for example your vCenter address, or AD FQDN name) directly in the code. Store them as `Config\config_ADFQDNName.json` and load it contents to the variable using `10-Init-LoadConfigurationParameter.ps1` template. If you need this variable to be available in the enpoints - use [`$cache:variablename` assingment and usage](https://docs.universaldashboard.io/endpoints/custom-variable-scopes#cache-scope). 

Files in the `Pages` should use numbering scheme (`^\d\d-`) in the names to: 

* control load order (you don't want to load the page if its dependencies wasn't loaded) and
* have a loose self-organizing structure

Suggested order:

1. `00-` critical pre-init (like vmware)
1. `10-` environment and variables initialization
1. `11-` scheduled endpoints and cache entries
1. `4?-` static pages
1. `5?-` dynamic pages
1. `90-` post-init catch-all (consult `90-PostInit.ps1` for `UDEPVar*` init)
1. `99-` homepage

# Notes

This project was born as an attempt to write the useful dashboard for vSphere deployment at one company. In the process (amid the errors, quirks and frustration) the need for a more useful building block (than UD help pages) was realized.


