class_name StateMachine extends Node

signal current_state_changed(current_state: State)
signal previous_state_changed(previous_state: State)

var _current_state : State : set=set_current_state, get=get_current_state
var _previous_state : State : set=set_previous_state, get=get_previous_state

@export var _auto_start := false : set=set_auto_start, get=get_auto_start

func _ready() -> void:
	if not _auto_start:
		return
		
	if not get_child_count():
		return
	
	# Inicialização automatica de estado.
	_change_state_handler(get_children().front())


func set_current_state(current_state: State) -> void:
	if _current_state == current_state:
		return
	
	_current_state = current_state
	current_state_changed.emit(get_current_state())

func get_current_state() -> State:
	return _current_state
	
func set_previous_state(previous_state: State) -> void:
	if _previous_state == previous_state:
		return
	
	_previous_state = previous_state
	previous_state_changed.emit(previous_state)

func get_previous_state() -> State:
	return _previous_state

func set_auto_start(new_auto_start: bool) -> void:
	if _auto_start == new_auto_start:
		return
	
	_auto_start = new_auto_start

func get_auto_start() -> bool:
	return _auto_start

func _change_state_handler(state: State) -> void:
	# Bloqueia a execução do nó nulo.
	# Em caso do uso do purge, o nó é executado uma unica vez e em seguida, removido da arvore de objetos.
	if not state:
		return
	
	# Impede que o ciclo continue executando em caso de não haver alterações no estado.
	# Essencial para quebrar o laço de execução process, physic_process etc...
	if get_current_state() == state:
		return
	
	# Define o estado atual.
	set_current_state(state)
	
	# Se existir o estado anterior, o finaliza.
	if get_previous_state():
		get_previous_state()._exit_state()
		
		# Elimina da arvore de objetos, o estado de execução unica.
		# Após a transição do estado ocorrer.
		if get_previous_state().get("_one_shot") and not _auto_start:
			await get_tree().process_frame
			await get_tree().physics_frame
		
			remove_child(get_previous_state())
	
	# Inicialização do ciclo de repetição do estado atual.
	# Essencial para manter a execução do laço de execução process, physic_process etc...
	get_current_state()._enter_state()
	
	# Elimina da arvore de objetos, o estado de execução unica.
	# Sem a transição de estado ocorrer.
	if get_current_state().get("_one_shot") && _auto_start:
		await get_tree().process_frame
		await get_tree().physics_frame
		
		# Finaliza o estado atual.
		get_current_state()._exit_state()
		
		# Elimina o estado atual da arvore de objetos após a execução unica ocorrer.
		remove_child(get_current_state())
		return

	# Define o estado anterior.
	set_previous_state(state)
