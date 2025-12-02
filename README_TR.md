# Godot Piscine - Hafta 0: Taksi Şoförü

Bu proje, Godot Piscine sürecinin ilk ödevidir. Amaç, spesifik hareket mekaniklerine ve etkileşimlere sahip bir 2D karakter kontrolcüsü oluşturmaktır.

## 🎮 Kontroller

- **Hareket:** Taksi hareket ettirmek için `WASD` veya `Ok Tuşlarını` kullanın.
- **Etkileşim:** "Puck" (Top) ile çarpışarak onu itin!

## ✨ Özellikler ve Bonuslar (Hafta 0)

### Zorunlu (Mandatory)
- [x] Taksi şeklinde karakter oluşturuldu.
- [x] 4 yönlü hareket eklendi.
- [x] Hareket yönüne göre değişen Sprite (Yukarı, Aşağı, Sol, Sağ).

### Bonus Özellikler
- [x] **Fizik Tabanlı Hareket:** Anlık hareket yerine ivmelenme (hızlanma) ve yavaşlama eğrileri kullanıldı, bu da araca "drift" hissi veriyor.
- [x] **Özel Sprite:** Varsayılan görseller yerine özel bir karakter ("Sayan") kullanıldı.
- [x] **Parçacık Efektleri (Particles):** Araç hareket ederken arkasından çıkan egzoz dumanı (`GPUParticles2D`) eklendi.
- [x] **Dinamik Animasyon:** Taksi hareket halindeyken oynayan ve durduğunda duran çok kareli (multi-frame) animasyonlar eklendi.
- [x] **Daha Yumuşak Çarpışmalar:** Puck gibi yuvarlak nesnelerle daha iyi etkileşim için dikdörtgen yerine "Kapsül" (Capsule) çarpışma şekli kullanıldı.

# Godot Piscine - Hafta 1: Şehir ve Engeller

Bu hafta, bir şehir ortamı inşa ederek ve etkileşimli engeller ekleyerek simülasyonu genişlettik.

## 🏙️ Özellikler (Hafta 1)

### Zorunlu (Mandatory)
- [x] **TileMap Şehir:** `StreetTileset` kullanılarak yollar inşa edildi.
- [x] **Evler (Duvarlar):** Taksinin geçemeyeceği `StaticBody2D` tabanlı ev engelleri eklendi.
- [x] **Trafik Konileri:** Çarpıldığında taksiyi %50 yavaşlatan koniler eklendi.

### Bonus Özellikler
- [x] **Yağ Lekeleri (Oil Spills):** Kaygan yağ bölgeleri eklendi. Taksi bu alanlardan geçerken yol tutuşu (traction) düşer ve kontrol zorlaşır (kayma efekti).
- [x] **Hızlandırıcılar (Boost Pads):** Taksiyi geçici olarak 2 kat hızlandıran "Nitro" bölgeleri eklendi.
- [x] **Kaotik Puck:** Puck (Top) da hızlandırıcılardan etkileniyor! Bir boost pad'e çarptığında füze gibi fırlayarak oyuna kaos ve eğlence katıyor.
- [x] **Modüler Engel Sistemi:** Farklı engellerin taksinin özelliklerini (Hız, Yol Tutuşu) değiştirebilmesi için ortak bir kod yapısı kuruldu.

## 🛠️ Teknik Detaylar

- **Motor:** Godot 4.x
- **Dil:** GDScript
- **Fizik:** Puck için RigidBody2D etkileşimleri.
- **Ekran:** Her monitörde düzgün görünmesi için **Tam Ekran (Exclusive Fullscreen)** modu ve `canvas_items` ölçekleme ayarı yapıldı.

## 🚀 Nasıl Çalıştırılır

1. Godot Engine'i açın.
2. Bu klasörü (`Week1`) import edin.
3. Projeyi çalıştırın (F5) veya `scenes/main.tscn` sahnesini açın.
