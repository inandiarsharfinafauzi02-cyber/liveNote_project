# LIVE NOTE PROJECT
- NAMA  : Inandiar sharfi fauzi
- NIM   : 362458302078
- Kelas : 2B

 1.  Update Feature: Tambahkan fitur edit. Ketika ListTile ditekan (onTap), munculkan
 formulir yang sudah terisi data lama, dan update data tersebut di Firebase menggunakan
 perintah .update().

 DOKUMENTASI
 - <img width="447" height="67" alt="image" src="https://github.com/user-attachments/assets/31a1bb05-abcd-4319-af96-6fa528306ef3" />
 penjelasan:
properti onTap yang berfungsi sebagai pemicu sentuhan. Ketika widget disentuh, ia memanggil fungsi _showForm sambil membawa data lama (document). Intinya adalah untuk menampilkan formulir pengeditan yang sudah terisi dengan data yang ada, sehingga pengguna dapat memperbaruinya.

- <img width="533" height="133" alt="image" src="https://github.com/user-attachments/assets/b162a9ee-0a35-4be4-bf48-34447ef5561b" />
penjelasan:
Kode ini berfungsi untuk memperbarui dokumen spesifik di Firebase Firestore. Dengan query yang ada pada gambar, ia mengambil catatan berdasarkan ID (doc.id) dan mengganti nilai title dan content lama dengan yang baru. Yang penting, ia juga mencatat waktu pembaruan yang akurat menggunakan FieldValue.serverTimestamp() dari sisi server Firebase.

- keseluruhan Source code
  <img width="1618" height="6860" alt="image" src="https://github.com/user-attachments/assets/a7f435b9-4860-42cf-b4b0-2898ba35f593" />


 2.  Testing: Jalankan aplikasi di 2 device berbeda (Emulator HP Fisik atau 2 Emulator).
 Buktikan bahwa data tersinkronisasi secara otomatis.
## Hasil
- Tampilan awal
- 
  ![WhatsApp Image 2025-11-24 at 17 07 01_c6ee7e67](https://github.com/user-attachments/assets/59d91586-e83a-49dc-915e-8de07f85c03a)

- Membuat judul dan catatan baru
- 
![WhatsApp Image 2025-11-24 at 16 39 23_f69a8041](https://github.com/user-attachments/assets/c2e0fdb8-7667-4e1e-aeed-a3c9946be9bb)

- Hasil membuat judul dan catatan
- 
![WhatsApp Image 2025-11-24 at 16 39 23_c5aa2237](https://github.com/user-attachments/assets/1b8740da-f08f-4a6e-a320-34f26f507f3b)

-  Mengedit judul dan catatan
-  
![WhatsApp Image 2025-11-24 at 16 39 22_f847a31b](https://github.com/user-attachments/assets/753f6d6b-e384-411a-8a44-be96742b4a6a)

- hasil Mengedit judul dan catatan
- 
![WhatsApp Image 2025-11-24 at 17 29 48_ca738703](https://github.com/user-attachments/assets/f7484df9-dd92-49ff-806a-18359a7b108d)


- Hasil pada FIREBASE sebelum di ubah
- 
![WhatsApp Image 2025-11-24 at 16 32 50_59a6ab27](https://github.com/user-attachments/assets/3de1be72-c8a4-4406-8bae-0be12732067f)

- Hasil pada FIREBASE setelah diubah
- 
  <img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/a77b904e-547b-4817-a329-504b8b9eae2a" />
  
  penjelasan :
  perbedaan yang dari hasil firebase untuk sebelumnnya tidak ada angka untuk urutan sedangkan sesudahnya terdapat angka untuk urutan




