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


#funksjon for å gjøre om tekst til tall

fun energi-to-number(s) -> Number:
  block:
    cases(Option) string-to-number(s): 
    | some(a) => a 
      | none => 120 
    end
  end 
where: 
  energi-to-number("") is 120 
  energi-to-number("48") is 48 
end 

#gjør teksten om til tall i energi-kolonnen

energi-tabell = transform-column(kWh-wealthy-consumer-data, "energi", energi-to-number) 

distance-travelled-per-day = 48
distance-per-unit-of-fuel = 4
energy-per-unit-of-fuel = 10

#regner ut energiforbruk per dag for en vanlig inbygger
energy-per-day = ( distance-travelled-per-day / 
                            distance-per-unit-of-fuel ) * 
                                        energy-per-unit-of-fuel
energy-per-day

#skriver ut tabellen

energi-tabell

#regner ut energiforbruk

energiforbruk = sum(energi-tabell, "energi") 
energiforbruk

#lager et chart

bar-chart(energi-tabell, "komponent", "energi")
