# Architecture Decision Records (ADR) – Holy Blast Furnaces!

## ADR-001: Wybór silnika Godot Engine 4 i języka GDScript

* **Data:** 13-10-2026
* **Status:** Zaakceptowano

### Kontekst
Projekt zakłada stworzenie gry typu Tower Defense z motywem hutniczym, wyposażonej we wbudowany edytor map oraz tryb kooperacji wieloosobowej. Zespół liczy 3 osoby (podział na mechanikę rozgrywki, interfejs/edytor oraz architekturę/sieć/bazę danych), a czas realizacji jest ograniczony do jednego semestru. Potrzebujemy technologii umożliwiającej szybkie wdrożenie wszystkich członków zespołu, łatwą pracę równoległą w systemie Git oraz natywne wsparcie dla sieci i UI.

### Decyzja
Wybieramy silnik Godot Engine 4 wraz z natywnym językiem skryptowym GDScript jako główną platformę wykonawczą aplikacji.

### Rozważane alternatywy
* **Język Odin:** Odrzucono, ponieważ zespół uznał, że silnik Godot i wysokopoziomowy język GDScript będą znacznie łatwiejsze do nauczenia się w krótkim czasie. Ponadto pisanie gry w języku Odin wiązałoby się z koniecznością ręcznego programowania od podstaw systemu okienkowego, interfejsu pod edytor map oraz niskopoziomowej obsługi sieci.

### Konsekwencje
* **Pozytywne:** Niski próg wejścia dla całego zespołu, błyskawiczne tworzenie interfejsu edytora map dzięki wbudowanym węzłom UI, czytelny tekstowy format scen (.tscn) ułatwiający pracę zespołową w Git oraz gotowe komponenty sieciowe.
* **Negatywne:** Niższa wydajność surowych obliczeń w języku interpretowanym GDScript w porównaniu do kompilowanego języka Odin, co wymaga unikania ciężkich pętli w metodzie `_process()`.


## ADR-02: Wykorzystanie lokalnej bazy danych SQLite do przechowywania map i statystyk

* **Data:** 13-10-2026
* **Status:** Zaakceptowano

### Kontekst
Gra posiada wbudowany edytor map pozwalający graczom na tworzenie własnych plansz, definiowanie układu kafelków, ścieżek przeciwników oraz konfiguracji fal. Dodatkowo wymagania projektowe narzucają opracowanie ustrukturyzowanego relacyjnego modelu danych (ERD) oraz kontrolę przepływu danych (DFD).

### Decyzja
Do trwałego przechowywania danych (persystencji) wybieramy lokalną, relacyjną bazę danych SQLite, integrowaną z silnikiem Godot poprzez bibliotekę GDExtension (`godot-sqlite`). Dostęp do bazy zostaje odizolowany w dedykowanej warstwie repozytorium (`DatabaseManager`).

### Rozważane alternatywy
* **Pliki JSON lub natywne zasoby Godota (.tres):** Odrzucono, ponieważ nie zapewniają relacyjnej kontroli integralności danych (brak kluczy obcych i więzów spójności), utrudniają filtrowanie/sortowanie wielu map oraz nie odwzorowują klasycznego schematu ERD.
* **Zewnętrzny serwer relacyjnej bazy danych (np. PostgreSQL / MySQL):** Odrzucono, aby nie zmuszać użytkownika końcowego do instalacji i konfiguracji zewnętrznego serwera bazodanowego w celu uruchomienia gry na własnym komputerze.

### Konsekwencje
* **Pozytywne:** Pełna spójność relacyjna (np. kaskadowe usuwanie kafelków i przypisanych fal przy usunięciu mapy), całość bazy mieści się w pojedynczym pliku lokalnym, możliwość bezpośredniego użycia zapytań SQL i jednoznacznego odwzorowania tabel na diagramie ERD.
* **Negatywne:** Konieczność dołączenia natywnej binarki rozszerzenia GDExtension dla docelowych systemów operacyjnych oraz ręcznego mapowania wyników zapytań SQL na obiekty w GDScript.


## ADR-03: Architektura sieciowa Host-Client (Listen Server) dla trybu kooperacji

* **Data:** 13-10-2026
* **Status:** Zaakceptowano

### Kontekst
Jednym z głównych założeń projektu jest tryb wieloosobowy (kooperacja), w którym gracze wspólnie bronią bazy na tej samej mapie. Wymaga to niezawodnej synchronizacji stanu rozgrywki (pozycji wrogów, stawianych wież hutniczych, stanu surowców i zdrowia bazy) w czasie rzeczywistym.

### Decyzja
Przyjmujemy architekturę sieciową typu Host-Client (Listen Server) opartą na wysokopoziomowym API sieciowym Godota (`ENetMultiplayerPeer`, `MultiplayerSpawner`, `MultiplayerSynchronizer` oraz wywołania RPC). Jeden z graczy pełni jednocześnie rolę klienta oraz autorytatywnego serwera rozgrywki.

### Rozważane alternatywy
* **Architektura z dedykowanym serwerem zewnętrznym:** Odrzucono z uwagi na koszty utrzymania infrastruktury serwerowej oraz dodatkowy nakład pracy na administrację i wdrażanie osobnej aplikacji serwerowej.
* **Architektura Peer-to-Peer z deterministycznym modelem Lockstep:** Odrzucono ze względu na wysokie ryzyko desynchronizacji (rozjazdu stanu gry między graczami) wynikające z niedeterministycznych obliczeń zmiennoprzecinkowych i fizyki.

### Konsekwencje
* **Pozytywne:** Brak kosztów utrzymania serwerów zewnętrznych, autorytatywny host zapobiega oszustwom i konfliktom stanu (np. jednoczesne postawienie dwóch wież na tym samym polu przez różnych graczy), szybka implementacja dzięki gotowym węzłom synchronizacji w Godot 4.
* **Negatywne:** Rozłączenie gracza pełniącego rolę hosta skutkuje przerwaniem sesji dla pozostałych uczestników; konieczność przesłania niestandardowej mapy z bazy SQLite hosta do klientów przed startem meczu.
