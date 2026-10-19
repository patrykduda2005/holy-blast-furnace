# Konstytucja projektu: Holy Blast Furnaces!

## Podstawowe zasady

### I. Wizja i zakres prototypu
Holy Blast Furnaces! jest grą typu Tower Defense o wytwarzaniu stopów metali żelaznych. Projekt powstaje w silniku Godot Engine 4.7.2, a SQLite jest docelową bazą danych. Tworzony prototyp ma charakter prototypu z porzuceniem (Throwaway Prototype): jego celem jest przygotowanie prostych makiet prezentujących interfejs i ekrany gry, bez implementowania zaawansowanej logiki w silniku.

### II. Historie użytkownika i kryteria akceptacji
Wymagania funkcjonalne prototypu są opisywane za pomocą historii użytkownika zgodnych ze standardem INVEST. Każda historia zawiera kryteria akceptacji w formacie Given-When-Then.

#### US1: Budowa wieżyczki obronnej
- **Jako** gracz
- **Chcę** zbudować wieżyczkę (np. „Elektryczny Piec Łukowy”) na wybranym polu
- **Po to, aby** bronić bazy przed zanieczyszczeniami.
- **Kryteria akceptacji (Given-When-Then):**
  - **Zakładając, że** gracz posiada wymagane 50 jednostek surowca i wybrał puste, dozwolone pole na mapie.
  - **Kiedy** gracz zatwierdza budowę wieżyczki.
  - **Wtedy** wieżyczka pojawia się na polu, a z konta gracza ubywa 50 jednostek surowca.

#### US2: Stworzenie nowej mapy w edytorze
- **Jako** gracz-twórca
- **Chcę** postawić przeszkodę (np. element instalacji pieca) na planszy
- **Po to, aby** zaprojektować unikalny układ poziomu.
- **Kryteria akceptacji (Given-When-Then):**
  - **Zakładając, że** gracz otworzył puste okno edytora map.
  - **Kiedy** gracz przeciąga element z paska narzędzi na puste pole na siatce.
  - **Wtedy** element zostaje umieszczony i zablokowany w wybranym miejscu na siatce.

#### US3: Uruchomienie fali przeciwników
- **Jako** gracz
- **Chcę** nacisnąć przycisk uruchomienia fali
- **Po to, aby** rozpocząć fazę obrony.
- **Kryteria akceptacji (Given-When-Then):**
  - **Zakładając, że** mapa jest wczytana, a na ekranie widnieje przycisk „Start Fali”.
  - **Kiedy** gracz klika przycisk „Start Fali”.
  - **Wtedy** rozpoczyna się odliczanie (np. 3 sekundy), po czym wrogowie zaczynają wchodzić na mapę z punktu startowego.

#### US4: Zapisanie projektu mapy
- **Jako** gracz-twórca
- **Chcę** zapisać stworzony układ planszy
- **Po to, aby** móc do niego wrócić lub go przetestować.
- **Kryteria akceptacji (Given-When-Then):**
  - **Zakładając, że** na mapie znajduje się co najmniej punkt startowy wrogów i baza (wielki piec).
  - **Kiedy** gracz klika przycisk „Zapisz mapę”.
  - **Wtedy** dane mapy zapisują się w lokalnej bazie SQLite, a system wyświetla komunikat o sukcesie.

#### US5: Ekran końca gry (porażka)
- **Jako** gracz
- **Chcę** zobaczyć ekran podsumowania po przegranej
- **Po to, aby** wiedzieć, jak długo przetrwałem.
- **Kryteria akceptacji (Given-When-Then):**
  - **Zakładając, że** punkty wytrzymałości bazy (Wielkiego Pieca) spadają do zera.
  - **Kiedy** system odnotowuje zniszczenie bazy.
  - **Wtedy** rozgrywka zostaje zatrzymana, a na ekranie wyświetla się podsumowanie z liczbą pokonanych wrogów.

#### Diagram przypadków użycia UML
*(Miejsce na link do diagramu przypadków użycia UML w formacie obrazka)*

## Wymagania systemowe i metryki

### Wymagania funkcjonalne
- **REQ-F1:** System pozwala na budowę i niszczenie struktur obronnych na predefiniowanej siatce.
- **REQ-F2:** Edytor map serializuje (zapisuje) układ obiektów do struktury bazy danych SQLite.
- **REQ-F3:** Mechanika gry w czasie rzeczywistym oblicza kolizje i zasięg ataku.

### Wymagania niefunkcjonalne (NFR) i metryki
- **REQ-NF1 — Wydajność (Performance Efficiency):** Czas wczytywania nowej mapy do pamięci operacyjnej powinien być jak najkrótszy.
  - **Metryka:** Czas reakcji (Response Time) poniżej 3 sekund od momentu wybrania mapy z menu.
- **REQ-NF2 — Niezawodność (Reliability):** Silnik gry musi działać stabilnie podczas uruchomienia symulacji dużej ilości wrogów.
  - **Metryka:** MTBF (Mean Time Between Failures — średni czas między awariami) wynoszący minimum 24 godziny nieprzerwanej symulacji bez krytycznego błędu (tzw. crasha).
- **REQ-NF3 — Użyteczność (Usability):** Interfejs tworzenia mapy musi być zrozumiały bez czytania dokumentacji.
  - **Metryka:** Czas potrzebny na stworzenie pierwszej działającej mapy z bazą i ścieżką (Time on Task) wynosi poniżej 5 minut dla nowego użytkownika.

#### Diagram wymagań SysML
*(Miejsce na link do diagramu wymagań SysML w formacie obrazka)*

## Zarządzanie konstytucją
Niniejsza konstytucja gromadzi założenia projektu, historie użytkownika, kryteria akceptacji, wymagania systemowe i metryki opisane dla Holy Blast Furnaces!. Zmiany tych ustaleń powinny zachować spójność między zakresem prototypu, historiami użytkownika i wymaganiami. Prototyp pozostaje prototypem z porzuceniem; opisane funkcje i wymagania określają docelowe zachowanie oraz makiety, a nie nakaz implementacji zaawansowanej logiki w silniku.

**Wersja**: 1.0.0 | **Data ratyfikacji**: 2026-10-19 | **Ostatnia zmiana**: 2026-10-19
