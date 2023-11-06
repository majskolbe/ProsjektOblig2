include shared-gdrive(
"dcic-2021",
"1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")
include gdrive-sheets
include data-source
ssid = "1RYN0i4Zx_UETVuYacgaGfnFcv4l9zd9toQTTdkQkj7g"
kWh-wealthy-consumer-data =
load-table: komponent, energi
    source: load-spreadsheet(ssid).sheet-by-name("kWh", true)
    sanitize energi using string-sanitizer
end

#Definerer verdiene for formelen for energy-per-day
#Måtte flytte opp denne kodebiten for å skrive det ut i tabellen og få det med i chartet jeg skrev ut til slutt

distance-travelled-per-day = 48
distance-per-unit-of-fuel = 4
energy-per-unit-of-fuel = 10

#regner ut energiforbruk per dag for en vanlig inbygger
energy-per-day = ( distance-travelled-per-day / 
                            distance-per-unit-of-fuel ) * 
                                        energy-per-unit-of-fuel
#skriver ut tallet formelen regner ut med de definerte verdiene
energy-per-day


#funksjon for å gjøre om tekst til tall

fun energi-to-number(str :: String) -> Number:
  cases(Option) string-to-number(str):
    | some(a) => a
    | none => energy-per-day
  end
where:
  energi-to-number("") is energy-per-day
energi-to-number("48") is 48
end

#gjør teksten om til tall i energi-kolonnen med funksjonen jeg lagde

energi-tabell = transform-column(kWh-wealthy-consumer-data, "energi", energi-to-number) 


#skriver ut den riktige tabellen

energi-tabell

#summerer sammen alle verdiene i "energi" kolonnen

energiforbruk = sum(energi-tabell, "energi") 
energiforbruk

#lager og skriver ut et chart med alt fra tabellen

bar-chart(energi-tabell, "komponent", "energi")