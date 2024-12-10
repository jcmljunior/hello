extends State

const FRAME_SIZE = Vector2(32, 32)
const FRAME_COUNT = 6

var animation_speed = 5.0
var time_passed = 0.0
var current_frame = 0

@onready var sprite_2d: Sprite2D = %Sprite2D

func _ready():
	# Ativamos o uso da região para o sprite
	sprite_2d.region_enabled = true
	# Definimos o tamanho da região para um quadro
	sprite_2d.region_rect.size = FRAME_SIZE

func _process(delta):
	# Atualiza o tempo acumulado
	time_passed += delta

	# Verifica se é hora de mudar para o próximo quadro
	if time_passed >= 1.0 / animation_speed:
		time_passed = 0.0

		# Atualiza para o próximo quadro com laço de repetição.
		#current_frame = (current_frame + 1) % FRAME_COUNT
		# Atualiza para o próximo quadro sem laço de repetição.
		# Importante para a finalização do estado ocorrer.
		current_frame = current_frame + 1

		# Calcula a posição do quadro na spritesheet
		var frame_x = current_frame * FRAME_SIZE.x
		var frame_y = 0

		# Atualiza a região do sprite
		sprite_2d.region_rect.position = Vector2(frame_x, frame_y)
