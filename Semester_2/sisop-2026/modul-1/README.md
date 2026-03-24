# Sisop-1-2026-IT-107

## Member

| Nama                   | NRP        |
| ---------------------- | ---------- |
| Yovi Prayudya Rizky Ramadhani | 5027251107 |

## Reporting

### Soal 1

#### Penjelasan

**passenger.csv**

untuk langkah pertama, download terlebih dahulu [passenger.csv](https://docs.google.com/spreadsheets/d/1NHmyS6wRO7To7ta-NLOOLHkPS6valvNaX7tawsv1zfE/export?format=csv&gid=0) dengan menggunakan command `wget -O passenger.csv "link passenger.csv"`

Selanjutnya membuat program bernama KANJ.sh

**1. Shell scripting - KANJ.sh - BEGINNING**

```sh
BEGIN {
	FS = ","
	pilihan = tolower(ARGV[2])
	delete ARGV[2]
}
```

Disini adalah awal mulanya. Untuk memulai command biasanya menggunakan `awk -f file_program arg1 arg2` dengan file_program berupa .awk atau .sh (dengan catatan .sh tidak berupa `#!/bin/bash`), arg1 bisa berupa inputan file apapun seperti txt, csv dan arg2 adalah inputan apapun.

**2. Shell scripting - KANJ.sh - MIDDLE**

```sh
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
```

lalu pada bagian ini terdapat beberapa pilihan

```sh
{
	if (NR == 1) {
		next
	}
```

adalah sebuah perintah untuk AWK yang melakukan pengecekan NR terhadap 1 dan dia akan skip bagian itu.

```sh
	#removing \r on csv
	sub("\r", "", $0)
```

bagian ini adalah regex yang melakukan pengecekan terhadap file dan biasanya file tersebut ada `\r` yang disebut sebagai carriage return merupakan barisan yang kembali ke posisi awalnya. kemudian

```sh
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
```

adalah sebuah program if else inputan user. Inputan `a` adalah inputan yang menjumlahkan seluruh penumpang yang ada di csv ini. Inputan `b` adalah inputan yang menjumlahkan gerbong yang ada di csv. Inputan `c` adalah inputan pengecekan dalam csv yang tertua. Inputan `d` adalah inputan untuk mengetahui jumlah seluruh umur penumpang dalam csv. Dan yang terakhir inputan `e` adalah inputan program yang ingin memeriksa total penumpang Business class ini

**3. Shell scripting - KANJ.sh - END**

```sh
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

		case "d":
		if (data > 0) {
			average_age = total / data
			printf "Rata-rata usia penumpang adalah %.0f tahun", average_age
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
```

Ini adalah program terakhir dari shell script ini. Bisa dibilang outputan program ini dan sedikit menambahkan untuk opsi `d` itu adalah average atau rata-rata umur dari seluruh penumpang dalam csv ini

#### Output

1. Mengunduh file passenger.csv

![download](assets/soal_1/download.png)

2. Output dari pilihan a

![alt text](assets/soal_1/opsi%20a.png)

3. Output dari pilihan b

![alt text](assets/soal_1/opsi%20b.png)

4. Output dari pilihan c

![alt text](assets/soal_1/opsi%20c.png)

5. Output dari pilihan d

![alt text](assets/soal_1/opsi%20d.png)

6. Output dari pilihan e

![alt text](assets/soal_1/opsi%20e.png)

7. Output dari selain pilihan a, b, c, d, e

![alt text](assets/soal_1/opsi%20lain.png)

#### Kendala

Tidak ada kendala

### Soal 2

**Dikerjakan secara: individu**

#### Penjelasan

**a. Mengunduh file peta-ekspedisi-mamba.pdf**

Langkah pertama yaitu menyiapkan tools `gdown` untuk mendownload sebuah pdf. Lalu menggunakan command `gdown https://drive.google.com/uc?id=1q10pHSC3KFfvEiCN3V6PTroPR7YGHF6Q`

**b. Membuat sebuah folder ekspedisi dan memindahkan ke dalam folder ekspedisi**

Langka kedua menggunakan command `mv peta-ekspedisi-mamba.pdf ekspedisi` untuk memindahkannya ke dalam folder ekspedisi

**c. Menggunakan strings untuk mengetahui metadata pdf file**

Langkah ketiga menggunakan command `strings peta-ekspedisi-mamba.pdf` untuk mengetahui rahasia dalam file pdf ini yang berupa sebuah link github.

**d. Menggunakan git clone**

Langkah keempat menggunakan command `git clone https://github.com/pocongcyber77/peta-gunung-kawi.git` untuk clone berupa `gsxtrack.json`

**e. mengurutkan id, site_name, latitude, dan longitude**

Langkah kelima membuat sebuah program bernama `parserkoordinat.sh` yang berisi programnya:

```sh
#!/bin/bash

echo "haik, wakarimasta. Lagi process membaca gsxtrack.json dan dipindah ke titik-penting.txt"

jq -r '.features[] | "\(.id), \(.properties.site_name), \(.properties.latitude), \(.properties.longitude)"' gsxtrack.json > titik-penting.txt

echo "Kelar wak. udh selesai dipindah ke titik-penting.txt"
```

Inti dari program ini adalah mengambil id, site_name, latitude, dan longitude yang ada dalam `features` dan dipindahkan ke `titik-penting.txt` untuk diurutkan.

**f. Membuat titik pusat metode titik simetri diagonal**

Langkah keenam membuat program `nemupusaka.sh` yang programnya:

```sh
#!/bin/bash

file="titik-penting.txt"

awk -F', ' '
BEGIN {
}
NR==1 {
    lat_min=lat_max=$3
    lon_min=lon_max=$4
}
{
    if ($3 < lat_min) lat_min = $3
    if ($3 > lat_max) lat_max = $3
    if ($4 < lon_min) lon_min = $4
    if ($4 > lon_max) lon_max = $4
}
END {
    pusat_lat = (lat_min + lat_max) / 2
    pusat_lon = (lon_min + lon_max) / 2
    
    printf "Koordinat: "
    printf "%.6f, %.6f\n", pusat_lat, pusat_lon
    printf "Koordinat: %.6f, %.6f\n", pusat_lat, pusat_lon > "posisipusaka.txt"
}' "$file"
```

Yang isi dari program ini adalah membandingkan maximum dan minimum longitude dan latitude dari masing-masing yang ada di file `titik-penting.txt`

```sh
{
    if ($3 < lat_min) lat_min = $3
    if ($3 > lat_max) lat_max = $3
    if ($4 < lon_min) lon_min = $4
    if ($4 > lon_max) lon_max = $4
}
```

adalah program mencari latitude maximum, latitude minimum, longitude minimum, dan longitude maximum. Karena program menggunakan awk, jadinya program tersebut akan terus berjalan sampai akhir

```sh
END {
    pusat_lat = (lat_min + lat_max) / 2
    pusat_lon = (lon_min + lon_max) / 2
    
    printf "Koordinat: "
    printf "%.6f, %.6f\n", pusat_lat, pusat_lon
    printf "Koordinat: %.6f, %.6f\n", pusat_lat, pusat_lon > "posisipusaka.txt"
}' "$file"
```

dan yang terakhir adalah program mencari titk koordinatnya dan mengeluarkan output x, y.

#### Output

1. Mengunduh file peta-ekspedisi-mamba.pdf
   
![alt text](assets/soal_2/install.png)

![alt text](assets/soal_2/download_pdf.png)

2. Membuat sebuah folder ekspedisi dan memindahkan ke dalam folder ekspedisi
   
![alt text](assets/soal_2/moving.png)

3. Menggunakan strings untuk mengetahui metadata pdf file

![alt text](assets/soal_2/strings_pdf.png)

4. Menggunakan git clone

![alt text](assets/soal_2/cloning_git.png)

5. mengurutkan id, site_name, latitude, dan longitude

![alt text](assets/soal_2/coordinate.png)

6. Membuat titik pusat metode titik simetri diagonal

![alt text](assets/soal_2/shell_script_catch_titik.png)   

#### Kendala

Tidak ada kendala

### Soal 3

#### Penjelasan

**Shell scripting - Kost Slebew**

Pertama untuk tambah penghuni dari sebuah kost, bisa memanfaatkan looping sederhana dan melakukan validasi dari tiap input user dalam nama, kamar, status, dan data-data dari input user akan dimasukkan ke dalam sebuah file `data/penghuni.csv`

```c
create() {

    echo "==================================================== "
    echo "             『Daftar Huni kost Slebew 』            "
    echo "==================================================== "

    while true; do
    read -p "Silahkan masukkan nama: " nama
    if grep -q -w "$nama" data/penghuni.csv 2>/dev/null; then
        echo "Maaf, Penghuni dengan nama '$nama' sudah terdaftar!"
        echo "Silakan coba masukkan nama lain."
        continue
    fi

    read -p "Masukkan kamar yang diinginkan: " kamar
    if [[ $kamar =~ $re ]] ; then
        if grep -q -w "$kamar" data/penghuni.csv 2>/dev/null; then
            echo "Maaf, Kamar $kamar sudah terisi!"
            echo "Silakan coba masukkan nomor kamar lain."
            continue
        fi
    else
        echo "maaf harus input angka"
        sleep 1
        continue
    fi
    read -p "Harga sewa: " price
    read -p "Tanggal masuk (YYYY-MM-DD): " date
    read -p "status awal (aktif atau menunggak): " status
    if [[ "$status" == "aktif" || "$status" == "menunggak" ]]; then
          echo "$nama,$kamar,$price,$date,$status" >> data/penghuni.csv

            echo "penghuni '$nama' berhasil ditambahkan ke Kamar $kamar dengan status $status "

            while true; do
                read -p "Enter untuk kembali..." dummy
                if [ "$dummy" != "" ]; then
                    echo "Nope, harus enter"
                else
                    break   
                fi
            done
        return
    else
          echo "Harus ketik aktif atau menunggak yakk"
          continue
     fi
done
}
```

Sebelum melanjutkan, terdapat pembuatan awal folder dan file menjadi 1 dan menggunakan cd untuk menuju ke file `kost_slebew.sh`. Dan juga terdapat global regex yang mewajibkan pengguna untuk input hanya berupa angka

pembuata folder dan file penghuni.csv

```sh
cd "$(dirname "$0")" 
mkdir -p data log rekap sampah 
if [ ! -f data/penghuni.csv ]; then
    echo "Nama,Kamar,Harga,Tanggal,Status" > data/penghuni.csv
fi
```

regex global berupa angka

```sh
re='^[0-9]+$'
```

Setelah itu ada function `delete` untuk menghapus data penghuni dari kos yang sesuai diminta sama soal dan untuk menghapusnya hanya lewat nama dari penghuni itu serta history penghapusannya dipindah dengan mengcopy dari file utama ke file `history_hapus.csv`ini. Dan untuk penghapusannya hanya di file `history_hapus.csv` bukan di utamanya.

```sh
delete() {

    echo "==================================================== "
    echo "           『Delete Huni Kost Slebew 』              "
    echo "==================================================== "

    cp data/penghuni.csv sampah/history_hapus.csv
    read -p "Masukkan nama penghuni yang ingin dihapus: " nama

    if grep -q -w "$nama" sampah/history_hapus.csv 2>/dev/null; then
        sed -i "/^$nama,/d" sampah/history_hapus.csv
        echo "Penghuni '$nama' berhasil dihapus."
    else
        echo "Penghuni '$nama' tidak ditemukan."
    fi

     while true; do
          read -p "Enter untuk kembali..." dummy
          if [ "$dummy" != "" ]; then
               echo "Nope, harus enter"

               else
                    break   
          fi
    done

    return
}
```

Selanjutnya program diminta untuk melakukan list penghuni

```sh
list_huni() {
    echo "==================================================== "
    echo "             『List huni Kost Slebew 』              "
    echo "==================================================== "
    echo " NO | NAMA HUNI KOST | KAMAR | HARGA SEWA | STATUS | "
    echo "---------------------------------------------------- "

    awk -F',' '
    BEGIN { 
        aktif = 0
        nunggak = 0
        no = 1 
    }
    NR > 1 { 
        
        if ($5 == "aktif") aktif++
        if ($5 == "menunggak") nunggak++
        
        tampilan = $0
        gsub(/,/, " | ", tampilan)
        
        print no ". " tampilan
        print "---------------------------------------------------- "
        no++
    }
    END {

        total = no - 1
        print "Total: " total " | Aktif: " aktif " | Menunggak: " nunggak
    }' data/penghuni.csv 2>/dev/null

    echo "==================================================== "
    read -p "Enter untuk kembali..." dummy
    return
}
```

Pada function ini, saya menggunakan awk untuk melakukan suatu perulangan untuk membaca `penghuni.csv` dengan sebuah kondisi dimana yang menunggak sendiri dan yang aktif sendiri, tidak digabung menjadi 1.

```sh
update_huni() {

    echo "==================================================== "
    echo "             『Update Huni Kost Slebew 』            "
    echo "==================================================== "
    read -p "Masukkan nama penghuni yang ingin diubah statusnya: " nama

        if grep -q -w "$nama" data/penghuni.csv 2>/dev/null; then
            read -p "Masukkan status Baru (Aktif atau nunggak): " stat_bar
            sed -i "s/^\($nama,[^,]*,[^,]*,[^,]*\),.*/\1,$stat_bar/" data/penghuni.csv
            echo "Penghuni '$nama' berhasil diganti menjadi $stat_bar"
        else
            echo "Penghuni '$nama' tidak ditemukan."
        fi
}
```

Dalam program ini, akan mengubah suatu status berdasarkan nama yang diketik dan status terbaru. Misalkan `Kano` dengan status lama `menunggak`, user akan menginput nama `Kano` dan mengubah status lamanya menjadi `aktif`. Begitupun sebaliknya dan data ini akan tersimpan dalam file `penghuni.csv`. Disini juga pemakaian `sed` dipakai untuk mengubah statusnya tersebut ke dalam file `penghuni.csv` dengan status barunya dan mungkin beberapa function yang lain juga menggunakan `sed` untuk mengubah suatu data dalam file itu seperti dalam `delete` function.

```sh
laporan() {
    rekap=$(awk -F',' '
    BEGIN {
        pendapatan = 0
        pendapatan_nung = 0
        jml_nunggak = 0
        list_nunggak = ""
    }
    NR > 1 { 
        
        if ($5 == "aktif") {
            pendapatan += $3
        } 
        else if ($5 == "menunggak") {
            pendapatan_nung += $3
            jml_nunggak++
            list_nunggak = list_nunggak $1 ", "
        }
    }
    END {

        if (list_nunggak != "") {
            sub(/, $/, "", list_nunggak)
        } else {
            list_nunggak = "-"
        }

        print "===================================================="
        print "          『 Laporan huni Kost Slebew 』            "
        print "===================================================="
        print "Total Pendapatan Aktif : Rp " pendapatan
        print "Total tunggakan        : RP " pendapatan_nung
        print "Jumlah Orang Nunggak   : " jml_nunggak
        print "Daftar Nama Nunggak    : " list_nunggak
        print "===================================================="
    }' data/penghuni.csv 2>/dev/null)

    echo "$rekap"
    
    echo "$rekap" > rekap/laporan_bulanan.txt
    echo "Hasil rekapan sudah dimasukkan ke dalam rekap/laporan_bulanan.txt"
    
    read -p "Enter untuk kembali..." dummy
}
```

Pada function `laporan` disini juga saya menggunakan awk untuk melakukan suatu perulangan dalam membaca sebua file `penghuni.csv` untuk merekap hasil pendapatannya dengan kondisi aktif tersendiri dan menunggak tersendiri. Selanjutnya dari data rekapan tersebut, akan disimpan ke sebuah file `laporan_bulanan.txt` dengan menggunakan teknik `overwrite` 

```sh
pengingat() {
    while true; do
        echo "==================================================== "
        echo "                  『 Menu Kron 』                   "
        echo "==================================================== "
        echo "1. Lihat Jadwal Aktif (System)"
        echo "2. Tambah Jadwal Baru"
        echo "3. Hapus Semua Jadwal"
        echo "4. Kembali"
        echo "==================================================== "
        read -p "Pilih 1-4: " pilih

        if [ "$pilih" == "1" ]; then
            echo "--- List Cron yang sedang berjalan ---"
            crontab -l 2>/dev/null || echo "Belum ada jadwal aktif."
            
        elif [ "$pilih" == "2" ]; then
            echo "Format: menit jam tgl bulan hari_minggu"
            read -p "Input jadwal (contoh: 00 23 * * *): " jadwal
            read -p "Perintah/Script yg dijalankan (path lengkap): " cmd
            
            (crontab -l 2>/dev/null; echo "$jadwal $cmd") | crontab -
            
            echo "Jadwal berhasil diaktifkan!"
            echo "[$(date)] Berhasil input: $jadwal $cmd" > log/tagihan.log

        elif [ "$pilih" == "3" ]; then

            crontab -r
            echo "Semua jadwal cron telah dihapus!"
            echo "[$(date)] Menghapus semua cron" >> log/tagihan.log

        elif [ "$pilih" == "4" ]; then
            break 
        else
            echo "pilihan salah. coba lagi"
        fi

        read -p "Enter untuk kembali..." dummy
                if [ "$dummy" != "" ]; then
                    echo "Nope, harus enter"
                else
                    break   
                fi
    done
}
```

Dan disinilah function terakhir yaitu `pengingat` dengan melakukan teknik `crob`. Dalam function ini, ada perulangan sederhana menggunakan while dan memiliki beberapa pilihan

```sh
if [ "$pilih" == "1" ]; then
            echo "--- List Cron yang sedang berjalan ---"
            crontab -l 2>/dev/null || echo "Belum ada jadwal aktif."
```

Jika pilihannya 1 maka pilihan ini akan menjalankan list yang sudah dibuat oleh user ataupun masih belum ada

```sh
        elif [ "$pilih" == "2" ]; then
            echo "Format: menit jam tgl bulan hari_minggu"
            read -p "Input jadwal (contoh: 00 23 * * *): " jadwal
            read -p "Perintah/Script yg dijalankan (path lengkap): " cmd
            
            (crontab -l 2>/dev/null; echo "$jadwal $cmd") | crontab -
            
            echo "Jadwal berhasil diaktifkan!"
            echo "[$(date)] Berhasil input: $jadwal $cmd" >> log/tagihan.log
```

Jika pilihan 2 maka user harus menginput sesuai dengan aturan cron yaitu `*` pertama untuk menit `*` kedua untuk jam, `*` untuk hari dalam bulan, `*` bulan, dan yang terakhir untuk hari dalam minggu dan untuk inputan ini harus lengkap. jika hanya jam saja maka `00 07 * * *`. Selanjutnya adalah path menuju sebuah program `kosh_slebew.sh`. Untuk pathnya sendiri harus lengkap. Dan jika user sudah input sesuai 2 kategori data, maka inputan ini akan masuk ke dalam file `tagihan.log`.

```sh
        elif [ "$pilih" == "3" ]; then

            crontab -r
            echo "Semua jadwal cron telah dihapus!"
            echo "[$(date)] Menghapus semua cron" >> log/tagihan.log
```

Jika inputan angka 3, program ini akan menjalan penghapusan cron yang sudah dibuat oleh pengguna dan akan menghapus yang sudah jalan di dalam file `tagihan.log`

```sh
elif [ "$pilih" == "4" ]; then
            break 
        else
            echo "pilihan salah. coba lagi"
        fi

        read -p "Enter untuk kembali..." dummy
                if [ "$dummy" != "" ]; then
                    echo "Nope, harus enter"
                else
                    break   
                fi
    done
```

Pilihan terakhir yaitu keluar dari menu cron itu sendiri

```sh
while true
do
cat << "EOF"

 __                  __           .__        ___.                  
|  | ______  _______/  |_    _____|  |   ____\_ |__   ______  _  __
|  |/ /  _ \/  ___/\   __\  /  ___/  | _/ __ \| __ \_/ __ \ \/ \/ /
|    <  <_> )___ \  |  |    \___ \|  |_\  ___/| \_\ \  ___/\     / 
|__|_ \____/____  > |__|   /____  >____/\___  >___  /\___  >\/\_/  
     \/         \/              \/          \/    \/     \/        

EOF

echo "============================================="
echo "      『SISTEM MANAJEMEN KOST SLEBEW 』      "
echo "============================================="
echo " ID | OPTION "
echo "---------------------------------------------"
echo " 1 | Menambahkan penghuni baru ke daftar "
echo " 2 | Menghapus penghuni dari daftar "
echo " 3 | Menampilkan daftar penghuni "
echo " 4 | Update status penghuni " 
echo " 5 | Cetak laporan keuangan "
echo " 6 | Kelola Cron (pengingat tagihan) "
echo " 7 | Exit "
echo "============================================="
read -p "Silahkan pilih [1 - 7]:" opt

    if [[ $opt =~ $re ]] ; then
        if [ "$opt" == "7" ]; then
            exit 0
        elif [ "$opt" == "1" ]; then
            create
        elif [ "$opt" == "2" ]; then
            delete
        elif [ "$opt" == "3" ]; then
            list_huni
        elif [ "$opt" == "4" ]; then
            update_huni
        elif [ "$opt" == "5" ]; then
            laporan
        elif [ "$opt" == "6" ]; then
            pengingat
        else 
            echo "Harus memilih angka 1 - 7 yak!"
            sleep 1
            continue
        fi
    else 
    echo "Harus masukin angka :<"
    sleep 1
    continue
    fi
done
```

Terdapat pilihan menu untuk sebuah user yang bisa pilih dari no 1 sampai 7 dan memiliki handler masing-masing kecuali no 7 yaitu program yang keluar dari perulangan dan mematikan program

#### Output

1. Client connected ke server dan main menu

![alt text](assets/soal_3/client_connected.png)

2. Stats player

![alt text](assets/soal_3/stats.png)

3. Weapon list dan buy weapon

![alt text](assets/soal_3/weapon_list.png)

4. View inventory and equipped

![alt text](assets/soal_3/inventory_equipped.png)

5. Battle mode

![alt text](assets/soal_3/battle.png)

6. Attacking dan damage

![alt text](assets/soal_3/attack.png)

7. Critical attack

![alt text](assets/soal_3/critical.png)

8. Passive active

![alt text](assets/soal_3/passive.png)

9. Gold reward

![alt text](assets/soal_3/reward.png)

10. Stats setelah melakukan kill dan mendapatkan reward

![alt text](assets/soal_3/after_battle.png)

11. Error handling

![alt text](assets/soal_3/error_1.png)
![alt text](assets/soal_3/error_2.png)
![alt text](assets/soal_3/error_3.png)
![alt text](assets/soal_3/error_4.png)
![alt text](assets/soal_3/error_5.png)

#### Kendala

Tidak ada kendala

### Soal 4

**Dikerjakan oleh: Kanafira Vanesha Putri (5027241010)**

#### Penjelasan

Pada soal ini diminta untuk membantu Sung Jin Woo untuk melakukan modifikasi program.  
A) Membuat file system.c dan hunter.c dan memastikan bahwa hunter hanya bisa dijalankan apabila system sudah jalan. Sehingga code ini memastikan bahwa shared memory telah dibuat.

```c
    signal(SIGINT, sigint_handler);
    key_t key = get_system_key();
    shm_id = shmget(key, sizeof(struct SystemData), IPC_CREAT | 0666);
    system_data = shmat(shm_id, NULL, 0);
    if (system_data->num_hunters == 0 && system_data->num_dungeons == 0) {
        system_data->num_hunters = 0;
        system_data->num_dungeons = 0;
        system_data->current_notification_index = 0;
```

B) Membuat registrasi dan login menu serta hunter menu. Jadi kita membuat function untuk registrasi menu dengan ketentuan yang sudah ada di soal. lalu memasukkan menu tersebut ke main nya agar bisa dipanggil sesuai dengan kondisinya.

```c
void print_menu() {
    printf("\n" BOLD CYAN "=== '%s' MENU ===\n" RESET, username);
    printf(" " GREEN "1. Dungeon List\n");
    printf(" " GREEN "2. Dungeon Raid\n");
    printf(" " GREEN "3. Hunter Battle\n");
    printf(" " GREEN "4. Notification\n");
    printf(" " GREEN "5. Exit\n" RESET);
    printf(" Choice: ");
}

    int choice;
    while (1) {
        printf("\n=== HUNTER MENU ===\n");
        printf("1. Register\n");
        printf("2. Login\n");
        printf("3. Exit\n");
        printf("Choice: ");
        scanf("%d", &choice);
        clear_input_buffer();

        if (choice == 1) {
            printf("Masukkan username: ");
            scanf("%s", username);
            clear_input_buffer();

            int idx = -1;
            for (int i = 0; i < system_data->num_hunters; i++) {
                if (strcmp(system_data->hunters[i].username, username) == 0) {
                    idx = i;
                    break;
                }
            }

            if (idx == -1) {
                idx = system_data->num_hunters;
                strcpy(system_data->hunters[idx].username, username);
                system_data->hunters[idx].level = 1;
                system_data->hunters[idx].exp = 0;
                system_data->hunters[idx].atk = 10;
                system_data->hunters[idx].hp = 100;
                system_data->hunters[idx].def = 5;
                system_data->hunters[idx].banned = 0;

                key_t hunter_key = ftok("/tmp", 'A' + idx);
                system_data->hunters[idx].shm_key = hunter_key;
                system_data->num_hunters++;

                hunter_id = shmget(hunter_key, sizeof(struct Hunter), IPC_CREAT | 0666);
                if (hunter_id == -1) {
                    perror("shmget");
                    exit(EXIT_FAILURE);
                }
                this_hunter = shmat(hunter_id, NULL, 0);
                memcpy(this_hunter, &system_data->hunters[idx], sizeof(struct Hunter));
                printf("Registrasi sukses!\n");

                break;
            } else {
                printf("Username sudah terdaftar.\n");
            }
        } else if (choice == 2) {
            printf("Masukkan username: ");
            scanf("%s", username);
            clear_input_buffer();

            int idx = -1;
            for (int i = 0; i < system_data->num_hunters; i++) {
                if (strcmp(system_data->hunters[i].username, username) == 0) {
                    idx = i;
                    break;
                }
            }

            if (idx == -1) {
                printf("Username tidak ditemukan.\n");
            } else {
                if (system_data->hunters[idx].banned) {
                    printf("Akun Anda dibanned. Tidak bisa login.\n");
                    shmdt(system_data);
                    return 1;
                }
                hunter_id = shmget(system_data->hunters[idx].shm_key, sizeof(struct Hunter), 0666);
                this_hunter = shmat(hunter_id, NULL, 0);
                printf("Login sukses!\n");

                break;
            }
        } else if (choice == 3) {
            shmdt(system_data);
            printf("Exiting without deleting shared memory.\n");
            exit(0);
        } else {
            printf(BOLD RED"Invalid option.\n"RESET);
        }
    }
```

Setelah registrasi lalu terdapat menu hunter.

```c
  printf("\n=== HUNTER SYSTEM ===\n");

int choice;
    while (1) {
        printf("\n=== HUNTER MENU ===\n");
        printf("1. Register\n");
        printf("2. Login\n");
        printf("3. Exit\n");
        printf("Choice: ");
        scanf("%d", &choice);
        clear_input_buffer();
```

C) Membuat system menu yang lalu terdapat fitur untuk menampilkan informasi lengkap hunter. Sehingga pertama tama kita buat dulu function untuk menampilkan hunter yang ada.

```c
void tampilkan_semua_hunter() {
    printf("\n" BOLD CYAN "=== DAFTAR HUNTER ===\n" RESET);
    printf(BOLD MAGENTA "+--------------------+-----+-----+-----+-----+-----+-----------+\n");
    printf("│ Username           │ Lv  │EXP  │ATK  │HP   │DEF  │ Status    │\n");
    printf("+--------------------+-----+-----+-----+-----+-----+-----------+\n" RESET);

    for (int i = 0; i < system_data->num_hunters; i++) {
        struct Hunter h = system_data->hunters[i];
        printf("│ %-18s │ %3d │ %3d │ %3d │ %3d │ %3d │ %-9s │\n",
               h.username, h.level, h.exp, h.atk, h.hp, h.def,
               h.banned ? RED "Banned" RESET : GREEN "Active" RESET);
    }

    printf(BOLD MAGENTA "+--------------------+-----+-----+-----+-----+-----+-----------+\n" RESET);
}
```

Lalu kita panggil function diatas pada kondisi sesuai yang ada di menu yang tertera pada soal.

```c
    int cmd;
while (1) {
    printf("== SYSTEM MENU ==\n");
    printf("1. Hunter Info\n");
    printf("2. Dungeon Info\n");
    printf("3. Generate Dungeon\n");
    printf("4. Duel Hunter\n");
    printf("5. Ban H-unter\n");
    printf("6. Unban Hunter\n");
    printf("7. Reset Hunter\n");
    printf("8. Exit\n");
    printf("Choice: ");

    scanf("%d", &cmd);
    while (getchar() != '\n');
    if (cmd == 1) {
        tampilkan_semua_hunter();
    }
    else if (cmd == 2) {
        tampilkan_semua_dungeon();
    }
    else if (cmd == 3) {
        generate_dungeon();
    }
    else if (cmd == 4) {
        duel();
    }
    else if (cmd == 5) {
        ban_hunter();
    }
    else if (cmd == 6) {
        unban_hunter();
    }
    else if (cmd == 7) {
        reset_hunter();
    }
    else if (cmd == 8) {
        sigint_handler(0);
        break;
    }
    else {
        printf(BOLD RED"Invalid option. \n"RESET);
    }
}
```

D) Membuat funtion untuk fitur generate dungeon dengan ketentuan ketentuan yang telah diberikan pada soal yaitu level, exp, atk, hps, def, dan key lalu memasukkannya ke dalam main menu. dimana setiap dungeon akan disimpan dalam shared memory sendiri yang berbeda dan dapat diakses oleh hunter.

```c
void generate_dungeon() {
    if (system_data->num_dungeons >= MAX_DUNGEONS) {
        printf(RED "Jumlah dungeon maksimal tercapai!\n" RESET);
        return;
    }

    const char* dungeon_names[] = {
        "Double Dungeon", "Demon Castle", "Pyramid Dungeon", "Red Gate Dungeon",
        "Hunters Guild Dungeon", "Busan A-Rank Dungeon", "Insects Dungeon",
        "Goblins Dungeon", "D-Rank Dungeon", "Gwanak Mountain Dungeon",
        "Hapjeong Subway Station Dungeon"
    };

    const int min_levels[] = {1, 2, 3, 1, 2, 4, 1, 1, 2, 3, 4};
    const int exps[] = {150, 200, 250, 180, 220, 300, 160, 170, 190, 210, 250};
    const int atks[] = {130, 150, 140, 120, 130, 150, 140, 125, 130, 135, 145};
    const int hps[] = {60, 80, 70, 65, 75, 90, 70, 65, 70, 85, 80};
    const int defs[] = {30, 40, 35, 30, 35, 45, 40, 30, 35, 40, 45};

    int idx = system_data->num_dungeons;
    struct Dungeon *d = &system_data->dungeons[idx];

    strcpy(d->name, dungeon_names[idx]);
    d->min_level = min_levels[idx];
    d->exp = exps[idx];
    d->atk = atks[idx];
    d->hp = hps[idx];
    d->def = defs[idx];
    d->shm_key = ftok("/tmp", 'A' + idx);
    system_data->num_dungeons++;

    printf(GREEN "\n=== Dungeon berhasil dibuat! ===\n" RESET);
    printf(" " BOLD BLUE "Name           : " RESET "%s\n", d->name);
    printf(" " BOLD BLUE "Minimum Level  : " RESET "%d\n", d->min_level);
    printf(" " BOLD BLUE "EXP Reward     : " RESET "%d\n", d->exp);
    printf(" " BOLD BLUE "ATK            : " RESET "%d\n", d->atk);
    printf(" " BOLD BLUE "HP             : " RESET "%d\n", d->hp);
    printf(" " BOLD BLUE "DEF            : " RESET "%d\n", d->def);
    printf(" " BOLD BLUE "SharedMem Key  : " RESET "%d\n", d->shm_key);
}
```

E) Membuat function untuk fitur yang dapat menampilkan daftar lengkap dungeon. Function tampilkan_semua_dungeon berisi rincian spesifikasi dari dungeon yang telah digenerate tanpa memandang level. Lalu memanggil function ini pada main menu.

```c
void tampilkan_semua_dungeon() {
    printf("\n" BOLD CYAN "╔════════════════════════════════════════════╗\n" RESET);
    printf(        BOLD CYAN "║             DAFTAR DUNGEON                 ║\n" RESET);
    printf(        BOLD CYAN "╚════════════════════════════════════════════╝\n" RESET);

    for (int i = 0; i < system_data->num_dungeons; i++) {
        struct Dungeon d = system_data->dungeons[i];
        printf(BOLD MAGENTA "\n[Dungeon %d]\n" RESET, i + 1);
        printf(" " BOLD "• Nama Dungeon    : " RESET "%s\n", d.name);
        printf(" " BOLD "• Minimum Level   : " RESET "%d\n", d.min_level);
        printf(" " BOLD "• EXP             : " RESET "%d\n", d.exp);
        printf(" " BOLD "• ATK             : " RESET "%d\n", d.atk);
        printf(" " BOLD "• HP              : " RESET "%d\n", d.hp);
        printf(" " BOLD "• DEF             : " RESET "%d\n", d.def);
        printf(" " BOLD "• SharedMem Key   : " RESET "%d\n", d.shm_key);
    }
}
```

F) Menambahkan fitur menampilkan dungeon sesuai level hunter pada menu hunter. Pada function ini dungeon ditampilkan berdasarkan level dari hunternya sehingga berbeda dengan yang ada pada menu system.

```c
void dungeon_list() {
    printf("=== AVAILABLE DUNGEONS ===\n");

    int count = 0;

    for (int i = 0; i < system_data->num_dungeons; i++) {
        if (this_hunter->level >= system_data->dungeons[i].min_level) {
            printf("%d. %s (Level %d+)\n",
                   i + 1,
                   system_data->dungeons[i].name,
                   system_data->dungeons[i].min_level);
            count++;
        }
    }

    if (count == 0) {
        printf("No dungeons available for your level.\n");
    }
}
```

G) Menambahkan function untuk fitur dungeon raid. Yaitu dengan mengecek terlebih dahulu apakah ada dungeon yang tersedia lalu memastikan indexnya dan jika hunter menang maka dungeon akan hilang dan menambahkan stat dari dungeon yang dikalahkan ke stat hunter lalu jika exp hunter mencapai 500 maka hunter akan naik level dan jika level up maka exp level kembali ke 0

```c
void dungeon_raid() {
    dungeon_list();
    printf("Choose Dungeon: ");
    int choice;
    scanf("%d", &choice);
    clear_input_buffer();
    choice -= 1;

    if (choice >= 0 && choice < system_data->num_dungeons &&
        this_hunter->level >= system_data->dungeons[choice].min_level) {

        struct Dungeon d = system_data->dungeons[choice];
        this_hunter->atk += d.atk;
        this_hunter->hp += d.hp;
        this_hunter->def += d.def;
        this_hunter->exp += d.exp;

        if (this_hunter->exp >= 500) {
            this_hunter->level++;
            this_hunter->exp = 0;
        }

        for (int i = choice; i < system_data->num_dungeons - 1; i++) {
            system_data->dungeons[i] = system_data->dungeons[i + 1];
        }
        system_data->num_dungeons--;

        if (system_data->num_dungeons > 0) {
            system_data->current_notification_index %= system_data->num_dungeons;
        } else {
            system_data->current_notification_index = 0;
        }

        for (int i = 0; i < system_data->num_hunters; i++) {
            if (strcmp(system_data->hunters[i].username, this_hunter->username) == 0) {
                memcpy(&system_data->hunters[i], this_hunter, sizeof(struct Hunter));
                break;
            }
        }

        shmctl(shmget(d.shm_key, sizeof(struct Dungeon), 0666), IPC_RMID, NULL);

        printf("\nRaid Success! Gained:\n");
        printf("ATK: +%d\n", d.atk);
        printf("HP: +%d\n", d.hp);
        printf("DEF: +%d\n", d.def);
        printf("EXP: +%d\n", d.exp);
    } else {
        printf("Invalid choice or level too low.\n");
    }
}
```

H) Menambahkan function untuk fitur hunter battle. Pada menu ini hunter dapat memilih hunter lain yang ingin dilawan lalu terdapat kondisi dimana hunter yang menang akan mendapatkan stat tambahan dari stat hunter yang kalah dan akan dihapus dari system.

```c
void duel() {
    char user1[50], user2[50];
    printf("\n" BOLD YELLOW "Masukkan username hunter 1: " RESET);
    scanf("%s", user1);
    printf(BOLD YELLOW "Masukkan username hunter 2: " RESET);
    scanf("%s", user2);

    int idx1 = -1, idx2 = -1;
    for (int i = 0; i < system_data->num_hunters; i++) {
        if (strcmp(system_data->hunters[i].username, user1) == 0) idx1 = i;
        if (strcmp(system_data->hunters[i].username, user2) == 0) idx2 = i;
    }

    if (idx1 == -1 || idx2 == -1) {
        printf(RED "Salah satu atau kedua hunter tidak ditemukan.\n" RESET);
        return;
    }

    struct Hunter *h1 = &system_data->hunters[idx1];
    struct Hunter *h2 = &system_data->hunters[idx2];

    int total1 = h1->atk + h1->hp + h1->def;
    int total2 = h2->atk + h2->hp + h2->def;

    if (total1 == total2) {
        printf(YELLOW "Pertarungan imbang. Tidak ada perubahan.\n" RESET);
        return;
    }

    struct Hunter *winner = (total1 > total2) ? h1 : h2;
    struct Hunter *loser = (total1 > total2) ? h2 : h1;

    key_t loser_key = loser->shm_key;

    winner->atk += loser->atk;
    winner->hp += loser->hp;
    winner->def += loser->def;

    int winner_shmid = shmget(winner->shm_key, sizeof(struct Hunter), 0666);
    struct Hunter *winner_shm = shmat(winner_shmid, NULL, 0);
    if (winner_shm != (void *)-1) {
        winner_shm->atk = winner->atk;
        winner_shm->hp = winner->hp;
        winner_shm->def = winner->def;
        shmdt(winner_shm);
    }

    for (int i = 0; i < system_data->num_hunters; i++) {
        if (strcmp(system_data->hunters[i].username, loser->username) == 0) {
            for (int j = i; j < system_data->num_hunters - 1; j++) {
                system_data->hunters[j] = system_data->hunters[j + 1];
            }
            system_data->num_hunters--;
            break;
        }
    }

    printf(GREEN "\n%s menang duel melawan %s!\n" RESET, winner->username, loser->username);
}
```

I) Menambahkan function untuk fitur ban hunter. Lalu function ini akan dipanggil pada main menu system

```c
void ban_hunter() {
    char user[50];
    printf("Masukkan username yang ingin diban: ");
    scanf("%s", user);
    for (int i = 0; i < system_data->num_hunters; i++) {
        if (strcmp(system_data->hunters[i].username, user) == 0) {
            system_data->hunters[i].banned = 1;

            int shmid = shmget(system_data->hunters[i].shm_key, sizeof(struct Hunter), 0666);
            struct Hunter *shm_hunter = shmat(shmid, NULL, 0);
            if (shm_hunter != (void *)-1) {
                shm_hunter->banned = 1;
                shmdt(shm_hunter);
            }

            printf("%s telah diban.\n", user);
            return;
        }
    }
    printf("Hunter tidak ditemukan.\n");
}
```

J) Menambahkan function untuk fitur unban hunter lalu dapat mereset hunter. Sehingga function ini mengaktifkan kembali hunter yang sebelumnya dilarang (banned), dengan cara mengatur flag banned = 0 pada data hunter di shared memory.

```c
void unban_hunter() {
    char user[50];
    printf("Masukkan username yang ingin di-unban: ");
    scanf("%s", user);
    for (int i = 0; i < system_data->num_hunters; i++) {
        if (strcmp(system_data->hunters[i].username, user) == 0) {
            system_data->hunters[i].banned = 0;
            printf("%s telah di-unban.\n", user);
            return;
        }
    }
    printf("Hunter tidak ditemukan.\n");
}

void reset_hunter() {
    char user[50];
    printf("Masukkan username yang ingin direset: ");
    scanf("%s", user);
    for (int i = 0; i < system_data->num_hunters; i++) {
        if (strcmp(system_data->hunters[i].username, user) == 0) {
            system_data->hunters[i].level = 1;
            system_data->hunters[i].exp = 0;
            system_data->hunters[i].atk = 10;
            system_data->hunters[i].hp = 100;
            system_data->hunters[i].def = 5;

            // Update shared memory
            int shmid = shmget(system_data->hunters[i].shm_key, sizeof(struct Hunter), 0666);
            struct Hunter *shm_hunter = shmat(shmid, NULL, 0);
            if (shm_hunter != (void *)-1) {
                shm_hunter->level = 1;
                shm_hunter->exp = 0;
                shm_hunter->atk = 10;
                shm_hunter->hp = 100;
                shm_hunter->def = 5;
                shmdt(shm_hunter);
            }

            printf("%s telah direset.\n", user);
            return;
        }
    }
    printf("Hunter tidak ditemukan.\n");
}
```

K) Menambahkan function untuk fitur notifikasi yang berganti tiap 3 detik. Menampilkan real-time notifikasi dungeon kepada hunter seperti layaknya sistem game, dengan siklus dinamis dan penghentian yang intuitif.

```c
void show_single_notification(int index) {
    if (index >= system_data->num_dungeons || index < 0) return;

    struct Dungeon d = system_data->dungeons[index];
    printf("\n[NOTIF] Dungeon tersedia: %s (Level %d+)\n", d.name, d.min_level);
}

void run_notification_loop() {
    int index = 0;
    int stop = 0;

    printf("Menampilkan notifikasi dungeon...\n");

    while (!stop) {
        if (system_data->num_dungeons == 0) {
            printf("[NOTIF] Tidak ada dungeon tersedia.\n");
            sleep(3);
            continue;
        }

        show_single_notification(index);
        index = (index + 1) % system_data->num_dungeons;

        for (int i = 0; i < 3; i++) {
            sleep(1);
            if (is_enter_pressed()) {
                printf("Keluar dari notifikasi.\n");
                stop = 1;
                break;
            }
        }
    }
}
```

L) Menghapus shared memory setiap kali sistem dimatikan.

```c
void sigint_handler(int sig) {
    printf("\nSystem shutting down...\n");

<<<<<<< HEAD
    for (int i = 0; i < system_data->num_hunters; i++) {
        int shmid = shmget(system_data->hunters[i].shm_key, sizeof(struct Hunter), 0666);
        if (shmid != -1) shmctl(shmid, IPC_RMID, NULL);
    }
    for (int i = 0; i < system_data->num_dungeons; i++) {
        int shmid = shmget(system_data->dungeons[i].shm_key, sizeof(struct Dungeon), 0666);
        if (shmid != -1) shmctl(shmid, IPC_RMID, NULL);
    }

    shmdt(system_data);
    shmctl(shm_id, IPC_RMID, NULL);
    printf("Semua shared memory telah dihapus.\n");
    exit(0);
}
```

#### Output

Pada soal ini diminta untuk membantu Sung Jin Woo untuk melakukan modifikasi program.  
A) Membuat file system.c dan hunter.c dan memastikan bahwa hunter hanya bisa dijalankan apabila system sudah jalan.  
 ![](assets/soal_4/soal_4_a1.png)
![](assets/soal_4/soal_4_a2.png)

B) Membuat registrasi dan login menu serta hunter menu.
![](assets/soal_4/soal_4_b.png)

C) Membuat system menu yang lalu terdapat fitur untuk menampilkan informasi lengkap hunter.  
 ![](assets/soal_4/soal_4_c.png)

D) Membuat fitur generate dungeon.  
 ![](assets/soal_4/soal_4_d.png)

E) Menambahkan fitur yang dapat menampilkan daftar lengkap dungeon.  
 ![](assets/soal_4/soal_4_e.png)

F) Menambahkan fitur menampilkan dungeon sesuai level hunter pada menu hunter.  
 ![](assets/soal_4/soal_4_f.png)

G) Menambahkan fitur dungeon raid.  
 ![](assets/soal_4/soal_4_g.png)

H) Menambahkan fitur hunter battle.  
 ![](assets/soal_4/soal_4_h.png)

I) Menambahkan fitur ban hunter.  
 ![](assets/soal_4/soal_4_i.png)

J) Menambahkan fitur unban hunter.  
 ![](assets/soal_4/soal_4_j.png)

K) Menambahkan fitur notifikasi yang berganti tiap 3 detik.  
 ![](assets/soal_4/soal_4_k.png)

L) Menghapus shared memory setiap kali sistem dimatikan.
![](assets/soal_4/soal_4_l.png)

#### Kendala

Tidak ada kendala