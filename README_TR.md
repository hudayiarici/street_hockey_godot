# Godot Piscine - Sokak Hokeyi Oyunu

Bu proje, Godot Piscine eğitim serisi için geliştirilmiş 2 oyunculu bir hava hokeyi oyunudur. İki oyuncu, taksilerle puck'ı (diski) iterek gol atmaya çalışır.

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
- **Çözünürlük:** **1280x720** (720p HD, 16:9 en-boy oranı) - Optimal uyumluluk için standart çözünürlük.
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

# Godot Piscine - Hafta 2: HUD ve Oyun Akışı

Hafta 2'de yakıt yönetimi, mesafe takibi ve düzgün oyun akış ekranları ile cilalı bir kullanıcı arayüzü eklendi.

## 🎯 Özellikler (Hafta 2)

### Zorunlu (Mandatory)
- [x] **Başlangıç Ekranı:** Oyun bir karşılama ekranı ile başlıyor. Başlamak için `SPACE`, çıkmak için `E` tuşuna basın.
- [x] **Yakıt Sayacı:** Week 2 asset'lerinden alınan animasyonlu sprite'lar ile görsel yakıt göstergesi. **Her oyuncunun kendi yakıt sistemi var.**
- [x] **Yakıt Tüketimi:** Taksiler hareket ettikçe yakıt azalıyor (5 yakıt/saniye). **Oyuncu 1 ve Oyuncu 2 için ayrı takip.**
- [x] **Oyun Sonu Ekranı:** Bir oyuncunun yakıtı bittiğinde ekrana gelir ve her iki oyuncunun mesafesini gösterir.

### Bonus Özellikler
- [x] **Duraklama Menüsü:** İstediğiniz zaman `ESC` tuşuna basarak oyunu durdurun. Devam için `SPACE`, yeniden başlat için `R`, çıkış için `E`.
- [x] **Düzgün Pause Sistemi:** Oyun duraklatıldığında tamamen donar (`process_mode` sistemi kullanılarak).
- [x] **Mesafe Sayacı:** Her iki oyuncunun da gittiği toplam mesafeyi ayrı ayrı gerçek zamanlı olarak takip eder.
- [x] **İkili HUD Sistemi:** Her oyuncunun kendi HUD'u var (Oyuncu 1: sol üst, Oyuncu 2: sağ üst).
- [x] **Yakıt Doldurma Mekaniği:** Puck'a çarptığınızda yakıtınız %10 artıyor (maksimum %100'e kadar)!
- [x] **Animasyonlu Yakıt Göstergesi:** 3 aşamalı görsel geri bildirim ve animasyonlu ibre kullanır:
  - **%100-%67**: Yeşil gösterge (`Tachimetrofull6`)
  - **%66-%34**: Turuncu gösterge (`Tachimetrofull4`)
  - **%33-%0**: Kırmızı gösterge (`Tachimetrofull1`)
  - İbre (`lancetta`) yakıt seviyesine göre saat yönünün tersine 0° (%100 yakıt) ile -270° (%0 yakıt) arasında döner
  - Sadece `Tachimetrofull` sprite'ları kullanılıyor (ibre çizilmemiş), ibre ayrı animasyonlu sprite

# Godot Piscine - Hafta 3: Son Rötuşlar ve Final Özellikler

Hafta 3'te gelişmiş görsel geri bildirim, yakıt istasyonları ve oyun deneyimini tamamlayan kalite iyileştirmeleri eklendi.

## 🎯 Özellikler (Hafta 3)

### Rötuş ve İyileştirme Özellikleri
- [x] **Standart Çözünürlük:** Tüm ekranlarda optimal uyumluluk için **1280x720** (720p HD, 16:9) çözünürlüğe yükseltildi.
- [x] **Yakıt İstasyonları:** Harita köşelerinde stratejik yakıt doldurma bölgeleri (saniyede %5):
  - **Oyuncu 1 İstasyonu:** Haritanın sol üst köşesi
  - **Oyuncu 2 İstasyonu:** Haritanın sağ üst köşesi
- [x] **Gerçek Zamanlı Bildirimler:** Anında görsel geri bildirim için renkli HUD bildirimleri:
  - 🟢 **"SPEED BOOST!"** (Yeşil) - Hız artışı aktif
  - 🟠 **"SLOWED DOWN!"** (Turuncu) - Koniye çarpıldı
  - 🔴 **"OIL! LOW TRACTION!"** (Kırmızı) - Yağ lekesine girildi
  - 🟡 **"FUEL +10%"** (Sarı) - Puck'a çarpıldı
- [x] **Gol Sonrası Reset Sistemi:** Sorunsuz oyun akışı için her gol sonrası oyuncular otomatik olarak başlangıç pozisyonlarına döner.
- [x] **Oyuncuya Özel Bildirimler:** Her oyuncu kendi tarafında bildirimleri görür (Oyuncu 1: sol-orta, Oyuncu 2: sağ-orta).

## 🎮 Güncellenmiş Kontroller

- **SPACE** - Oyunu başlat (başlangıç ekranından)
- **Oyuncu 1 (Sol taraf):** Taksiyi hareket ettirmek için `WASD` tuşlarını kullanın.
- **Oyuncu 2 (Sağ taraf):** Taksiyi hareket ettirmek için `Ok Tuşlarını` kullanın.
- **ESC** - Oyunu duraklat/devam ettir
- **R** - Oyunu yeniden başlat (duraklama veya oyun sonu ekranından)
- **E** - Oyundan çık (duraklama veya oyun sonu ekranından)

## 🔄 Oyun Akışı

1. **Başlangıç Ekranı** → SPACE'e basın
2. **Oynanış** → Taksileri hareket ettirin, yakıt tüketin, mesafe kaydedin
3. **Duraklama Menüsü** → İstediğiniz zaman ESC'ye basın
4. **Oyun Sonu** → Yakıt 0'a ulaştığında veya 3 gol atıldığında

## 🎮 Oyun Durumu

**Durum:** ✅ **TAMAMLANDI** - Tüm temel özellikler ve rötuşlar uygulandı!

Oyun artık tamamen oynanabilir durumda:
- Eksiksiz 2 oyunculu rekabet modu
- Yakıt yönetimi ile tam HUD sistemi
- Etkileşimli engeller ve güçlendirmeler
- Görsel geri bildirim ve bildirimler
- Stratejik oynanış için yakıt istasyonları
- Baştan sona cilalı oyun akışı

## 🚀 Nasıl Çalıştırılır

1. Godot Engine'i açın.
2. Bu klasörü import edin.
3. Projeyi çalıştırın (F5) veya `scenes/main.tscn` sahnesini açın.
