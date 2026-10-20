# Konstytucja projektu: Holy Blast Furnaces!

## Podstawowe zasady

### I. Wizja i zakres prototypu
Holy Blast Furnaces! jest grą typu Tower Defense o wytwarzaniu stopów metali żelaznych. Projekt powstaje w silniku Godot Engine 4.7.2, a SQLite jest docelową bazą danych. Tworzony prototyp ma charakter prototypu z porzuceniem (Throwaway Prototype): jego celem jest przygotowanie prostych makiet prezentujących interfejs i ekrany gry, bez implementowania zaawansowanej logiki w silniku.

### II. Historie użytkownika i kryteria akceptacji
Wymagania funkcjonalne prototypu są opisywane za pomocą historii użytkownika zgodnych ze standardem INVEST. Każda historia zawiera kryteria akceptacji w formacie Given-When-Then.

**US1: Rozegranie standardowego poziomu**
* **Jako** gracz
* **Chcę** przejść wybrany poziom broniąc pieca przed falami przeciwników
* **Po to, aby** wygrać i ewentualnie odblokować kolejne mapy lub osiągnięcia.
* **Kryteria Akceptacji:**
  * **Zakładając, że (Given)** gracz wybrał standardowy poziom z menu głównego.
  * **Kiedy (When)** gracz kliknie "Start", a następnie rozmieszcza obronę i odpiera fale wrogów (aż do wyczerpania puli zanieczyszczeń).
  * **Wtedy (Then)** gra wyświetla ekran zwycięstwa (lub porażki, jeśli punkty zdrowia pieca spadną do zera) i podsumowuje wynik.

**US2: Stworzenie nowej mapy w edytorze**
* **Jako** gracz-twórca
* **Chcę** umieścić bazę i wyznaczyć ścieżkę dla wrogów na pustej planszy
* **Po to, aby** zaprojektować unikalny układ poziomu.
* **Kryteria Akceptacji:**
  * **Zakładając, że (Given)** gracz otworzył okno "Nowa Mapa" w edytorze.
  * **Kiedy (When)** gracz umieszcza obiekt typu "Baza" i wytycza linię ciągłą łączącą punkt startowy z bazą.
  * **Wtedy (Then)** system zatwierdza poprawność układu planszy i umożliwia dodawanie przeszkód (np. elementów instalacji pieca) na pozostałych polach siatki.

**US3: Zapis mapy do lokalnej bazy SQLite**
* **Jako** gracz-twórca
* **Chcę** zapisać stworzony w edytorze projekt mapy
* **Po to, aby** móc do niego wrócić później lub go zagrać.
* **Kryteria Akceptacji:**
  * **Zakładając, że (Given)** mapa w edytorze posiada bazę, punkt startowy i przynajmniej jedną poprawną ścieżkę (jest zwalidowana).
  * **Kiedy (When)** gracz klika przycisk "Zapisz mapę" i podaje jej nazwę.
  * **Wtedy (Then)** dane mapy (układ siatki i obiektów) są serializowane i trwale zapisywane w lokalnej bazie danych SQLite pod podaną nazwą, po czym system wyświetla komunikat o sukcesie.

**US4: Udostępnienie stworzonej mapy społeczności**
* **Jako** gracz-twórca
* **Chcę** przesłać własną, zrobioną przez siebie mapę na serwer gry
* **Po to, aby** inni gracze mogli ją pobrać i na niej zagrać.
* **Kryteria Akceptacji:**
  * **Zakładając, że (Given)** gracz znajduje się w menu "Zapisane Mapy", wybrał jedną ze swoich poprawnych map i ma aktywne połączenie z serwerem.
  * **Kiedy (When)** gracz klika przycisk "Publikuj/Udostępnij".
  * **Wtedy (Then)** plik mapy zostaje wysłany do zewnętrznej bazy, otrzymuje publiczny identyfikator (np. kod), a mapa staje się widoczna dla innych graczy na publicznej liście poziomów.

**US5: Rozgrywka wieloosobowa (Kooperacja)**
* **Jako** gracz 1 (Host)
* **Chcę** założyć pokój dla wybranej mapy i zaprosić do niego drugiego gracza
* **Po to, aby** wspólnie bronić bazy przed atakami wrogów.
* **Kryteria Akceptacji:**
  * **Zakładając, że (Given)** Gracz 1 znajduje się w menu głównym, tworzy nową sesję wieloosobową na wybranej mapie i system generuje kod dołączenia (session ID).
  * **Kiedy (When)** Gracz 2 (Klient) wpisuje ten sam kod w opcji "Dołącz do gry".
  * **Wtedy (Then)** obaj gracze zostają przeniesieni na wspólną planszę, a system synchronizuje czas rzeczywisty, stan budowanych wież oraz postęp fal między obydwoma urządzeniami (z opóźnieniem nieprzekraczającym np. 100ms).

#### Diagram przypadków użycia UML
*https://uml.planttext.com/plantuml/png/NLB1Ji904BqtwJ-CdF002IWNGmYHH9hWHO6Bjs4xreNjJhExJTCQB_w5yJFy1EM_tDeYWTkRVVFcpRpir3eqBazL62XwTk0OZ4nU7CJIa72ITHZOdTGP6amXGx73X9QkL0GrZpfH50PXWCAnWSxSeAWwW1Rcfs_GNHNVNqRWvH-xEcC7q8tOkeQCpiWXT1TAacxfHUttRmwTY5K9jmgjWxlSQ1HaBphm6WO0kIM1rlSySaM9GIq9_C4wHXDpGGb3nfNaDFyRl9uDJaHBLx2fg1Pftxs55BCI2g2uT3NHYeOdedNix_ZvoBogSQjdi3weRSRxTnALvlsdaEs4g_DT4rCMEuH2acAslE42VGRC6Vb0jcs6wzdrYUu9CsaRbvX1yGvLRRl1geJbmxrqXuL7OV1MPpY7Nc_INBrguV08_L9H2xtFuWZ3mFT1lr-N8xY1yLXgeVAO9fCmc9AE_M_w1G00*

## Wymagania systemowe i metryki

### REQ-F: Wymagania Funkcjonalne
Funkcjonalności systemu:
* **REQ-F1: Pętla Rozgrywki**
  * *Opis:* Fale przeciwników i obrona pieca.
* **REQ-F2: Edytor Map**
  * *Opis:* Tworzenie i zapis map do bazy danych SQLite.

### REQ-NF: Wymagania Niefunkcjonalne (NFR)
Klasyfikacja ISO/IEC 25002 (SQuaRE):
* **REQ-NF1: Efektywność Wydajnościowa**
  * *Opis:* Płynność renderowania grafiki w Godot Engine.
  * **Metryka:** Frame Rate > 60 FPS.
* **REQ-NF2: Dostępność (Availability)**
  * *Opis:* Dostępność serwera ze stworzonymi mapami dla graczy.
  * **Metryka:** Availability Uptime > 99.5%.
* **REQ-NF3: Niezawodność (Reliability)**
  * *Opis:* Stabilność sesji wieloosobowej w relacji Host/Klient.
  * **Metryka:** MTBF > 50h (Mean Time Between Failures - średni czas między awariami).
* **REQ-NF4: Odtwarzalność (Maintainability)**
  * *Opis:* Średni czas naprawy ewentualnych błędów związanych z zapisem w SQLite.
  * **Metryka:** MTTR < 1h (Mean Time To Repair - średni czas do naprawy).
#### Diagram wymagań SysML
*https://uml.planttext.com/plantuml/png/VPJ1Jjj048RlaV8EKwHAeH8b2QGI4KL0YG7H171IzLXDx0cTnDvrTzTrxQeNBdq6siVe8pHvhww11ATOFlWotd--VsPszb0RL2OEWtfDprX4g3049MFXUr89Kj0f_l1a64b1mWnD6X1OMRjUgzUy0BM63RTtlTLiTk5K8Pp988LZ6pVWn4gWH_h51g06U-XJ_-Xy0FlxYhx4h2Yq-GuEu7kz1c3ecu6tC4oreH1kL0eZcLWN9pGXeGao83yrqeeWnAXU-_4Vtkd2npJ46nIC5YnctbGA30Ijs4ubk22HYzyUWxvt4fUGMbsucj-P0C6LcNMQpFW9qggce6rUf3BoE14y-_id0GOvLfOB4PE79RXs5thtfKCVeoTGkn8qIgIb22QRFyE8TTury2KChz-peUUOmLe31qoJGW-XCN3SpHLxKDtA2virdV0ClId2-V1o-xpt3jgTPhCDZU5rZ6vliunlszgRqCoaIJw1-KzhnyVfmpHaWWLwTO-l5hUfU4oXIFYah3elAe5JwKi3FN73Wd95dunAPvWFnbvo0XSDmG6yQO9pDIppQ6Tn8hMPtqMFWCRHL-G0nnomIOiTgXxFUX9DobvrX8n0ctnmKgGXvnF3aDTz5d7m8J8SveRtzbvtNfRvtUdceymmaVxIi4i1b_ZTgLvBaqjMTlMK8M4AfDHoRDTq2eqpMz7sHS1MkxbkkJywTgp7JlCpDFg40aQvwMCo2P6m6y51h4YNNedTBbpw9a6LuHBUw2CBOx-I6dOhQrZyKkGB1Y-p0e6HmYI5yU9sVkVdUtY_9R6z9CiDMQzXvC8-jDPA64bmAK9MI--h5-xLrjR3afR41ixogFDqhlKiqbwU6ZW5QQiarYw9xPJ4TkkrGxiEzkd-1m00*

## Zarządzanie konstytucją
Niniejsza konstytucja gromadzi założenia projektu, historie użytkownika, kryteria akceptacji, wymagania systemowe i metryki opisane dla Holy Blast Furnaces!. Zmiany tych ustaleń powinny zachować spójność między zakresem prototypu, historiami użytkownika i wymaganiami. Prototyp pozostaje prototypem z porzuceniem; opisane funkcje i wymagania określają docelowe zachowanie oraz makiety, a nie nakaz implementacji zaawansowanej logiki w silniku.

**Wersja**: 1.0.0 | **Data utworzenia**: 2026-10-19 | **Ostatnia zmiana**: 2026-10-19
