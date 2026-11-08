extends Node

var db: SQLite
# user:// działa zarówno w edytorze, jak i po wyeksportowaniu gry do .exe
var db_path: String = "user://settings.db"


func _ready() -> void:
	init_db()
	apply_saved_settings()


func init_db() -> void:
	db = SQLite.new()
	db.path = db_path
	db.open_db()

	# Tworzymy tabelę (id = 1 gwarantuje, że zawsze mamy tylko jeden wiersz z ustawieniami)
	var create_query: String = """
	CREATE TABLE IF NOT EXISTS settings (
		id INTEGER PRIMARY KEY CHECK (id = 1),
		window_mode TEXT NOT NULL,
		resolution TEXT NOT NULL
	);
	"""
	db.query(create_query)

	# Wstawiamy domyślne ustawienia przy pierwszym uruchomieniu gry
	var default_query: String = """
	INSERT OR IGNORE INTO settings (id, window_mode, resolution)
	VALUES (1, 'Windowed', '1920x1080');
	"""
	db.query(default_query)
	db.close_db()


func save_settings(window_mode: String, resolution: String) -> void:
	db.open_db()
	var query: String = "UPDATE settings SET window_mode = ?, resolution = ? WHERE id = 1;"
	db.query_with_bindings(query, [window_mode, resolution])
	db.close_db()
	print("[SQLite] Zapisano ustawienia: ", window_mode, " | ", resolution)
	apply_video_settings(window_mode, resolution)


func load_settings() -> Dictionary:
	db.open_db()
	db.query("SELECT window_mode, resolution FROM settings WHERE id = 1;")
	var result: Array = db.query_result
	db.close_db()

	if result.size() > 0:
		return result[0]
	return {"window_mode": "Windowed", "resolution": "1920x1080"}


func apply_saved_settings() -> void:
	var data: Dictionary = load_settings()
	apply_video_settings(data["window_mode"], data["resolution"])


func apply_video_settings(window_mode: String, resolution: String) -> void:
	# 1. Tryb okna
	if window_mode == "Fullscreen":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	# 2. Rozdzielczość (np. "1920x1080" -> [1920, 1080])
	var parts: PackedStringArray = resolution.split("x")
	if parts.size() == 2:
		var size := Vector2i(int(parts[0]), int(parts[1]))
		DisplayServer.window_set_size(size)
