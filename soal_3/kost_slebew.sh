#!/bin/bash

# some update on this kost_slebew.sh: (there are many # on this section, so yeah. that is updating some content and point it if it is new update tho)
re='^[0-9]+$'

cd "$(dirname "$0")" 
mkdir -p data log rekap sampah 
if [ ! -f data/penghuni.csv ]; then
    echo "Nama,Kamar,Harga,Tanggal,Status" > data/penghuni.csv
fi

# adding function tagihan for './kost_slebew.sh --check-tagihan' and using tee to look and override
tagihan() {

    if [ -f "data/penghuni.csv" ]; then
        waktu=$(date +"%Y-%m-%d %H:%M:%S")
        echo "[$waktu] Mengecek tagihan..." | tee -a log/tagihan.log
        
        awk -F',' '
        NR > 1 && $5 == "menunggak" { 
            print " -> Si " $1 " di kamar " $2 " belum bayar Rp" $3 
        }' data/penghuni.csv | tee -a log/tagihan.log
    fi
}

# Here are the command if './kost_slebew.sh --check-tagihan'
if [ "$1" == "--check-tagihan" ] ; then
    tagihan
    exit 0;
fi  

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
        continue
    fi

    read -p "Harga sewa: " price
    if [[ "$price" -le 0 ]]; then
        echo "angka tidak boleh minus maupun 0"
        continue
    fi

    # adding some sanitize on date section
    read -p "Tanggal masuk (YYYY-MM-DD): " date
    if [[ ! "$date" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "Salah format brok. harusnya 2026-12-31!"
        continue
    fi

    if ! date -d "$date" >/dev/null 2>&1; then
            echo "Tanggal tidak masuk akal,coba bikin yg bener!"
            continue
        fi
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

# update delete section, remove 'cp' change to
delete() {

    echo "==================================================== "
    echo "           『Delete Huni Kost Slebew 』              "
    echo "==================================================== "

    read -p "Masukkan nama penghuni yang ingin dihapus: " nama

    # this one
    if grep -q "^$nama," data/penghuni.csv 2>/dev/null; then
        data_orang=$(grep "^$nama," data/penghuni.csv)
        tgl_hapus=$(date +"%Y-%m-%d")
        echo "$data_orang,$tgl_hapus" >> sampah/history_hapus.csv
        sed -i "/^$nama,/d" data/penghuni.csv
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

        while true; do
            read -p "Tekan enter untuk kembali... " dummy

            if [ "$dummy" != "" ]; then
                echo "Harus enter"
            else
                break
            fi
        done
}

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
    while true; do
        if [ "$dummy" != "" ]; then
            echo "Nope, harus enter"
        else
            break   
        fi
    done
}

#adjust some cron in here
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
            # adding some loop in here
            while true; do
                echo "Format: menit jam tgl bulan hari_minggu"
                read -p "Input jadwal (contoh: 00 23 * * *): " jadwal
                read -p "Perintah/Script yg dijalankan (path lengkap): " cmd
                read -p "Perintahnya yang diinginkan: " command
                
                #adding command "--check-tagihan" to crontab
                if (crontab -l 2>/dev/null; echo "$jadwal $cmd $command") | crontab - 2>/dev/null; then
                    echo "Jadwal berhasil diaktifkan!"
                    echo "[$(date)] Berhasil input: $jadwal $cmd $command" >> log/tagihan.log
                    break
                else
                    echo "Gagal mengaktifkan jadwal! Pastikan format waktunya benar."
                fi
            done

        elif [ "$pilih" == "3" ]; then

            crontab -r
            echo "Semua jadwal cron telah dihapus!"
            echo "[$(date)] Menghapus semua cron" >> log/tagihan.log

        elif [ "$pilih" == "4" ]; then
            break 
        else
            echo "pilihan salah. coba lagi"
        fi

        while true; do
            read -p "Enter untuk kembali..." dummy
                if [ "$dummy" != "" ]; then
                    echo "Nope, harus enter"
                else
                    break   
                fi
        done
    done
}

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
read -p "Silahkan pilih [1 - 7]: " opt

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