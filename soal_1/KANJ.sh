BEGIN {
	FS = ","
	pilihan = tolower(ARGV[2])
	delete ARGV[2]
}

{
	if (NR == 1) {
		next
	}

	#removing \r on csv
	sub("\r", "", $0)

	if (pilihan == "a") count_passenger++ 
	if (pilihan == "b") {
		if(!($4 in Gerbong)) {
			carriage++
			Gerbong[$4] = 1
		}
	}
	if (pilihan == "c") {
		if(NR == 2) {
			age = $2
			oldest = $1
		} else if ($2 > age) {
			age = $2
			oldest = $1
		}
	}
	if (pilihan == "d") {
		total += $2
		data++
	}
	if (pilihan == "e") {
		if ($3 == "Business") {
			business_passenger++
		}
	}
}

END {
	switch (pilihan) {
		case "a":
		print "Jumlah seluruh penumpang KANJ adalah " count_passenger " orang"
		break
		case "b":
		if (carriage == "") {
			print "Jumlah gerbong penumpang KANJ adalah 0"
			
		} else {
			print "Jumlah gerbong penumpang KANJ adalah " carriage
		}
		break

		case "c":
		print oldest " adalah penumpang kereta tertua dengan usia " age " tahun"
		break

		# fixing option d: adding "\n" on the last sentence
		case "d":
		if (data > 0) {
			average_age = total / data
			printf "Rata-rata usia penumpang adalah %.0f tahun\n", average_age
		}
		break

		case "e":
		if (business_passenger == "") business_passenger = 0
		print "Jumlah penumpang business class ada " business_passenger " orang"
		break

		default:
		print "Soal tidak dikenali. Gunakan a, b, c, d, atau e. \nContoh penggunaan: awk -f file.sh data.csv a"
		break
	}
}
