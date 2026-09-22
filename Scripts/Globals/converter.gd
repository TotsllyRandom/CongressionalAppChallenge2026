extends Node

## Conversion rates -> USD
const RATES = {
	"AFN" : 0.016,
	"ALL" : 0.013,
	"DZD" : 0.0075,
	"AOA" : 0.0011,
	"ARS" : 0.0007,
	"AMD" : 0.0026,
	"AWG" : 0.56,
	"AUD" : 0.71,
	"AZN" : 0.59,
	"BSD" : 1.00,
	"BHD" : 2.63,
	"BDT" : 0.0085,
	"BBD" : 0.50,
	"BYN" : 0.31,
	"BZD" : 0.50,
	"BMD" : 1.00,
	"BTN" : 0.012,
	"BOB" : 0.14,
	"BAM" : 0.59,
	"BWP" : 0.074,
	"BRL" : 0.19,
	"GBP" : 1.33,
	"BND" : 0.75,
	"BGN" : 0.59,
	"BIF" : 0.0003,
	"CVE" : 0.010,
	"KHR" : 0.0002,
	"CAD" : 0.71,
	"KYD" : 1.20,
	"XAF" : 0.0018,
	"XPF" : 0.0096,
	"CLP" : 0.0011,
	"CNY" : 0.15,
	"COP" : 0.0002,
	"KMF" : 0.0023,
	"CDF" : 0.0004,
	"CRC" : 0.0019,
	"CUP" : 0.042,
	"CZK" : 0.045,
	"DKK" : 0.16,
	"DJF" : 0.0056,
	"DOP" : 0.017,
	"XCD" : 0.37,
	"EGP" : 0.020,
	"ERN" : 0.067,
	"ETB" : 0.017,
	"EUR" : 1.15,
	"FJD" : 0.45,
	"FKP" : 1.33,
	"GMD" : 0.015,
	"GEL" : 0.37,
	"GHS" : 0.067,
	"GIP" : 1.33,
	"GTQ" : 0.13,
	"GNF" : 0.0001,
	"GYD" : 0.0048,
	"HTG" : 0.0075,
	"HNL" : 0.040,
	"HKD" : 0.13,
	"HUF" : 0.0028,
	"ISK" : 0.0072,
	"INR" : 0.010,
	"IDR" : 0.000063,
	"IRR" : 0.000024,
	"IQD" : 0.0008,
	"ILS" : 0.27,
	"JMD" : 0.0064,
	"JPY" : 0.0064,
	"JOD" : 1.41,
	"KZT" : 0.0022,
	"KES" : 0.0076,
	"KWD" : 3.23,
	"KGS" : 0.011,
	"LAK" : 0.000046,
	"LBP" : 0.000011,
	"LSL" : 0.055,
	"LRD" : 0.0052,
	"LYD" : 0.21,
	"MOP" : 0.12,
	"MKD" : 0.019,
	"MGA" : 0.0002,
	"MWK" : 0.0006,
	"MYR" : 0.25,
	"MVR" : 0.065,
	"MRU" : 0.025,
	"MUR" : 0.022,
	"MXN" : 0.059,
	"MDL" : 0.056,
	"MNT" : 0.0003,
	"MAD" : 0.10,
	"MZN" : 0.016,
	"MMK" : 0.0005,
	"NAD" : 0.055,
	"NPR" : 0.0075,
	"ANG" : 0.56,
	"TWD" : 0.031,
	"NZD" : 0.62,
	"NIO" : 0.027,
	"NGN" : 0.0007,
	"KPW" : 0.0011,
	"NOK" : 0.095,
	"OMR" : 2.63,
	"PKR" : 0.0036,
	"PAB" : 1.00,
	"PGK" : 0.26,
	"PYG" : 0.00013,
	"PEN" : 0.27,
	"PHP" : 0.017,
	"PLN" : 0.25,
	"QAR" : 0.27,
	"RON" : 0.22,
	"RUB" : 0.011,
	"RWF" : 0.0008,
	"SHP" : 1.33,
	"WST" : 0.36,
	"STN" : 0.044,
	"SAR" : 0.27,
	"RSD" : 0.0093,
	"SCR" : 0.075,
	"SLE" : 0.044,
	"SGD" : 0.78,
	"SBD" : 0.12,
	"SOS" : 0.0018,
	"ZAR" : 0.063,
	"KRW" : 0.0007,
	"SSP" : 0.0077,
	"LKR" : 0.0033,
	"SDG" : 0.0017,
	"SRD" : 0.028,
	"SEK" : 0.097,
	"CHF" : 1.22,
	"SYP" : 0.000077,
	"TJS" : 0.091,
	"TZS" : 0.00038,
	"THB" : 0.030,
	"TOP" : 0.42,
	"TTD" : 0.15,
	"TND" : 0.32,
	"TRY" : 0.030,
	"TMT" : 0.29,
	"UGX" : 0.00027,
	"UAH" : 0.025,
	"AED" : 0.27,
	"USD" : 1.00,
	"UYU" : 0.025,
	"UZS" : 0.000079,
	"VUV" : 0.0084,
	"VES" : 0.027,
	"VND" : 0.000038,
	"XOF" : 0.0018,
	"YER" : 0.0040,
	"ZMW" : 0.039,
	"ZWG" : 0.073
}


## USD -> Currency
func get_currency_from_usd(currency:String,amount):
	
	## time/memory saver
	if currency == "USD":
		return amount
	
	## failsafe if currency is not found
	if not RATES.keys().has(currency):
		print("Could not find currency '"+currency+"' in const RATES")
		return
	
	amount = float(amount)
	
	return amount / RATES[currency]
	

## Currency -> USD
func get_usd_from_currency(currency:String,amount):
	
	## time/memory saver
	if currency == "USD":
		return amount
	
	## failsafe if currency is not found
	if not RATES.keys().has(currency):
		print("Could not find currency '"+currency+"' in const RATES")
		return
	
	## makes amount into float for easier conversion
	amount = float(amount)
	
	return amount * RATES[currency]


## Currency 1 -> USD -> Currency 2
func get_currency_from_currency(currency1:String,currency2:String,amount):
	
	## failsafe if currency is not found
	if not RATES.keys().has(currency1):
		print("Could not find currency '"+currency1+"' in const RATES")
		return
	if not RATES.keys().has(currency2):
		print("Could not find currency '"+currency2+"' in const RATES")
		return
	
	## currency 1 -> USD -> currency 2
	if not currency1 == "USD":
		amount = get_usd_from_currency(currency1,amount)
	
	if not currency2 == "USD":
		amount = get_currency_from_usd(currency2,amount)
	
	return amount
