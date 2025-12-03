# Godot Piscine - Sokak Hokeyi Oyunu

Bu proje, Godot Piscine eğitim serisi için geliştirilmiş 2 oyunculu bir hava hokeyi oyunudur. İki oyuncu, taksilerle puck'ı (diski) iterek gol atmaya çalışır.

## 🎮 Kontroller

- **Oyuncu 1 (Sol taraf):** Taksiyi hareket ettirmek için `WASD` tuşlarını kullanın.
- **Oyuncu 2 (Sağ taraf):** Taksiyi hareket ettirmek için `Ok Tuşlarını` kullanın.
- **Duraklat/Devam:** Oyunu durdurmak için `ESC` tuşuna basın.
- **Yeniden Başlat:** Oyunu yeniden başlatmak için `R` tuşuna basın.
- **Çıkış (duraklatma ekranından):** Çıkmak için `E` tuşuna basın.

## 🏒 Oyun Kuralları

- **Amaç:** Kazanmak için 3 gol atın!
- **Puanlama:** Puck'ı rakibinizin kalesine sokun (sol kale = Oyuncu 2 skor, sağ kale = Oyuncu 1 skor).
- **Hareket:** Oyuncular kendi yarı sahalarında kalmalıdır.

## ✨ Özellikler ve Bonuslar (Hafta 0)

### Zorunlu (Mandatory)
- [x] Taksi şeklinde karakter oluşturuldu.
- [x] 4 yönlü hareket eklendi.
- [x] Hareket yönüne göre değişen Sprite (Yukarı, Aşağı, Sol, Sağ).

### Bonus Özellikler
- [x] **Fizik Tabanlı Hareket:** Anlık hareket yerine ivmelenme (hızlanma) ve yavaşlama eğrileri kullanıldı, bu da araca "drift" hissi veriyor.
- [x] **Modifiye Edilmiş Sprite:** "Sayan" karakter sprite'ına kırmızı görsel öğeler eklenerek özelleştirildi.
- [x] **Parçacık Efektleri (Particles):** Araç hareket ederken arkasından çıkan egzoz dumanı (`GPUParticles2D`) eklendi.
- [x] **Dinamik Animasyon:** Taksi hareket halindeyken oynayan ve durduğunda duran çok kareli (multi-frame) animasyonlar eklendi.
- [x] **Daha Yumuşak Çarpışmalar:** Puck gibi yuvarlak nesnelerle daha iyi etkileşim için dikdörtgen yerine "Kapsül" (Capsule) çarpışma şekli kullanıldı.

# Godot Piscine - Hafta 1: Şehir ve Engeller

Bu hafta, bir şehir ortamı inşa ederek ve etkileşimli engeller ekleyerek simülasyonu genişlettik.

## 🏙️ Özellikler (Hafta 1)

### Zorunlu (Mandatory)
- [x] **TileMap Şehir:** `StreetTileset` kullanılarak yollar inşa edildi.
- [x] **Evler (Duvarlar):** Taksinin geçemeyeceği `StaticBody2D` tabanlı ev engelleri eklendi.
- [x] **Trafik Konileri:** Çarpıldığında taksiyi yavaşlatan koniler eklendi (hızı %25'e düşürür).

### Bonus Özellikler
- [x] **Yağ Lekeleri (Oil Spills):** Kaygan yağ bölgeleri eklendi. Taksi bu alanlardan geçerken yol tutuşu (traction) düşer ve kontrol zorlaşır (kayma efekti).
- [x] **Hızlandırıcılar (Boost Pads):** Taksiyi geçici olarak 3 kat hızlandıran "Nitro" bölgeleri eklendi (3x çarpan).
- [x] **Modüler Engel Sistemi:** Farklı engellerin taksinin özelliklerini (Hız, Yol Tutuşu) değiştirebilmesi için ortak bir kod yapısı kuruldu.
- [x] **2 Oyunculu Rekabet Modu:** Gol algılama, kazanma koşulları ve oyun durumu yönetimine sahip tam bir puanlama sistemi.

## 🛠️ Teknik Detaylar

- **Motor:** Godot 4.x
- **Dil:** GDScript
- **Fizik:** Puck için RigidBody2D etkileşimleri.
- **Ekran:** Her monitörde düzgün görünmesi için **Tam Ekran (Exclusive Fullscreen)** modu ve `canvas_items` ölçekleme ayarı yapıldı.

## 🔄 Son Güncellemeler

- **Engel Etki Süreleri:**
  - Etkiler artık alandan çıktıktan sonra da belirli bir süre devam ediyor.
  - **Boost & Koni:** Etki süresi **3 saniye** (5 saniyeden düşürüldü).
  - **Yağ (Oil):** Etki süresi **1 saniye**.
- **Oynanış Dengesi:**
  - **Yağ Lekeleri:** Yol tutuşu **%10**'a düşürüldü (%50 idi), aracı kontrol etmek artık çok daha zor.
  - **Taksi Değerleri:** Daha seri hareket için **Maksimum Hız 1000.0** ve **İvmelenme 1500.0** olarak ayarlandı.
- **Geliştirilmiş Çarpışma Fiziği:**
  - Taksinin hızı, ekran kenarlarına veya evlere çarptığında anında sıfırlanıyor. Bu, çarpışmadan sonra aracın sıfırdan ivmelenerek kalkmasını sağlayarak daha doğal bir "dur-kalk" hissi veriyor.
- **Disk (Puck) Fiziği:**
  - Diskin daha rahat kayması ve gerçek bir hava hokeyi diski gibi hissettirmesi için `linear_damp` (sürtünme) değeri 0.5'ten 0.1'e düşürüldü.

## 🚀 Nasıl Çalıştırılır

1. Godot Engine'i açın.
2. Bu klasörü (`Week1`) import edin.
3. Projeyi çalıştırın (F5) veya `scenes/main.tscn` sahnesini açın.
